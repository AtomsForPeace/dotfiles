#!/usr/bin/bash


echo "Setting up dotfiles."

base_dir=$(PWD)

# Install packages 
echo "Installing packages with apt-get"
apt install -y tmux git firefox

# Neovim
echo "Fetching neovim"
apt install -y tmux git 
mkdir ~/Apps/ 
cd ~/Apps/
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
cd base_dir

# Rust 
echo "Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Rye
echo "Installing rye"
curl -sSf https://rye-up.com/get | bash 
