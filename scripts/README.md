#阿里云远端缓存清理script开发（测试）
###**姜宇珩**
###**主要功能**
配置脚本定时自动删除服务器中的客户文件，并将所删除文件名和操作时间记录入日志文件
###**脚本代码**
`test1.exp`
```
#!/usr/local/bin/expect -f
set date [exec date "+%Y%m%d%H%M%S"]
set time [exec date "+%Y-%m-%d %H:%M:%S"]
set division "-------$time remove client files success-------"
set password "yxjk@123"                 //用户服务器密码
set log_location "/root/log"            //储存日志文件的绝对地址
set rm_location "/tmp"              //需要清空用户文件的绝对地址
spawn ssh root@100.11.96.2              //目标主机的地址
set timeout 100
expect "password:"
send "$password\r"
expect "*#"
send "cd $log_location\r"
expect "*#"
send "ls $rm_location >> $date.log\r"
expect "*#"
send "sudo rm -r $rm_location\r"
expect "*#"
send "echo $division >> $date.log\r"
expect "*#"
send "exit\r"
interact
```
###**实现过程**
1. 使用shell结合expect的方法，自动填写密码远程登录服务器，并实施操作。
```expect test1.exp```
2. 使用crond定时自动启动脚本完成清理工作。
```
[root@JKXEDK-APP-T1 ~]# crontab -e
0 1,13 * * * sh /yxxd/src/autoscp.sh >> /yxxd/log/cronlog.log 2>&1
15 14 * * * /usr/local/bin/expect /root/test1.exp >> /root/1.txt
[root@JKXEDK-APP-T1 ~]# service  crond restart
```




