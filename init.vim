
call plug#begin()
  Plug 'benmills/vimux'
  Plug 'junegunn/vim-peekaboo'
  Plug 'chrisbra/vim-diff-enhanced'
  Plug 'mihaifm/vimpanel'
  Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'justinmk/vim-sneak'
  Plug 'Shougo/Unite.vim'
  Plug 'Shougo/tabpagebuffer.vim'
  Plug 'ap/vim-buftabline'
  Plug 'mhinz/vim-startify'
  Plug 'morhetz/gruvbox'
  Plug 'airblade/vim-gitgutter'
  Plug 'bling/vim-bufferline'
  Plug 'jszakmeister/vim-togglecursor'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'junegunn/fzf.vim'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'scrooloose/nerdcommenter'
  Plug 'rking/ag.vim'
  Plug 'tpope/vim-repeat'
  Plug 'itchyny/lightline.vim'
  Plug 'xolox/vim-misc'
  Plug 'gcmt/taboo.vim'
  "Plug 'neovim/nvim-lsp'
  Plug 'janko/vim-test'
 Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
call plug#end()

autocmd FileType fzf tnoremap <buffer> <A-j> <Down>
autocmd FileType fzf tnoremap <buffer> <A-k> <Up>
nnoremap <ESC>j :m+<CR>==

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <f2> <plug>(lsp-rename)
    " refer to doc to add more commands
endfunction


augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:indentLine_enabled = 0

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('~/asyncomplete.log')


let test#strategy = "vimux"
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>

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

"autocmd BufNewFile,BufRead *.java :call OnJava()
"autocmd BufNewFile,BufRead *.js :call OnJS()
"autocmd BufNewFile,BufRead *.scala :call OnScala()
"autocmd BufNewFile,BufRead *.py :call OnPython()

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
noremap <A-h>  :FzfHistory<CR>
noremap <A-q>  :q<Cr>





"set rtp+=~/.config/nvim/plugged/deoplete.nvim

let g:python3_host_prog = '/usr/bin/python3'

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
inoremap <A-j> Down
inoremap <A-k> Up

noremap <leader>sc  :FzfAg <CR>'class ):$ 
noremap <leader>sm  :FzfAg <CR>'def ):$ 
noremap <leader>su  :FzfAg <CR>!def !):$ 

iabbr deb from pudb set_trace
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1
let g:bookmark_auto_save = 1
nnoremap <C-]> :call CocActionAsync('jumpDefinition')<cr>

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
set autoread                                                                                                                                                                                    
au CursorHold * checktime  
let g:LanguageClient_serverCommands = { 'python': [$HOME . '/.local/bin/pyls'] }

let g:bookmark_highlight_lines = 0
let g:bookmark_auto_save = 1
let g:bookmark_auto_save_file = $HOME . '/bookmarks'
" Or map each action separately
nmap <A-r> <Plug>(coc-rename)


function! OnPython()
  nnoremap ,test :-1read ~/myConfig/test.py<CR>/placeholder<CR>ciw
  set foldmethod=manual
  "nnoremap <leader>f :PymodeLintAuto<cr>
endfunction

let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
let g:golden_ratio_exclude_nonmodifiable = 1
let g:goldenview__enable_default_mapping = 0

let g:fzf_command_prefix = 'Fzf'
let g:notes_directories = ['~/Documents/Notes']
nnoremap <silent> <leader>t :call FZFOpen(':FzfGFiles')<CR>
nnoremap <leader>j :FzfBuffers<cr>
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

"command Gs Gstatus
"command Gc Gcommit

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! LightlineCurrentDirectory(n) abort
  return fnamemodify(getcwd(tabpagewinnr(a:n), a:n), ':t')
endfunction

let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'gitbranch', 'readonly', 'filename', 'modified'] ],
      \    'right': []
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename',
      \ }
      \ }


noremap <A-j> 10j
noremap <A-k> 10k
noremap <A-m> /def<cr>

noremap <A-t> :terminal


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
tnoremap <C-Right> <C-\><C-n><c-w>l
tnoremap <C-Left> <C-\><C-n><c-w>h
tnoremap <C-Up>  <C-\><C-n><c-w>k
tnoremap <C-Down> <C-\><C-n><c-w>j

if has('nvim')
    autocmd TermOpen term://* startinsert
endif

" Window navigation function
" Make ctrl-h/j/k/l move between windows and auto-insert in terminals
func! s:mapMoveToWindowInDirection(direction)
    func! s:maybeInsertMode(direction)
        stopinsert
        execute "wincmd" a:direction

        if &buftype == 'terminal'
            startinsert!
        endif
    endfunc

    execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
                \ "<C-\\><C-n>"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
    execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
                \ ":call <SID>maybeInsertMode(\"" . a:direction . "\")<CR>"
endfunc
for dir in ["h", "j", "l", "k"]
    call s:mapMoveToWindowInDirection(dir)
endfor

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

noremap <leader>s <C-c>:w<cr>

noremap <leader>r :%s/\(<c-r>=expand("<cword>")<cr>\)//gc<LEFT><LEFT><LEFT>
cnoremap %w <C-R>=expand("<cword>")<cr>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
cnoremap new tabnew 
cnoremap ter terminal 
cnoremap rc e ~/.config/nvim/init.vim<C-b>
noremap <C-h> <C-w>h
set signcolumn=yes


imap <A-j> <Down>

if &diff
    set cursorline
    map ] ]c
    map [ [c
    hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
endif


command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': '--delimiter : --nth 3..'}), <bang>0)

vnoremap <A-g> "hy:GGrep <C-r>h<CR>
vnoremap <leader>sc "hy:FzfAg <C-r>h<CR>'class ):$ 
vnoremap <leader>sm "hy:FzfAg <C-r>h<CR>'def ):$ 
vnoremap <leader>su "hy:FzfAg <C-r>h<CR>!def !):$  

noremap <A-g>  :GGrep<CR>
noremap <A-c>  :Gstatus <CR>
noremap <A-b>  :BookmarkShowAll <CR>
noremap <A-n>  :BookmarkNext <CR>zz
noremap <A-N>  :BookmarkPrev <CR>zz


nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nnoremap <expr> <A-j> &diff ? ']c' : '<C-W>j'
nnoremap <expr> <A-k> &diff ? '[c' : '<C-W>j'

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction 


if exists('*complete_info')
  inoremap <expr> <tab> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <tab> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
inoremap <silent><expr> <c-n> coc#refresh()

let peekaboo_compact = 0
" MOST IMPORTANT FIX GREP


function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <leader>a  :TestNearest --keepdb -n<cr>
nnoremap <leader>b  :VimuxRunCommand '/scripts/run_black && /scripts/run_isort'<cr>
nnoremap <silent> <Leader>g :GGrep <C-R><C-W><CR>
imap <C-l> <Plug>(coc-snippets-expand)

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

noremap <A-j> 10j
noremap <A-k> 10k
autocmd TextChanged,TextChangedI <buffer> silent write
map <A-n> :NERDTreeToggle<CR>
