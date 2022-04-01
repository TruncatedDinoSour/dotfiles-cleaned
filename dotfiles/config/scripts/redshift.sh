#!/usr/bin/env bash
RR=1
GG=1
BB=1
LL=1

NR=1
NG=1
NB=1
NL=1

MIN=0 # min gamma
MAX=200 # max gamma

CON=`xrandr -q | grep con | cut -d " " -f 1 | xargs`
echo "Detected connectors are: $CON"
echo "Which do you want to manipulate?"
array=( $(echo $CON) )
select MON in "${array[@]}"; do

    info() {
        clear
        echo "Working on $MON"
        echo "r/R g/G b/B to move gamma"
        echo "l/L to adjust brightness"
        echo "s to save, q to reset and quit."
    }

set_val() {
    case $1 in
        RED)
            RR=$2
            NR=$(echo "$RR/100" | bc -l)
            ;;
        GREEN)
            GG=$2
            NG=$(echo "$GG/100" | bc -l)
            ;;
        BLUE)
            BB=$2
            NB=$(echo "$BB/100" | bc -l)
            ;;
        BRIGHTNESS)
            LL=$2
            NL=$(echo "$LL/100" | bc -l)
            ;;
    esac
    info
}

inc_gamma() {
    let "VAL = $1 + 5"
    if (( "$VAL" < "$MAX" )); then
        set_val $2 $VAL
        echo "$2 increased to $VAL"
    else
        echo "$2 cannot be increased above or to $MAX."
    fi
    info
}

dec_gamma() {
    let "VAL = $1 - 5"
    if (( "$VAL" > "$MIN" )); then
        set_val $2 $VAL
        echo "$2 decreased to $VAL"
    else
        echo "$2 cannot be decreased below or to $MIN."
    fi
    info
}

info
while read -n1 -s; do
    case $REPLY in
        R) inc_gamma $RR "RED" ;;
        r) dec_gamma $RR "RED" ;;
        G) inc_gamma $GG "GREEN" ;;
        g) dec_gamma $GG "GREEN" ;;
        B) inc_gamma $BB "BLUE" ;;
        b) dec_gamma $BB "BLUE" ;;
        L) inc_gamma $LL "BRIGHTNESS" ;;
        l) dec_gamma $LL "BRIGHTNESS" ;;
        s|S)
            echo "xrandr --output $MON --gamma $NR:$NG:$NB --brightness $LL" > ~/xrandrconf
            chmod u+x ~/xrandrconf
            echo "Saved as ~/xrandrconf"
            exit 0
            ;;
        q|Q)
            xrandr --output $MON --gamma 1.0:1.0:1.0 --brightness 1.0
            exit 0
            ;;
    esac

    xrandr --output $MON --gamma $NR:$NG:$NB --brightness $NL > /dev/null 2>&1
done
done
