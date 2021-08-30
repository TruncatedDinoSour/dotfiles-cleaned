# Defined in ./fish_funcs_add.fish @ line 56
function tars
    if count $argv > /dev/null
        /usr/bin/tar -tvf $argv
    else
        echo "tars - show the contents of a .tar.gz archive"
        echo "usage: tars <file>"
    end
end
