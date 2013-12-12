#!/bin/sh

if [ "${TERM%%-*}" = "screen" ]; then
	if [ -n "$TMUX" ]; then
		echo -ne "\x1bPtmux;\x1b\x1b]4;236;rgb:32/30/2f\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;234;rgb:1d/20/21\a\x1b\\"

		echo -ne "\x1bPtmux;\x1b\x1b]4;235;rgb:28/28/28\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;237;rgb:3c/38/36\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;239;rgb:50/49/45\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;241;rgb:66/5c/54\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;243;rgb:7c/6f/64\a\x1b\\"

		echo -ne "\x1bPtmux;\x1b\x1b]4;244;rgb:92/83/74\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;245;rgb:92/83/74\a\x1b\\"

		echo -ne "\x1bPtmux;\x1b\x1b]4;228;rgb:f4/e8/ba\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;230;rgb:ff/ff/c8\a\x1b\\"

		echo -ne "\x1bPtmux;\x1b\x1b]4;229;rgb:fd/f4/c1\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;223;rgb:eb/db/b2\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;250;rgb:d5/c4/a1\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;248;rgb:bd/ae/93\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;246;rgb:a8/99/84\a\x1b\\"

		echo -ne "\x1bPtmux;\x1b\x1b]4;167;rgb:fb/49/34\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;142;rgb:b8/bb/26\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;214;rgb:fa/bd/2f\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;109;rgb:83/a5/98\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;175;rgb:d3/86/9b\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;108;rgb:8e/c0/7c\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;208;rgb:fe/80/19\a\x1b\\"

		echo -ne "\x1bPtmux;\x1b\x1b]4;88;rgb:9d/00/06\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;100;rgb:79/74/0e\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;136;rgb:b5/76/14\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;24;rgb:07/66/78\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;96;rgb:8f/3f/71\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;66;rgb:42/7b/58\a\x1b\\"
		echo -ne "\x1bPtmux;\x1b\x1b]4;130;rgb:af/3a/03\a\x1b\\"
	else
		echo -ne "\x1bP\x1b]4;236;rgb:32/30/2f\a\x1b\\"
		echo -ne "\x1bP\x1b]4;234;rgb:1d/20/21\a\x1b\\"

		echo -ne "\x1bP\x1b]4;235;rgb:28/28/28\a\x1b\\"
		echo -ne "\x1bP\x1b]4;237;rgb:3c/38/36\a\x1b\\"
		echo -ne "\x1bP\x1b]4;239;rgb:50/49/45\a\x1b\\"
		echo -ne "\x1bP\x1b]4;241;rgb:66/5c/54\a\x1b\\"
		echo -ne "\x1bP\x1b]4;243;rgb:7c/6f/64\a\x1b\\"

		echo -ne "\x1bP\x1b]4;244;rgb:92/83/74\a\x1b\\"
		echo -ne "\x1bP\x1b]4;245;rgb:92/83/74\a\x1b\\"

		echo -ne "\x1bP\x1b]4;228;rgb:f4/e8/ba\a\x1b\\"
		echo -ne "\x1bP\x1b]4;230;rgb:ff/ff/c8\a\x1b\\"

		echo -ne "\x1bP\x1b]4;229;rgb:fd/f4/c1\a\x1b\\"
		echo -ne "\x1bP\x1b]4;223;rgb:eb/db/b2\a\x1b\\"
		echo -ne "\x1bP\x1b]4;250;rgb:d5/c4/a1\a\x1b\\"
		echo -ne "\x1bP\x1b]4;248;rgb:bd/ae/93\a\x1b\\"
		echo -ne "\x1bP\x1b]4;246;rgb:a8/99/84\a\x1b\\"

		echo -ne "\x1bP\x1b]4;167;rgb:fb/49/34\a\x1b\\"
		echo -ne "\x1bP\x1b]4;142;rgb:b8/bb/26\a\x1b\\"
		echo -ne "\x1bP\x1b]4;214;rgb:fa/bd/2f\a\x1b\\"
		echo -ne "\x1bP\x1b]4;109;rgb:83/a5/98\a\x1b\\"
		echo -ne "\x1bP\x1b]4;175;rgb:d3/86/9b\a\x1b\\"
		echo -ne "\x1bP\x1b]4;108;rgb:8e/c0/7c\a\x1b\\"
		echo -ne "\x1bP\x1b]4;208;rgb:fe/80/19\a\x1b\\"

		echo -ne "\x1bP\x1b]4;88;rgb:9d/00/06\a\x1b\\"
		echo -ne "\x1bP\x1b]4;100;rgb:79/74/0e\a\x1b\\"
		echo -ne "\x1bP\x1b]4;136;rgb:b5/76/14\a\x1b\\"
		echo -ne "\x1bP\x1b]4;24;rgb:07/66/78\a\x1b\\"
		echo -ne "\x1bP\x1b]4;96;rgb:8f/3f/71\a\x1b\\"
		echo -ne "\x1bP\x1b]4;66;rgb:42/7b/58\a\x1b\\"
		echo -ne "\x1bP\x1b]4;130;rgb:af/3a/03\a\x1b\\"
	fi
