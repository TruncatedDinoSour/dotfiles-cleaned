#include "config.h"
#include "colours.h"

#include <stdio.h>
#include <unistd.h>
#include <pwd.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/utsname.h>

#include "modules/distro.h"
#include "modules/userinfo.h"
#include "modules/sysuname.h"
#include "modules/packages.h"

#define PATH_IMPL

#include "path.h"

#define END_INFO_LINE(f) " " RESET " " BOLD "~" RESET GRAY " %" f RESET "\n"

int main(void) {
    char *distro_name = distro(), *shell;

    userinfo(u);
    sysuname(s);

    printf(/* .......................................................... */
           GRAY " ,d88b.d88b,    " RESET "%s" BLUE "@" RESET "%s\n" RED
                " 88888888888    \uf30d" END_INFO_LINE("s") GREEN
           /**/ " `Y8888888Y´    \uf120" END_INFO_LINE("s") YELLOW
           /**/ "   `Y888Y´      \uf08a" END_INFO_LINE("s") BLUE
           /**/ "     `Y´        \uf8d5" END_INFO_LINE("zu"),
           user_name(u), uname_hostname(s), distro_name,
           (shell = get_base(user_shell(u))), uname_kver(s), packages()
           /* .......................................................... */
    );

    free(distro_name);
    free(shell);

    return 0;
}
