func! myspacevim#before() abort
  let g:python_host_prog = "/usr/bin/python2"
  set autoread
endf

func! myspacevim#after() abort
  let g:indentLine_concealcursor = ''
  set concealcursor = ''
endf
