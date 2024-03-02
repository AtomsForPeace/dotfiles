#!/usr/bin/bash

old_dir=~/dotfiles_old/

mkdir $old_dir
mkdir ~/.config

# Set up symlinks
echo "Creating symlinks"
ln -s nvim/ ~/.config/nvim/
mv ~/.profile $old_dir
ln -s .profile ~/.profile
mv ~/.bashrc $old_dir
ln -s .bashrc ~/.bashrc
mv ~/.zshrc $old_dir
ln -s .zshrc ~/.zshrc
mv ~/.tmux.conf $old_dir
ln -s .tmux.conf ~/.tmux.conf
mv ~/.gitconfig $old_dir
ln -s .gitconfig ~/.gitconfig
mv ~/.tmux/ $old_dir
ln -s .tmux/ 
