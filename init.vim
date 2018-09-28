
call plug#begin()
  Plug 'jszakmeister/vim-togglecursor'
  Plug 'zchee/deoplete-jedi'
  Plug 'davidhalter/jedi-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'python-mode/python-mode', { 'branch': 'develop' }
  Plug 'scrooloose/nerdcommenter'
  Plug 'rking/ag.vim'
  Plug 'tpope/vim-repeat'
  Plug 'tmhedberg/SimpylFold'
  Plug 'itchyny/lightline.vim'
  Plug 'xolox/vim-lua-ftplugin'
  Plug 'xolox/vim-misc'
  Plug 'chr4/nginx.vim'
  Plug 'vimwiki/vimwiki'
call plug#end()

" BASIC SETTINGS
set tags=./tags;,tags;
set background=dark
set number
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set autowrite		" Automatically save before commands like :next and :make
set foldmethod=syntax
set foldopen-=block
set foldnestmax=1
set hidden		" Hide buffers when they are abandoned
set relativenumber
let mapleader = " "
autocmd FileType python set colorcolumn=120
autocmd BufRead,BufNewFile *.conf setfiletype conf
let g:pymode_options_max_line_length = 120
let g:jedi#use_tabs_not_buffers = 0
let g:fzf_command_prefix = 'Fzf'
let g:notes_directories = ['~/Documents/Notes']
nnoremap <leader>t :FzfFiles<cr>
nnoremap <leader>j :FzfBuffers<cr>
map <C-n> ;NERDTreeToggle<CR>

"let g:pymode_rope = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo=1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif  
"window resize
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
noremap <cr> i<cr><esc>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map vv V
tnoremap <Esc> <C-\><C-n>
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
cnoremap %% <C-R>=expand('%:h').'/'<cr>
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

function! CompileFile()
  let file_name = expand('%')
  let file_no = expand('%:r')
  exec ':w' 
  exec ':!javac'  file_name
  exec ':!java' file_no
endfunction

function! RunNode()
  let file_name = expand('%')
  exec ':w' 
  exec ':!node'  file_name
endfunction

function! RunScala()
  let file_name = expand('%')
  exec ':w' 
  exec ':!scala'  file_name
endfunction

function! RunPython()
  let file_name = expand('%')
  exec ':w' 
  exec ':!python3 -m unittest'  file_name
endfunction

function! OnJava()
  abbr log System.out.println("");<Left><Left><Left>
  abbr main public static void main(String [] args) {<CR>}<Esc>O
  abbr classg class expand('%:t') {<CR>}<Esc>O
  abbr fori for( int c = 0; c ; c++) {<CR><CR> }<Esc>?c<CR>
  noremap <leader>a  :call CompileFile()<CR>
endfunction

function! OnJS()
  abbr log console.log("");<Left><Left><Left>
  noremap <leader>a  :call RunNode()<CR>
endfunction

function! OnScala()
  abbr main def main(args: Array[String]) {<CR>}<Esc>O
  noremap <leader>a  :call RunScala()<CR>
endfunction

function! OnPython()
  nnoremap ,test :-1read ~/myConfig/test.py<CR>/placeholder<CR>ciw
  ab deb from pudb set_trace; set_trace()
  noremap <leader>a  :call RunPython()<CR>
  set foldmethod=indent
  let g:pymode_options_max_line_length = 120
  let g:jedi#show_call_signatures = 2
  let g:pymode_lint_on_write = 0
  let g:pymode_options_colorcolumn = 0
  nnoremap <leader>l :PymodeLint<cr>
  nnoremap <leader>f :PymodeLintAuto<cr>
nnoremap <leader>. :call OpenTestAlternate()<cr>
noremap <leader>r :%s/old/new/gc
endfunction

autocmd FileType python set colorcolumn=120
autocmd BufRead *.py setlocal colorcolumn=0

function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let file_name = expand("%:t:r")
  let file_path = expand("%:h")
  let new_file = file_path . file_name
  let in_spec = match(current_file, '^Test/') != -1

  if !in_spec
    echo file_path
    let new_file = 'test/' . file_path . '/Test' .  file_name . '.py'
  else
    let new_file_path = substitute(file_path, 'test/', '', '')
    let new_file_name = substitute(file_name, 'Test', '', '')
    let new_file = new_file_path . '/' . new_file_name . '.py'
  endif
  return new_file
endfunction

autocmd BufNewFile,BufRead *.java :call OnJava()
autocmd BufNewFile,BufRead *.js :call OnJS()
autocmd BufNewFile,BufRead *.scala :call OnScala()
autocmd BufNewFile,BufRead *.py :call OnPython()

map <leader>n :call RenameFile()<cr>
set wildignore+=node_modules,*.png,*.dll,*.class,*.cache,*.xml
set noswapfile
filetype plugin indent on
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
let g:ycm_server_python_interpreter = 'python'
"let g:UltiSnipsExpandTrigger=" "
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

set guicursor=

let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.scala   = '[^. *\t]\.\w*'

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" https://github.com/Shougo/deoplete.nvim/issues/100
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Lazy load Deoplete to reduce statuptime
" See manpage
" Enable deoplete when InsertEnter.

"autocmd InsertEnter * call deoplete#enable()
let g:EclimCompletionMethod = 'omnifunc'

"MAPINGS


nnoremap <CR> za
nnoremap ; : 
nnoremap : ;
nnoremap <tab> gt
noremap <leader>f =i}
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map vv V
tnoremap <Esc> <C-\><C-n>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
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

noremap <leader>r :%s/\(<c-r>=expand("<cword>")<cr>\)//gc<LEFT><LEFT><LEFT>

cnoremap %w <C-R>=expand("<cword>")<cr>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
cnoremap new tabnew 
cnoremap rc e ~/myConfig/init.vim

if exists('$TMUX')
    let &t_EI = "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\033]PlFBA922\033\\"
    silent !echo -ne "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"
    autocmd VimLeave * silent !echo -ne "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"
else
    let &t_EI = "\033]Pl3971ED\033\\"
    let &t_SI = "\033]PlFBA922\033\\"
    silent !echo -ne "\033]Pl3971ED\033\\"
    autocmd VimLeave * silent !echo -ne "\033]Pl3971ED\033\\"
  endif


hi ColorColumn ctermbg=0 guibg=#eee8d5
let g:diminactive_use_syntax = 1
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
call deoplete#custom#source('_',  'max_menu_width', 0)
call deoplete#custom#source('_',  'max_abbr_width', 0)
call deoplete#custom#source('_',  'max_kind_width', 0)
