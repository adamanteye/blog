#!/bin/bash
set -euo pipefail

SITE='https://blog.adamanteye.cc'
EMAIL='adamanteye@disroot.org'
NAME='adamanteye'
BUILD_DIR="$1"
DESC="adamantye's blog"

echo '<?xml version="1.0" encoding="utf-8"?>'
echo '<feed xmlns="http://www.w3.org/2005/Atom">'
echo "  <title>$DESC</title>"
echo "  <updated>$(date --utc +%Y-%m-%dT%H:%M:%SZ)</updated>"
echo "  <id>$SITE</id>"
echo "  <link href=\"$SITE/atom.xml\" rel=\"self\"/>"
echo "  <link href=\"$SITE/\"/>"

find "$BUILD_DIR" -mindepth 2 -maxdepth 2 -type f -name "index.html" | sort -r | while read -r file; do
	title=$(head -n 20 "$file" | grep -m 1 '<title>' | sed -E 's/.*<title>(.*) - adamanteye<\/title>.*/\1/')
	rel="${file#$BUILD_DIR/}"
	rel="${rel%/index.html}/"

	src="src/$rel"
	id="$(basename "$(dirname "$file")")"

	if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		created=$(git log --diff-filter=A --follow --format=%aI -1 -- "$src" || true)
		updated=$(git log -1 --format=%aI -- "$src" || true)
	fi

	created="${created:-$(date -Iseconds)}"
	updated="${updated:-$created}"

	echo "  <entry>"
	echo "    <title>$title</title>"
	echo '    <author>'
	echo "      <name>$NAME</name>"
	echo "      <uri>$SITE</uri>"
	echo "      <email>$EMAIL</email>"
	echo "    </author>"
	echo "    <link href=\"$SITE/$rel\"/>"
	echo "    <id>$id</id>"
	echo "    <updated>$updated</updated>"
	echo "    <published>$created</published>"
	echo "  </entry>"
done

echo '</feed>'
