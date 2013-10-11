" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 11 Oct 2013
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name='gruvbox'

if !has('gui_running') && &t_Co != 256
	finish
endif

" }}}
" Global settings: {{{

if !exists('g:gruvbox_bold')
	let g:gruvbox_bold=1
endif
if !exists('g:gruvbox_italic')
	let g:gruvbox_italic=1
endif
if !exists('g:gruvbox_underline')
	let g:gruvbox_underline=1
endif

if !exists('g:gruvbox_italicize_comments')
	let g:gruvbox_italicize_comments=1
endif
if !exists('g:gruvbox_italicize_strings')
	let g:gruvbox_italicize_strings=0
endif

if !exists('g:gruvbox_termcolors')
	let g:gruvbox_termcolors=256
endif

if !exists('g:gruvbox_invert_indent_guides')
	let g:gruvbox_invert_indent_guides=0
endif

if !exists('g:gruvbox_hls_cursor')
	let g:gruvbox_hls_cursor='orange'
endif

if &background == 'light'
	let s:gruvbox_background='light'
else
	let s:gruvbox_background='dark'
endif

" }}}
" Palette: {{{

let s:gb = {}

if &background == 'dark'
	let s:gb.dark0  = ['282828', 235]     " 40-40-40
	let s:gb.dark1  = ['3c3836', 237]     " 60-56-54
	let s:gb.dark2  = ['504945', 239]     " 80-73-69
	let s:gb.dark3  = ['665c54', 241]     " 102-92-84
	let s:gb.dark4  = ['7c6f64', 243]     " 124-111-100

	let s:gb.medium = ['928374', 245]     " 146-131-116

	let s:gb.light0 = ['fdf4c1', 229]     " 253-244-193
	let s:gb.light1 = ['ebdbb2', 223]     " 235-219-178
	let s:gb.light2 = ['d5c4a1', 250]     " 213-196-161
	let s:gb.light3 = ['bdae93', 248]     " 189-174-147
	let s:gb.light4 = ['a89984', 246]     " 168-153-132

	let s:gb.light4_256 = ['a89984', 246] " 168-153-132

	let s:gb.red    = ['fb4934', 167]     " 251-73-52
	let s:gb.green  = ['b8bb26', 142]     " 184-187-38
	let s:gb.yellow = ['fabd2f', 214]     " 250-189-47
	let s:gb.blue   = ['83a598', 109]     " 131-165-152
	let s:gb.purple = ['d3869b', 175]     " 211-134-155
	let s:gb.aqua   = ['8ec07c', 108]     " 142-192-124
	let s:gb.orange = ['fe8019', 208]     " 254-128-25

	if g:gruvbox_termcolors == 16
		let s:gb.dark0  = ['282828', 0]
		let s:gb.light4 = ['a89984', 7]
		let s:gb.medium = ['928374', 8]
		let s:gb.red    = ['fb4934', 9]
		let s:gb.green  = ['b8bb26', 10]
		let s:gb.yellow = ['fabd2f', 11]
		let s:gb.blue   = ['83a598', 12]
		let s:gb.purple = ['d3869b', 13]
		let s:gb.aqua   = ['8ec07c', 14]
		let s:gb.light1 = ['ebdbb2', 15]
	endif
