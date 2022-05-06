#!/bin/bash

#set -e

#fetch all tags
echo "[+] Fetching tags"
git fetch --tags

# get latest tag
LATEST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)
echo "[+] Latest tag is $LATEST_TAG"
LATEST_TAG_NUMBER=$(git describe --tags `git rev-list --tags --max-count=1` | sed 's/\.//g')

# get the version file tag
VERSION=$(cat version)
echo "[+] Current version from version file is: $VERSION"
VERSION_NUMBER=$(cat version | sed 's/\.//g')

if [ -z "$VERSION" ]
    then
        echo "[+] You must set a version to be able proceed."
        exit 1
fi

# Setting account
git config --global user.email "kaleby@dash.fi"
git config --global user.name "Kaleby Cadorin"

if [ -z "$LATEST_TAG" ]
    then
        echo "No tag applied to the repo yet, the tag $VERSION can be applied"
    else
        LATEST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)
        echo "[+] Latest tag is $LATEST_TAG"
fi

LATEST_TAG_NUMBER=$(git describe --tags `git rev-list --tags --max-count=1` | sed 's/\.//g')

if [ "$VERSION_NUMBER" -le "$LATEST_TAG_NUMBER" ]
    then
        echo "[+] FAIL - The tag $VERSION cannot be smaller or equal than $LATEST_TAG"
        exit 1
    else
        echo "[+] SUCCESS - Merge the PR to have tag $VERSION applied to master branch"
fi