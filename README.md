##Deploy上线脚本流程

####说明:
###### 安居客发布一堆的脚本:
 http://git.corp.anjuke.com/anjuke/v2-deploy

###### 配置文件common.sh:
````

````

####1.创建分支 
    create_branch.sh (参数branchName:不带后缀)
    eg. create_branch.sh pmt-15111
* 加载配置文件common.sh
* 如果本地不存在代码仓库,执行clone操作,clone到目录${RELEASE_ROOT_GIT},如/home/www/release/git
* 判断开发分支是否存在,不存在的话git remote add ${DEV_ALIAS}
* 切换分支到master,并创建三个分支,${branchName}-anjuke ${branchName}-haozu ${branchName}-jinpu
* 三个分支push到开发branch:user-branch

####2.开发完成,pg测试:
    publish.sh (参数branchName:不带后缀,[anjuke||haozu||jinpu])
* 脚本发布到pg环境,界面操作,发布脚本位于pg(/home/www/bin/user-site).
* 默认将三个分支都发布到pg环境

####3.pg测试完成,分支合并入master 
    git-merge-branch.sh (branchName:不带后缀,[anjuke,haozu,jinpu]):

* 在代码仓库中切换到master,并作rebase
* fetch 对应的分支branchName-(anjuke...)
* branch rebase master
* master merge branch
* 代码提交
* 删除本地的分支
* 出现冲突线下解决.然后重新合并入master.

####4.创建新版本 
    git-create-new-version.sh (年_周,序号,[anjuke,haozu,jinpu],[branch],[branchName])
    eg. git-create-new-version.sh 2013_30 01 anjuke,haozu branch pmt-15111
    表示将anjuke和好租 开发环境branch而非mater的代码拉到服务器,并创建版本(2013_30_01)

* 接收参数前两个拼接成版本号,$3表示要上线的项目以逗号分隔,例如 anjuke,jinpu
* $4表示从master还是开发branch拉代码,$5表示开发分支(无后缀)
* 切换到对应分支,并作rebase
* 代码chekout-index到临时文件目录$RELEASE_ROOT_TEMP/$app,如/home/www/release/temp/anjuke/
* 如果是master上线,创建tag;
* 删除分支
* 调用各个远程服务器的同步脚本rsync-from-deploy.sh (版本,anjuke||haozu||jinpu)
  * 如果是anjuke,代码同步到/home/www/release/v2/${版本}/
  * 如果是haozu,代码同步到/home/www/release/v2/anjuke-zu/${版本}/
  * 如果是jinpu,代码同步到/home/www/release/v2/anjuke-jp/${版本}/



####5.发布BETA版本 release-version-beta.sh(版本号,[anjuke,haozu,jinpu]):
    
* 调用各个服务器的shell脚本release-version-beta.sh(版本号,anjuke||haozu||jinpu),
    * 版本号写入/home/www/conf/RELEASE_VERSION
    * 或/home/www/config/machine/HZ_RELEASE_VERSION
    * 或/home/www/config/machine/JP_RELEASE_VERSION

####6.GA或者smoke服务器发布(//TODO 类似5,):

* 创建新版本
* 调用远程的发布脚本
* echo 1 > /home/evans/release-bin/RELEASE_STATUS_SMOKE


#### TODO
common.sh 增加:
```
arrAnjukeAppServer=(\
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
SITE_ANJUKE_GIT="git@git.corp.anjuke.com:anjuke/v2-site"
SITE_HAOZU_GIT="git@git.corp.anjuke.com:site/haozu-user"
SITE_JINPU_GIT="git@git.corp.anjuke.com:site/jinpu-user"
BRANCH_GIT="git@git.corp.anjuke.com:kyouzhang/user-branch"
```

deploy服务器(app10-089):

* /home/www/release/git 存放a,h,j的代码仓库
* 创建BIN_ROOT目录,存放shell脚本,/home/evans/release-bin
  * common.sh
  * git-merge-branch.sh
  * git-create-new-version.sh
  * release-version-beta.sh
* 创建log目录/home/evans/release-bin/releaselog

线上服务器:
 
* /home/www/bin/rsync-from-deploy.sh
* /home/www/bin/release-version-beta.sh

