#!/bin/bash
set -euo pipefail

SITE='https://blog.adamanteye.cc'
EMAIL='xuelin@adamanteye.cc'
NAME='Xuelin Yang'
BUILD_DIR="$1"
DESC="Adamantye's Blog"
REGEX_ARTICLE='(<article>.+</article>)'

VOID_ELEM="area base br col embed hr img input link meta param source track wbr"

echo '<?xml version="1.0" encoding="utf-8"?>'
echo '<feed xmlns="http://www.w3.org/2005/Atom">'
echo "  <title>$DESC</title>"
echo "  <updated>$(date --utc +%Y-%m-%dT%H:%M:%SZ)</updated>"
echo "  <id>$SITE</id>"
echo "  <link href=\"$SITE/atom.xml\" rel=\"self\"/>"
echo "  <link href=\"$SITE/\"/>"

find "$BUILD_DIR" -mindepth 2 -type f -name "index.html" | sort -r | while read -r file; do
	title=$(head -n 20 "$file" | grep -m 1 '<title>' | sed -E 's/.*<title>(.*)<\/title>.*/\1/')
	content=$(<"$file")
	[[ $content =~ $REGEX_ARTICLE ]]
	content=${BASH_REMATCH[1]}
	for tag in $VOID_ELEM; do
		content=$(echo "$content" | sed -E "s|<$tag\b([^>]*)>|<$tag\1 />|g")
	done
	rel="${file#"$BUILD_DIR"/}"
	rel="${rel%/index.html}/"

	src="src/$rel"
	id="${rel%/}"

	created=$(git log --reverse --date=iso-strict --format="%cd" -- "$src" | head -n 1 || true)
	updated=$(git log -1 --date=iso-strict --format="%cd" -- "$src" || true)
	if [ -z "$created" ]; then
		echo "warning: no git history for $src" >&2
		created=$(date -Iseconds)
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
	echo '    <content type="xhtml">'
	echo '      <div xmlns="http://www.w3.org/1999/xhtml">'
	echo "        $content"
	echo '      </div>'
	echo '    </content>'
	echo "    <updated>$updated</updated>"
	echo "    <published>$created</published>"
	echo "  </entry>"
done

echo '</feed>'
