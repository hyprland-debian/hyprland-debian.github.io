#!/usr/bin/env bash

if [ "$1" = "" ]; then
    echo "Usage: $0 <username/repo>"
    exit
fi

REPO=$1

LATEST_RELEASE_URL="https://api.github.com/repos/$REPO/releases/latest"
LATEST_RELEASE=$(curl -s "$LATEST_RELEASE_URL")

if [ "$(echo "$LATEST_RELEASE" | jq -r ".status")" == "404" ]; then
    echo "Repository $REPO doesn't have the latest release"
    exit
fi

ASSETS=$(echo "$LATEST_RELEASE" | jq ".assets")

DEB_ASSET=$(echo "$ASSETS" | jq '[ .[] | select( .name | endswith(".deb") ) ][0]')

DEB_NAME=$(echo "$DEB_ASSET" | jq -r ".name")
DEB_URL=$(echo "$DEB_ASSET" | jq -r ".browser_download_url")

if [[ "$DEB_NAME" == "null" ]] || [[ "$DEB_URL" == "null" ]]; then
    echo "Repository $REPO doesn't have *.deb assets attached to the latest release"
    exit
fi

echo "DEB_NAME = $DEB_NAME"
echo "DEB_URL = $DEB_URL"

wget "$DEB_URL" -O "$DEB_NAME"
