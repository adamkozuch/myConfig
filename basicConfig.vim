
noremap <Left> <c-w><
noremap <Right> <c-w>>
noremap <silent> <C-Right> <c-w>l
noremap <silent> <C-Left> <c-w>h
noremap <silent> <C-Up> <c-w>k
noremap <silent> <C-Down> <c-w>j
noremap <Up> <c-w>-
noremap <Down> <c-w>+

imap jk <esc>
noremap <leader>s <C-c>:w<cr>
noremap <leader>r :%s/old/new/gc
noremap <leader>f =i}
noremap <leader>c ciw
noremap <leader>v v%
noremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map vv V
tnoremap <Esc> <C-\><C-n>
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]
cnoremap %% <C-R>=expand('%:h').'/'<cr>
imap <C-L> <C-X><C-L> 
nnoremap <tab> gt
noremap <leader>f =i}
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map vv V
tnoremap <Esc> <C-\><C-n>
noremap <Left> <c-w><
noremap <Right> <c-w>>
noremap <Up> <c-w>-
noremap <Down> <c-w>+
imap jk <esc>
noremap <leader>s <C-c>:w<cr>

noremap <leader>r :%s/\(<c-r>=expand("<cword>")<cr>\)//gc<LEFT><LEFT><LEFT>

cnoremap %w <C-R>=expand("<cword>")<cr>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
cnoremap new tabnew 
cnoremap rce e ~/.config/nvim/init.vim<C-b>
cnoremap rcs so ~/.config/nvim/init.vim<C-b>
cnoremap test :!python3 -m unittest discover -s ./test/ -p 'Test*.py'
noremap <C-h> <C-w>h