else
	echo -ne "\x1b]4;236;rgb:32/30/2f\x1b\\"
	echo -ne "\x1b]4;234;rgb:1d/20/21\x1b\\"

	echo -ne "\x1b]4;235;rgb:28/28/28\x1b\\"
	echo -ne "\x1b]4;237;rgb:3c/38/36\x1b\\"
	echo -ne "\x1b]4;239;rgb:50/49/45\x1b\\"
	echo -ne "\x1b]4;241;rgb:66/5c/54\x1b\\"
	echo -ne "\x1b]4;243;rgb:7c/6f/64\x1b\\"

	echo -ne "\x1b]4;244;rgb:92/83/74\x1b\\"
	echo -ne "\x1b]4;245;rgb:92/83/74\x1b\\"

	echo -ne "\x1b]4;228;rgb:f4/e8/ba\x1b\\"
	echo -ne "\x1b]4;230;rgb:ff/ff/c8\x1b\\"

	echo -ne "\x1b]4;229;rgb:fd/f4/c1\x1b\\"
	echo -ne "\x1b]4;223;rgb:eb/db/b2\x1b\\"
	echo -ne "\x1b]4;250;rgb:d5/c4/a1\x1b\\"
	echo -ne "\x1b]4;248;rgb:bd/ae/93\x1b\\"
	echo -ne "\x1b]4;246;rgb:a8/99/84\x1b\\"

	echo -ne "\x1b]4;167;rgb:fb/49/34\x1b\\"
	echo -ne "\x1b]4;142;rgb:b8/bb/26\x1b\\"
	echo -ne "\x1b]4;214;rgb:fa/bd/2f\x1b\\"
	echo -ne "\x1b]4;109;rgb:83/a5/98\x1b\\"
	echo -ne "\x1b]4;175;rgb:d3/86/9b\x1b\\"
	echo -ne "\x1b]4;108;rgb:8e/c0/7c\x1b\\"
	echo -ne "\x1b]4;208;rgb:fe/80/19\x1b\\"

	echo -ne "\x1b]4;88;rgb:9d/00/06\x1b\\"
	echo -ne "\x1b]4;100;rgb:79/74/0e\x1b\\"
	echo -ne "\x1b]4;136;rgb:b5/76/14\x1b\\"
	echo -ne "\x1b]4;24;rgb:07/66/78\x1b\\"
	echo -ne "\x1b]4;96;rgb:8f/3f/71\x1b\\"
	echo -ne "\x1b]4;66;rgb:42/7b/58\x1b\\"
	echo -ne "\x1b]4;130;rgb:af/3a/03\x1b\\"
fi
