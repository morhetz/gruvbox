" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 16 Dec 2013
" -----------------------------------------------------------------------------

function! gruvbox#bg_toggle()
	if &background == 'dark'
		set background=light
	else
		set background=dark
	endif

	colo gruvbox
endfunction

function! gruvbox#invert_signs_toggle()
	if g:gruvbox_invert_signs == 0
		let g:gruvbox_invert_signs=1
	else
		let g:gruvbox_invert_signs=0
	endif

	colo gruvbox
endfunction
