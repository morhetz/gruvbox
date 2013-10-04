#!/bin/bash

if [[ "$TERM" == "screen" || "$TERM" == "screen-256color" ]]; then
	echo -ne "\eP\e]4;235;rgb:28/28/28\a\e\\"
	echo -ne "\eP\e]4;237;rgb:3c/38/36\a\e\\"
	echo -ne "\eP\e]4;239;rgb:50/49/45\a\e\\"
	echo -ne "\eP\e]4;241;rgb:66/5c/54\a\e\\"
	echo -ne "\eP\e]4;243;rgb:7c/6f/64\a\e\\"

	echo -ne "\eP\e]4;244;rgb:92/83/74\a\e\\"
	echo -ne "\eP\e]4;245;rgb:92/83/74\a\e\\"

	echo -ne "\eP\e]4;229;rgb:fd/f4/c1\a\e\\"
	echo -ne "\eP\e]4;223;rgb:eb/db/b2\a\e\\"
	echo -ne "\eP\e]4;250;rgb:d5/c4/a1\a\e\\"
	echo -ne "\eP\e]4;248;rgb:bd/ae/93\a\e\\"
	echo -ne "\eP\e]4;246;rgb:a8/99/84\a\e\\"

	echo -ne "\eP\e]4;167;rgb:fb/49/34\a\e\\"
	echo -ne "\eP\e]4;142;rgb:b8/bb/26\a\e\\"
	echo -ne "\eP\e]4;214;rgb:fa/bd/2f\a\e\\"
	echo -ne "\eP\e]4;109;rgb:83/a5/98\a\e\\"
	echo -ne "\eP\e]4;175;rgb:d3/86/9b\a\e\\"
	echo -ne "\eP\e]4;108;rgb:8e/c0/7c\a\e\\"
	echo -ne "\eP\e]4;208;rgb:fe/80/19\a\e\\"

	echo -ne "\eP\e]4;88;rgb:9d/00/06\a\e\\"
	echo -ne "\eP\e]4;100;rgb:79/74/0e\a\e\\"
	echo -ne "\eP\e]4;136;rgb:b5/76/14\a\e\\"
	echo -ne "\eP\e]4;24;rgb:07/66/78\a\e\\"
	echo -ne "\eP\e]4;96;rgb:8f/3f/71\a\e\\"
	echo -ne "\eP\e]4;66;rgb:42/7b/58\a\e\\"
	echo -ne "\eP\e]4;130;rgb:af/3a/03\a\e\\"
else
	echo -ne "\e]4;235;rgb:28/28/28\e\\"
	echo -ne "\e]4;237;rgb:3c/38/36\e\\"
	echo -ne "\e]4;239;rgb:50/49/45\e\\"
	echo -ne "\e]4;241;rgb:66/5c/54\e\\"
	echo -ne "\e]4;243;rgb:7c/6f/64\e\\"

	echo -ne "\e]4;244;rgb:92/83/74\e\\"
	echo -ne "\e]4;245;rgb:92/83/74\e\\"

	echo -ne "\e]4;229;rgb:fd/f4/c1\e\\"
	echo -ne "\e]4;223;rgb:eb/db/b2\e\\"
	echo -ne "\e]4;250;rgb:d5/c4/a1\e\\"
	echo -ne "\e]4;248;rgb:bd/ae/93\e\\"
	echo -ne "\e]4;246;rgb:a8/99/84\e\\"

	echo -ne "\e]4;167;rgb:fb/49/34\e\\"
	echo -ne "\e]4;142;rgb:b8/bb/26\e\\"
	echo -ne "\e]4;214;rgb:fa/bd/2f\e\\"
	echo -ne "\e]4;109;rgb:83/a5/98\e\\"
	echo -ne "\e]4;175;rgb:d3/86/9b\e\\"
	echo -ne "\e]4;108;rgb:8e/c0/7c\e\\"
	echo -ne "\e]4;208;rgb:fe/80/19\e\\"

	echo -ne "\e]4;88;rgb:9d/00/06\e\\"
	echo -ne "\e]4;100;rgb:79/74/0e\e\\"
	echo -ne "\e]4;136;rgb:b5/76/14\e\\"
	echo -ne "\e]4;24;rgb:07/66/78\e\\"
	echo -ne "\e]4;96;rgb:8f/3f/71\e\\"
	echo -ne "\e]4;66;rgb:42/7b/58\e\\"
	echo -ne "\e]4;130;rgb:af/3a/03\e\\"
fi
