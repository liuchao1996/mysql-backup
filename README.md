# mysql-backup
mysql自动备份，自动删除30天前备份文件

修改好配置后，添加到linux的定时任务中即可。

打开定时任务配置文件
``crontab -e``

配置定时任务
`` 0 3 * * * 脚本存放目录/mysql-backup.sh >> 日志存放目录/log 2>&1 ``
