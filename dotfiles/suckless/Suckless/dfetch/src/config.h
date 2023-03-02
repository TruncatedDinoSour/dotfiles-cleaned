#ifndef _CONFIG_H
#define _CONFIG_H

#define _POSIX_C_SOURCE 2

#define MODULE_DISTRO
#define MODULE_USERINFO
#define MODULE_SYSUNAME
#define MODULE_PACKAGES

#define MAX_DISTRO_LENGTH   64
#define DISTRO_NAME_ATTR    "NAME="
#define MAX_PACKAGE_CMD_LEN 11
static const char package_managers[][MAX_PACKAGE_CMD_LEN] = {"q qlist -I"};
#define PKG_END " 2>/dev/null|wc -l"
#endif /* _CONFIG_H */
