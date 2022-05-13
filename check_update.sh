#!/bin/sh

download_latest_release() {
    URL=https://api.github.com/repos/${PROJECT}/releases/latest
    VERSION=$(curl --silent "${URL}" | jq -r '.tag_name')
    echo "$PROJECT LATEST VERSION: $VERSION"
    DOWNLOAD_URL=$(curl --silent "${URL}" | jq -r '.assets[].browser_download_url'|grep $FILE_PATTERN)
    echo "DOWNLOAD:$DOWNLOAD_URL"
    wget -O $FILE_NAME $DOWNLOAD_URL
}

echo "Start"
cat project.txt | awk -F':' '{ print $1 }'| while read project 
do
    echo "start check:$project"
    sh check_latest_release.sh $project
done
touch current_release
DIFF_COUNT=`diff -U 0 current_release latest_release | grep -v ^@ | tail -n +3 | wc -l`
cp latest_release current_release
if [ $DIFF_COUNT -gt 0 ] ; then
    echo "Need Update"
else
    echo "Updated"
fi