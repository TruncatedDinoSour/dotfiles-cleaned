#include "fastfetch.h"
#include <string.h>

#define FF_WMTHEME_MODULE_NAME "WM Theme"
#define FF_WMTHEME_NUM_FORMAT_ARGS 1

static void printWMTheme(FFinstance* instance, const char* theme)
{
    if(instance->config.wmThemeFormat.length == 0)
    {
        ffPrintLogoAndKey(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey);
        puts(theme);
    }
    else
    {
        ffPrintFormatString(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, NULL, FF_WMTHEME_NUM_FORMAT_ARGS, (FFformatarg[]){
            {FF_FORMAT_ARG_TYPE_STRING, theme}
        });
    }
}

static void printWMThemeFromConfigFile(FFinstance* instance, const char* configFile, const char* themeRegex, const char* defaultValue)
{
    FFstrbuf theme;
    ffStrbufInit(&theme);

    if(!ffParsePropFileConfig(instance, configFile, themeRegex, &theme))
    {
        ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "Config file %s doesn't exist", configFile);
        ffStrbufDestroy(&theme);
        return;
    }

    if(theme.length == 0)
    {
        ffStrbufDestroy(&theme);

        if(defaultValue == NULL)
        {
            ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "Couldn't find WM theme in %s", configFile);
            return;
        }

        printWMTheme(instance, defaultValue);
        return;
    }

    printWMTheme(instance, theme.chars);
    ffStrbufDestroy(&theme);
}

static void printWMThemeFromSettings(FFinstance* instance, const char* dconfKey, const char* gsettingsSchemaName, const char* gsettingsPath, const char* gsettingsKey)
{
    const char* theme = ffSettingsGet(instance, dconfKey, gsettingsSchemaName, gsettingsPath, gsettingsKey, FF_VARIANT_TYPE_STRING).strValue;

    if(theme == NULL || *theme == '\0')
    {
        ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "Couldn't find WM theme in DConf or GSettings");
        return;
    }

    printWMTheme(instance, theme);
}

static void printGTKThemeAsWMTheme(FFinstance* instance)
{
    const FFGTKResult* gtk = ffDetectGTK4(instance);

    if(gtk->theme.length > 0)
    {
        printWMTheme(instance, gtk->theme.chars);
        return;
    }

    gtk = ffDetectGTK3(instance);

    if(gtk->theme.length > 0)
    {
        printWMTheme(instance, gtk->theme.chars);
        return;
    }

    gtk = ffDetectGTK2(instance);

    if(gtk->theme.length > 0)
    {
        printWMTheme(instance, gtk->theme.chars);
        return;
    }

    ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "Couldn't detect GTK4/3/2 theme");
}

static void printMutter(FFinstance* instance)
{
    const char* theme = ffSettingsGet(instance, "/org/gnome/shell/extensions/user-theme/name", "org.gnome.shell.extensions.user-theme", NULL, "name", FF_VARIANT_TYPE_STRING).strValue;
    if(theme != NULL && *theme != '\0')
    {
        printWMTheme(instance, theme);
        return;
    }

    printGTKThemeAsWMTheme(instance);
}

static void printMuffin(FFinstance* instance)
{
    const char* name = ffSettingsGet(instance, "/org/cinnamon/theme/name", "org.cinnamon.theme", NULL, "name", FF_VARIANT_TYPE_STRING).strValue;
    const char* theme = ffSettingsGet(instance, "/org/cinnamon/desktop/wm/preferences/theme", "org.cinnamon.desktop.wm.preferences", NULL, "theme", FF_VARIANT_TYPE_STRING).strValue;

    if(name == NULL && theme == NULL)
    {
        ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "Couldn't find muffin theme in GSettings / DConf");
        return;
    }

    if(name == NULL)
        printWMTheme(instance, theme);
    else if(theme == NULL)
        printWMTheme(instance, name);
    else
    {
        FFstrbuf buffer;
        ffStrbufInit(&buffer);
        ffStrbufAppendS(&buffer, name);
        ffStrbufAppendS(&buffer, " (");
        ffStrbufAppendS(&buffer, theme);
        ffStrbufAppendC(&buffer, ')');

        printWMTheme(instance, buffer.chars);

        ffStrbufDestroy(&buffer);
    }
}

