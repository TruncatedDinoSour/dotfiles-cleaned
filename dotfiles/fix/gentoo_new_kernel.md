# Upgrading the kernel - gentoo
**Please make sure to back important stuff up before doing anything drastic.**

## What do I need?
- A shell
- [GRUB (UEFI)](https://wiki.gentoo.org/wiki/Grub)
- [Dracut](https://wiki.gentoo.org/wiki/Dracut)
- [All kernel dependencies (or just gentoo-sources)](https://wiki.gentoo.org/wiki/Kernel)


## Basic updating
```bash
$ sudo emerge --sync
$ sudo emerge -uDU --with-bdeps=y @world
```
Update and continue on the next step


## Select the kernel

1. Eselect
```bash
$ eselect kernel list
```

pick a kernel and type:
```bash
$ sudo eselect set <KERNEL_NUMBER>
```

for example:
```bash
$ eselect kernel list
Available kernel symlink targets:
[1]   linux-5.13.13-gentoo *
[2]   linux-5.13.14-gentoo

$ sudo eselect kernel set 2

$ eselect kernel list
Available kernel symlink targets:
[1]   linux-5.13.13-gentoo
[2]   linux-5.13.14-gentoo *
```

2. Manual
or you can symlink the kernel manually:
```bash
$ sudo ln -sf /usr/src/linux-X.Y.Z-gentoo /usr/src/linux
```


## Migrate your configuration
There's few ways of doing this, the ones from gentoo wiki are:
- In the [procfs](https://wiki.gentoo.org/wiki/Procfs) filesystem, if the kernel option Enable access to .config through /proc/config.gz (CONFIG_IKCONFIG_PROC) was activated in the present kernel:
```bash
$ zcat /proc/config.gz > /usr/src/linux/.config
```

- From the old kernel. This will only work when the old kernel was compiled with CONFIG_IKCONFIG:
```bash
$ /usr/src/linux/scripts/extract-ikconfig /path/to/old/kernel >/usr/src/linux/.config
```

- In the `/boot` directory, if the configuration was installed there:
```bash
$ cp /boot/config-X.Y.Z-gentoo /usr/src/linux/.config
```

- In the kernel directory of the currently-running kernel:
```bash
$ cp /usr/src/linux-X.Y.Z-gentoo/.config /usr/src/linux/
```

- in the `/etc/kernels/` directory, if SAVE_CONFIG="yes" is set in /etc/genkernel.conf and genkernel was previously used:
```bash
$ cp /etc/kernels/kernel-config-x86_64-X.Y.Z-gentoo /usr/src/linux/.config
```

I personally copied it from my previous kernel.

### Now make your .config compatible
```bash
$ cd /usr/src/linux
$ sudo make oldconfig
```

Now pick the features you want in the kernel.
type `m` to enable it as a module, `y` to build it into the kernel, `n` to disable the feature and `?` for help.


## Build
Now it's time to build the kernel, run all of these commands one by one or joined together with `&&`:

1. `make` the kernel:
```bash
$ sudo make
```

2. install the modules:
```bash
$ sudo make modules_install
```

3. install the kernel
```bash
$ sudo make install
```

This process can be sped up with passing make the -j`N` flag.


## Rebuild the GRUB config
```bash
$ sudo grub-mkconfig -o /boot/grub/grub.cfg
```


## Make a new initramfs specific to your kernel
```bash
$ sudo dracut --kver X.Y.Z-gentoo
```
You might need to add the `--force` or `-f` flag for this to work


## Boot into your new kernel
Now boot into your new kernel, log in and follow the next steps.


## Let's clean up
Now as you have booted into your new kernel, let's clean up.

0. prepare
```bash
$ sudo su
```
This will drop you into a root shell.


1. (optional) Removing the sources.
```bash
$ rm -r /usr/src/linux-X.Y.Z-gentoo
```

2. Remove the files generated during a build
```bash
$ rm -r /lib/modules/X.Y.Z-gentoo
```

3. Remove the boot files
```bash
$ cd /boot
$ rm /boot/vmlinuz-X.Y.Z-gentoo
$ rm /boot/System.map-X.Y.Z-gentoo
$ rm /boot/initramfs-X.Y.Z-gentoo
$ rm /boot/config-X.Y.Z-gentoo
$ rm *.old
```

4. Remaking the initramfs
```bash
$ dracut --force
```

5. Remaking GRUB config
```bash
$ grub-mkconfig -o /boot/grub/grub.cfg
```


## Rebooting
Now you can reboot and enjoy hopefully not broken kernel.
```bash
$ sudo reboot
```


## Sources
- [Gentoo wiki - kernel:removal](https://wiki.gentoo.org/wiki/Kernel/Removal)
- [Gentoo wiki - kernel:upgrade](https://wiki.gentoo.org/wiki/Kernel/Upgrade)

