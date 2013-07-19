#!/bin/bash

writeLog(){
    Week=`date +%Y%W`
    Today=`date +%Y-%m-%d`
    Time=`date +%T`
    echo "Date:$Today  Week:$Week Time:$Time $1" >> $LOG_ROOT/$Week.txt
}

if [ $USER == 'kyou' ]; then
    #!这个依赖好像有点奇怪，是线下的脚本就应该直接定义线下的common，线上的用线上的common，可能他们还有一个公共的common
    . common-dev.sh
    return;
fi

arrCityAppServer=(\
app10-001
app10-002
app10-010
app10-011
app10-014
app10-015
app10-039
app10-040
app10-042
app10-044
app10-057
app10-069
app10-070
app10-071
app10-073
app10-074
app10-086
xapp10-008
)
arrMyAppServer=(\
app10-034
app10-035
app10-036
app10-058
app10-067
app10-081
app10-083
xapp10-085
)
arrV1AnjukeServer=(\
10.10.3.11
10.10.3.18
10.10.3.42
10.10.3.8
)
arrOpCsServer=(\
10.10.6.186
10.10.6.187
10.10.3.35
)
arrSmokeCityAppServer=(\
app10-011
)
arrSmokeMyAppServer=(\
app10-034
)
arrAnjukeBbsServer=(\
10.10.3.23
)
arrPlayGroundApps=(\
xapp20-020
xapp20-021
)
devGitRepo=(\
/home/www/release/git_dev
)

strFileServer='10.10.3.42'
BIN_ROOT='/home/evans/release-bin'
LOG_ROOT=$BIN_ROOT'/releaselog'
RELEASE_V1_ROOT='/home/www/release/v1'
RELEASE_V2_ROOT='/home/www/release/svn'
RELEASE_PAGES_ROOT='/home/www/release/pages'
RELEASE_ROOT_GIT='/home/www/release/git'
RELEASE_ROOT_GIT_DEV='/home/www/release/git_dev'
RELEASE_ROOT_GIT_BROKER='/home/www/release/anjuke-broker'
RELEASE_ROOT_GIT_DEV_BROKER='/home/www/release/git_dev'
RELEASE_ROOT_ARCHIVE='/home/www/release/ajk-archive.tar.bz2'
REMOTE_V1_ROOT='/home/www/v1'
REMOTE_V2_ROOT='/home/www/release/v2'
REMOTE_PAGES_ROOT='/home/www/pages'
REMOTE_ROOT_GIT='/home/www/archive'
IgnoreFile='/home/www/release/ignore.v2'
autolog='/home/evans/release-bin/testcrontab.log'
