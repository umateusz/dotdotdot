DOTDOTDOT_PATH=~/dotdotdot

. $DOTDOTDOT_PATH/system/functions.sh
. $DOTDOTDOT_PATH/system/aliases.sh

for f in $DOTDOTDOT_PATH/local/*; do
    . $f
done

eval $($DOTDOTDOT_PATH/system/functions.py)
