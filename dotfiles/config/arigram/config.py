import os
import random
import time
from re import escape as escape_special
from threading import Thread
from timeit import default_timer as timer
from urllib.parse import quote as url_safe

import pyfzf
import uwuify
import wikipedia
from plyer import notification
from pyperclip import copy as copy_to_clipboard
from simpleaudio import WaveObject

import arigram
from arigram import config as tg_config
from arigram.controllers import msg_handler
from arigram.tdlib import TextParseModeInput
from arigram.utils import is_yes, suspend

MSG_MODIFIERS = {
    "uwufier": lambda string: uwuify.uwu(string, flags=uwuify.SMILEY | uwuify.YU),
    "scream": lambda string: string.upper(),
    "calm tf down": lambda string: string.lower(),
    "australia": lambda string: string[::-1],
    "kde": lambda string: string.replace("c", "k").replace("C", "K"),
    "swap": lambda string: string.swapcase(),
    "ok hun": lambda string: string.title().removesuffix(".") + ".",
    "sr2": lambda string: "".join((chr(ord(character) << 2) for character in string)),
    "!sr2": lambda string: "".join((chr(ord(character) >> 2) for character in string)),
    "c l o s e  y o u r  f u c k i n g  d o o r": lambda string: " ".join(string),
}


class Custom:
    def _play_wav(self, wave_path: str) -> Thread:
        def player() -> None:
            wave_obj = WaveObject.from_wave_file(wave_path)
            play_obj = wave_obj.play()
            play_obj.wait_done()

        sound = Thread(target=player)
        sound.setDaemon(True)

        return sound

    def _notify(self, title: str, message: str) -> Thread:
        def notifier() -> None:
            if notification.notify is not None:
                notification.notify(
                    app_name=f"arigram {arigram.__version__}",
                    title=title,
                    message=message,
                )

        notif = Thread(target=notifier)
        notif.setDaemon(True)

        return notif

    def _is_locked(self, lockfile: str = "/tmp/arigram.lock") -> bool:
        return os.path.exists(lockfile)

    def notify(self, *args, **kwargs) -> None:
        del args

        self._notify(str(kwargs.get("title")), str(kwargs.get("msg"))).start()
        self._play_wav(f"{tg_config.CONFIG_DIR}resources/notification.wav").start()

    def batch_delete(self, ctrl, *args) -> None:
        del args

        lockfile = "/tmp/arigram-delete.lock"

        if self._is_locked(lockfile):
            return

        def killer(sleep_time: float, many: int, __total: int = 0) -> int:
            if self._is_locked(lockfile):
                return __total
            open(lockfile, "w").close()

            count = many
            total = __total

            for _ in range(many):
                try:
                    is_deleted = ctrl.model.delete_msgs()
                    ctrl.discard_selected_msgs()

                    if not is_deleted:
                        ctrl.prev_msg()

                        if not ctrl.model.has_prev_message():
                            count = 0
                            break

                        continue
                except (IndexError, KeyError):
                    count = 0
                    break

                time.sleep(sleep_time)

                count -= 1
                total += 1

            os.remove(lockfile)
            if count > 0:
                return killer(sleep_time, count, total)

            return total

        max_deletion = int(ctrl.view.status.get_input("how many to delete (int)"))
        sleep_time = float(
            ctrl.view.status.get_input("every valid deletion sleep (float in s)")
        )

        start = timer()
        total = killer(sleep_time, max_deletion)
        end = timer()

        ctrl.model.send_message(
            text=f"[ARIGRAM] Deleted {total}/{max_deletion} messages with delay of {sleep_time}s in {(end - start):.3f}s"
        )

    def batch_send(self, ctrl, *args) -> None:
        del args

        lockfile = "/tmp/arigram-send.lock"

        if self._is_locked(lockfile):
            return

        def sender(sleep_time: float, many: int, string: str, __total: int = 0) -> int:
            if self._is_locked(lockfile):
                return __total
            open(lockfile, "w").close()

            count = many
            total = __total

            for _ in range(many):
                ctrl.model.send_message(string)

                time.sleep(sleep_time)

                count -= 1
                total += 1

            os.remove(lockfile)
            if count > 0:
                return sender(sleep_time, count, string, total)

            return total

        max_sending = int(ctrl.view.status.get_input("how many to send (int)"))
        string = ctrl.view.status.get_input("what to send (str)")
        sleep_time = float(
            ctrl.view.status.get_input("every valid message sent sleep (float in s)")
        )

        start = timer()
        total = sender(sleep_time, max_sending, string)
        end = timer()

        ctrl.model.send_message(
            text=f"[ARIGRAM] Sent {total}/{max_sending} messages with delay of {sleep_time}s in {(end - start):.3f}s"
        )

    @staticmethod
    def send_reversed(ctrl, *args) -> None:
        del args
        ctrl.model.send_message(ctrl.view.status.get_input("reversed message")[::-1])

    @staticmethod
    def send_countdown(ctrl, *args) -> None:
        del args
        max_count = ctrl.view.status.get_input("countdown")

        for count in reversed(range(1, int(max_count) + 1)):
            ctrl.model.send_message(str(count))
            time.sleep(1)

    @staticmethod
    def send_wiki(ctrl, *args) -> None:
        del args

        search = ctrl.view.status.get_input("wikipedia query")

        if not search:
            ctrl.present_info("Query canceled")
            return

        query_results = wikipedia.search(search)

        if not search:
            ctrl.present_info("Query canceled")
            return

        with suspend(ctrl.view):
            article_name = pyfzf.FzfPrompt().prompt(
                query_results, "--prompt='Article: '"
            )

        article_page = wikipedia.page(article_name)

        resp = ctrl.view.status.get_input(
            f"send wikipedia article about <{article_page.title}>? (Y/n)"
        ).strip()

        if not is_yes(resp):
            ctrl.present_info(f"Discarding article about <{article_page.title}>")
            return

        message_content = f"""[Wikipedia: {escape_special(article_page.title)}](https://en.wikipedia.org/wiki/{url_safe(article_page.title)})

```
{article_page.summary[:200]}...
```
"""
        ctrl.model.send_message(message_content)

    @staticmethod
    def uwu(ctrl, *args) -> None:
        del args

        msg = " ".join(
            word if word != ":face:" else random.choice(uwuify.core.SMILEYS)
            for word in ctrl.view.status.get_input("uwu").split()
        )

        ctrl.model.send_message(MSG_MODIFIERS["uwufier"](msg))

        ctrl.present_info("nya~")

    def modify_cur_message(self, ctrl, *args) -> None:
        del args

        msg = ctrl.model.current_msg["content"]["text"]["text"]

        with suspend(ctrl.view):
            copy_to_clipboard(
                MSG_MODIFIERS[pyfzf.FzfPrompt().prompt(MSG_MODIFIERS.keys())[0]](msg)
            )

        ctrl.present_info("mod copied to clipboard")

    @staticmethod
    def kde(ctrl, *args) -> None:
        del args
        ctrl.model.send_message(
            MSG_MODIFIERS["kde"](ctrl.view.status.get_input("KDEidied message"))
        )

    @staticmethod
    def send_formal(ctrl, *args) -> None:
        del args
        ctrl.model.send_message(
            MSG_MODIFIERS["ok hun"](ctrl.view.status.get_input("Formalised message"))
        )

    @staticmethod
    def sr2(ctrl, *args) -> None:
        del args

        ctrl.model.send_message(
            MSG_MODIFIERS["sr2"](ctrl.view.status.get_input("SR2 message"))
        )

    @staticmethod
    def googleitforme(ctrl, *args) -> None:
        chat_id = ctrl.model.chats.id_by_index(ctrl.model.current_chat)
        if not chat_id:
            return

        msg_ids = ctrl.model.selected[chat_id]
        if not msg_ids:
            msg = ctrl.model.current_msg
            msg_ids = [msg["id"]]

        ctrl.model.copied_msgs = (chat_id, msg_ids)
        ctrl.discard_selected_msgs()

        question: list = list(ctrl.model.get_current_message_text())
        question[0] = " ".join(question[0].split())

        if not question[1]:
            ctrl.present_error("Failed to get message text")
            return

        question_encoded: str = url_safe(question[0])

        msg_txt: str = f"""Have you tried looking up {question[0]!r} ?

* SearX results: https://searx.be/search?q={question_encoded}

* Ecosia results: https://www.ecosia.org/search?q={question_encoded}
* DuckDuckGo results: https://duckduckgo.com/?q={question_encoded}
* Google results: https://google.com/search?q={question_encoded}

* Gentoo Linux wiki results: https://wiki.gentoo.org/index.php?search={question_encoded}
* Arch Linux wiki results: https://wiki.archlinux.org/index.php?search={question_encoded}

This isn't google, please search before asking <3"""

        reply_to_msg = ctrl.model.current_msg_id
        ctrl.model.view_all_msgs()
        ctrl.tg.reply_message(chat_id, reply_to_msg, msg_txt)

    @staticmethod
    def close_your_fucking_door(ctrl, *args) -> None:
        ctrl.model.send_message(
            MSG_MODIFIERS["c l o s e  y o u r  f u c k i n g  d o o r"](
                ctrl.view.status.get_input("close your fucking door")
            )
        )


