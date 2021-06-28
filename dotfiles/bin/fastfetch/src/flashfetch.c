#include "fastfetch.h"

int main(int argc, char** argv)
{
    //Disable compiler warnings
    UNUSED(argc);
    UNUSED(argv);

    FFinstance instance;
    ffInitInstance(&instance); //This also applys default configuration to instance.config

    //Configuration
    ffLoadLogoSet(&instance, FASTFETCH_BUILD_DISTRIBUTION_ID);
    ffStrbufSetS(&instance.config.color, instance.config.logo.colors[0]); //Use the primary color of the logo as key color

    //Multithreading --> better performance
    ffStartDetectionThreads(&instance);

    //Does things like disabling line wrap
    ffStart(&instance);

    //Printing
    ffPrintTitle(&instance);
    ffPrintSeparator(&instance);
    ffPrintOS(&instance);
    ffPrintHost(&instance);
    ffPrintKernel(&instance);
    ffPrintUptime(&instance);
    ffPrintPackages(&instance);
    ffPrintShell(&instance);
    ffPrintResolution(&instance);
    ffPrintDesktopEnvironment(&instance);
    ffPrintWM(&instance);
    ffPrintWMTheme(&instance);
    ffPrintTheme(&instance);
    ffPrintIcons(&instance);
    ffPrintFont(&instance);
    ffPrintCursor(&instance);
    ffPrintTerminal(&instance);
    ffPrintTerminalFont(&instance);
    ffPrintCPU(&instance);
    ffPrintGPU(&instance);
    ffPrintMemory(&instance);
    ffPrintDisk(&instance);
    ffPrintBattery(&instance);
    ffPrintLocale(&instance);
    ffPrintBreak(&instance);
    ffPrintColors(&instance);

    ffFinish(&instance);
    return 0;
}
