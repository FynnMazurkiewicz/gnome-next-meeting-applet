#!/usr/bin/env bash
set -eufx

VERSION=${1-""}
[[ -z ${VERSION} ]] && { echo "need a version"; exit 1 ;}

vfile=gnome_next_meeting_applet/__init__.py
sed -i "s/.*version.*/__version__ = '${VERSION}'/" ${vfile}
git commit -S -m "Release ${VERSION} 🥳" ${vfile}
git tag -S ${VERSION}
git push --tags origin ${VERSION}

./debian/build.sh
./packaging/rpm/build.sh
./packaging/update-aur ${VERSION}
