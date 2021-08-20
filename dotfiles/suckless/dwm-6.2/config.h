/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

/* definitions */
char sudo_cmd[5] = "sudo";

/* appearance */
static const unsigned int gappx     = 2;        /* gaps */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const bool doAutostart       = true;     /* autostart */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "sans:size=11",
	"FontAwesome:size=10.5"};
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#211e1d"; /* #222222 */
static const char col_gray2[]       = "#211e1d"; /* #444444 */
static const char col_gray3[]       = "#f9f6e8"; /* #BBBBBB */
static const char col_gray4[]       = "#383838"; /* #EEEEEE */
static const char col_cyan[]        = "#f9f0c2"; /* #005577 */
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 }, /* innnactive bar */
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  }, /* active bar */
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                         instance   title       tags mask     isfloating    isterminal  noswallow   monitor */
	/*                                                      (1 << tag - 1)                     */
	/* all tags */
	{ "ksnip",                      NULL,       NULL,       0,            1,            0,          1,          -1 },
	{ "Tk",                         NULL,       NULL,       0,            1,            0,          1,          -1 },
	{ "st",                         NULL,       NULL,       0,            0,            1,          0,          -1 },
	{ "Alacritty",                  NULL,       NULL,       0,            0,            1,          0,          -1 },
	{ NULL,                         NULL,   "Event Tester", 0,            0,            0,          1,          -1 }, /* xev */
	{ "SimpleScreenRecorder",       NULL,       NULL,       0,            1,            0,          1,          -1 },
	{ "Peek",                       NULL,       NULL,       0,            1,            0,          1,          -1 },
	{ "obs",                        NULL,       NULL,       0,            1,            0,          1,          -1 },

	/* tag 2 */
	{ "firefox",                    NULL,       NULL,       1 << 1,       0,           0,           0,          -1 },
	{ "Tor Browser",                NULL,       NULL,       1 << 1,       0,           0,           0,          -1 },
	{ "LibreWolf",                  NULL,       NULL,       1 << 1,       0,           0,           0,          -1 },
	{ "chromium",                   NULL,       NULL,       1 << 1,       0,           0,           0,          -1 },
    { "qBittorrent",                NULL,       NULL,       1 << 1,       0,           0,           0,          -1 },
    { "kristall",                   NULL,       NULL,       1 << 1,       0,           0,           0,          -1 },
    { "Thunderbird",                NULL,       NULL,       1 << 1,       0,           0,           0,          -1 },

	/* tag 3 */
	{ "Code",                       NULL,       NULL,       1 << 2,       0,           0,           0,          -1 },
	{ "jetbrains-pycharm-ce",       NULL,       NULL,       1 << 2,       0,           0,           0,          -1 },
	{ "VSCodium",                   NULL,       NULL,       1 << 2,       0,           0,           0,          -1 },

	/* tag 4 */
	{ "discord",                    NULL,       NULL,       1 << 3,       0,           0,           0,          -1 },
	{ "TelegramDesktop",            NULL,       NULL,       1 << 3,       0,           0,           0,          -1 },
	{ "KotatogramDesktop",          NULL,       NULL,       1 << 3,       0,           0,           0,          -1 },
    { "Bitwarden",                  NULL,       NULL,       1 << 3,       0,           0,           0,          -1 },

	/* tag 5 */
	{ "Microsoft Teams - Preview",  NULL,       NULL,       1 << 4,       0,           0,           0,          -1 },
	{ "teams-for-linux",            NULL,       NULL,       1 << 4,       0,           0,           0,          -1 },
	{ "zoom",                       NULL,       NULL,       1 << 4,       0,           0,           0,          -1 },

	/* tag 6 */
	{ "VirtualBox Manager",         NULL,       NULL,       1 << 5,       0,           0,           0,          -1 },

	/* tag 7 */
	{ "libreoffice",                NULL,       NULL,       1 << 6,       0,           0,           0,          -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
// static const char *dmenucmd[] = { "rofi", "-show", "run", NULL };
static const char *dmenucmd[] = { "dmenu_run", NULL };

static const char *mutecmd[] = { "amixer", "-q", "set", "Master", "toggle", NULL  };
static const char *volupcmd[] = { "amixer", "-q", "set", "Master", "5%+", "unmute", NULL  };
static const char *voldowncmd[] = { "amixer", "-q", "set", "Master", "5%-", "unmute", NULL  };
// static const char *miccmd[] = { "amixer", "set", "Capture", "toggle", NULL  };

static const char *brupcmd[] = { sudo_cmd, "xbacklight", "-inc", "10", NULL  };
static const char *brdowncmd[] = { sudo_cmd, "xbacklight", "-dec", "10", NULL  };

static const char *bashcmd[] = { "st", "-e", "bash", NULL };
static const char *editorcmd[] = { "st", "-e", "vim", NULL  };
static const char *lockercmd[] = { "xautolock", "-locknow", NULL };
static const char *browser[] = { "firefox", NULL };
static const char *netwmgr[] = { "st", "-e", "nmtui", NULL };

// static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st",  NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	// make a window master
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0}  },
	// toggle bar
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	// cycle through the stack clockwise
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	// cycle thtough the stack anti-clockwise
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	// increases number of windows on master
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
	// decreases number of windows on master
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	// make master smaller
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	// make master larger
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	// useless (not, i didn't understand this)
	// { MODKEY,                       XK_Return, zoom,           {0} },
	// switch to a used tab
	{ MODKEY,                       XK_Tab,    view,           {0} },
	// kill a window
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	// default layout
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	// floating layout
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	// tabbed layout
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	// toggle floating window
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	// toggle floating on all windows
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	// select all tags?
	// { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	// copy a window to all tags?
	// { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	// ???
	// { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	// { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	// { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	// { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
    // gap control
    { MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
    { MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
    { MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
    // switch to tags
	TAGKEYS(                        XK_1,                      0)
		TAGKEYS(                        XK_2,                      1)
		TAGKEYS(                        XK_3,                      2)
		TAGKEYS(                        XK_4,                      3)
		TAGKEYS(                        XK_5,                      4)
		TAGKEYS(                        XK_6,                      5)
		TAGKEYS(                        XK_7,                      6)
		TAGKEYS(                        XK_8,                      7)
		TAGKEYS(                        XK_9,                      8)
		// exit dwm
		{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },

	// media keys
	{ 0,                            XF86XK_AudioMute,         spawn,          {.v = mutecmd }   },
	{ 0,                            XF86XK_AudioLowerVolume,  spawn,          {.v = voldowncmd} },
	{ 0,                            XF86XK_AudioRaiseVolume,  spawn,          {.v = volupcmd}   },
	{ 0,                            XF86XK_MonBrightnessUp,   spawn,          {.v = brupcmd}    },
	{ 0,                            XF86XK_MonBrightnessDown, spawn,          {.v = brdowncmd}  },

	// st + bash
	{ MODKEY|ShiftMask,             XK_b,                     spawn,          {.v = bashcmd}   },
	// vim
	{ MODKEY|ControlMask,           XK_e,                     spawn,          {.v = editorcmd} },
	// locker
	{ MODKEY,                       XK_x,                     spawn,          {.v = lockercmd} },
	// actual full screen patch
	{ MODKEY|ShiftMask,             XK_f,                     togglefullscr,  {0}  },
	// windows
	// { Mod1Mask,                  XK_Tab,                   spawn,          {.v = dmenuwin}  },
	// browser
	{ MODKEY,                       XK_w,                     spawn,          {.v = browser}   },
	// networm management
	{ MODKEY,                       XK_n,                     spawn,          {.v = netwmgr}   }
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

