#!/bin/sh

download_latest_release() {
    URL=https://api.github.com/repos/${PROJECT}/releases/latest
    VERSION=$(curl --silent "${URL}" | jq -r '.tag_name')
    echo "$PROJECT LATEST VERSION: $VERSION"
    DOWNLOAD_URL=$(curl --silent "${URL}" | jq -r '.assets[].browser_download_url'|grep $FILE_PATTERN)
    echo "DOWNLOAD:$DOWNLOAD_URL"
    wget -O $FILE_NAME $DOWNLOAD_URL
}

mkdir softs
cat project.txt | while read line 
do
    echo "start update:$line"
    PROJECT=`echo $line|awk -F':' '{ print $1 }'`
    FILE_PATTERN=`echo $line|awk -F':' '{ print $2 }'`
    FILE_NAME=`echo $line|awk -F':' '{ print $3 }'`
    DIR_NAME=`echo $line|awk -F':' '{ print $4 }'`
    PACKAGE_TYPE=`echo $line|awk -F':' '{ print $5 }'`
    download_latest_release $PROJECT $FILE_PATTERN $FILE_NAME
    mkdir $DIR_NAME
    mkdir -p builds/$DIR_NAME
    if [ $PACKAGE_TYPE = "zip" ] ; then
        unzip $FILE_NAME -d $DIR_NAME
    fi
    if [ $PACKAGE_TYPE = "gz" ] ; then
        tar -xf $FILE_NAME -C $DIR_NAME
    fi
    if [ $PACKAGE_TYPE = "xz" ] ; then
        tar -xf $FILE_NAME -C $DIR_NAME
    fi
    mv $DIR_NAME/* builds/$DIR_NAME
done