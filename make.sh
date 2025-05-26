#!/bin/zsh -ex

# ref: https://github.com/tisfeng/Easydict/blob/415f826fdbbdd373e8a5ebb73c7710d81c619b76/docs/How-to-use-macOS-system-dictionary-in-Easydict-zh.md

if [[ ! -d oaldpe-apple ]] ; then
    pyglossary --write-format=AppleDict mdict/oaldpe.mdx oaldpe-apple
fi

pushd oaldpe-apple

sed -i "" 's:src="/:src=":g' oaldpe-apple.xml

# build_dict.sh fails to handle a large quantity of files; workaround is below
make || true

# copy audio, images, fonts and other resources
rsync -a -P OtherResources/ objects/dict.dictionary/Contents/

# handle the CSS
cat "../oaldpe-styles-unfold-all.css" >> "objects/dict.dictionary/Contents/DefaultStyle.css"

# set folder icon
# ref: https://apple.stackexchange.com/a/6905 and https://apple.stackexchange.com/a/10020
## Extract the icon to its own resource file:
DeRez -only icns "../icon.png" >! tmpicns.rsrc

## append this resource to the file you want to icon-ize.
Rez -append tmpicns.rsrc -o $'objects/dict.dictionary/Icon\r'

## Use the resource to set the icon.
SetFile -a C 'objects/dict.dictionary/'
## Hide the Icon\r file from Finder.
SetFile -a V $'objects/dict.dictionary/Icon\r'

mv -f "objects"/dict.dictionary "objects/oaldpe-apple.dictionary"

popd
