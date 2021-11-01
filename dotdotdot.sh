DOTDOTDOT_PATH=~/dotdotdot

. $DOTDOTDOT_PATH/system/functions.sh
. $DOTDOTDOT_PATH/system/aliases.sh
export PATH=$PATH:$DOTDOTDOT_PATH/system/bin
export PATH=$PATH:$HOME/go/bin

for f in $DOTDOTDOT_PATH/local/*(.N); do
    . $f
done

# load auto complete for custom scripts
bashcompinit
autoload bashcompinit
source $DOTDOTDOT_PATH/plugins/bash_completion.d/python-argcomplete

SCRIPTS_WITH_COMPLETE=(\
)

for script in "${SCRIPTS_WITH_COMPLETE[@]}"; do
    eval "$($DOTDOTDOT_PATH/.venvs/dotdotdot/bin/register-python-argcomplete $script)"
done
