# Defined in ./fish_funcs_add.fish @ line 40
function tarc
    if count $argv > /dev/null
        /usr/bin/tar -czvf $argv[1] $argv[2..-1]
    else
        echo "tarc - compress folders into .tar.gz files"
        echo "usage: <name> <folder(s)>"
    end
end
