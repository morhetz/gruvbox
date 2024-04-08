#!/bin/sh

colors=(
  # --- Background shades (used in layers, UI sections) ---
  "234=16/18/19"   # bg0_h - very dark background
  "235=1e/1e/1e"   # bg0    - base background
  "236=26/24/23"   # bg1    - slightly lighter bg
  "237=2e/2a/29"   # bg2    - line numbers, subtle bg
  "239=3f/39/35"   # bg3    - border lines, splitbars
  "241=53/4a/42"   # bg4    - cursor line bg, subtle contrast
  "243=68/5c/51"   # bg5    - low contrast UI elements

  # --- Faded foreground / comments / subdued text ---
  "244=7f/70/61"   # gray1  - comments
  "245=7f/70/61"   # gray2  - docstrings, hints (same as gray1)

  # --- Main foreground and subtle variants ---
  "250=cb/b8/90"   # fg     - default foreground text
  "248=af/9f/81"   # fg1    - slightly faded text
  "246=97/87/71"   # fg2    - further dimmed

  # --- Light background highlights (e.g. selection, search) ---
  "228=ef/df/ae"   # yellow1 - selection bg
  "229=fa/ee/bb"   # yellow2 - search highlight bg
  "230=f8/f4/cd"   # lightest - special highlights
  "223=e6/d4/a3"   # alt highlight bg

  # --- Core Gruvbox accent colors ---
  "167=f7/30/28"   # red     - errors, removals
  "142=aa/b0/1e"   # green   - additions, success
  "214=f7/b1/25"   # yellow  - warnings
  "175=c7/70/89"   # purple  - function names, git renamed
  "108=7d/b6/69"   # aqua    - type hints, diffs
  "109=71/95/86"   # teal    - status bars, cursor
  "208=fb/6a/16"   # orange  - search match, bright UI

  # --- Darker accent variants for backgrounds or subtle diff ---
  "88=89/00/09"    # red dark     - error background
  "100=66/62/0d"   # green dark   - diff bg
  "136=a5/63/11"   # yellow dark  - change marker
  "130=9d/28/07"   # orange dark  - symbol/markup
  "24=0e/53/65"    # blue dark    - info, links
  "96=7b/2b/5e"    # purple dark  - markdown, hint bg
  "66=35/6a/46"    # green deep   - background diff +
)

# Detect terminal escape sequence wrapping
if [ "${TERM%%-*}" = "screen" ]; then
  if [ -n "$TMUX" ]; then
    prefix="\033Ptmux;\033"
    suffix="\033\\"
  else
    prefix="\033P"
    suffix="\033\\"
  fi
else
  prefix=""
  suffix="\033\\"
fi

# Apply one color index+value to the terminal palette
set_color() {
  index="${1%%=*}"
  value="${1#*=}"
  printf "${prefix}\033]4;%s;rgb:%s\007${suffix}" "$index" "$value"
}

# Loop over all defined colors
for color in "${colors[@]}"; do
  set_color "$color"
done
