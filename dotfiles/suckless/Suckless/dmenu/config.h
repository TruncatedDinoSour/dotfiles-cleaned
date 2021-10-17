/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

const static int dmenuwpx = 430;             /* dmenu width */
static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"firamono:size=11.5",
    "unifont"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*                          fg         bg       */
	[SchemeNorm]          =  { "#BBBBBB", "#262220" },
	[SchemeSel]           =  { "#383838", "#f9f0c2" },
	[SchemeSelHighlight]  =  { "#3f3f3f", "#f9f0c2" },
	[SchemeNormHighlight] =  { "#383838", "#262220" },
	[SchemeOut]           =  { "#262220", "#f9f0c2" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 12;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static const unsigned int border_width = 2;

