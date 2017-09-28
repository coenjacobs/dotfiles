#!/bin/bash
# Setup symlinks for main dotfiles in home directory
# This badly needs to be turned into a for loop...

if [ -e ~/.ackrc ];
then
	mv ~/.ackrc ~/.old-ackrc
fi
ln -s ~/.dotfiles/ack/.ackrc ~/.ackrc

if [ -e ~/.tmux.conf ];
then
	mv ~/.tmux.conf ~/.old-tmux.conf
fi
ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf

if [ -e ~/.vimrc ];
then
	mv ~/.vimrc ~/.old-vimrc
fi
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc

if [ -e ~/.zshrc ];
then
	mv ~/.zshrc ~/.old-zshrc
fi
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

if [ -e ~/.composer/composer.json ];
then
	mv ~/.composer/composer.json ~/.composer/.old-composer.json
fi
ln -s ~/.dotfiles/composer/composer.json ~/.composer/composer.json
