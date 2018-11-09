
function! OnJS()
  abbr log console.log("");<Left><Left><Left>
  noremap <leader>a  :call RunNode()<CR>
endfunction

function! OnPython()
  nnoremap <C-]>  :call jedi#goto_definitions()<CR>
  nnoremap ,test :-1read ~/myConfig/test.py<CR>/placeholder<CR>ciw
  ab deb from pudb set_trace; set_trace()
  noremap <leader>a  :call RunPython()<CR>
  set foldmethod=manual
  let g:jedi#show_call_signatures = 1
  let g:jedi#popup_on_dot = 0
  let g:jedi#use_tabs_not_buffers = 0
  let g:jedi#usages_command = "<leader>s"
  let g:jedi#rename_command = "<leader>r"
  nnoremap <leader>l :call Flake8()<cr>
  "nnoremap <leader>f :PymodeLintAuto<cr>
  nnoremap <leader>. :call OpenTestAlternate()<cr>
  noremap <leader>r :%s/old/new/gc
endfunction
