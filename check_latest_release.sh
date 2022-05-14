#!/bin/sh

check_latest_release() {
    URL=https://api.github.com/repos/${PROJECT}/releases/latest
    VERSION=$(curl --silent "${URL}" | jq -r '.tag_name')
    echo "$PROJECT LATEST VERSION: $VERSION"
    echo "$PROJECT = $VERSION" >> latest_release
}

PROJECT=$1
check_latest_release $PROJECT