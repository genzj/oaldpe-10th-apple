#!/bin/zsh -ex
# Syncing the built dictionary with the installed dictionary folder.
# A quick method to verify modifications during development.
pushd oaldpe-apple

rsync -a -P --exclude='*.mp3' ./objects/oaldpe-apple.dictionary/ ~/Library/Dictionaries/oaldpe-apple.dictionary/

popd

