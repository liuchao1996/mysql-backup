#!/bin/bash
# 数据库认证
 user="用户名"
 password="密码"
 host="ip"

 #数据库名称，多个以逗号,分隔
 db_names="数据库1,数据库2"
# 备份文件存储路径
 backup_path="路径"
 date=$(date +"%Y-%m-%d")
# 设置导出文件的缺省权限
 umask 177



#循环开始----------------------------------
for dbName in $(echo $db_names | sed "s/,/ /g")
do

 echo ""
 echo "----------------------------------------"

 echo "备份$dbName,开始时间："$(date +"%F%n%T")
 
 # Dump数据库到SQL文件
 mysqldump --user=$user --password=$password --host=$host $dbName > $backup_path/$dbName-$date.sql;
	
 # 压缩
 tar -zcvf $backup_path/$dbName-$date.tar.gz -C $backup_path/ $dbName-$date.sql;
	
 #删除掉源文件
 rm -rf $backup_path/$dbName-$date.sql;

  echo "备份$dbName,结束时间："$(date +"%F%n%T")

done
#循环结束----------------------------------



# 删除30天之前的就备份文件
find $backup_path -mtime +30 -type f |xargs rm -f