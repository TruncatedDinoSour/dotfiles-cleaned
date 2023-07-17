#ifndef _SYSUNAME_H
#define _SYSUNAME_H

#ifdef MODULE_SYSUNAME
#define sysuname(s)   \
    struct utsname s; \
    uname(&s)
#define uname_os(s)       (s).sysname
#define uname_hostname(s) (s).nodename
#define uname_kver(s)     (s).release
#define uname_over(s)     (s).version
#define uname_arch(s)     (s).machine
#endif /* MODULE_SYSUNAME */
#endif /* _SYSUNAME_H */
