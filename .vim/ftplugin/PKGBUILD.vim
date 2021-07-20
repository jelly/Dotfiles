function! Pkgrel()
	let save_pos = getpos(".")
	let pattern = 'pkgrel='
	if search(pattern, 'eW') is 0
		return
	endif
	exe "normal \<c-a>\<esc>"
	call setpos(".", save_pos)
endfunction

nmap <F1> :call Pkgrel()<CR>