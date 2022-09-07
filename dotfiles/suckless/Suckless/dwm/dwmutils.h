static const unsigned char ALL_TAGS = 0;

#define mk_tag(tag) 1 << (tag - 1)
#define mk_atag(cls, tag)                                                      \
    { cls, NULL, NULL, tag, -1 }
#define mk_ftag(cls, tag) mk_atag(cls, mk_tag(tag))
#define mk_command(...)                                                        \
    { __VA_ARGS__, NULL }
