# Defined in ./fish_funcs_add.fish @ line 11
function cin
    if count $argv > /dev/null
	    gcc $argv -o main -lm
    else
        echo "cin - compile c files as a linked lib"
        echo "usage: cin <c source>"
    end
end