else
	let s:gb.dark0  = ['fdf4c1', 229]     " 253-244-193
	let s:gb.dark1  = ['ebdbb2', 223]     " 235-219-178
	let s:gb.dark2  = ['d5c4a1', 250]     " 213-196-161
	let s:gb.dark3  = ['bdae93', 248]     " 189-174-147
	let s:gb.dark4  = ['a89984', 246]     " 168-153-132

	let s:gb.medium = ['928374', 244]     " 146-131-116

	let s:gb.light0 = ['282828', 235]     " 40-40-40
	let s:gb.light1 = ['3c3836', 237]     " 60-56-54
	let s:gb.light2 = ['504945', 239]     " 80-73-69
	let s:gb.light3 = ['665c54', 241]     " 102-92-84
	let s:gb.light4 = ['7c6f64', 243]     " 124-111-100

	let s:gb.light4_256 = ['7c6f64', 243] " 124-111-100

	let s:gb.red    = ['9d0006', 88]      " 157-0-6
	let s:gb.green  = ['79740e', 100]     " 121-116-14
	let s:gb.yellow = ['b57614', 136]     " 181-118-20
	let s:gb.blue   = ['076678', 24]      " 7-102-120
	let s:gb.purple = ['8f3f71', 96]      " 143-63-113
	let s:gb.aqua   = ['427b58', 66]      " 66-123-88
	let s:gb.orange = ['af3a03', 130]     " 175-58-3

	if g:gruvbox_termcolors == 16
		let s:gb.dark0  = ['fdf4c1', 0]
		let s:gb.light4 = ['7c6f64', 7]
		let s:gb.medium = ['928374', 8]
		let s:gb.red    = ['9d0006', 9]
		let s:gb.green  = ['79740e', 10]
		let s:gb.yellow = ['b57614', 11]
		let s:gb.blue   = ['076678', 12]
		let s:gb.purple = ['8f3f71', 13]
		let s:gb.aqua   = ['427b58', 14]
		let s:gb.light1 = ['3c3836', 15]
	endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
	" Arguments: group, guifg, guibg, gui, guisp

	let histring = 'hi ' . a:group . ' '

	if strlen(a:fg)
		if a:fg == 'fg'
			let histring .= 'guifg=fg ctermfg=fg '
		elseif a:fg == 'bg'
			let histring .= 'guifg=bg ctermfg=bg '
		elseif a:fg == 'none'
			let histring .= 'guifg=NONE ctermfg=NONE '
		else
			let c = get(s:gb, a:fg)
			let histring .= 'guifg=#' . c[0] . ' ctermfg=' . c[1] . ' '
		endif
	endif

	if a:0 >= 1 && strlen(a:1)
		if a:1 == 'bg'
			let histring .= 'guibg=bg ctermbg=bg '
		elseif a:fg == 'fg'
			let histring .= 'guibg=fg ctermbg=fg '
		elseif a:1 == 'none'
			let histring .= 'guibg=NONE ctermbg=NONE '
		else
			let c = get(s:gb, a:1)
			let histring .= 'guibg=#' . c[0] . ' ctermbg=' . c[1] . ' '
		endif
	else
		let histring .= 'guibg=NONE ctermbg=NONE '
	endif

	if a:0 >= 2 && strlen(a:2)
		if a:2 == 'none'
			let histring .= 'gui=NONE cterm=NONE '
		elseif a:2 == 'italic' && g:gruvbox_italic == 0
			let histring .= 'gui=NONE cterm=NONE '
		elseif a:2 == 'bold' && g:gruvbox_bold == 0
			let histring .= 'gui=NONE cterm=NONE '
		elseif a:2 == 'bold,inverse' && g:gruvbox_bold == 0
			let histring .= 'gui=inverse cterm=inverse '
		elseif a:2 == 'underline' && g:gruvbox_underline == 0
			let histring .= 'gui=NONE cterm=NONE '
		elseif a:2 == 'bold,italic'
			if g:gruvbox_italic == 0 && g:gruvbox_bold == 0
				let histring .= 'gui=NONE cterm=NONE '
			elseif g:gruvbox_italic == 0
				let histring .= 'gui=bold cterm=bold '
			elseif g:gruvbox_bold == 0
				let histring .= 'gui=italic cterm=italic '
			else
				let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
			endif
		else
			let histring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
		endif
	else
		let histring .= 'gui=NONE cterm=NONE '
	endif

	if a:0 >= 3 && strlen(a:3)
		if a:3 == 'none'
			let histring .= 'guisp=NONE '
		else
			let c = get(s:gb, a:3)
			let histring .= 'guisp=#' . c[0] . ' '
		endif
	endif

	execute histring
endfunction

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', 'light1', 'dark0')

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvbox/issues/7
if s:gruvbox_background == 'light'
	set background=light
else
	set background=dark
endif

