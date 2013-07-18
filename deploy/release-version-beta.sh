#!/bin/bash

if [ -z $1 ]; then
    echo "Please input {RELEASE_VERSION (YYYY_MM_patch)}.";
    exit 0;
fi

. common.sh

#~ 指定上线的app 以逗号分割
if [ -z $2 ]; then
    releaseAppList="anjuke"
else
    param=$2
    releaseAppList=${param//,/ }
fi

for app in $releaseAppList
do
    string_machines=''
    appServer=
    #~  首字母大写
    upper_app=`echo $app|sed "s/\b[a-z]/\U&/g"`
    servers='arr'$upper_app'AppServer[@]'
    
    #~ 拼接服务器字符串
    for machine in ${!servers}
        do
            string_machines="${string_machines} -m ${machine} "
        done
    dsh -r ssh -c ${string_machines} "/home/www/bin/release-version-beta.sh" $1 $app
    
    writeLog "${app}: switch city beta version $1"
done

