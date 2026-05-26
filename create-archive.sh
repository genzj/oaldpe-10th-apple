#!/bin/bash

cd "$(dirname "$0")/oaldpe-apple/objects" && \
    tar -cvJf oaldpe-apple.dictionary.tar.xz \
      --exclude='*_*#_*_*.mp3' \
      --exclude='._*' \
      --exclude='**/._*' \
      oaldpe-apple.dictionary