if version >= 700
	" Screen line that the cursor is
	call s:HL('CursorLine',   'none', 'dark1')
	" Screen column that the cursor is
	call s:HL('CursorColumn', 'none', 'dark1')

	" Tab pages line filler
	call s:HL('TabLineFill', 'dark4', 'bg')
	" Active tab page label
	call s:HL('TabLineSel', 'bg', 'dark4', 'bold')
	" Not active tab page label
	call s:HL('TabLine', 'dark4', 'bg')

	" Match paired bracket under the cursor
	call s:HL('MatchParen', 'none', 'dark3', 'bold')
endif

if version >= 703
	" Highlighted screen columns
	call s:HL('ColorColumn',  'none', 'dark1')

	" Concealed element: \lambda → λ
	call s:HL('Conceal', 'blue', 'none')

	" Line number of CursorLine
	call s:HL('CursorLineNr', 'yellow', 'dark1')
endif

call s:HL('NonText',    'dark2')
call s:HL('SpecialKey', 'dark2')

call s:HL('Visual',    'none',  'dark3', 'inverse')
call s:HL('VisualNOS', 'none',  'dark3', 'inverse')

call s:HL('Search',    'dark0', 'yellow')
call s:HL('IncSearch', 'dark0', 'yellow')

call s:HL('Underlined', 'blue', 'none', 'underline')

call s:HL('StatusLine',   'dark4', 'dark0', 'bold,inverse')
call s:HL('StatusLineNC', 'dark2', 'light4', 'bold,inverse')

" The column separating vertically split windows
call s:HL('VertSplit', 'light4', 'dark2')

" Current match in wildmenu completion
call s:HL('WildMenu', 'blue', 'dark2', 'bold')

" Directory names, special names in listing
call s:HL('Directory', 'green', 'none', 'bold')

" Titles for output from :set all, :autocmd, etc.
call s:HL('Title', 'green', 'none', 'bold')

" Error messages on the command line
call s:HL('ErrorMsg',   'bg', 'red', 'bold')
" More prompt: -- More --
call s:HL('MoreMsg',    'yellow', 'none', 'bold')
" Current mode message: -- INSERT --
call s:HL('ModeMsg',    'yellow', 'none', 'bold')
" 'Press enter' prompt and yes/no questions
call s:HL('Question',   'orange', 'none', 'bold')
" Warning messages
call s:HL('WarningMsg', 'red', 'none', 'bold')

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', 'dark4')

" Column where signs are displayed
call s:HL('SignColumn', 'none', 'bg')

" Line used for closed folds
call s:HL('Folded', 'medium', 'dark1', 'italic')
" Column where folds are displayed
call s:HL('FoldColumn', 'medium', 'dark1')

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', 'none', 'none', 'inverse')
" Visual mode cursor, selection
call s:HL('vCursor', 'none', 'none', 'inverse')
" Input moder cursor
call s:HL('iCursor', 'none', 'none', 'inverse')
" Language mapping cursor
call s:HL('lCursor', 'none', 'none', 'inverse')

" }}}
" Syntax Highlighting: {{{

call s:HL('Special', 'orange')
if g:gruvbox_italicize_comments == 0
	call s:HL('Comment', 'medium', 'none')
else
	call s:HL('Comment', 'medium', 'none', 'italic')
endif
call s:HL('Todo', 'fg', 'bg', 'bold')

" Generic statement
call s:HL('Statement',   'red')
" if, then, else, endif, swicth, etc.
call s:HL('Conditional', 'red')
" for, do, while, etc.
call s:HL('Repeat',      'red')
" case, default, etc.
call s:HL('Label',       'red')
" try, catch, throw
call s:HL('Exception',   'red')
" sizeof, "+", "*", etc.
hi! def link Operator Normal
" Any other keyword
call s:HL('Keyword',     'red')

" Variable name
call s:HL('Identifier', 'blue')
" Function name
call s:HL('Function',   'green', 'none', 'bold')

" Generic preprocessor
call s:HL('PreProc',   'aqua')
" Preprocessor #include
call s:HL('Include',   'aqua')
" Preprocessor #define
call s:HL('Define',    'aqua')
" Same as Define
call s:HL('Macro',     'aqua')
" Preprocessor #if, #else, #endif, etc.
call s:HL('PreCondit', 'aqua')

