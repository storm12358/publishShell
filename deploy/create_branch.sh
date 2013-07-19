#!/bin/bash 

. common.sh

new_branch=$1
#git 取代码

if [ ! $new_branch ];then
    echo "请输入分支"
    exit
fi

for app in $SITES_EXT
    do
    curr_dir=$RELEASE_ROOT_GIT/$app
    #~ 不存在的话进行clone
        if [ ! -d $curr_dir ]; then
            mkdir -p $curr_dir
            uppercase=`echo $app|sed "s/\b[a-z]*/\U&/g"`
            eval remote='$SITE_'$uppercase'_GIT' 
            echo "clone ${uppercase}...："
            cd $RELEASE_ROOT_GIT
            git clone $remote $app 
        fi
    #~ rebase master分支
    cd $curr_dir
    
    #~ 判断branch是否存在
    has_branch=`git remote | sed -n '/branch/p'`
    if [ ! $has_branch ];then
        git remote add ${DEV_ALIAS} $BRANCH_GIT 
    fi
    #~ 判断当前分支是不是master
    curr_branch=`git branch | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'` #!这里${DEV_ALIAS}应该是branch，是个命令
    if [ ! $curr_branch == 'master' ]; then
        echo $curr_branch
        git checkout master 
    fi
    
    git pull --rebase origin master  
    git branch $new_branch-$app #!可以直接git fetch origin master:$new_branch-$app 代替前两步，以免本地的master被改动导致代码和远程不同
    git push ${DEV_ALIAS} $new_branch-$app  
    git branch -D $new_branch-$app
    
done




