import sys
import subprocess
import time
def run(tasks, max_proc=1, interval=1):
        while len(tasks) and len(tasks) < max_proc:
            t = tasks.pop()
            print t
            subprocess.Popen(t, shell=True)
            if len(tasks):
                 time.sleep(interval)
            elif not len(tasks):
                 break

task=[]

ipstr=sys.argv[2]
ips=ipstr.split(",")

#~ 区分 安居客好租金铺
appType=sys.argv[3]

for ip in ips:
    if len(ip):
        task.append("dsh -c -m "+ip+" '/home/www/bin/do-git-create-new-version.sh "+sys.argv[1]+" "+appType+"' >> releaselog/"+sys.argv[1]+".log 2>&1")

run(task,40,1)
