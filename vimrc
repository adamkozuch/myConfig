if has("syntax")
  syntax on
endif

set background=dark

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned

imap<c-l> <space>=><space>
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
let mapleader = ","
execute pathogen#infect() Source a global configuration file if available
set expandtab
set shiftwidth=2
set softtabstop=2
"making current window more obvous
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END
