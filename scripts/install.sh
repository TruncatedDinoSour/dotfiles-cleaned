#!/bin/sh

pacm="/bin/paru"        # Your AUR helper
sudo="/bin/sudo"        # Run commands as root
pins="-S --needed"      # Arguments to install an AUR package
ping="--ignore"         # Arguments to ignore package installation

if [[ "$EUID" == 0 ]];
then
    echo "[-] Do not run me as root!"
    exit -1
fi


pkg_base="curl git make pango man-db nano sed cmake"
pkg_font="adobe-source-code-pro-fonts awesome-terminal-fonts cantarell-fonts gnu-free-fonts nerd-fonts-hack siji-git ttf-font-awesome"
pkg_theme="gruvbox-dark-gtk gruvbox-material-icon-theme-git"
pkg_app="firefox kotatogram-desktop-bin ksnip thunar tor-browser vscodium-bin"
pkg_lang="lua51 python3 python-pip"
pkg_extra="mpv bash-completion bat bpython feh tlp gmp preload lsd lxappearance vim vscodium-bin-marketplace xautolock pango"
pkg_display="xorg xorg-xinit"
pkg_source="dunst-git"
pkg_i3="i3-gaps i3lock-color i3blocks"
pkg_lib="imlib2 libxinerama libxft"


function q() {
    echo -en "\n"

    echo "[*] $1"

    if [[ "$4"  ]];
    then
        local lgray="\e[0;37m"
        local reset="\e[0m"
        echo -e "${lgray}[#] $4${reset}"
    fi

    echo "[?] $2"

    echo -en "$3"
    read -p "" Q_RESPONSE

    if [[ "${Q_RESPONSE,,}" == "y" ]];
    then
        return 0
    else
        return 1
    fi
}

function software() {
    if q "Checking internet connection" "Continue?" "[y/N]$ " "\$ ping -c 5 google.com";
    then
        local red="\e[0;31m"
        local reset="\e[0m"
        echo "[*] Checking Internet connection..."

        echo -en "$red"
        ping -c 5 google.com >/dev/null
        local status="$?"
        echo -en "$reset"

        if [[ "$status" != 0 ]];
        then
            echo "[-] You don't seem to be connected to the internet. EXIT CODE: $status"
            return
        else
            echo "[:] You are connected to the Internet"
        fi
    else
        echo "[-] This step is required"
        return
    fi


    if q "Installing base software" "Continue?" "[y/N]$ " "$pkg_base";
    then
        $pacm $pins ${pkg_base}
    else
        echo "[-] Required base won't be installed - exiting"
        return
    fi


    if q "Installing fonts" "Continue?" "[y/N]$ " "$pkg_font";
    then
        $pacm $pins ${pkg_font}
    else
        echo "[-] No fonts will be installed... Skipping"
    fi


    if q "Installing themes" "Continue?" "[y/N]$ " "$pkg_theme";
    then
        $pacm $pins ${pkg_theme}
    else
        echo "[-] No themes will be installed... skipping"
    fi


    if q "Installing apps" "Continue?" "[y/N]$ " "$pkg_app";
    then
        echo "[?] What packages to ignore? (seperate by ,)"
        read -p ">>> " ignorepkg
        local ignorepkg=$(echo "$ignorepkg" | sed "s/ //g")

        $pacm $pins ${pkg_app} $ping "${ignorepkg}"
    else
        echo "[-] No extra apps will be installed... Skipping"
    fi


    if q "Installing language support" "Continue?" "[y/N]$ " "$pkg_lang";
    then
        $pacm $pins $pkg_lang
    else
        echo "[-] Some things might not work without language support... Skipping"
    fi


    if q "Installing extra packages" "Continue?" "[y/N]$ " "$pkg_extra";
    then
        echo "[?] What packages to ignore? (seperate by ,)"
        read -p ">>> " ignorepkg
        local ignorepkg=$(echo "$ignorepkg" | sed "s/ //g")

        $pacm $pins ${pkg_extra} $ping "${ignorepkg}"
    else
        echo "[-] No extra packages will be installed... Skipping"
    fi


    if q "Installing a display server" "Continue?" "[y/N]$ " "$pkg_display";
    then
        $pacm $pins ${pkg_display}
    else
        echo "[-] No display server installed, Some things might break... Skipping"
    fi


    if q "Installing packages that will be compiled" "Continue?" "[y/N]$ " "$pkg_source";
    then
        $pacm $pins ${pkg_source}
    else
        echo "[-] No extra compiled packages will be installed... Skipping"
    fi


    if q "Installing i3" "Continue?" "[y/N]$ " "$pkg_i3";
    then
        $pacm $pins ${pkg_i3}
    else
        echo "[-] i3 Will not be installed"
    fi


    if q "Installing required libs for compiling suckless" "Continue?" "[y/N]$ " "$pkg_lib";
    then
        $pacm $pins ${pkg_lib}
    else
        echo "[-] Don't compile anything suckless I.e DWM, slock, ST and Dmenu if you don't have these libs installed... Skipping"
    fi
}

