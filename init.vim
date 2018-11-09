
call plug#begin()
  Plug 'Shougo/Unite.vim'
  Plug 'Shougo/tabpagebuffer.vim'
  Plug 'ap/vim-buftabline'
  Plug 'mrtazz/simplenote.vim'
  Plug 'Raimondi/delimitMate'
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

nnoremap <leader>a :!go run %
let g:SimplenoteUsername = "adam.kozuch@gmail.com"
let g:SimplenotePassword = "hujmnie"



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



colorscheme gruvbox

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
