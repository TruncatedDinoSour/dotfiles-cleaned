# Defined in ./fish_funcs_add.fish @ line 20
function b
    if count $argv > /dev/null
        /usr/bin/$argv[1] $argv[2..-1]
    else
        echo "b - execute binary files directly"
        echo "usage: b <command name> [options]"
    end
end
