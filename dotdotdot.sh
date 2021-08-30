DOTDOTDOT_PATH=~/dotdotdot

. $DOTDOTDOT_PATH/system/functions.sh
. $DOTDOTDOT_PATH/system/aliases.sh
export PATH=$PATH:$DOTDOTDOT_PATH/system/bin

for f in $DOTDOTDOT_PATH/local/*(.N); do
    . $f
done

eval $($DOTDOTDOT_PATH/system/functions.py)
