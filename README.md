gruvbox
=======

Retro groove color scheme for Vim.

Gruvbox is heavily inspired by [badwolf][1], [jellybeans][2] and [solarized][3].

Designed as a bright theme with pastel 'retro groove' colors and light/dark mode switching in the way of [solarized][3]. The main focus when developing Gruvbox is to keep colors easily distinguishable, contrast enough and still pleasant for the eyes.

   [1]: https://github.com/sjl/badwolf
   [2]: https://github.com/nanotech/jellybeans.vim
   [3]: http://ethanschoonover.com/solarized

Screenshots
-----------

Color scheme is in early development stage, so this could serve as working preview.

### Dark mode

![Screenshot](http://i.imgur.com/2870c.png)

### Light mode

![Screenshot](http://i.imgur.com/oS9I3.png)

Features
--------

* Distraction-free HTML highlighting
* Clojure detailed support
* [Airline][4] theme mapping
* Hand-tuned plugin-specific highlighting for [EasyMotion][5], [Better Rainbow Parentheses][6], [Indent Guides][7], [Syntastic][8] and [Git Gutter][9]

   [4]: https://github.com/bling/vim-airline
   [5]: https://github.com/Lokaltog/vim-easymotion
   [6]: https://github.com/kien/rainbow_parentheses.vim
   [7]: https://github.com/nathanaelkane/vim-indent-guides
   [8]: https://github.com/scrooloose/syntastic
   [9]: https://github.com/airblade/vim-gitgutter

Usage
-----

gruvbox comes in two modes, dark and light. To toggle between them with F5 you can add these to your .vimrc:

	map <F5> :call ToggleBg()<CR>
	function! ToggleBg()
		if &background == 'dark'
			set bg=light
		else
			set bg=dark
		endif

		colo gruvbox
	endfunc

Just setting background to an appropriate value would work as well:

	set bg=dark    " Setting dark mode
	set bg=light   " Setting light mode

Since gruvbox inverts cursor color, it could be awkward to determine current position, when the search is highlighted. To get single cursor color while searching map these gruvbox functions same way:

	map <silent> <F4> :call gruvbox#hls_toggle()<CR>
	imap <silent> <F4> <ESC>:call gruvbox#hls_toggle()<CR>a
	vmap <silent> <F4> <ESC>:call gruvbox#hls_toggle()<CR>gv
 
	nnoremap <silent> <CR> :call gruvbox#hls_hide()<CR><CR>
  
	nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
	nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
	nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

So you'll get `g:gruvbox_hls_cursor` (orange by default) cursor color when highlight search is on and inverted one otherwise. With such mappings you could also toggle search highlight on and off with F4 and hide it with Enter.

[10]: https://gist.github.com/morhetz/6795169

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

That's known issue with Ubuntu GTK-themes. Refer [†][10] for more details. Known affected terms are Gnome Terminal, Terminator and Lilyterm and probably more VTE-based. Though with Lilyterm option 'Dim text when inactive' set off everything works fine.

   [11]: https://github.com/morhetz/gruvbox/issues/13#issuecomment-30063099

### Lighter colors with iTerm2

(...). Refer [†][11] and [‡][12] for more details.

   [12]: https://github.com/morhetz/gruvbox/issues/8#issuecomment-26782758
   [13]: https://github.com/morhetz/gruvbox/issues/8#issuecomment-27627656

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
Uses 256-color palette (suitable to pair with gruvbox-palette shell script). If you're dissatisfied with that, set option value to `16` to fallback base colors to your terminal palette. Refer [†][14] for details.  
default: `256`

[14]: https://github.com/morhetz/gruvbox/issues/4

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

Contributions
-------------

See [gruvbox-generalized][15] repo for contributions, ports and extras.

[15]: https://github.com/morhetz/gruvbox-generalized

ToDo
----

* More fyletype specific highlighting (ruby, python, javascript, coffeescript)
* Airline theme

License
-------
[MIT/X11][]

   [MIT/X11]: https://en.wikipedia.org/wiki/MIT_License
