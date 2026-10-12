#!/bin/bash
set -euo pipefail

SRC_DIR="$1"

find "$SRC_DIR" -mindepth 4 -maxdepth 4 -type f -name meta.typ | sort -r | while read -r meta; do
	name="${meta#"$SRC_DIR"/}"
	name="${name%/meta.typ}"
	date="${name:0:10}"
	echo "#{"
	echo "  import \"../src/$name/meta.typ\": title, desc"
	if [[ -f "build/$name/index.html" ]]; then
		preview=$(python3 bin/excerpt.py "build/$name/index.html")
		echo "  let preview = $preview"
	else
		echo '  let preview = ""'
	fi
	echo '  html.li({'
	echo "    [#link(\"./$name/\")[#title] $date]"
	echo '    if preview != "" {'
	echo "      html.elem(\"blockquote\", attrs: (cite: \"./$name/\"), preview)"
	echo '    } else if desc != none and desc != "" {'
	echo '      html.p(desc)'
	echo '    }'
	echo '  })'
	echo "}"
done
