#!/bin/sh

if [ "${TERM%%-*}" = "screen" ]; then
  if [ -n "$TMUX" ]; then
    printf "\033Ptmux;\033\033]4;236;rgb:32/30/2f\007\033\\"
    printf "\033Ptmux;\033\033]4;234;rgb:1d/20/21\007\033\\"

    printf "\033Ptmux;\033\033]4;235;rgb:28/28/28\007\033\\"
    printf "\033Ptmux;\033\033]4;237;rgb:3c/38/36\007\033\\"
    printf "\033Ptmux;\033\033]4;239;rgb:50/49/45\007\033\\"
    printf "\033Ptmux;\033\033]4;241;rgb:66/5c/54\007\033\\"
    printf "\033Ptmux;\033\033]4;243;rgb:7c/6f/64\007\033\\"

    printf "\033Ptmux;\033\033]4;244;rgb:92/83/74\007\033\\"
    printf "\033Ptmux;\033\033]4;245;rgb:92/83/74\007\033\\"

    printf "\033Ptmux;\033\033]4;228;rgb:f2/e5/bc\007\033\\"
    printf "\033Ptmux;\033\033]4;230;rgb:f9/f5/d7\007\033\\"

    printf "\033Ptmux;\033\033]4;229;rgb:fb/f1/c7\007\033\\"
    printf "\033Ptmux;\033\033]4;223;rgb:eb/db/b2\007\033\\"
    printf "\033Ptmux;\033\033]4;250;rgb:d5/c4/a1\007\033\\"
    printf "\033Ptmux;\033\033]4;248;rgb:bd/ae/93\007\033\\"
    printf "\033Ptmux;\033\033]4;246;rgb:a8/99/84\007\033\\"

    printf "\033Ptmux;\033\033]4;167;rgb:fb/49/34\007\033\\"
    printf "\033Ptmux;\033\033]4;142;rgb:b8/bb/26\007\033\\"
    printf "\033Ptmux;\033\033]4;214;rgb:fa/bd/2f\007\033\\"
    printf "\033Ptmux;\033\033]4;109;rgb:83/a5/98\007\033\\"
    printf "\033Ptmux;\033\033]4;175;rgb:d3/86/9b\007\033\\"
    printf "\033Ptmux;\033\033]4;108;rgb:8e/c0/7c\007\033\\"
    printf "\033Ptmux;\033\033]4;208;rgb:fe/80/19\007\033\\"

    printf "\033Ptmux;\033\033]4;88;rgb:9d/00/06\007\033\\"
    printf "\033Ptmux;\033\033]4;100;rgb:79/74/0e\007\033\\"
    printf "\033Ptmux;\033\033]4;136;rgb:b5/76/14\007\033\\"
    printf "\033Ptmux;\033\033]4;24;rgb:07/66/78\007\033\\"
    printf "\033Ptmux;\033\033]4;96;rgb:8f/3f/71\007\033\\"
    printf "\033Ptmux;\033\033]4;66;rgb:42/7b/58\007\033\\"
    printf "\033Ptmux;\033\033]4;130;rgb:af/3a/03\007\033\\"
  else
    printf "\033P\033]4;236;rgb:32/30/2f\007\033\\"
    printf "\033P\033]4;234;rgb:1d/20/21\007\033\\"

    printf "\033P\033]4;235;rgb:28/28/28\007\033\\"
    printf "\033P\033]4;237;rgb:3c/38/36\007\033\\"
    printf "\033P\033]4;239;rgb:50/49/45\007\033\\"
    printf "\033P\033]4;241;rgb:66/5c/54\007\033\\"
    printf "\033P\033]4;243;rgb:7c/6f/64\007\033\\"

    printf "\033P\033]4;244;rgb:92/83/74\007\033\\"
    printf "\033P\033]4;245;rgb:92/83/74\007\033\\"

    printf "\033P\033]4;228;rgb:f2/e5/bc\007\033\\"
    printf "\033P\033]4;230;rgb:f9/f5/d7\007\033\\"

    printf "\033P\033]4;229;rgb:fb/f1/c7\007\033\\"
    printf "\033P\033]4;223;rgb:eb/db/b2\007\033\\"
    printf "\033P\033]4;250;rgb:d5/c4/a1\007\033\\"
    printf "\033P\033]4;248;rgb:bd/ae/93\007\033\\"
    printf "\033P\033]4;246;rgb:a8/99/84\007\033\\"

    printf "\033P\033]4;167;rgb:fb/49/34\007\033\\"
    printf "\033P\033]4;142;rgb:b8/bb/26\007\033\\"
    printf "\033P\033]4;214;rgb:fa/bd/2f\007\033\\"
    printf "\033P\033]4;109;rgb:83/a5/98\007\033\\"
    printf "\033P\033]4;175;rgb:d3/86/9b\007\033\\"
    printf "\033P\033]4;108;rgb:8e/c0/7c\007\033\\"
    printf "\033P\033]4;208;rgb:fe/80/19\007\033\\"

    printf "\033P\033]4;88;rgb:9d/00/06\007\033\\"
    printf "\033P\033]4;100;rgb:79/74/0e\007\033\\"
    printf "\033P\033]4;136;rgb:b5/76/14\007\033\\"
    printf "\033P\033]4;24;rgb:07/66/78\007\033\\"
    printf "\033P\033]4;96;rgb:8f/3f/71\007\033\\"
    printf "\033P\033]4;66;rgb:42/7b/58\007\033\\"
    printf "\033P\033]4;130;rgb:af/3a/03\007\033\\"
  fi

