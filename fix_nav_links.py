#!/usr/bin/env python3
"""Replace JS-dependent nav spans with anchor links in the Apple Dictionary XML."""

import re
import sys
import tempfile
import shutil

NAV_RE = re.compile(r'<div class="oaldpe-nav">(.*?)</div>')
SPAN_RE = re.compile(r'<span[^>]*>(.*?)</span>')
TITLE_RE = re.compile(r'd:title="([^"]*)"')


def transform_nav(match, title):
    inner = match.group(1)
    spans = SPAN_RE.findall(inner)
    spans = [s for s in spans if s != "All"]
    anchors = []
    for i, label in enumerate(spans, start=1):
        anchors.append(f'<a href="#{title}_{i}">{label}</a>')
    return '<div class="oaldpe-nav">' + "".join(anchors) + "</div>"


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <xml-file>", file=sys.stderr)
        sys.exit(1)

    src = sys.argv[1]
    fd, tmp = tempfile.mkstemp(dir=".", suffix=".xml")

    with open(src, "r", encoding="utf-8") as fin, open(fd, "w", encoding="utf-8") as fout:
        for line in fin:
            if "oaldpe-nav" in line:
                m = TITLE_RE.search(line)
                if m:
                    title = m.group(1)
                    line = NAV_RE.sub(lambda match: transform_nav(match, title), line)
            fout.write(line)

    shutil.move(tmp, src)


if __name__ == "__main__":
    main()
