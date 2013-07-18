#!/bin/bash

if [ -z $1 ]; then
    echo "Please input {RELEASE_VERSION (YYYY_MM_patch)}.";
    return;
fi

. common.sh

#~ 指定上线的app 以逗号分割
if [ -z $2 ]; then
    releaseAppList="anjuke"
else
    param=$2
    releaseAppList=${param/,/ }
fi

for app in $releaseAppList
do
    case $app in 
        'anjuke')
            #record versions on local so that crontab can update beta automatically
            /home/www/bin/release-version.sh $1 $app
            reload=0
            for i in ${arrAnjukeAppServer[@]}
            do
                echo -e "\n $i"
                dsh -c -m $i "/home/www/bin/release-version.sh" $1 $app
                if [ $reload -ne 1 ]; then
                    echo 1 > /home/evans/release-bin/RELEASE_STATUS_GA_CITY
                    reload=1
                fi
                sleep 10 
            done
            ;;
        'haozu')
            #record versions on local so that crontab can update beta automatically
            /home/www/bin/release-version.sh $1 $app
            for i in ${arrHaozuAppServer[@]}
            do
                echo -e "\n $i"
                dsh -c -m $i "/home/www/bin/release-version.sh" $1 $app
                sleep 10 
            done
            ;;
        'jinpu')
            #record versions on local so that crontab can update beta automatically
            /home/www/bin/release-version.sh $1 $app
            for i in ${arrJinpuAppServer[@]}
            do
                echo -e "\n $i"
                dsh -c -m $i "/home/www/bin/release-version.sh" $1 $app
                sleep 10 
            done
            ;;
        * )
            echo "Input error."
            exit
            ;;
    esac
    writeLog "${app}: switch city online version $1"
done
