#include "fastfetch.h"

#include <string.h>

#define FF_DE_MODULE_NAME "DE"
#define FF_DE_NUM_FORMAT_ARGS 4

void ffPrintDesktopEnvironment(FFinstance* instance)
{
    const FFWMDEResult* result = ffDetectWMDE(instance);

    if(result->dePrettyName.length == 0)
    {
        ffPrintError(instance, FF_DE_MODULE_NAME, 0, &instance->config.deKey, &instance->config.deFormat, FF_DE_NUM_FORMAT_ARGS, "No DE found");
        return;
    }

    if(instance->config.deFormat.length == 0)
    {
        ffPrintLogoAndKey(instance, FF_DE_MODULE_NAME, 0, &instance->config.deKey);

        ffStrbufWriteTo(&result->dePrettyName, stdout);

        if(result->deVersion.length > 0)
        {
            putchar(' ');
            ffStrbufWriteTo(&result->deVersion, stdout);
        }

        putchar('\n');
    }
    else
    {
        ffPrintFormatString(instance, FF_DE_MODULE_NAME, 0, &instance->config.deKey, &instance->config.deFormat, NULL, FF_DE_NUM_FORMAT_ARGS, (FFformatarg[]){
            {FF_FORMAT_ARG_TYPE_STRING, result->sessionDesktop},
            {FF_FORMAT_ARG_TYPE_STRBUF, &result->deProcessName},
            {FF_FORMAT_ARG_TYPE_STRBUF, &result->dePrettyName},
            {FF_FORMAT_ARG_TYPE_STRBUF, &result->deVersion}
        });
    }
}