" Generic constant
call s:HL('Constant',  'purple')
" Character constant: 'c', '/n'
call s:HL('Character', 'purple')
" String constant: "this is a string"
if g:gruvbox_italicize_strings == 0
	call s:HL('String',  'green')
else
	call s:HL('String',  'green', 'none', 'italic')
endif
" Boolean constant: TRUE, false
call s:HL('Boolean',   'purple')
" Number constant: 234, 0xff
call s:HL('Number',    'purple')
" Floating point constant: 2.3e10
call s:HL('Float',     'purple')

" Generic type
call s:HL('Type', 'yellow')
" static, register, volatile, etc
call s:HL('StorageClass', 'orange')
" struct, union, enum, etc.
call s:HL('Structure', 'aqua')
" typedef
call s:HL('Typedef', 'yellow')

" }}}
" Completion Menu: {{{

if version >= 700
	" Popup menu: normal item
	call s:HL('Pmenu', 'light1', 'dark2')
	" Popup menu: selected item
	call s:HL('PmenuSel', 'dark2', 'blue', 'bold')
	" Popup menu: scrollbar
	call s:HL('PmenuSbar', 'none', 'dark2')
	" Popup menu: scrollbar thumb
	call s:HL('PmenuThumb', 'none', 'dark4')
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', 'dark0', 'red')
call s:HL('DiffAdd',    'dark0', 'green')
"call s:HL('DiffChange', 'dark0', 'blue')
"call s:HL('DiffText',   'dark0', 'yellow')

" Alternative setting
call s:HL('DiffChange', 'dark0', 'aqua')
call s:HL('DiffText',   'dark0', 'yellow')

" }}}
" Spelling: {{{

if has("spell")
	" Not capitalised word
	call s:HL('SpellCap',   'none', 'none', 'undercurl', 'red')
	" Not recognized word
	call s:HL('SpellBad',   'none', 'none', 'undercurl', 'blue')
	" Wrong spelling for selected region
	call s:HL('SpellLocal', 'none', 'none', 'undercurl', 'aqua')
	" Rare word
	call s:HL('SpellRare',  'none', 'none', 'undercurl', 'purple')
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! def link EasyMotionTarget Search
hi! def link EasyMotionShade Comment

" }}}
" Indent Guides: {{{

let g:indent_guides_auto_colors = 0

if g:gruvbox_invert_indent_guides == 0
	call s:HL('IndentGuidesOdd', 'bg', 'dark2')
	call s:HL('IndentGuidesEven', 'bg', 'dark1')
else
	call s:HL('IndentGuidesOdd', 'bg', 'dark2', 'inverse')
	call s:HL('IndentGuidesEven', 'bg', 'dark3', 'inverse')
endif

" }}}
" Better Rainbow Parentheses: {{{

let g:rbpt_colorpairs = [
	\ ['brown',       '#458588'],
	\ ['Darkblue',    '#b16286'],
	\ ['darkgray',    '#cc241d'],
	\ ['darkgreen',   '#d65d0e'],
	\ ['darkcyan',    '#458588'],
	\ ['darkred',     '#b16286'],
	\ ['darkmagenta', '#cc241d'],
	\ ['brown',       '#d65d0e'],
	\ ['gray',        '#458588'],
	\ ['black',       '#b16286'],
	\ ['darkmagenta', '#cc241d'],
	\ ['Darkblue',    '#d65d0e'],
	\ ['darkgreen',   '#458588'],
	\ ['darkcyan',    '#b16286'],
	\ ['darkred',     '#cc241d'],
	\ ['red',         '#d65d0e'],
	\ ]

"}}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

call s:HL('diffAdded', 'green')
call s:HL('diffRemoved', 'red')
call s:HL('diffChanged', 'aqua')

call s:HL('diffFile', 'orange')
call s:HL('diffNewFile', 'yellow')

call s:HL('diffLine', 'blue')

" }}}
" Html: {{{

