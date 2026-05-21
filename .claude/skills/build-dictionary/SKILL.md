---
name: build-dictionary
description: Build the OALDPE Apple dictionary from MDict source files in the mdict/ directory
disable-model-invocation: true
---

# Build OALDPE Apple Dictionary

## Prerequisites

1. **Dictionary Development Kit** must be at `/Applications/Utilities/Dictionary Development Kit`
2. **Xcode Command Line Tools** installed (`/usr/bin/xcodebuild -version` to verify)
3. **Python venv** activated with dependencies installed (`source .venv/bin/activate`)
4. **Source files** present in `mdict/` (oaldpe.mdx, oaldpe.mdd, oaldpe.css, etc.)

## Build Steps

```bash
source .venv/bin/activate
./make.sh
```

The script performs:
1. `pyglossary` converts `mdict/oaldpe.mdx` → `oaldpe-apple/` (AppleDict format)
2. Patches XML to fix resource paths (`src="/` → `src="`)
3. Runs `make` (may partially fail on large file count — this is expected)
4. Copies resources via `rsync` into the dictionary bundle

## Post-build (currently after `exit 0` in make.sh — manual steps)

- Append `oaldpe-styles-unfold-all.css` to `DefaultStyle.css`
- Set folder icon using `DeRez`/`Rez`/`SetFile`
- Rename output to `oaldpe-apple.dictionary`

## Install / Uninstall

```bash
./install.sh   # copies built dictionary to ~/Library/Dictionaries/
./uninstall.sh # removes it
```

## Common Issues

- **make fails partially**: Expected due to large file count. The `|| true` in make.sh handles this.
- **pyglossary not found**: Ensure venv is activated.
- **Dictionary Development Kit missing**: Download "Additional Tools for Xcode" matching your Xcode version from Apple Developer downloads.