custom_code = Custom()

with open(
    os.path.expanduser("~/Ari/passwd/phone_number.n"), "r", encoding="utf-8"
) as pn:
    PHONE = pn.readline().strip()

NOTIFY_FUNCTION = custom_code.notify
CUSTOM_KEYBINDS = {
    "z": {"func": custom_code.batch_delete, "handler": msg_handler},
    "x": {"func": custom_code.batch_send, "handler": msg_handler},
    "C": {"func": custom_code.send_reversed, "handler": msg_handler},
    "w": {"func": custom_code.send_wiki, "handler": msg_handler},
    "B": {"func": custom_code.send_countdown, "handler": msg_handler},
    "U": {"func": custom_code.uwu, "handler": msg_handler},
    "M": {"func": custom_code.modify_cur_message, "handler": msg_handler},
    "F": {"func": custom_code.kde, "handler": msg_handler},
    "Y": {"func": custom_code.send_formal, "handler": msg_handler},
    "W": {"func": custom_code.sr2, "handler": msg_handler},
    "X": {"func": custom_code.googleitforme, "handler": msg_handler},
    "H": {"func": custom_code.close_your_fucking_door, "handler": msg_handler},
}
DEFAULT_OPEN = tg_config.LONG_MSG_CMD
EXTRA_TDLIB_HEADEARS = {
    "disable_web_page_preview": True,
    "parse_mode": {
        "@type": TextParseModeInput.textParseModeMarkdown.name,
        "version": 2,
    },
}
USERS_COLOURS = [
    random.choice(tg_config.USERS_COLOURS) for _ in tg_config.USERS_COLOURS
]
