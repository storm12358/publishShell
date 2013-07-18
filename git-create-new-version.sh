#!/bin/bash

if [ -z $1 ]; then
    echo "Please input {RELEASE_VERSION (YYYY_MM [patch])}.";
    exit 0;
fi

if [ -z $2 ]; then
    echo "Please input RELEASE_VERSION order number.";
    exit 0;
else
    version=$1_$2
fi

. common.sh
idate=`date +"%F %H:%M:%S"`
echo "git update to newest start"

#~ 指定上线的app 以逗号分割
if [ -z $3 ]; then
    releaseAppList="anjuke"
else
    param=$3
    releaseAppList=${param/,/ }
fi

for app in $releaseAppList
do
    appServer=
    #~  首字母大写
    upper_app=`echo $app|sed "s/\b[a-z]/\U&/g"`
    servers='arr'$upper_app'AppServer[@]'
    
    #~ 拼接服务器字符串
    for i in ${!servers}
    do
        appServer=$appServer$i,
    done
    
    if [ -z $appServer ]; then
        echo "$upper_app 服务器列表不存在..."
        continue
    fi
    
    cd $RELEASE_ROOT_GIT/$app
    git checkout master
    git fetch origin
    git rebase origin/master
    git tag -f -a $version -m "create tag $version $idate" 
    git push origin --tags

    cd $BIN_ROOT; 
    python git-create-new-version.py $version $appServer $app >> releaselog/$version.log
done

