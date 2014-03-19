gruvbox
=======

Retro groove color scheme for Vim.

Gruvbox is heavily inspired by [badwolf][], [jellybeans][] and [solarized][].

Designed as a bright theme with pastel 'retro groove' colors and light/dark mode switching in the way of [solarized][]. The main focus when developing Gruvbox is to keep colors easily distinguishable, contrast enough and still pleasant for the eyes.

   [badwolf]: https://github.com/sjl/badwolf
   [jellybeans]: https://github.com/nanotech/jellybeans.vim
   [solarized]: http://ethanschoonover.com/solarized

Screenshots
-----------

Refer [Gallery][] for more syntax-specific screenshots.

   [Gallery]: https://github.com/morhetz/gruvbox/wiki/Gallery

### Dark mode

![Screenshot](http://i.imgur.com/2870c.png)

### Light mode

![Screenshot](http://i.imgur.com/oS9I3.png)

Features
--------

* Lots of style-customization options (contrast, color invertion, italics usage etc.)
* Extended filetype highlighting: Html, Xml, Vim, Clojure, C, Python, JavaScript, CoffeeScript, Ruby, Objective-C, Go, Lua, MoonScript, Java
* Supported plugins: [EasyMotion][], [vim-sneak][], [Indent Guides][], [indentLine][], [Rainbow Parentheses][], [Airline][], [GitGutter][], [Signify][], [ShowMarks][], [Signature][], [Syntastic][], [CtrlP][], [Startify][]

   [EasyMotion]: https://github.com/Lokaltog/vim-easymotion
   [vim-sneak]: https://github.com/justinmk/vim-sneak
   [Indent Guides]: https://github.com/nathanaelkane/vim-indent-guides
   [indentLine]: https://github.com/Yggdroot/indentLine
   [Rainbow Parentheses]: https://github.com/kien/rainbow_parentheses.vim
   [Airline]: https://github.com/bling/vim-airline
   [GitGutter]: https://github.com/airblade/vim-gitgutter
   [Signify]: https://github.com/mhinz/vim-signify
   [ShowMarks]: http://www.vim.org/scripts/script.php?script_id=152
   [Signature]: https://github.com/kshenoy/vim-signature
   [Syntastic]: https://github.com/scrooloose/syntastic
   [CtrlP]: https://github.com/kien/ctrlp.vim
   [Startify]: https://github.com/mhinz/vim-startify

Usage
-----

gruvbox comes in two modes, dark and light. To toggle between them with F5 you can add these to your .vimrc:

	map <silent> <F5> :call gruvbox#bg_toggle()<CR>
	imap <silent> <F5> <ESC>:call gruvbox#bg_toggle()<CR>a
	vmap <silent> <F5> <ESC>:call gruvbox#bg_toggle()<CR>gv

Just setting background to an appropriate value would work as well:

	set bg=dark    " Setting dark mode
	set bg=light   " Setting light mode

Since gruvbox inverts cursor color, it could be awkward to determine current position, when the search is highlighted. To get single cursor color while searching, map these gruvbox functions same way:

	nnoremap <silent> <Leader><Space> :call gruvbox#hls_toggle()<CR>
	inoremap <silent> <Leader><Space> <ESC>:call gruvbox#hls_toggle()<CR>a
	vnoremap <silent> <Leader><Space> <ESC>:call gruvbox#hls_toggle()<CR>gv
 
	nnoremap <silent> <CR> :call gruvbox#hls_hide()<CR><CR>
  
	nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
	nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
	nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

So you'll get `g:gruvbox_hls_cursor` (orange by default) cursor color when highlight search is on and inverted one otherwise. With such mappings you could also toggle search highlight on and off with <Leader><Space> and hide it with Enter.

Terminal-specific
-----------------

(...).

* (Recommended) 256-color palette with gruvbox-palette shell script
* 16 colors palette mode with gruvbox terminal colorscheme

Troubleshooting
---------------

### Italics gets inverted (terminal)

Most terminals doesn't allow italics so the text that must be italicized goes inverted. To prevent that disable `g:gruvbox_italic` option.

### Effect of gruvbox_256palette.sh gets reset on Alt-Tab

That's known issue with Ubuntu GTK-themes. Refer [†][1] for more details. Known affected terms are Gnome Terminal, Terminator and Lilyterm and probably more VTE-based. Though with Lilyterm option 'Dim text when inactive' set off everything works fine.

   [1]: https://github.com/morhetz/gruvbox/issues/13#issuecomment-30063099

### Lighter colors with iTerm2

(...). Refer [†][2] and [‡][3] for more details.

   [2]: https://github.com/morhetz/gruvbox/issues/8#issuecomment-26782758
   [3]: https://github.com/morhetz/gruvbox/issues/8#issuecomment-27627656

Configuration
-------------

### g:gruvbox_bold
Enables bold text.  
default: `1`

### g:gruvbox_italic
Enables italic text.  
default: `1`

### g:gruvbox_underline
Enables underlined text.  
default: `1`

### g:gruvbox_undercurl
Enables undercurled text.  
default: `1`

### g:gruvbox_termcolors
Uses 256-color palette (suitable to pair with gruvbox-palette shell script). If you're dissatisfied with that, set option value to `16` to fallback base colors to your terminal palette. Refer [†][4] for details.  
default: `256`

[4]: https://github.com/morhetz/gruvbox/issues/4

### g:gruvbox_contrast
Possible values are `soft`, `medium` and `hard`.  
default: `medium`

### g:gruvbox_hls_cursor
Changes cursor background while search is highlighted. Possible values are any of gruvbox palette.  
default: `orange`

### g:gruvbox_sign_column
Changes sign column background color. Possible values are any of gruvbox palette.  
default: `dark1`

### g:gruvbox_italicize_comments
Enables italic for comments.  
default: `1`

### g:gruvbox_italicize_strings
Enables italic for strings.  
default: `0`

### g:gruvbox_invert_selection
Inverts selected text.  
default: `1`

### g:gruvbox_invert_signs
Inverts GitGutter and Syntastic signs. Useful to rapidly focus on.  
default: `0`

### g:gruvbox_invert_indent_guides
Inverts indent guides. Could be nice paired with `set list` so it would highlight only tab symbols instead of it's background.  
default: `0`

Functions
---------

### gruvbox#bg_toggle()

(...)

### gruvbox#invert_signs_toggle()

(...)

### gruvbox#hls_show()

(...)

### gruvbox#hls_show_cursor()

(...)

### gruvbox#hls_hide()

(...)

### gruvbox#hls_hide_cursor()

(...)

### gruvbox#hls_toggle()

(...)

Contributions
-------------

See [gruvbox-generalized][] repo for contributions, ports and extras.

[gruvbox-generalized]: https://github.com/morhetz/gruvbox-generalized

ToDo
----

* Filetype syntax highlighting (R, TeX and I'm still dissatisfied with CSS)
* Plugin support (MiniBufExplorer, Tagbar)
* Airline theme

License
-------
[MIT/X11][]

   [MIT/X11]: https://en.wikipedia.org/wiki/MIT_License
