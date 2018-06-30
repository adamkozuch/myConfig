#!/bin/sh
# install ruby before
 git config --global core.editor vim &&
sudo apt-get install ruby ruby-dev vim-nox &&
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim &&
cd ~/.vim &&
 git clone https://github.com/wincent/command-t.git bundle/command-t &&
cd ~/.vim/bundle/command-t/ruby/command-ti &&
ruby extconf.rb &&
make 

