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
## Convert PNG to icns
mkdir -p ../icon.iconset
sips -z 512 512 "../icon.png" --out ../icon.iconset/icon_256x256@2x.png
iconutil -c icns ../icon.iconset -o ../icon.icns
## Write icns resource directly into the Icon file (bypasses DeRez which can't read data-fork icns)
echo 'read '"'"'icns'"'"' (-16455) "../icon.icns";' > tmpicns.r
touch $'objects/dict.dictionary/Icon\r'
Rez tmpicns.r -append -o $'objects/dict.dictionary/Icon\r'

## Use the resource to set the icon.
SetFile -a C 'objects/dict.dictionary/'
## Hide the Icon\r file from Finder.
SetFile -a V $'objects/dict.dictionary/Icon\r'

mv -f "objects"/dict.dictionary "objects/oaldpe-apple.dictionary"

popd
