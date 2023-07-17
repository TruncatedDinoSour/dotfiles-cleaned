# python startup file
import atexit
import os
import readline
import rlcompleter

# tab completion
readline.parse_and_bind("tab: complete")

# history file
histfile = os.path.join(os.environ["HOME"], ".cache", ".python_history")

if not os.path.exists(histfile):
    open(histfile, "w").close()

try:
    readline.read_history_file(histfile)
except IOError:
    pass

atexit.register(readline.write_history_file, histfile)
atexit.register(readline.read_history_file, histfile)
readline.set_history_length(1000)

del os, histfile, readline, rlcompleter

e = exit
