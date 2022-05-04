#!/bin/bash

#fetch all tags
echo "[+] Fetching tags"
git fetch --tags

# get latest tag
LATEST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)
echo "[+] Latest tag is $LATEST_TAG"
LATEST_TAG_NUMBER=$(git describe --tags `git rev-list --tags --max-count=1` | sed 's/\.//g')

# get current commit hash for tag
CURR_COMMIT=$(git rev-parse HEAD)
echo "[+] Current commit hash is $CURR_COMMIT"

# get current short commit hash
SHORT_COMMIT=$(git rev-parse --short HEAD)
echo "[+] Current short commit hash is $SHORT_COMMIT"

# get the version file tag
VERSION=$(cat version)
echo "[+] Current version from version file is: $VERSION"
VERSION_NUMBER=$(cat version | sed 's/\.//g')

# Setting account
git config --global user.email "kaleby@dash.fi"
git config --global user.name "Kaleby Cadorin"

if [ "$VERSION_NUMBER" -le "$LATEST_TAG_NUMBER" ]
    then
        echo "The tag version cannot be smaller than $LATEST_TAG"
        exit 1
    else
        echo "Tag $VERSION will be applied"
        git tag "$VERSION" HEAD -m "Added tag $VERSION to commit $SHORT_COMMIT"
        git push --tag
fi

