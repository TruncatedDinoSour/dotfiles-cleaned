#!/usr/bin/env node
"use strict";

/* free deepAI api
 * ( proxied, you can make it try your network first though
 * by setting DA_TRY=1 )
 *
 * e.g. dai text-generator text:'hello world in C'
 */

import got from "got";
import { HttpsProxyAgent, HttpProxyAgent } from "hpagent";
import "process";

const MAX32 = 2 ** 32;

const USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36";

const DEFAULT_KEY = "quickstart-QUdJIGlzIGNvbWluZy4uLi4K";
const PROXY_API =
    "https://gimmeproxy.com/api/getProxy?post=true&get=true&user-agent=true&supportsHttps=true&protocol=http&minSpeed=20&curl=true";
const API = "https://api.deepai.org/api";

var SEED_VECTOR = [];
for (var SEED_IDX = 0; 64 > SEED_IDX; )
    SEED_VECTOR[SEED_IDX] = 0 | (MAX32 * Math.sin(++SEED_IDX % Math.PI));

function escape_nonalpha(string) {
    return unescape(encodeURI(string));
}

/*
 * i did not write this code, only made it a slight bit
 * prettier, this is a custom hashing algorithm used by
 * deepai, this function is called `f` and is defined as
 * `f=function`, you can probably grep for it and youll find it,
 * for example : `f=function(){for(var v=[],w=0;64>w;)v[w]=0|4294967296*`,
 * this continues, as mentioned in the function
 * body its located at https://deepai.org/machine-learning-model/text-generator
 * ( yes as in index.html ) L1035, all line numbers are from
 * prettified source code using firefox
 */
function deepai_hash(target) {
    let computed_tmp;

    // var z,D,E,H=[z=1732584193,D=4023233417,~z,~D]
    // https://deepai.org/machine-learning-model/text-generator L1035
    let const1 = 1732584193; // z=
    let const2 = 4023233417; // D=

    let hash_buf = [];
    let hash = [const1, const2, ~const1, ~const2];

    let alpha_target = escape_nonalpha(target) + "\u0080";
    let alpha_target_len = alpha_target.length;

    target = (--alpha_target_len / 4 + 2) | 15;

    for (hash_buf[--target] = 8 * alpha_target_len; ~alpha_target_len; )
        hash_buf[alpha_target_len >> 2] |=
            alpha_target.charCodeAt(alpha_target_len) <<
            (8 * alpha_target_len--);

    for (SEED_IDX = alpha_target = 0; SEED_IDX < target; SEED_IDX += 16) {
        for (alpha_target_len = hash; 64 > alpha_target; ) {
            const1 = alpha_target_len[1] | 0;
            const2 = alpha_target_len[2];

            computed_tmp = alpha_target_len[3];

            alpha_target_len = [
                computed_tmp,
                const1 +
                    (((computed_tmp =
                        alpha_target_len[0] +
                        [
                            (const1 & const2) | (~const1 & computed_tmp),
                            (computed_tmp & const1) | (~computed_tmp & const2),
                            const1 ^ const2 ^ computed_tmp,
                            const2 ^ (const1 | ~computed_tmp),
                        ][(alpha_target_len = alpha_target >> 4)] +
                        SEED_VECTOR[alpha_target] +
                        ~~hash_buf[
                            SEED_IDX |
                                ([
                                    alpha_target,
                                    5 * alpha_target + 1,
                                    3 * alpha_target + 5,
                                    7 * alpha_target,
                                ][alpha_target_len] &
                                    15)
                        ]) <<
                        (alpha_target_len = [
                            7, 12, 17, 22, 5, 9, 14, 20, 4, 11, 16, 23, 6, 10,
                            15, 21,
                        ][4 * alpha_target_len + (alpha_target++ % 4)])) |
                        (computed_tmp >>> -alpha_target_len)),
                const1,
                const2,
            ];
        }

        for (alpha_target = 4; alpha_target; )
            hash[--alpha_target] += alpha_target_len[alpha_target];
    }

    for (target = ""; 32 > alpha_target; )
        target += (
            (hash[alpha_target >> 3] >> (4 * (1 ^ alpha_target++))) &
            15
        ).toString(16);

    return target.split("").reverse().join("");
}

function deepai_key() {
    return Math.round(1e11 * Math.random()) + "";
}

function create_deepai_key() {
    let k = deepai_key();
    return `tryit-${k}-${deepai_hash(
        USER_AGENT + deepai_hash(USER_AGENT + deepai_hash(USER_AGENT + k))
    )}`;
}

function parse_params(params) {
    return Object.fromEntries(
        params.map((param) =>
            param
                .split(/:(.+)/)
                .map((m) => m.trim())
                .filter((m) => m)
        )
    );
}

function error(msg) {
    console.error(msg);
    process.exit(1);
}

async function main() {
    if (process.argv.length < 4 || !(process.argv[2] = process.argv[2].trim()))
        error("usage : <api> <parametre:value> ...");

    // console.log(
    //     `curl -F 'text=${encodeURI(
    //         process.argv.slice(2).join(" ")
    //     )}' -H 'api-key:${create_deepai_key()}' -A '${USER_AGENT}' https://api.deepai.org/api/text-generator --proxy http://5.75.233.30:8080`
    // );

    let params = parse_params(process.argv.slice(3));

    for (let [k, v] of Object.entries(params))
        if (!v) error(`\`${k}\` does not have a non-empty defined value`);

    let options = {
        url: `${API}/${process.argv[2]}`,
        headers: {
            "Api-key": DEFAULT_KEY,
            "User-Agent": USER_AGENT,
        },
        method: "POST",
        form: params,
    };

    async function new_session(do_api) {
        let defkey = options.headers["Api-key"] === DEFAULT_KEY;
        options.headers["Api-key"] = create_deepai_key();
        if (!do_api && defkey) return;

        await got.get(PROXY_API).then((r) => {
            let proxy = {
                keepAlive: true,
                keepAliveMsecs: 1000,
                maxSockets: 256,
                maxFreeSockets: 256,
                scheduling: "lifo",
                proxy: r.body,
                headers: options.headers,
            };

            options.agent = {
                https: new HttpsProxyAgent(proxy),
                http: new HttpProxyAgent(proxy),
            };

            options.agent.http2 = options.agent.http2;
        });
    }

    // DA_TRY -- try other methods than just an API bypass
    if (!process.env.DA_TRY) await new_session(true);

    var run = true;

    while (run) {
        await got
            .post(options)
            .then((j) => {
                let r = JSON.parse(j.body);

                if (r.output) console.log(r.output.trim());
                else console.log(r);

                run = false;
            })
            .catch(() => new_session());
    }
}

main();
