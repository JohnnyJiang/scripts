#!/usr/local/bin/expect -f
set date [exec date "+%Y%m%d%H%M%S"]
set time [exec date "+%Y-%m-%d %H:%M:%S"]
set division "-------Remove client files success-------"
spawn ssh root@100.11.96.2
set timeout 100
expect "password:"
send "yxjk@123\r"
expect "*#"
send "sudo rm /tmp/test1.txt\r"
expect "*#"
send "cd /tmp\r"
expect "*#"
send "echo $time $division > $date.log\r"
expect "*#"
send "exit\r"
interact