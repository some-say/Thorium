#!/bin/bash

# Copyright (c) 2023 Alex313031 and Midzer.

YEL='\033[1;33m' # Yellow
CYA='\033[1;96m' # Cyan
RED='\033[1;31m' # Red
GRE='\033[1;32m' # Green
c0='\033[0m' # Reset Text
bold='\033[1m' # Bold Text
underline='\033[4m' # Underline Text

# Error handling
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "${RED}Failed $*"; }

printf "\n" &&
printf "${YEL}Building .dmg of Thorium...\n" &&
printf "${CYA}\n" &&

cd ~/chromium/src &&

# Fix file attr
xattr -csr out/thorium/Thorium.app &&

# Sign binary
codesign --force --deep --sign - out/thorium/Thorium.app &&

# Build dmg package
chrome/installer/mac/pkg-dmg --sourcefile --source out/thorium/Thorium.app --target "out/thorium/Thorium_MacOS.dmg" --volname Thorium --symlink /Applications:/Applications --format UDBZ --verbosity 2 &&

cat logos/apple_ascii_art.txt &&

printf "${GRE}.DMG Build Completed. ${YEL}Installer at \'//out/thorium/Thorium*_MacOS.dmg\'\n" &&
tput sgr0
