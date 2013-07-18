#!/bin/bash

version=$1
appType=$2
case $appType in
    'anjuke')
        release_version_file_dir='/home/www/conf/'
        file_name='RELEASE_VERSION_BETA'
        dir_ext=''
        ;;
    'haozu')
        release_version_file_dir='/home/www/config/machine/'
        file_name='ZU_RELEASE_VERSION_BETA'
        dir_ext='anjuke-zu/'
        ;;
    'jinpu')
        release_version_file_dir='/home/www/config/machine/'
        file_name='JP_RELEASE_VERSION_BETA'
        dir_ext='anjuke-jp/'
        ;;
    * )
        echo "Please input Project correctly. "  
        echo "eg. anjuke,haozu,jinpu"
        exit
        ;;
esac

if [ ! -d "/home/www/release/v2/${dir_ext}${version}" ]; then
    echo "Please input {TRUNK_VERSION (YYYY_MM_patch)} correctly.";
    exit;
fi

if [ ! -d ${release_version_file_dir} ];then
    mkdir -p $release_version_file_dir
fi

version_file=${release_version_file_dir}${file_name}
echo $1 > ${version_file}
cat ${version_file}

echo ===========================
