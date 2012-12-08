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

Color scheme is in early development stage, so this could serve as working preview.

### Dark mode

![Screenshot](http://i.imgur.com/2870c.png)

### Ligth mode

![Screenshot](http://i.imgur.com/oS9I3.png)

Usage
-----

gruvbox comes in two modes, dark and light. To toggle between them with F5 you can add these to your .vimrc

	map <F5> :call ToggleBg()<CR>
	function! ToggleBg()
		if &background == 'dark'
			set bg=light
		else
			set bg=dark
		endif
	endfunc

Just setting background to an appropriate value would work as well

	set bg=dark    " Setting dark mode
	set bg=light   " Setting light mode

ToDo
----

* Terminal low-color mode (&lt;256)
* More fyletype specific highlighting
* Customizable options (overrides, background switch, etc.)
* Powerline colors

License
-------
[MIT/X11][]

   [MIT/X11]: https://en.wikipedia.org/wiki/MIT_License
