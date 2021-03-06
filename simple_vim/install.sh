#!/bin/bash
INSTALL_DIR=$PWD

if [ -d "~/.vim" ]; then
    mv ~/.vim ~/.vim.`date +%m%d-%H:%M`.bak
fi
if [ -d "~/.vimrc" ]; then
    mv ~/.vimrc ~/.vimrc.`date +%m%d-%H:%M`.bak
fi

curl -fsLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp -r $INSTALL_DIR/colors/ ~/.vim/
cp $INSTALL_DIR/vimrc ~/.vimrc

vim +PlugInstall


sed -i '/colorscheme solarized/s/^" //' ~/.vimrc
sed -i '/autocmd/s/^" //' ~/.vimrc
