#!/bin/bash  --login
if [ -z $1 ]; then
    echo "Please input Your Branch Name.";
    return;
fi

. common.sh

branchName=$1

#~ 指定上线的app 以逗号分割
if [ -z $2 ]; then
    releaseAppList="anjuke"
else
    param=$2
    releaseAppList=${param/,/ }
fi

for app in $releaseAppList
    do
    curr_dir=$RELEASE_ROOT_GIT/$app
    
    git checkout master;
    git fetch origin;
    git rebase origin/master;

    git branch -D $branchName
    git fetch $DEV_ALIAS $branchName:$branchName;
    git checkout $branchName;
    git rebase master;

    git checkout master;
    git merge $branchName --no-ff;
    git push origin master:master;

done


