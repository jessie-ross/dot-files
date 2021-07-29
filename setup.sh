#!/bin/bash

set -o noclobber

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# # Vim/Neovim
mkdir ~/.config 2>/dev/null
ln -sh "${SCRIPT_DIR}/nvim" ~/.config/nvim
ln -sh "${SCRIPT_DIR}/vim" ~/.vim
ln -sh "${SCRIPT_DIR}/vimrc" ~/.vimrc

# # Zshrc
# We have copy a blank zshrc down when one doesn't exist and source in the main
# one as a lot of local junk gets copied in there.
cp "${SCRIPT_DIR}/zshrc" ~/.zshrc 
ln -sh "${SCRIPT_DIR}/zshrc.main" ~/.zshrc.main

# # Git
ln -sh "${SCRIPT_DIR}/gitconfig" ~/.gitconfig
