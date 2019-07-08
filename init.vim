
call plug#begin()
  "Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
  "Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mihaifm/vimpanel'
  Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  Plug 'python-rope/ropevim'
  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'deoplete-plugins/deoplete-jedi'
  Plug 'justinmk/vim-sneak'
  Plug 'Yggdroot/indentLine'
  Plug 'Shougo/Unite.vim'
  Plug 'Shougo/tabpagebuffer.vim'
  Plug 'ap/vim-buftabline'
  Plug 'mrtazz/simplenote.vim'
  Plug 'Raimondi/delimitMate'
  Plug 'mhinz/vim-startify'
  Plug 'morhetz/gruvbox'
  Plug 'nvie/vim-flake8'
  Plug 'posva/vim-vue'
  Plug 'ternjs/tern_for_vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'bling/vim-bufferline'
  Plug 'jszakmeister/vim-togglecursor'
  Plug 'davidhalter/jedi-vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
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
  "Plug 'chr4/nginx.vim'
  Plug 'vimwiki/vimwiki'
  Plug 'gcmt/taboo.vim'
  "Plug 'metakirby5/codi.vim'
  "Plug 'beeender/Comrade'
call plug#end()

let g:indentLine_enabled = 0




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
filetype plugin on
let mapleader = " "
autocmd FileType python set colorcolumn=120
autocmd BufRead,BufNewFile *.conf setfiletype conf
"nnoremap <leader>t :FzfGFiles<cr>

"let g:pymode_rope = 1
"window resize
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
  let file_name = expand('%:p:h')
  exec ':w' 
  exec ':!./manage.py test --keepdb'  file_name
endfunction

function! OnJava()
  abbr log System.out.println("");<Left><Left><Left>
  abbr main public static void main(String [] args) {<CR>}<Esc>O
  abbr classg class expand('%:t') {<CR>}<Esc>O
  abbr fori for( int c = 0; c ; c++) {<CR><CR> }<Esc>?c<CR>
  noremap <leader>a  :call CompileFile()<CR>
endfunction


function! OnScala()
  abbr main def main(args: Array[String]) {<CR>}<Esc>O
  noremap <leader>a  :call RunScala()<CR>
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

set guicursor=


autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" https://github.com/Shougo/deoplete.nvim/issues/100
" use tab to forward cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Lazy load Deoplete to reduce statuptime
" See manpage
" Enable deoplete when InsertEnter.


"MAPINGS




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

function! LightlineWorkingDirectory()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction



"colorscheme gruvbox
set notermguicolors
nnoremap <leader>s :Ag! --python "\b\s?<C-R><C-W>\b"<CR>:cw<CR>:redr!<CR>


autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction


source ~/myConfig/langConfig.vim
source ~/myConfig/basicConfig.vim
source ~/myConfig/pluginConfig.vim

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

nnoremap <ESC>j :m+<CR>==

noremap <A-s>  :FzfAg<CR>
noremap <A-q>  :q<Cr>
noremap <A-r>  :call jedi#rename()<cr>
let g:jedi#jedi_completion_enabled = 1
let g:jedi#completions_command = "<A-n>"
let g:jedi#popup_on_dot = 1



"set rtp+=~/.config/nvim/plugged/deoplete.nvim

let g:python3_host_prog = '/usr/bin/python3.7'
let g:deoplete#enable_at_startup = 1

let g:deoplete#enable_profile = 1
let g:sneak#use_ic_scs = 1
let g:sneak#label = 0

autocmd! bufwritepost .vimrc source %


nnoremap <silent> s :<C-U>call sneak#wrap('',           2, 0, 2, 2)<CR>
nnoremap <silent> S :<C-U>call sneak#wrap('',           2, 1, 2, 2)<CR>
xnoremap <silent> s :<C-U>call sneak#wrap(visualmode(), 2, 0, 2, 2)<CR>
xnoremap <silent> S :<C-U>call sneak#wrap(visualmode(), 2, 1, 2, 2)<CR>
onoremap <silent> s :<C-U>call sneak#wrap(v:operator,   2, 0, 2, 2)<CR>
onoremap <silent> S :<C-U>call sneak#wrap(v:operator,   2, 1, 2, 2)<CR>
"makes clipboard common for system and vim
set clipboard+=unnamedplus

map <CR> <CR>
noremap <A-j> }
noremap <A-k> {
noremap <A-g>  :FzfAg <CR>
noremap <leader>sc  :FzfAg <CR>'class ):$ 
noremap <leader>sm  :FzfAg <CR>'def ):$ 
noremap <leader>su  :FzfAg <CR>!def !):$ 
vnoremap <A-g> "hy:FzfAg <C-r>h<CR>
vnoremap <leader>sc "hy:FzfAg <C-r>h<CR>'class ):$ 
vnoremap <leader>sm "hy:FzfAg <C-r>h<CR>'def ):$ 
vnoremap <leader>su "hy:FzfAg <C-r>h<CR>!def !):$  

let g:jedi#smart_auto_mappings = 1
iabbr deb from pudb set_trace
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:jedi#usages_command = "<leader>y"
"nnoremap <C-]> :call CocActionAsync('jumpDefinition')<cr>
" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
set autoread                                                                                                                                                                                    
au CursorHold * checktime  
