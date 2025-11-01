#!/bin/bash
set -euo pipefail

DIRS=("$@")

for name in "${DIRS[@]}"; do
	meta="../src/$name/meta.typ"
	echo "- #link(\"/$name\", {"
	echo "    import \"../src/$name/meta.typ\": title"
	echo "    \"${name:0:10} \" + title"
	echo "  })"
done
