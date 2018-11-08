
call plug#begin()
  Plug 'mhinz/vim-startify'
  Plug 'morhetz/gruvbox'
  Plug 'zhaocai/GoldenView.Vim'
  Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' }
  Plug 'nvie/vim-flake8'
  Plug 'posva/vim-vue'
  Plug 'ternjs/tern_for_vim'
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'airblade/vim-gitgutter'
  Plug 'bling/vim-bufferline'
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
  "Plug 'python-mode/python-mode', { 'branch': 'develop' }
  Plug 'scrooloose/nerdcommenter'
  Plug 'rking/ag.vim'
  Plug 'tpope/vim-repeat'
  Plug 'itchyny/lightline.vim'
  Plug 'xolox/vim-lua-ftplugin'
  Plug 'xolox/vim-misc'
  Plug 'chr4/nginx.vim'
  Plug 'vimwiki/vimwiki'
  Plug 'gcmt/taboo.vim'
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'metakirby5/codi.vim'
call plug#end()

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
command Gs Gstatus
command Gc Gcommit
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }




" BASIC SETTINGS
set tags=./tags;,tags;
set background=dark
set number
"set showmode off
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
let g:fzf_command_prefix = 'Fzf'
let g:notes_directories = ['~/Documents/Notes']
"nnoremap <leader>t :FzfGFiles<cr>
nnoremap <silent> <leader>t :call FZFOpen(':FzfGFiles')<CR>
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
noremap <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map vv V
tnoremap <Esc> <C-\><C-n>
map <C-h> <C-w>h
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
  nnoremap <C-]>  :call jedi#goto_definitions()<CR>
  nnoremap ,test :-1read ~/myConfig/test.py<CR>/placeholder<CR>ciw
  ab deb from pudb set_trace; set_trace()
  noremap <leader>a  :call RunPython()<CR>
  set foldmethod=manual
  "let g:pymode_options_max_line_length = 120
  let g:jedi#show_call_signatures = 1
  let g:jedi#popup_on_dot = 0
  "let g:pymode_options_colorcolumn = 0
  "let g:pymode_lint_cwindow = 0
  "let g:pymode_lint_on_write = 1
  let g:jedi#use_tabs_not_buffers = 0
  let g:jedi#usages_command = "<leader>s"
  let g:jedi#rename_command = "<leader>r"
  nnoremap <leader>l :call Flake8()<cr>
  "nnoremap <leader>f :PymodeLintAuto<cr>
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
cnoremap rc e ~/myConfig/init.vim<C-b>
cnoremap test :!python3 -m unittest discover -s ./test/ -p 'Test*.py'
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
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction



colorscheme gruvbox
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename'
      \ }
      \ }
call deoplete#custom#source('_',  'max_menu_width', 0)
call deoplete#custom#source('_',  'max_abbr_width', 0)
call deoplete#custom#source('_',  'max_kind_width', 0)

nnoremap <leader>s :Ag! --python "\b\s?<C-R><C-W>\b"<CR>:cw<CR>:redr!<CR>

let g:golden_ratio_exclude_nonmodifiable = 1
let g:goldenview__enable_default_mapping = 0

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

imap <C-L> <C-X><C-L> 
let g:deoplete#max_list = 10
let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

