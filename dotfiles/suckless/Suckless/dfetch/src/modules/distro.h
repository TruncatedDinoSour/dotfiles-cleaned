#ifndef _DISTRO_H
#define _DISTRO_H
static char *distro(void);

#ifdef MODULE_DISTRO
static char *distro(void) {
    int fd;
    char *p, *buffer;
    size_t bytes_read;

    if ((fd = open("/etc/os-release", O_RDONLY)) == -1)
        return NULL;

    bytes_read =
        read(fd, (buffer = malloc(MAX_DISTRO_LENGTH)), MAX_DISTRO_LENGTH);
    close(fd);

    if (bytes_read > 0 && (p = strstr(buffer, DISTRO_NAME_ATTR))) {
        *strchr((p += strlen(DISTRO_NAME_ATTR)), '\n') = '\0';
        strcpy(buffer, p);
        return buffer;
    }

    free(buffer);
    return NULL;
}
#endif /* MODULE_DISTRO */
#endif /* _DISTRO_H */
