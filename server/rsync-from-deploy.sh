#!/bin/bash

#~ 本地和各个服务器都得存在 

version=$1
appType=$2

if [ -z $1 ]; then
    echo "Please input {VERSION (YYYY_MM_patch)}.";
    exit;
fi

case $appType in
    'anjuke')
        dir_ext=''
        ;;
    'haozu')
        dir_ext='anjuke-zu/'
        ;;
    'jinpu')
        dir_ext='anjuke-jp/'
        ;;
esac

rsync -a --delete-after -e ssh evans@app10-089:/home/www/release/temp/${appType}/ /home/www/release/v2/${dir_ext}$1/
