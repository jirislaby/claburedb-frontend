#!/bin/bash

find tmp/sha1/ -name '*[^l].xz' -print0|xargs -0 -P4 -n 1 -I{} sh -c '
	FILE="{}"
	FILEO="${FILE%.xz}-hl.xz"
	if [ -f "$FILEO" -o `xzcat "$FILE" | wc -c` -lt 10000 ]; then
		exit 0
	fi
	echo "creating $FILEO"
	xzcat "$FILE" | ruby -e "require %{coderay};
		puts CodeRay.scan(ARGF.read, :c).html(:css => :class,
				:break_lines => true,
				:line_numbers => :inline)" | xz > "$FILEO"'
