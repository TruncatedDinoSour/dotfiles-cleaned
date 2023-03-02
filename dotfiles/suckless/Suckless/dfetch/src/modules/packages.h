#ifndef _PACKAGES_H
#define _PACKAGES_H
#include <stddef.h>

static size_t packages(void);

#ifdef MODULE_PACKAGES
static size_t packages(void) {
    static size_t total = 0;
    size_t pcount, idx;
    char full_cmd[MAX_PACKAGE_CMD_LEN + strlen(PKG_END) + 1];
    FILE *packages;

    for (idx = 0; idx < sizeof(package_managers) / sizeof(package_managers[0]);
         idx++) {
        strcpy(full_cmd, package_managers[idx]);
        strcat(full_cmd, PKG_END);

        if ((packages = popen(full_cmd, "r"))) {
            if (fscanf(packages, "%zu", &pcount))
                total += pcount;

            pclose(packages);
        }
    }

    return total;
}
#endif /* MODULE_PACKAGES */
#endif /* _PACKAGES_H */
