# Defined in ./fish_funcs_add.fish @ line 28
function l
    if count $argv > /dev/null
        $argv | /usr/bin/less
    else
        set tmpver (less)
        if not string match -ri "[Mm]issing [Ff]ilename.*"
            echo "l - show output as less"
            echo "usage: l <command> [options]"
        end
    end
end
