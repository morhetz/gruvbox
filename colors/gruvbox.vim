" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 01 Sep 2015
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
" Global Settings: {{{

if !exists('g:gruvbox_bold')
  let g:gruvbox_bold=1
endif
if !exists('g:gruvbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:gruvbox_italic=1
  else
    let g:gruvbox_italic=0
  endif
endif
if !exists('g:gruvbox_undercurl')
  let g:gruvbox_undercurl=1
endif
if !exists('g:gruvbox_underline')
  let g:gruvbox_underline=1
endif
if !exists('g:gruvbox_inverse')
  let g:gruvbox_inverse=1
endif

if !exists('g:gruvbox_guisp_fallback') || index(['fg', 'bg'], g:gruvbox_guisp_fallback) == -1
  let g:gruvbox_guisp_fallback='NONE'
endif

if !exists('g:gruvbox_improved_strings')
  let g:gruvbox_improved_strings=0
endif

if !exists('g:gruvbox_improved_warnings')
  let g:gruvbox_improved_warnings=0
endif

if !exists('g:gruvbox_termcolors')
  let g:gruvbox_termcolors=256
endif

if !exists('g:gruvbox_invert_indent_guides')
  let g:gruvbox_invert_indent_guides=0
endif

if !exists('g:gruvbox_contrast')
  let g:gruvbox_contrast='medium'
else
  echo 'g:gruvbox_contrast is deprecated; use g:gruvbox_contrast_light and g:gruvbox_contrast_dark instead'
endif

if !exists('g:gruvbox_contrast_dark')
  let g:gruvbox_contrast_dark='medium'
endif

if !exists('g:gruvbox_contrast_light')
  let g:gruvbox_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#282828', 235]     " 40-40-40
let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:gb.dark1       = ['#3c3836', 237]     " 60-56-54
let s:gb.dark2       = ['#504945', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fdf4c1', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#ebdbb2', 223]     " 235-219-178
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:gruvbox_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:gruvbox_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:gruvbox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:gruvbox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:gruvbox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:gruvbox_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:gruvbox_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:gruvbox_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:gruvbox_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:gruvbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}

" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:gruvbox_hls_cursor')
  let s:hls_cursor = get(s:gb, g:gruvbox_hls_cursor)
endif

