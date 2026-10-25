#!/usr/bin/env python

import sys
import json
from html.parser import HTMLParser
from pathlib import Path


SKIP_TAGS = {"figure", "pre", "script", "style", "svg", "table", "excluded"}
TEXT_TAGS = {"p", "li"}
HEADINGS = {"h1", "h2", "h3", "h4", "h5", "h6"}


class ExcerptParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.path, self.parts = [], []
        self.done = False

    def handle_starttag(self, tag, attrs):
        if (
            tag in HEADINGS
            and self.parts
            and "article" in self.path
            and not SKIP_TAGS.intersection(self.path)
        ):
            self.done = True
        self.path.append(tag)
        if tag == "section" and dict(attrs).get("role") in {
            "doc-bibliography",
            "doc-endnotes",
        }:
            self.path.append("excluded")
        if tag in TEXT_TAGS or tag == "br":
            self.handle_data(" ")

    def handle_endtag(self, tag):
        if tag in self.path:
            del self.path[len(self.path) - 1 - self.path[::-1].index(tag) :]
        if tag in TEXT_TAGS:
            self.handle_data(" ")

    def handle_data(self, data):
        if (
            not self.done
            and "article" in self.path
            and TEXT_TAGS.intersection(self.path)
            and not SKIP_TAGS.intersection(self.path)
        ):
            self.parts.append(data)


if __name__ == "__main__":
    parser = ExcerptParser()
    parser.feed(Path(sys.argv[1]).read_text(encoding="utf-8"))
    text = " ".join("".join(parser.parts).split())
    text = text[:400].rstrip() + "…" if len(text) > 400 else text
    print(json.dumps(text, ensure_ascii=False))
