# Defined in ./fish_funcs_add.fish @ line 48
function tard
    if count $argv > /dev/null
        /usr/bin/tar -zxvf $argv
    else
        echo "tard - decompress .tar.gz archives"
        echo "usage: tard <file>"
    end
end
