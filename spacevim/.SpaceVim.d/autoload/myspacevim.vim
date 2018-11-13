func! myspacevim#before() abort
endf

func! myspacevim#after() abort
  let g:indentLine_concealcursor = ''
  set concealcursor = ''
endf
