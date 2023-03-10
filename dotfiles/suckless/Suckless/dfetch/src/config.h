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
#define PKG_END             " 2>/dev/null|wc -l"
#define PKG_MANAGER(cmd)    cmd "\n"
#define PACKAGE_MANAGERS_CMD \
    "{\n" PKG_MANAGER("q qlist -I") "} 2>/dev/null|wc -l"
#endif /* _CONFIG_H */
