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
* Closure filetype highlighting
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

Inverted cursor (...).

Terminal-specific
-----------------

TBD.

* (Recommended) 256-color pallette with gruvbox-palette shell-script
* 16 colors palette mode with gruvbox terminal colorscheme

Troubleshooting
---------------

### Italics gets inverted (terminal)

(...).

### Effect of gruvbox_256palette.sh gets reset on Alt-Tab

That's known issue with Ubuntu GTK-themes. Refer [†][10] for more details. Known affected terms are Gnome Terminal, Terminator and Lilyterm (though with Lilyterm option 'Dim text when inactive' set off everything is fine).

   [10]: https://github.com/morhetz/gruvbox/issues/13#issuecomment-30063099

### Lighter colors with iTerm2

(...). Refer [†][11] and [‡][12] for more details.

   [11]: https://github.com/morhetz/gruvbox/issues/8#issuecomment-26782758
   [12]: https://github.com/morhetz/gruvbox/issues/8#issuecomment-27627656

Configuration
-------------

### g:gruvbox_bold
(...).
default: `1`

### g:gruvbox_italic
(...).
default: `1`

### g:gruvbox_underline
(...).
default: `1`

### g:gruvbox_undercurl
(...).
default: `1`

### g:gruvbox_termcolors
(...).
default: `256`

### g:gruvbox_hls_cursor
(...).
default: `orange`

### g:gruvbox_sign_column
(...).
default: `dark1`

### g:gruvbox_italicize_comments
(...).
default: `1`

### g:gruvbox_italicize_strings
(...).
default: `0`

### g:gruvbox_invert_selection
(...).
default: `1`

### g:gruvbox_invert_signs
(...).
default: `0`

### g:gruvbox_invert_indent_guides
(...).
default: `0`

Contributions
-------------

(...).

ToDo
----

* More fyletype specific highlighting (ruby, python, javascript, coffeescript)
* Airline theme

License
-------
[MIT/X11][]

   [MIT/X11]: https://en.wikipedia.org/wiki/MIT_License
