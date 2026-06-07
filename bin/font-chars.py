#!/usr/bin/env python3
from html.parser import HTMLParser
from pathlib import Path
import sys


TEXT_ATTRS = {"alt", "aria-label", "placeholder", "title"}
SKIP_TAGS = {"script", "style"}


class FontCharParser(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.chars = set()
        self.skip_stack = []

    def handle_starttag(self, tag, attrs):
        if tag in SKIP_TAGS:
            self.skip_stack.append(tag)
            return

        for name, value in attrs:
            if value and name in TEXT_ATTRS:
                self._add(value)

    def handle_endtag(self, tag):
        if self.skip_stack and self.skip_stack[-1] == tag:
            self.skip_stack.pop()

    def handle_data(self, data):
        if not self.skip_stack:
            self._add(data)

    def _add(self, text):
        for char in text:
            if char == " " or not char.isspace():
                self.chars.add(char)


def main():
    parser = FontCharParser()

    for arg in sys.argv[1:]:
        parser.feed(Path(arg).read_text(encoding="utf-8"))

    chars = {chr(codepoint) for codepoint in range(0x20, 0x7F)}
    chars.add("\u00a0")
    chars.update(parser.chars)

    sys.stdout.write("".join(sorted(chars, key=ord)))


if __name__ == "__main__":
    main()
