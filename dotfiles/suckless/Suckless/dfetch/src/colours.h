#ifndef _COLOURS_H
#define _COLOURS_H
#define COLOUR(code) "\033[" code "m"

#define RED    COLOUR("31")
#define GREEN  COLOUR("32")
#define YELLOW COLOUR("33")
#define BLUE   COLOUR("34")
#define GRAY   COLOUR("37")
#define BOLD   COLOUR("1")
#define RESET  COLOUR("0")
#endif /* _COLOURS_H */