elif [ "$TERM" != "linux" ] && [ "$TERM" != "vt100" ] && [ "$TERM" != "vt220" ]; then

  printf "\033]4;236;rgb:32/30/2f\033\\"
  printf "\033]4;234;rgb:1d/20/21\033\\"

  printf "\033]4;235;rgb:28/28/28\033\\"
  printf "\033]4;237;rgb:3c/38/36\033\\"
  printf "\033]4;239;rgb:50/49/45\033\\"
  printf "\033]4;241;rgb:66/5c/54\033\\"
  printf "\033]4;243;rgb:7c/6f/64\033\\"

  printf "\033]4;244;rgb:92/83/74\033\\"
  printf "\033]4;245;rgb:92/83/74\033\\"

  printf "\033]4;228;rgb:f2/e5/bc\033\\"
  printf "\033]4;230;rgb:f9/f5/d7\033\\"

  printf "\033]4;229;rgb:fb/f1/c7\033\\"
  printf "\033]4;223;rgb:eb/db/b2\033\\"
  printf "\033]4;250;rgb:d5/c4/a1\033\\"
  printf "\033]4;248;rgb:bd/ae/93\033\\"
  printf "\033]4;246;rgb:a8/99/84\033\\"

  printf "\033]4;167;rgb:fb/49/34\033\\"
  printf "\033]4;142;rgb:b8/bb/26\033\\"
  printf "\033]4;214;rgb:fa/bd/2f\033\\"
  printf "\033]4;109;rgb:83/a5/98\033\\"
  printf "\033]4;175;rgb:d3/86/9b\033\\"
  printf "\033]4;108;rgb:8e/c0/7c\033\\"
  printf "\033]4;208;rgb:fe/80/19\033\\"

  printf "\033]4;88;rgb:9d/00/06\033\\"
  printf "\033]4;100;rgb:79/74/0e\033\\"
  printf "\033]4;136;rgb:b5/76/14\033\\"
  printf "\033]4;24;rgb:07/66/78\033\\"
  printf "\033]4;96;rgb:8f/3f/71\033\\"
  printf "\033]4;66;rgb:42/7b/58\033\\"
  printf "\033]4;130;rgb:af/3a/03\033\\"

elif [ "$TERM" = "linux" ]; then

  printf "\e]P0282828" # Background

  printf "\e]P1ff0000" # Red
  printf "\e]P200ff00" # Green
  printf "\e]P3bbbb00" # Yellow
  printf "\e]P40000ff" # Blue
  printf "\e]P5aa00bb" # Magenta
  printf "\e]P600bbbb" # Cyan

  printf "\e]P7aaaaaa" # Foreground

  # Bold colors that can be used as aditionnal foreground colors
  printf "\e]P8666666" # Bold Black (grey, for comments)

  printf "\e]P9ff7777" # Bold Red
  printf "\e]PA77ff77" # Bold Green
  printf "\e]PBffff55" # Bold Yellow (could be orange)
  printf "\e]PC7777ff" # Bold Blue
  printf "\e]PDff55ff" # Bold Magenta
  printf "\e]PE55ffff" # Bold Cyan

  printf "\e]PFffffff" # Bold Foreground

  clear # Actualisates the background
fi
