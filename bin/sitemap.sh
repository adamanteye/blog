#!/bin/bash
set -euo pipefail

SITE='https://blog.adamanteye.cc'
BUILD_DIR="$1"

SRC_PREFIX='src'
DATE_FALLBACK_UTC="$(date --utc +%Y-%m-%dT%H:%M:%SZ)"

EXCLUDE_REGEX='(^|/)(404|error)(/|\.html$)'

emit_url() {
	local loc="$1"
	local src="$2"

	local lastmod
	lastmod="$(git log -1 --date=iso-strict --format="%cd" -- "$src" 2>/dev/null || true)"
	if [[ -z "${lastmod:-}" ]]; then
		lastmod="$DATE_FALLBACK_UTC"
	fi
	echo "  <url>"
	echo "    <loc>$loc</loc>"
	echo "    <lastmod>$lastmod</lastmod>"
	echo "    <priority>0.8</priority>"
	echo "    <changefreq>monthly</changefreq>"
	echo "  </url>"
}

echo '<?xml version="1.0" encoding="utf-8"?>'
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

find "$BUILD_DIR" -type f -name "index.html" | sort -r | while read -r file; do
	rel="${file#"$BUILD_DIR"/}"
	rel="${rel%/index.html}/"

	if [[ "$rel" =~ $EXCLUDE_REGEX ]]; then
		continue
	fi

	src="$SRC_PREFIX/$rel"
	emit_url "$SITE/$rel" "$src"
done

echo '</urlset>'
