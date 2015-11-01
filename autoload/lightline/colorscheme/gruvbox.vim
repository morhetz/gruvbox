" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Gruvbox colorscheme for Lightline (itchyny/lightline.vim)
" Author: gmoe <me@griffinmoe.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 31 Oct 2015
" -----------------------------------------------------------------------------

function! s:getGruvColor(group)
  let guiColor = synIDattr(hlID(a:group), "fg", "gui") 
  let termColor = synIDattr(hlID(a:group), "fg", "cterm") 
  return [ guiColor, termColor ]
endfunction

if exists('g:lightline')

  let s:bg1  = s:getGruvColor('GruvboxBg1')
  let s:bg2  = s:getGruvColor('GruvboxBg2')
  let s:bg3  = s:getGruvColor('GruvboxBg3')
  let s:bg4  = s:getGruvColor('GruvboxBg4')
  let s:gray = s:getGruvColor('GruvboxGray')
  let s:fg1  = s:getGruvColor('GruvboxFg1')
  let s:fg2  = s:getGruvColor('GruvboxFg2')
  let s:fg3  = s:getGruvColor('GruvboxFg3')
  let s:fg4  = s:getGruvColor('GruvboxFg4')

  let s:red    = s:getGruvColor('GruvboxRed')
  let s:green  = s:getGruvColor('GruvboxGreen')
  let s:yellow = s:getGruvColor('GruvboxYellow')
  let s:blue   = s:getGruvColor('GruvboxBlue')
  let s:purple = s:getGruvColor('GruvboxPurple')
  let s:aqua   = s:getGruvColor('GruvboxAqua')
  let s:orange = s:getGruvColor('GruvboxOrange')

  let s:p = {'normal':{}, 'inactive':{}, 'insert':{}, 'replace':{}, 'visual':{}, 'tabline':{}}
  let s:p.normal.left = [ [ s:bg1, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.normal.right = [ [ s:bg1, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.inactive.right = [ [ s:gray, s:bg1 ], [ s:gray, s:bg1 ] ]
  let s:p.inactive.left =  [ [ s:gray, s:bg1 ], [ s:gray, s:bg1 ] ]
  let s:p.insert.left = [ [ s:bg2, s:blue ], [ s:fg4, s:bg2 ] ]
  let s:p.insert.right = [ [ s:bg2, s:blue ], [ s:fg4, s:bg2 ] ]
  let s:p.replace.left = [ [ s:bg2, s:aqua ], [ s:fg4, s:bg2 ] ]
  let s:p.replace.right = [ [ s:bg2, s:aqua ], [ s:fg4, s:bg2 ] ]
  let s:p.visual.left = [ [ s:bg2, s:orange ], [ s:fg4, s:bg2 ] ]
  let s:p.visual.right = [ [ s:bg2, s:orange ], [ s:fg4, s:bg2 ] ]
  let s:p.normal.middle = [ [ s:fg3, s:bg1 ] ]
  let s:p.inactive.middle = [ [ s:fg3, s:bg1 ] ]
  let s:p.tabline.left = [ [ s:bg1, s:fg4 ] ]
  let s:p.tabline.tabsel = [ [ s:fg4, s:bg2 ] ]
  let s:p.tabline.middle = [ [ s:bg4, s:bg1 ] ]
  let s:p.tabline.right = [ [ s:bg1, s:orange ] ]
  let s:p.normal.error = [ [ s:bg1, s:red ] ]
  let s:p.normal.warning = [ [ s:bg2, s:yellow ] ]

  let g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(s:p)
endif