let s:number_column = s:bg4
let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:gruvbox_sign_column')
    let s:sign_column = get(s:gb, g:gruvbox_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:gruvbox_color_column')
  let s:color_column = get(s:gb, g:gruvbox_color_column)
endif

let s:vert_split = s:bg2
if exists('g:gruvbox_vert_split')
  let s:vert_split = get(s:gb, g:gruvbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:gruvbox_invert_signs')
  if g:gruvbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:gruvbox_invert_selection')
  if g:gruvbox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:gruvbox_invert_tabline')
  if g:gruvbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:gruvbox_italicize_comments')
  if g:gruvbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
  if g:gruvbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  if type(a:fg) == 3
    let fg = a:fg
  elseif type(a:fg) == 1 && strlen(a:fg)
    let fg = [a:fg, a:fg]
  else
    let fg = ['NONE', 'NONE']
  endif

  " background
  if a:0 >= 1 && type(a:1) == 3
    let bg = a:1
  elseif a:0 >= 1 && type(a:1) == 1 && strlen(a:1)
    let bg = [a:1, a:1]
  else
    let bg = ['NONE', 'NONE']
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2[:-2]
  else
    let emstr  = 'NONE'
  endif

  " special fallback
  if a:0 >= 3 && type(a:3) == 3
    if g:gruvbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    if g:gruvbox_guisp_fallback == 'bg'
      " bg fallback mode should invert higlighting
      if emstr == 'NONE'
        let emstr = 'inverse'
      else
        let emstr .= ',inverse'
      endif
    endif
  endif

  let histring = ['hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr, 'cterm=' . emstr
        \ ]

  " special
  if a:0 >= 3
    if type(a:3) == 3
      let specl = a:3[0]
    elseif type(a:3) == 1 && strlen(a:3)
      let specl = a:3
    else
      let specl = 'NONE'
    endif

    call add(histring, 'guisp=' . specl)
  endif

  execute join(histring, ' ')
endfunction

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   'NONE', s:bg1)
  " Screen column that the cursor is
  call s:HL('CursorColumn', 'NONE', s:bg1)

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, 'bg', s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', 'bg', s:bg4, s:bold . s:invert_tabline)
  " Not active tab page label
  call s:HL('TabLine', s:bg4, 'bg', s:invert_tabline)

  " Match paired bracket under the cursor
  call s:HL('MatchParen', 'NONE', s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  'NONE', s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, 'NONE')

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

call s:HL('NonText',    s:bg2)
call s:HL('SpecialKey', s:bg2)

call s:HL('Visual',    'NONE',  s:bg3, s:invert_selection)
call s:HL('VisualNOS', 'NONE',  s:bg3, s:invert_selection)

call s:HL('Search',    s:bg0, s:yellow)
call s:HL('IncSearch', s:bg0, s:hls_cursor)

call s:HL('Underlined', s:blue, 'NONE', s:underline)

call s:HL('StatusLine',   s:bg4, s:bg0, s:bold . s:inverse)
call s:HL('StatusLineNC', s:bg2, s:fg4, s:bold . s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:fg4, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
call s:HL('Directory', s:green, 'NONE', s:bold)

" Titles for output from :set all, :autocmd, etc.
call s:HL('Title', s:green, 'NONE', s:bold)

" Error messages on the command line
call s:HL('ErrorMsg',   'bg', s:red, s:bold)
" More prompt: -- More --
call s:HL('MoreMsg',    s:yellow, 'NONE', s:bold)
" Current mode message: -- INSERT --
call s:HL('ModeMsg',    s:yellow, 'NONE', s:bold)
" 'Press enter' prompt and yes/no questions
call s:HL('Question',   s:orange, 'NONE', s:bold)
" Warning messages
call s:HL('WarningMsg', s:red, 'NONE', s:bold)

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', 'NONE', s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', 'NONE', 'NONE', s:inverse)
" Visual mode cursor, selection
call s:HL('vCursor', 'NONE', 'NONE', s:inverse)
" Input moder cursor
call s:HL('iCursor', 'NONE', 'NONE', s:inverse)
" Language mapping cursor
call s:HL('lCursor', 'NONE', 'NONE', s:inverse)

" }}}
" Syntax Highlighting: {{{

if g:gruvbox_improved_strings == 0
  call s:HL('Special', s:orange)
else
  call s:HL('Special', s:bg1, s:orange, s:italic)
endif

call s:HL('Comment', s:gray, 'NONE', s:italicize_comments)
call s:HL('Todo', 'fg', 'bg', s:bold . s:italic)
call s:HL('Error', s:red, 'bg', s:bold . s:inverse)

" Generic statement
call s:HL('Statement',   s:red)
" if, then, else, endif, swicth, etc.
call s:HL('Conditional', s:red)
" for, do, while, etc.
call s:HL('Repeat',      s:red)
" case, default, etc.
call s:HL('Label',       s:red)
" try, catch, throw
call s:HL('Exception',   s:red)
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
call s:HL('Keyword',     s:red)

" Variable name
call s:HL('Identifier', s:blue)
" Function name
call s:HL('Function',   s:green, 'NONE', s:bold)

" Generic preprocessor
call s:HL('PreProc',   s:aqua)
" Preprocessor #include
call s:HL('Include',   s:aqua)
" Preprocessor #define
call s:HL('Define',    s:aqua)
" Same as Define
call s:HL('Macro',     s:aqua)
" Preprocessor #if, #else, #endif, etc.
call s:HL('PreCondit', s:aqua)

" Generic constant
call s:HL('Constant',  s:purple)
" Character constant: 'c', '/n'
call s:HL('Character', s:purple)
" String constant: "this is a string"
if g:gruvbox_improved_strings == 0
  call s:HL('String',  s:green, 'NONE', s:italicize_strings)
else
  call s:HL('String',  s:bg1, s:fg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
call s:HL('Boolean',   s:purple)
" Number constant: 234, 0xff
call s:HL('Number',    s:purple)
" Floating point constant: 2.3e10
call s:HL('Float',     s:purple)

" Generic type
call s:HL('Type', s:yellow)
" static, register, volatile, etc
call s:HL('StorageClass', s:orange)
" struct, union, enum, etc.
call s:HL('Structure', s:aqua)
" typedef
call s:HL('Typedef', s:yellow)

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', 'NONE', s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', 'NONE', s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:gruvbox_improved_warnings == 0
    call s:HL('SpellCap',   'NONE', 'NONE', s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, 'NONE', s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   'NONE', 'NONE', s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', 'NONE', 'NONE', s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  'NONE', 'NONE', s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link SneakPluginTarget Search
hi! link SneakStreakTarget Search
call s:HL('SneakStreakMask', s:yellow, s:yellow)
hi! link SneakStreakStatusLine Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:gruvbox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', 'bg', s:bg2)
    call s:HL('IndentGuidesEven', 'bg', s:bg1)
  else
    call s:HL('IndentGuidesOdd', 'bg', s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', 'bg', s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

call s:HL('GitGutterAdd', s:green, s:sign_column, s:invert_signs)
call s:HL('GitGutterChange', s:aqua, s:sign_column, s:invert_signs)
call s:HL('GitGutterDelete', s:red, s:sign_column, s:invert_signs)
call s:HL('GitGutterChangeDelete', s:aqua, s:sign_column, s:invert_signs)

" }}}
" GitCommit: "{{{

call s:HL('gitcommitSelectedFile', s:green)
call s:HL('gitcommitDiscardedFile', s:red)

" }}}
" Signify: {{{

call s:HL('SignifySignAdd', s:green, s:sign_column, s:invert_signs)
call s:HL('SignifySignChange ', s:aqua, s:sign_column, s:invert_signs)
call s:HL('SignifySignDelete', s:red, s:sign_column, s:invert_signs)

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', 'NONE', 'NONE', s:undercurl, s:red)
call s:HL('SyntasticWarning', 'NONE', 'NONE', s:undercurl, s:yellow)

call s:HL('SyntasticErrorSign', s:red, s:sign_column, s:invert_signs)
call s:HL('SyntasticWarningSign', s:yellow, s:sign_column, s:invert_signs)

" }}}
" Signature: {{{

call s:HL('SignatureMarkerText', s:purple, s:sign_column, s:invert_signs)
call s:HL('SignatureMarkText', s:blue, s:sign_column, s:invert_signs)

let g:SignatureMarkerTextHL='"SignatureMarkerText"'
let g:SignatureMarkTextHL='"SignatureMarkText"'

" }}}
" ShowMarks: {{{

call s:HL('ShowMarksHLl', s:blue, s:sign_column, s:invert_signs)
call s:HL('ShowMarksHLu', s:blue, s:sign_column, s:invert_signs)
call s:HL('ShowMarksHLo', s:blue, s:sign_column, s:invert_signs)
call s:HL('ShowMarksHLm', s:blue, s:sign_column, s:invert_signs)

" }}}
" CtrlP: {{{

call s:HL('CtrlPMatch', s:yellow)
call s:HL('CtrlPNoEntries', s:red)
call s:HL('CtrlPPrtBase', s:bg2)
call s:HL('CtrlPPrtCursor', s:blue)
call s:HL('CtrlPLinePre', s:bg2)

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

call s:HL('StartifyBracket', s:fg3)
call s:HL('StartifyFile', s:fg0)
call s:HL('StartifyNumber', s:blue)
call s:HL('StartifyPath', s:gray)
call s:HL('StartifySlash', s:gray)
call s:HL('StartifySection', s:yellow)
call s:HL('StartifySpecial', s:bg2)
call s:HL('StartifyHeader', s:orange)
call s:HL('StartifyFooter', s:bg2)

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

call s:HL('diffAdded', s:green)
call s:HL('diffRemoved', s:red)
call s:HL('diffChanged', s:aqua)

call s:HL('diffFile', s:orange)
call s:HL('diffNewFile', s:yellow)

call s:HL('diffLine', s:blue)

" }}}
" Html: {{{

call s:HL('htmlTag', s:blue)
call s:HL('htmlEndTag', s:blue)

call s:HL('htmlTagName', s:aqua, 'NONE', s:bold)
call s:HL('htmlArg', s:aqua)

call s:HL('htmlScriptTag', s:purple)
call s:HL('htmlTagN', s:fg1)
call s:HL('htmlSpecialTagName', s:aqua, 'NONE', s:bold)

call s:HL('htmlLink', s:fg4, 'NONE', s:underline)

call s:HL('htmlSpecialChar', s:orange)

call s:HL('htmlBold', 'fg', 'bg', s:bold)
call s:HL('htmlBoldUnderline', 'fg', 'bg', s:bold . s:underline)
call s:HL('htmlBoldItalic', 'fg', 'bg', s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', 'fg', 'bg', s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', 'fg', 'bg', s:underline)
call s:HL('htmlUnderlineItalic', 'fg', 'bg', s:underline . s:italic)
call s:HL('htmlItalic', 'fg', 'bg', s:italic)

" }}}
" Xml: {{{

call s:HL('xmlTag', s:blue)
call s:HL('xmlEndTag', s:blue)
call s:HL('xmlTagName', s:blue)
call s:HL('xmlEqual', s:blue)
call s:HL('docbkKeyword', s:aqua, 'NONE', s:bold)

call s:HL('xmlDocTypeDecl', s:gray)
call s:HL('xmlDocTypeKeyword', s:purple)
call s:HL('xmlCdataStart', s:gray)
call s:HL('xmlCdataCdata', s:purple)
call s:HL('dtdFunction', s:gray)
call s:HL('dtdTagName', s:purple)

call s:HL('xmlAttrib', s:aqua)
call s:HL('xmlProcessingDelim', s:gray)
call s:HL('dtdParamEntityPunct', s:gray)
call s:HL('dtdParamEntityDPunct', s:gray)
call s:HL('xmlAttribPunct', s:gray)

call s:HL('xmlEntity', s:orange)
call s:HL('xmlEntityPunct', s:orange)
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, 'NONE', s:bold . s:italicize_comments)

call s:HL('vimNotation', s:orange)
call s:HL('vimBracket', s:orange)
call s:HL('vimMapModKey', s:orange)
call s:HL('vimFuncSID', s:fg3)
call s:HL('vimSetSep', s:fg3)
call s:HL('vimSep', s:fg3)
call s:HL('vimContinue', s:fg3)

" }}}
" Clojure: {{{

call s:HL('clojureKeyword', s:blue)
call s:HL('clojureCond', s:orange)
call s:HL('clojureSpecial', s:orange)
call s:HL('clojureDefine', s:orange)

call s:HL('clojureFunc', s:yellow)
call s:HL('clojureRepeat', s:yellow)
call s:HL('clojureCharacter', s:aqua)
call s:HL('clojureStringEscape', s:aqua)
call s:HL('clojureException', s:red)

call s:HL('clojureRegexp', s:aqua)
call s:HL('clojureRegexpEscape', s:aqua)
call s:HL('clojureRegexpCharClass', s:fg3, 'NONE', s:bold)
call s:HL('clojureRegexpMod', s:fg3, 'NONE', s:bold)
call s:HL('clojureRegexpQuantifier', s:fg3, 'NONE', s:bold)

call s:HL('clojureParen', s:fg3)
call s:HL('clojureAnonArg', s:yellow)
call s:HL('clojureVariable', s:blue)
call s:HL('clojureMacro', s:orange)

call s:HL('clojureMeta', s:yellow)
call s:HL('clojureDeref', s:yellow)
call s:HL('clojureQuote', s:yellow)
call s:HL('clojureUnquote', s:yellow)

" }}}
" C: {{{

call s:HL('cOperator', s:purple)
call s:HL('cStructure', s:orange)

" }}}
" Python: {{{

call s:HL('pythonBuiltin', s:orange)
call s:HL('pythonBuiltinObj', s:orange)
call s:HL('pythonBuiltinFunc', s:orange)
call s:HL('pythonFunction', s:aqua)
call s:HL('pythonDecorator', s:red)
call s:HL('pythonInclude', s:blue)
call s:HL('pythonImport', s:blue)
call s:HL('pythonRun', s:blue)
call s:HL('pythonCoding', s:blue)
call s:HL('pythonOperator', s:red)
call s:HL('pythonExceptions', s:purple)
call s:HL('pythonBoolean', s:purple)
call s:HL('pythonDot', s:fg3)

" }}}
" CSS: {{{

call s:HL('cssBraces', s:blue)
call s:HL('cssFunctionName', s:yellow)
call s:HL('cssIdentifier', s:orange)
call s:HL('cssClassName', s:green)
call s:HL('cssColor', s:blue)
call s:HL('cssSelectorOp', s:blue)
call s:HL('cssSelectorOp2', s:blue)
call s:HL('cssImportant', s:green)
call s:HL('cssVendor', s:fg1)

call s:HL('cssTextProp', s:aqua)
call s:HL('cssAnimationProp', s:aqua)
call s:HL('cssUIProp', s:yellow)
call s:HL('cssTransformProp', s:aqua)
call s:HL('cssTransitionProp', s:aqua)
call s:HL('cssPrintProp', s:aqua)
call s:HL('cssPositioningProp', s:yellow)
call s:HL('cssBoxProp', s:aqua)
call s:HL('cssFontDescriptorProp', s:aqua)
call s:HL('cssFlexibleBoxProp', s:aqua)
call s:HL('cssBorderOutlineProp', s:aqua)
call s:HL('cssBackgroundProp', s:aqua)
call s:HL('cssMarginProp', s:aqua)
call s:HL('cssListProp', s:aqua)
call s:HL('cssTableProp', s:aqua)
call s:HL('cssFontProp', s:aqua)
call s:HL('cssPaddingProp', s:aqua)
call s:HL('cssDimensionProp', s:aqua)
call s:HL('cssRenderProp', s:aqua)
call s:HL('cssColorProp', s:aqua)
call s:HL('cssGeneratedContentProp', s:aqua)

" }}}
" JavaScript: {{{

call s:HL('javaScriptBraces', s:fg1)
call s:HL('javaScriptFunction', s:aqua)
call s:HL('javaScriptIdentifier', s:red)
call s:HL('javaScriptMember', s:blue)
call s:HL('javaScriptNumber', s:purple)
call s:HL('javaScriptNull', s:purple)
call s:HL('javaScriptParens', s:fg3)

" }}}
" YAJS: {{{

call s:HL('javascriptImport', s:aqua)
call s:HL('javascriptExport', s:aqua)
call s:HL('javascriptClassKeyword', s:aqua)
call s:HL('javascriptClassExtends', s:aqua)
call s:HL('javascriptDefault', s:aqua)

call s:HL('javascriptClassName', s:yellow)
call s:HL('javascriptClassSuperName', s:yellow)
call s:HL('javascriptGlobal', s:yellow)

call s:HL('javascriptEndColons', s:fg1)
call s:HL('javascriptFuncArg', s:fg1)
call s:HL('javascriptGlobalMethod', s:fg1)
call s:HL('javascriptNodeGlobal', s:fg1)

" call s:HL('javascriptVariable', s:orange)
call s:HL('javascriptVariable', s:red)
" call s:HL('javascriptIdentifier', s:orange)
" call s:HL('javascriptClassSuper', s:orange)
call s:HL('javascriptIdentifier', s:orange)
call s:HL('javascriptClassSuper', s:orange)

" call s:HL('javascriptFuncKeyword', s:orange)
" call s:HL('javascriptAsyncFunc', s:orange)
call s:HL('javascriptFuncKeyword', s:aqua)
call s:HL('javascriptAsyncFunc', s:aqua)
call s:HL('javascriptClassStatic', s:orange)

call s:HL('javascriptOperator', s:red)
call s:HL('javascriptForOperator', s:red)
call s:HL('javascriptYield', s:red)
call s:HL('javascriptExceptions', s:red)
call s:HL('javascriptMessage', s:red)

call s:HL('javascriptTemplateSB', s:aqua)
call s:HL('javascriptTemplateSubstitution', s:fg1)

" call s:HL('javascriptLabel', s:blue)
" call s:HL('javascriptObjectLabel', s:blue)
" call s:HL('javascriptPropertyName', s:blue)
call s:HL('javascriptLabel', s:fg1)
call s:HL('javascriptObjectLabel', s:fg1)
call s:HL('javascriptPropertyName', s:fg1)

call s:HL('javascriptLogicSymbols', s:fg1)
call s:HL('javascriptArrowFunc', s:fg1)

call s:HL('javascriptDocParamName', s:fg4)
call s:HL('javascriptDocTags', s:fg4)
call s:HL('javascriptDocNotation', s:fg4)
call s:HL('javascriptDocParamType', s:fg4)
call s:HL('javascriptDocNamedParamType', s:fg4)

" }}}
" CoffeeScript: {{{

call s:HL('coffeeExtendedOp', s:fg3)
call s:HL('coffeeSpecialOp', s:fg3)
call s:HL('coffeeCurly', s:orange)
call s:HL('coffeeParen', s:fg3)
call s:HL('coffeeBracket', s:orange)

" }}}
" Ruby: {{{

call s:HL('rubyStringDelimiter', s:green)
call s:HL('rubyInterpolationDelimiter', s:aqua)

" }}}
" ObjectiveC: {{{

call s:HL('objcTypeModifier', s:red)
call s:HL('objcDirective', s:blue)

" }}}
" Go: {{{

call s:HL('goDirective', s:aqua)
call s:HL('goConstants', s:purple)
call s:HL('goDeclaration', s:red)
call s:HL('goDeclType', s:blue)
call s:HL('goBuiltins', s:orange)

" }}}
" Lua: {{{

call s:HL('luaIn', s:red)
call s:HL('luaFunction', s:aqua)
call s:HL('luaTable', s:orange)

" }}}
" MoonScript: {{{

call s:HL('moonSpecialOp', s:fg3)
call s:HL('moonExtendedOp', s:fg3)
call s:HL('moonFunction', s:fg3)
call s:HL('moonObject', s:yellow)

" }}}
" Java: {{{

call s:HL('javaAnnotation', s:blue)
call s:HL('javaDocTags', s:aqua)
hi! link javaCommentTitle vimCommentTitle
call s:HL('javaParen', s:fg3)
call s:HL('javaParen1', s:fg3)
call s:HL('javaParen2', s:fg3)
call s:HL('javaParen3', s:fg3)
call s:HL('javaParen4', s:fg3)
call s:HL('javaParen5', s:fg3)
call s:HL('javaOperator', s:orange)

call s:HL('javaVarArg', s:green)

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

call s:HL('elixirStringDelimiter', s:green)
call s:HL('elixirInterpolationDelimiter', s:aqua)

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
call s:HL('scalaNameDefinition', s:fg1)
call s:HL('scalaCaseFollowing', s:fg1)
call s:HL('scalaCapitalWord', s:fg1)
call s:HL('scalaTypeExtension', s:fg1)

call s:HL('scalaKeyword', s:red)
call s:HL('scalaKeywordModifier', s:red)

call s:HL('scalaSpecial', s:aqua)
call s:HL('scalaOperator', s:fg1)

call s:HL('scalaTypeDeclaration', s:yellow)
call s:HL('scalaTypeTypePostDeclaration', s:yellow)

call s:HL('scalaInstanceDeclaration', s:fg1)
call s:HL('scalaInterpolation', s:aqua)

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, 'NONE', s:italic)

call s:HL('markdownH1', s:green, 'NONE', s:bold)
call s:HL('markdownH2', s:green, 'NONE', s:bold)
call s:HL('markdownH3', s:yellow, 'NONE', s:bold)
call s:HL('markdownH4', s:yellow, 'NONE', s:bold)
call s:HL('markdownH5', s:yellow)
call s:HL('markdownH6', s:yellow)

call s:HL('markdownCode', s:aqua)
call s:HL('markdownCodeBlock', s:aqua)
call s:HL('markdownCodeDelimiter', s:aqua)

call s:HL('markdownBlockquote', s:gray)
call s:HL('markdownListMarker', s:gray)
call s:HL('markdownOrderedListMarker', s:gray)
call s:HL('markdownRule', s:gray)
call s:HL('markdownHeadingRule', s:gray)

call s:HL('markdownUrlDelimiter', s:fg3)
call s:HL('markdownLinkDelimiter', s:fg3)
call s:HL('markdownLinkTextDelimiter', s:fg3)

call s:HL('markdownHeadingDelimiter', s:orange)
call s:HL('markdownUrl', s:purple)
call s:HL('markdownUrlTitleDelimiter', s:green)

call s:HL('markdownLinkText', s:gray, 'NONE', s:underline)
call s:HL('markdownIdDeclaration', s:gray, 'NONE', s:underline)

" }}}
" Haskell: {{{

" call s:HL('haskellType', s:yellow)
" call s:HL('haskellOperators', s:orange)
" call s:HL('haskellConditional', s:aqua)
" call s:HL('haskellLet', s:orange)
"
call s:HL('haskellType', s:fg1)
call s:HL('haskellIdentifier', s:fg1)
call s:HL('haskellSeparator', s:fg1)
call s:HL('haskellDelimiter', s:fg4)
call s:HL('haskellOperators', s:blue)
"
call s:HL('haskellBacktick', s:orange)
call s:HL('haskellStatement', s:orange)
call s:HL('haskellConditional', s:orange)

call s:HL('haskellLet', s:aqua)
call s:HL('haskellDefault', s:aqua)
call s:HL('haskellWhere', s:aqua)
call s:HL('haskellBottom', s:aqua)
call s:HL('haskellBlockKeywords', s:aqua)
call s:HL('haskellImportKeywords', s:aqua)
call s:HL('haskellDeclKeyword', s:aqua)
call s:HL('haskellDeriving', s:aqua)
call s:HL('haskellAssocType', s:aqua)

call s:HL('haskellNumber', s:purple)
call s:HL('haskellPragma', s:purple)

call s:HL('haskellString', s:green)
call s:HL('haskellChar', s:green)

" }}}
" Json: {{{

call s:HL('jsonKeyword', s:green)
call s:HL('jsonQuote', s:green)
call s:HL('jsonBraces', s:fg1)
call s:HL('jsonString', s:fg1)

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! GruvboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
  call s:HL('vCursor', s:bg0, s:hls_cursor)
  call s:HL('iCursor', s:bg0, s:hls_cursor)
  call s:HL('lCursor', s:bg0, s:hls_cursor)
endfunction

function! GruvboxHlsHideCursor()
  call s:HL('Cursor', 'NONE', 'NONE', s:inverse)
  call s:HL('vCursor', 'NONE', 'NONE', s:inverse)
  call s:HL('iCursor', 'NONE', 'NONE', s:inverse)
  call s:HL('lCursor', 'NONE', 'NONE', s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
