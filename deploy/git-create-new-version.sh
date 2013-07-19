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
    releaseAppList=${SITES_EXT}
else
    param=$3
    releaseAppList=${param//,/ }
fi

#~ 指定从master或者branch拉
#!这个功能目前应该比指定app更常用，建议参数放在前面
if [ -z $4 ]; then
    alias="origin"
elif [ $4 = "branch" ]; then
    alias=${DEV_ALIAS}
    #~ 分支
    if [ -z $5 ];then
        #!提示
        exit
    fi
    branch=$5
else
    #!建议提示更清晰，方便未来记录debug
    echo "wrong paramter. exit."
    exit
fi

#~  清除上次创建的版本
rm -r $RELEASE_ROOT_TEMP
mkdir -p $RELEASE_ROOT_TEMP

for app in $releaseAppList
do
    echo "Creating ${app} version:${version}."
    cd $RELEASE_ROOT_GIT/$app
    if [ $alias = ${DEV_ALIAS} ]; then
        real_branch=${branch}-${app}
        git fetch ${alias}
        git checkout ${real_branch}
        git rebase ${alias}/${real_branch} #!这里也可以直接使用fetch
        git checkout-index -a -f --prefix=$RELEASE_ROOT_TEMP/$app/ 
        git checkout master
        git branch -D ${real_branch}
    else
        git checkout master
        git fetch origin
        git rebase origin/master
        git tag -f -a $version -m "create tag $version $idate" 
        git push origin --tags
        git checkout-index -a -f --prefix=$RELEASE_ROOT_TEMP/$app/
    fi
    #!建议上线代码都取出以后，再一起去同步
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
    echo "现在正在从${RELEASE_ROOT_TEMP}/${app} 同步到 ${string_machines}";
    dsh -r ssh -c ${string_machines} "/home/www/bin/rsync-from-deploy.sh" $1 $app

done

