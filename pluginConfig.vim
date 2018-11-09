
let g:deoplete#max_list = 10
let g:flake8_show_quickfix=1
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1
let g:golden_ratio_exclude_nonmodifiable = 1
let g:goldenview__enable_default_mapping = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.scala   = '[^. *\t]\.\w*'
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo=1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif  
let g:fzf_command_prefix = 'Fzf'
let g:notes_directories = ['~/Documents/Notes']
nnoremap <silent> <leader>t :call FZFOpen(':FzfGFiles')<CR>
nnoremap <leader>j :FzfBuffers<cr>
map <C-n> ;NERDTreeToggle<CR>
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

"command Gs Gstatus
"command Gc Gcommit

call deoplete#custom#source('_',  'max_menu_width', 0)
call deoplete#custom#source('_',  'max_abbr_width', 0)
call deoplete#custom#source('_',  'max_kind_width', 0)

let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \    'right': []
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename'
      \ }
      \ }
nnoremap <C-]> :call jedi#goto_definitions()<Cr>
