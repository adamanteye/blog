#!/bin/bash
set -euo pipefail

SRC_DIR="$1"

find "$SRC_DIR" -mindepth 4 -maxdepth 4 -type f -name meta.typ | sort -r | while read -r meta; do
	name="${meta#"$SRC_DIR"/}"
	name="${name%/meta.typ}"
	date="${name:0:10}"
	echo "#{"
	echo "  import \"../src/$name/meta.typ\": title"
	echo "  [- $date #link(\"./$name\")[#title]]"
	echo "}"
done
