#ifndef _USERINFO_H
#define _USERINFO_H
#ifdef MODULE_USERINFO
#define userinfo(u)   struct passwd *u = getpwuid(getuid())
#define user_name(u)  (u)->pw_name
#define user_pw(u)    (u)->pw_passwd
#define user_uid(u)   (u)->pw_uid
#define user_gid(u)   (u)->pw_gid
#define user_info(u)  (u)->pw_gecos
#define user_home(u)  (u)->pw_dir
#define user_shell(u) (u)->pw_shell
#endif /* MODULE_USERINFO */
#endif /* _USERINFO_H */
