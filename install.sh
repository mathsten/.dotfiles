sudo apt-get update
sudo apt upgrade

# install zshell
sudo apt install zsh
chsh -s $(which zsh)

# install git
sudo apt install git

# install vim
sudo apt remove --assume-yes vim-tiny
sudo apt update
sudo apt install --assume-yes vim

# install tmux
sudo apt install tmux
