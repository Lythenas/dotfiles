func! myspacevim#before() abort
  let g:python_host_prog = "/usr/bin/python2"

  " automatically read files that have changed on disk
  set autoread

  " shorter updatetime so the sigils are updated quicker
  set updatetime=100

  """ Configure vim-flow
  let g:flow#autoclose = 1
  " Use locally installed flow
	let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
	if matchstr(local_flow, "^\/\\w") == ''
			let local_flow= getcwd() . "/" . local_flow
	endif
	if executable(local_flow)
		let g:flow#flowpath = local_flow
	endif
endf

func! myspacevim#after() abort
  let g:indentLine_concealcursor = ''
  set concealcursor = ''
  let g:used_javascript_libs = 'underscore,react,flux'
endf
