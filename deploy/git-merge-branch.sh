#!/bin/bash  --login
if [ -z $1 ]; then
    echo "Please input Your Branch Name.";
    return;
fi

. common.sh

branchName=$1

#~ 指定合并的app 以逗号分割 ,默认为 anjuke haozu jinpu
if [ -z $2 ]; then
    releaseAppList=${SITES_EXT}
else
    param=$2
    releaseAppList=${param//,/ }
fi

for app in $releaseAppList
do
    real_branch=${branchName}-${app}
    curr_dir=$RELEASE_ROOT_GIT/$app
    cd $curr_dir;
    
    git checkout master;
    git fetch origin;
    git rebase origin/master;

    git fetch $DEV_ALIAS $real_branch:$real_branch;
    git checkout $real_branch;
    git rebase master;

    git checkout master;
    git merge $real_branch --no-ff;
    git push origin master:master;
    git branch -D $real_branch;

done


