#!/bin/bash

DOTDOTDOT_PATH=~/dotdotdot

function backup_file()
{
    date=`date '+%Y-%m-%d-%H-%M-%S-%s'`
    filename=`basename "$1"`
    new_filename=$filename-$date
    cp $1 $DOTDOTDOT_PATH/backups/$new_filename
}

# check if project is aready installed
if [ -n "$(cat ~/.bashrc | grep dotdotdot)" ]; then
    echo "dotdotdot already installed"
    exit 0
fi

backup_file ~/.bashrc

add_to_bashrc='
### dotdotdot ###

# load all files from ~/dotdotdot/system
for file in $(find ~/dotdotdot/system)
    do
        if [ -f $file ]; then
	    . $file
        fi
done'
echo "$add_to_bashrc" >> ~/.bashrc

source ~/.bashrc