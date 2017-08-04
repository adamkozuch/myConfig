if has("syntax")
  syntax on
endif
execute pathogen#infect()

set background=dark
set number
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
let mapleader = " "
imap jk <esc>
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <leader>s <C-c>:w<cr>
noremap <leader>r :%s/old/new/gc
noremap <leader>f =i}
noremap <leader>c ciw
noremap <leader>v v%
noremap <cr> i<cr><esc>
map vv V
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-j>  10j
map <C-k> 10k
" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]
map <Leader>p :pastetoggle
cnoremap %% <C-R>=expand('%:h').'/'<cr>
execute pathogen#infect()
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent

"making current window more obvous
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

map <leader>n :call RenameFile()<cr>
" java compile
" run class
set wildignore+=node_modules,*.png,*.dll
set noswapfile
filetype plugin indent on
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:UltiSnipsExpandTrigger=" "
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let @q = 'biconsole.log(jkwwbea)'
noremap <leader>l @q
