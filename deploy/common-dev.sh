#!/bin/bash

arrAnjukeAppServer=(\
192.168.1.24
)
arrHaozuAppServer=(\
)
arrJinpuAppServer=(\
)

#~ 别名
DEV_ALIAS='branch'
#~ 
SITES_EXT='anjuke haozu jinpu'
#~ 从git中checkout的项目文件
RELEASE_ROOT_TEMP='/home/www/release/temp'
#~ git仓库
SITE_ANJUKE_GIT="git@git.corp.anjuke.com:anjuke/v2-site"
SITE_HAOZU_GIT="git@git.corp.anjuke.com:site/haozu-user"
SITE_JINPU_GIT="git@git.corp.anjuke.com:site/jinpu-user"
BRANCH_GIT="git@git.corp.anjuke.com:kyouzhang/user-branch"


arrSmokeCityAppServer=(\
app10-011
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