call s:HL('htmlTag', 'blue')
call s:HL('htmlEndTag', 'blue')

call s:HL('htmlTagName', 'aqua', 'none', 'bold')
call s:HL('htmlArg', 'aqua')

call s:HL('htmlScriptTag', 'purple')
call s:HL('htmlTagN', 'light1')
call s:HL('htmlSpecialTagName', 'aqua', 'none', 'bold')

call s:HL('htmlLink', 'light4', 'none', 'underline')

call s:HL('htmlSpecialChar', 'orange')

" }}}
" Vim: {{{

if g:gruvbox_italicize_comments == 0
	call s:HL('vimCommentTitle', 'light4_256', 'none', 'bold')
else
	call s:HL('vimCommentTitle', 'light4_256', 'none', 'bold,italic')
endif

"hi! def link vimVar Identifier
"hi! def link vimFunc Function
"hi! def link vimUserFunc Function


"call s:HL('vimUserFunc', 'green', 'none', 'bold')
"call s:HL('vimFunction', 'green', 'none', 'bold')

"call s:HL('vimFunc', 'blue')
"call s:HL('vimFuncName', 'blue')

"call s:HL('vimVar', 'purple')
"call s:HL('vimIsCommand', 'purple')


"call s:HL('vimMapMod', 'purple', 'none', 'bold,italic')
"call s:HL('vimMapModKey', 'purple', 'none', 'bold,italic')

"call s:HL('vimFunction', 'purple')
"call s:HL('vimUserFunc', 'purple')
"call s:HL('vimUserFunc', 'purple')

"hi! def link vimFunc Function
"hi! def link vimUserFunc Function

" }}}
" Clojure: {{{
call s:HL('clojureKeyword', 'blue')
call s:HL('clojureCond', 'orange')
call s:HL('clojureSpecial', 'orange')
call s:HL('clojureDefine', 'orange')

call s:HL('clojureFunc', 'yellow')
call s:HL('clojureRepeat', 'yellow')
call s:HL('clojureCharacter', 'aqua')
call s:HL('clojureStringEscape', 'aqua')
call s:HL('clojureException', 'red')

call s:HL('clojureRegexp', 'aqua')
call s:HL('clojureRegexpEscape', 'aqua')
call s:HL('clojureRegexpCharClass', 'light3', 'none', 'bold')
call s:HL('clojureRegexpMod', 'light3', 'none', 'bold')
call s:HL('clojureRegexpQuantifier', 'light3', 'none', 'bold')

call s:HL('clojureParen', 'light3')
call s:HL('clojureAnonArg', 'yellow')
call s:HL('clojureVariable', 'blue')
call s:HL('clojureMacro', 'orange')

call s:HL('clojureMeta', 'yellow')
call s:HL('clojureDeref', 'yellow')
call s:HL('clojureQuote', 'yellow')
call s:HL('clojureUnquote', 'yellow')
" }}}

" Functions -------------------------------------------------------------------
" Search Highlighting {{{

"function! gruvbox#bg_toggle()
"	if &background == 'dark'
"		set bg=light
"	else
"		set bg=dark
"	endif
"endfunction

function! gruvbox#hls_show()
	set hlsearch
	call s:HL('Cursor', 'dark0', g:gruvbox_hls_cursor)
	call s:HL('vCursor', 'dark0', g:gruvbox_hls_cursor)
	call s:HL('iCursor', 'dark0', g:gruvbox_hls_cursor)
	call s:HL('lCursor', 'dark0', g:gruvbox_hls_cursor)
endfunction

function! gruvbox#hls_hide()
	set nohlsearch
	call s:HL('Cursor', 'none', 'none', 'inverse')
	call s:HL('vCursor', 'none', 'none', 'inverse')
	call s:HL('iCursor', 'none', 'none', 'inverse')
	call s:HL('lCursor', 'none', 'none', 'inverse')
endfunction

function! gruvbox#hls_toggle()
	if &hlsearch
		call gruvbox#hls_hide()
	else
		call gruvbox#hls_show()
	endif
endfunction

" }}}