function compile() {
    local back=$(pwd)


    function install_dmenu() {
        cd 'dotfiles/suckless/dmenu-5.0'
        $sudo make clean install
    }

    function install_dwm() {
        cd 'dotfiles/suckless/dwm-6.2'
        $sudo make clean install
        cd ..
        mv .dwm $HOME/.dwm
    }

    function install_slock() {
        cd 'dotfiles/suckless/slock-1.4'
        $sudo make clean install
    }

    function install_st() {
        cd 'dotfiles/suckless/st'
        $sudo make clean install
    }


    local com=(
        'dmenu'
        'dwm'
        'slock'
        'st'
    )

    for suckless in "${!com[@]}";
    do
        if q "Compiling ${com[$suckless]}" "Continue?" "[y/N]$ ";
        then
            eval "install_${com[$suckless]}"
        else
            echo "${com[$suckless]} won't be installed... Skipping"
        fi

        cd $back
    done
}

function dotfiles() {
    local from=(
        'dotfiles/bin/*'
        'dotfiles/config/*'
        'dotfiles/core/.xinitrc'
        'dotfiles/core/bash_git'
        'dotfiles/core/doas.conf'
        'dotfiles/core/mkinitcpio.conf'
        'dotfiles/core/pacman.conf'
        'dotfiles/core/paru.conf'
        'dotfiles/core/reflector.conf'
        'dotfiles/core/sudoers'
        'dotfiles/editors/vim/*'
        'dotfiles/fish'
        'dotfiles/icons'
        'dotfiles/RCs/.bashrc'
        'dotfiles/RCs/nanorc'
        'dotfiles/suckless'
        'dotfiles/RCs/.profile'
        'dotfiles/core/st.*'
    )
    local to=(
        '/usr/src'
        "$HOME/.config"
        "$HOME"
        '/etc'
        '/etc'
        '/etc'
        '/etc'
        '/etc'
        '/etc/xdg/reflector'
        '/etc'
        "$HOME"
        '/etc'
        "$HOME/.icons"
        "$HOME"
        '/etc'
        "$HOME"
        "$HOME"
        '/usr/share/applications'
    )

    for dot in "${!from[@]}";
    do
        eval "cp -rfv ${from[$dot]} ${to[$dot]} || $sudo cp -rfv ${from[$dot]} ${to[$dot]} || true"
    done

    local back=$(pwd)


    cd /usr/src/fastfetch
    rm -rfv build
    mkdir -p build && \
        cd build && \
        cmake .. && \
        cmake --build .
    cd $back

    cd /usr/src/yafetch
    make
    cd $back


    $sudo ln -s /usr/src/colours/colours /usr/local/bin/colours
    $sudo ln -s /usr/src/fastfetch/build/fastfetch /usr/local/bin/fastfetch
    $sudo ln -s /usr/src/yafetch/yafetch /usr/local/bin/yafetch
    $sudo ln -s /usr/src/dunstest/dunstest /usr/local/bin/dunstest
    $sudo ln -s /usr/src/shot/shot /usr/local/bin/shot
}

function tapps() {
    local python_apps="trash-cli"

    if q "Installing python apps" "Continue?" "[y/N]$ " "$python_apps";
    then
        python3 -m pip install ${python_apps}
    else
        echo "No python apps will be installed... Skipping"
    fi
}

function services() {
    local svcs=(
        'systemd-networkd.service'
        'fstrim.timer'
        'reflector.timer'
        'tlp.service'
        'gpm.service'
        'preload.service'
    )

    for svc in "${!svcs[@]}";
    do
        if q "Enabling ${svcs[$svc]}" "Continue?" "[y/N]$ ";
        then
            $sudo systemctl enable ${svcs[$svc]} || true
        else
            echo "${svcs[$svc]} won't be enabled... Skipping"
        fi
    done
}

function opts() {
    echo "Select options between 1-6"
}


function main() {
    echo "This WILL erase most, if not all of your configs. If you don\'t want that please consider a manual installation:"
    echo "- https://github.com/TruncatedDinosour/dotfiles-cleaned#manual-installation-arch-linux"

    while true;
    do
        echo -en "\n"

        echo "[P] Get your CWD"
        echo "[1] Install software"
        echo "[2] Compile software"
        echo "[3] Install dotfiles"
        echo "[4] Third party apps"
        echo "[5] Enable services"
        echo "[6] exit"

        echo -en " [ $USER@$HOSTNAME ] ~ ( EU: $EUID UU: $UID ) ~ ( HM: $HOME )\n"
        echo -en " (${PWD##*/})# "
        read -p "" ch

        case "${ch}" in
            P) pwd      ;;
            1) software ;;
            2) compile  ;;
            3) dotfiles ;;
            4) tapps    ;;
            5) services ;;
            6) break    ;;
            *) opts     ;;
        esac
    done
}

main

