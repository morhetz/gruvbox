" Supporting code --------------------------------------------------------------
" Initialisation {{{

set background=dark

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let g:colors_name="gruvbox"

" To be done {{{
""" if has("gui_running") || &t_Co == 88 || &t_Co == 256
"""   let s:low_color = 0
""" else
"""   let s:low_color = 1
""" endif
"}}}

if !has("gui_running") && &t_Co != 88 && &t_Co != 256
    finish
endif

"}}}
" Palette {{{

let s:gb = {}

let s:gb.dark0  = ['282828', 235]
let s:gb.dark1  = ['3c3836', 237]
let s:gb.dark2  = ['504945', 239]
let s:gb.dark3  = ['665c54', 241]
let s:gb.dark4  = ['7c6f64', 243]

let s:gb.medium = ['928374', 245]

let s:gb.light0 = ['fdf4c1', 247]
let s:gb.light1 = ['ebdbb2', 223]
let s:gb.light2 = ['d5c4a1', 251]
let s:gb.light3 = ['bdae93', 253]
let s:gb.light4 = ['a89984', 255]

let s:gb.red    = ['fb4934', 167]
let s:gb.orange = ['fe8019', 208]
let s:gb.yellow = ['fabd2f', 214]
let s:gb.green  = ['b8bb26', 142]
let s:gb.aqua   = ['8ec07c', 108]
let s:gb.blue   = ['83a598', 109]
let s:gb.purple = ['d3869b', 175]

"}}}
" Highlighting Function {{{
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
            let histring .= 'guibg=NONE ctermfg=NONE '
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

" Actual colorscheme -----------------------------------------------------------
" Vanilla Vim {{{

" General/UI {{{

" Normal text
call s:HL('Normal', 'light1', 'dark0')

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
    call s:HL('MatchParen', 'orange', 'dark3', 'bold')
endif

if version >= 730
    " Highlighted screen columns
    call s:HL('ColorColumn',  'none', 'dark1')

    " Concealed element: \lambda → λ"
    call s:HL('Conceal', 'blue', 'none')"

    " Line number of CursorLine 
    call s:HL('CursorLineNr', 'yellow', 'dark1')
endif

call s:HL('NonText',    'dark2')
call s:HL('SpecialKey', 'dark2')

call s:HL('Visual',    'none',  'dark3', 'inverse')
call s:HL('VisualNOS', 'none',  'dark3', 'inverse')

call s:HL('Search',    'dark0', 'yellow')
call s:HL('IncSearch', 'dark0', 'yellow')

call s:HL('Underlined', 'blue', '', 'underline')

call s:HL('StatusLine',   'dark0', 'dark4', 'bold')
call s:HL('StatusLineNC', 'light4', 'dark2', 'bold')

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
" Gutter {{{

" Line number for :number and :# commands
call s:HL('LineNr', 'dark4')

" Column where signs are displayed
call s:HL('SignColumn', 'none', 'bg')

" Line used for closed folds
call s:HL('Folded', 'medium', 'dark1', 'italic')
" Column where folds are displayed
call s:HL('FoldColumn', 'medium', 'dark1')

" }}}
" Cursor {{{

" Character under cursor
call s:HL('Cursor',  'none', 'none', 'inverse')
" Visual mode cursor, selection
call s:HL('vCursor', 'none', 'none', 'inverse')
" Input moder cursor
call s:HL('iCursor', 'none', 'none', 'inverse')
" Language mapping cursor
call s:HL('lCursor', 'none', 'none', 'inverse')

" }}}
" Syntax highlighting {{{

call s:HL('Special', 'orange')

call s:HL('Comment', 'medium', 'none', 'italic')
call s:HL('Todo',    'fg', 'bg', 'bold')

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
call s:HL('String',    'green')
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
" Completion Menu {{{

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
" Diffs {{{

call s:HL('DiffDelete', 'dark0', 'red')
call s:HL('DiffAdd',    'dark0', 'green')
"call s:HL('DiffChange', 'dark0', 'blue')
"call s:HL('DiffText',   'dark0', 'yellow')

" Alternative setting
call s:HL('DiffChange', 'dark0', 'aqua')
call s:HL('DiffText',   'dark0', 'yellow')

" }}}
" Spelling {{{

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

" }}}

" Filetype specific -----------------------------------------------------------
"{{{ Diff

call s:HL('diffAdded', 'green')
call s:HL('diffRemoved', 'red')
call s:HL('diffChanged', 'aqua')

call s:HL('diffFile', 'orange')
call s:HL('diffNewFile', 'yellow')

call s:HL('diffLine', 'blue')

"}}}
