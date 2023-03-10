#ifndef _PACKAGES_H
#define _PACKAGES_H
#include <stddef.h>

static size_t packages(void);

#ifdef MODULE_PACKAGES
static size_t packages(void) {
    static size_t pcount;
    FILE *packages = popen(PACKAGE_MANAGERS_CMD, "r");

    if (fscanf(packages, "%zu", &pcount) != 1)
        pcount = 0;

    pclose(packages);
    return pcount;
}
#endif /* MODULE_PACKAGES */
#endif /* _PACKAGES_H */
