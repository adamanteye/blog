#!/bin/bash
set -euo pipefail

SITE='https://blog.adamanteye.cc'
EMAIL='adamanteye@disroot.org'
NAME='adamanteye'
BUILD_DIR="$1"
DESC="adamantye's blog"

echo '<feed>'
echo "  <title>$DESC</title>"
echo "  <updated>$(date --utc +%Y-%m-%dT%H:%M:%SZ)</updated>"
echo "  <id>$SITE</id>"
echo "  <link href=\"$SITE/atom.xml\" rel=\"self\"/>"
echo "  <link href=\"$SITE/\"/>"
echo '  <author>'
echo "    <name>$NAME</name>"
echo "    <email>$EMAIL</email>"
echo "  </author>"

find "$BUILD_DIR" -mindepth 2 -maxdepth 2 -type f -name "index.html" | sort | while read -r file; do
	rel="${file#$BUILD_DIR/}"
	rel="${rel%/index.html}/"

	src="src/$rel"
	title="$(basename "$(dirname "$file")")"

	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		created=$(git log --diff-filter=A --follow --format=%aI -1 -- "$src" 2>/dev/null || true)
		updated=$(git log -1 --format=%aI -- "$src" 2>/dev/null || true)
	fi

	created="${created:-$(date --iso-8601=seconds)}"
	updated="${updated:-$created}"

	echo "  <entry>"
	echo "    <title>$title</title>"
	echo "    <link href=\"$SITE/$rel\"/>"
	echo "    <id>$title</id>"
	echo "    <updated>$updated</updated>"
	echo "    <published>$created</published>"
	echo "  </entry>"
done

echo '</feed>'