static void printXFWM4(FFinstance* instance)
{
    const char* theme = ffSettingsGetXFConf(instance, "xfwm4", "/general/theme", FF_VARIANT_TYPE_STRING).strValue;

    if(theme == NULL)
    {
        ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "Couldn't find xfwm4::/general/theme in XFConf");
        return;
    }

    printWMTheme(instance, theme);
}

static void printOpenbox(FFinstance* instance, const FFstrbuf* dePrettyName)
{
    FFstrbuf absolutePath;
    ffStrbufInitA(&absolutePath, 64);
    ffStrbufAppendS(&absolutePath, instance->state.passwd->pw_dir);
    ffStrbufAppendC(&absolutePath, '/');

    if(ffStrbufIgnCaseCompS(dePrettyName, "LXQT") == 0)
        ffStrbufAppendS(&absolutePath, ".config/openbox/lxqt-rc.xml");
    else if(ffStrbufIgnCaseCompS(dePrettyName, "LXDE") == 0)
        ffStrbufAppendS(&absolutePath, ".config/openbox/lxde-rc.xml");
    else
        ffStrbufAppendS(&absolutePath, ".config/openbox/rc.xml");

    char* line = NULL;
    size_t len = 0;

    FILE* file = fopen(absolutePath.chars, "r");
    if(file == NULL)
    {
        ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "Couldn't open \"%s\"", absolutePath.chars);
        ffStrbufDestroy(&absolutePath);

        return;
    }

    FFstrbuf theme;
    ffStrbufInitA(&theme, 256);

    while(getline(&line, &len, file) != -1)
    {
        if(strstr(line, "<theme>") != 0)
            break;
    }

    while(getline(&line, &len, file) != -1)
    {
        if(strstr(line, "<name>") != 0)
        {
            ffStrbufAppendS(&theme, line);
            ffStrbufRemoveStrings(&theme, 2, "<name>", "</name>");
            ffStrbufTrimRight(&theme, '\n');
            ffStrbufTrim(&theme, ' ');
            break;
        }

        if(strstr(line, "</theme>") != 0) // sanity check
            break;
    }

    if(line != NULL)
        free(line);

    fclose(file);

    if(theme.length == 0)
        ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "Couldn't find theme name in \"%s\"", absolutePath.chars);
    else
        printWMTheme(instance, theme.chars);

    ffStrbufDestroy(&theme);
    ffStrbufDestroy(&absolutePath);
}

void ffPrintWMTheme(FFinstance* instance)
{
    const FFWMDEResult* result = ffDetectWMDE(instance);

    if(result->wmPrettyName.length == 0)
    {
        ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "WM Theme needs sucessfull WM detection");
        return;
    }

    if(ffStrbufIgnCaseCompS(&result->wmPrettyName, "KWin") == 0 || ffStrbufIgnCaseCompS(&result->wmPrettyName, "KDE") == 0 || ffStrbufIgnCaseCompS(&result->wmPrettyName, "Plasma") == 0)
        printWMThemeFromConfigFile(instance, "kwinrc", "theme =", "Breeze");
    else if(ffStrbufIgnCaseCompS(&result->wmPrettyName, "Xfwm4") == 0 || ffStrbufIgnCaseCompS(&result->wmPrettyName, "Xfwm") == 0)
        printXFWM4(instance);
    else if(ffStrbufIgnCaseCompS(&result->wmPrettyName, "Mutter") == 0)
    {
        if(ffStrbufIgnCaseCompS(&result->dePrettyName, "Gnome") == 0)
            printMutter(instance);
        else
            printGTKThemeAsWMTheme(instance);
    }
    else if(ffStrbufIgnCaseCompS(&result->wmPrettyName, "Muffin") == 0)
        printMuffin(instance);
    else if(ffStrbufIgnCaseCompS(&result->wmPrettyName, "Marco") == 0)
        printWMThemeFromSettings(instance, "/org/mate/Marco/general/theme", "org.mate.Marco.general", NULL, "theme");
    else if(ffStrbufIgnCaseCompS(&result->wmPrettyName, "Openbox") == 0)
        printOpenbox(instance, &result->dePrettyName);
    else
        ffPrintError(instance, FF_WMTHEME_MODULE_NAME, 0, &instance->config.wmThemeKey, &instance->config.wmThemeFormat, FF_WMTHEME_NUM_FORMAT_ARGS, "Unknown WM: %s", result->wmPrettyName.chars);
}
