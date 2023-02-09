#!/bin/bash

# NOTE: will clone repos onto local machine and accessed from within VM

# ensure user is non-privileged
if [[ ! $USER == "vagrant" ]]
then
	echo "WARNING: setup script not run as vagrant user. Exiting."
	exit 1
fi

echo 'Installing Python 3...'
sudo apt update > /dev/null 2>&1
sudo apt install -y software-properties-common > /dev/null 2>&1
sudo add-apt-repository -y ppa:deadsnakes/ppa > /dev/null 2>&1
sudo apt update > /dev/null 2>&1
sudo apt install -y python3.8 python3-venv > /dev/null 2>&1

echo "Installing pip3..."
sudo apt install -y python3-pip > /dev/null 2>&1

echo "Setting up bashrc..."
# grab bashrc from github
git clone https://github.com/alexfoster/bashrc.git $HOME/sync_folder/bashrc > /dev/null 2>&1
cp $HOME/.bashrc $HOME/.bashrc_original
ln -sf $HOME/sync_folder/bashrc/.bashrc $HOME/.bashrc

echo "Setting up vimrc..."
# grab vimrc from github
git clone https://github.com/alexfoster/vimrc.git $HOME/sync_folder/vimrc > /dev/null 2>&1
ln -sf $HOME/sync_folder/vimrc/.vimrc $HOME/.vimrc

echo "Setting up tmux..."
git clone https://github.com/samoshkin/tmux-config.git $HOME/sync_folder/tmux-config > /dev/null 2>&1
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm > /dev/null 2>&1
cp -a $HOME/sync_folder/tmux-config/tmux/. $HOME/.tmux/
ln -sf $HOME/.tmux/tmux.conf $HOME/.tmux.conf
tmux new -d -s __noop >/dev/null 2>&1 || true
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins"
$HOME/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true
