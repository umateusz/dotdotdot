#!/bin/bash

DOTDOTDOT_PATH=~/dotdotdot

function backup_file()
{
    date=`date '+%Y-%m-%d-%H-%M-%S-%s'`
    filename=`basename "$1"`
    new_filename=$filename-$date
    cp -r $1 $DOTDOTDOT_PATH/backups/$new_filename
}

## bash stuff
# check if project is aready installed
# if [ -n "$(cat ~/.bashrc | grep dotdotdot)" ]; then
#     echo "dotdotdot already installed"
#     exit 0
# fi

# backup_file ~/.bashrc

# add_to_bashrc='
# ### dotdotdot ###

# # load all files from ~/dotdotdot/system
# if [ -f ~/dotdotdot/dotdotdot.sh ]; then
#     . ~/dotdotdot/dotdotdot.sh
# fi'
# echo "$add_to_bashrc" >> ~/.bashrc
# source ~/.bashrc

echo "Running apt-get..."
sudo apt-get update && sudo apt-get install $(cat $DOTDOTDOT_PATH/system/apt.list)

echo "Linking zsh files..."
backup_file ~/.zshrc
ln -s $DOTDOTDOT_PATH/system/.zshrc ~/.zshrc

echo "Running python pip install"
/usr/bin/python3 -m pip install -r $DOTDOTDOT_PATH/system/py_requirements.txt

echo "Cloning oh-my-zsh"
git clone https://github.com/robbyrussell/oh-my-zsh.git $DOTDOTDOT_PATH/plugins/oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions $DOTDOTDOT_PATH/plugins/oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $DOTDOTDOT_PATH/plugins/oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "Changing default shell..."
chsh -s $(which zsh)

echo "Linking vscode settings..."
backup_file ~/.config/Code/User/settings.json
backup_file ~/.config/Code/User/keybindings.json
backup_file ~/.config/Code/User/snippets/

rm -rf ~/.config/Code/User/settings.json
rm -rf ~/.config/Code/User/keybindings.json
rm -rf ~/.config/Code/User/snippets

ln -s $DOTDOTDOT_PATH/system/vscode/settings.json ~/.config/Code/User/settings.json
ln -s $DOTDOTDOT_PATH/system/vscode/keybindings.json ~/.config/Code/User/keybindings.json
ln -s $DOTDOTDOT_PATH/system/vscode/snippets ~/.config/Code/User/snippets

echo "Linking git"
backup_file ~/.gitconfig
mv ~/.gitconfig ~/.gitconfig-local
ln -s $DOTDOTDOT_PATH/system/.gitconfig ~/.gitconfig
