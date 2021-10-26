local red = "\27[31m"
local grn = "\27[32m"
local yel = "\27[33m"
local blu = "\27[34m"
local mag = "\27[35m"
local cyn = "\27[36m"
local wht = "\27[37m"
local bld = "\27[1m"
local res = "\27[0m"

yafetch.sep = " ~ "
yafetch.sep_color = bld

-- if set to false, yafetch.shell() will return
-- the full path of the current shell
yafetch.shell_base = true
local shell = yafetch.shell()
local shell_icon = " "

local username = yafetch.user()
local hostname = yafetch.hostname()

local kernel = yafetch.kernel()
local kernel_icon = " "

local pkgs = yafetch.pkgs()
local pkgs_icon = " "

local distro = yafetch.distro()
local distro_icon

if distro == "Arch Linux" then
    distro_icon = " "
elseif distro == "NixOS" then
    distro_icon = " "
elseif distro == "Ubuntu" then
    distro_icon = " "
elseif distro == "Alpine Linux" then
    distro_icon = " "
else
    distro_icon = " "
end

if os.getenv("USER") == "root" then
    --[
    -- Dear future me,
    -- I am very sorry for the bad formatting,
    -- I cannot make it any prettier :(
    -- I hope you're not too mad about it...
    --]

    ascii1 = grn .. "    \\^V//       "  .. red .. bld
    ascii2 = res .. "    |. .|       "   .. res
    ascii3 = res .. "  - \\ - / _     "  .. res
    ascii4 = res .. "   \\_| |_/      "  .. res
    ascii5 = res .. "     \\ \\        " .. res
    ascii6 = res .. "   "                .. red .. "__" .. res .. "/_/" .. red .. "__      "   .. res
    ascii7 = red .. "  |_______|     "   .. res
    ascii8 = red .. "   \\     /      "  .. res .. "I am (g)root, don't break me"              .. res
    ascii9 = red .. "    \\___/       "  .. res

    root_mode = true
    root_extras = {
        [1] = ascii6,
        [2] = ascii7,
        [3] = ascii8,
        [4] = ascii9
    }
else
    ascii1 = wht .. " ,d88b.d88b,    " .. res
    ascii2 = red .. " 88888888888    " .. res
    ascii3 = grn .. " `Y8888888Y´    " .. res
    ascii4 = yel .. "   `Y888Y´      " .. res
    ascii5 = blu .. "     `Y´        " .. res
end

yafetch.header_sep = string.format("%s@%s", blu, res)
yafetch.header_sep_color = bold
yafetch.header_format = ascii1 -- could be ascii1, an icon, etc.

function yafetch.init()
    yafetch.header()
    yafetch.format(ascii2 .. res .. red, distro_icon, wht, distro)
    yafetch.format(ascii3 .. res .. grn, shell_icon, wht, shell)
    yafetch.format(ascii4 .. res .. yel, kernel_icon, wht, kernel)
    yafetch.format(ascii5 .. res .. blu, pkgs_icon, wht, pkgs)

    if root_mode then
        for _, extra_art in ipairs(root_extras) do
            print(extra_art)
        end
    end
end

