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
if [ -f ~/dotdotdot/dotdotdot.sh ]; then
    . ~/dotdotdot/dotdotdot.sh
fi'
echo "$add_to_bashrc" >> ~/.bashrc

source ~/.bashrc

echo "Running apt-get..."
sudo apt-get update && sudo apt-get install $(cat $DOTDOTDOT_PATH/system/apt.list)

echo "Running python pip install"
/usr/bin/python3 -m pip install -r $DOTDOTDOT_PATH/system/py_requirements.txt
