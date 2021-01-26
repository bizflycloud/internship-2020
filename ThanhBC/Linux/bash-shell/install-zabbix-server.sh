#! /bin/bash

printf "=========================================================================\n"
printf "Chuan bi qua trinh tai ban cai dat Zabbix-server... \n"
printf "=========================================================================\n"


#tat selinux
echo -e "Tắt SELinux trên máy cần cài. \n"
echo -e `sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config`

# Them repo cho de lay link cai dat zabbix
echo -e "=========================================================================\n"
echo -e "Thêm repository epel."
yum install epel-release -y


# Downloading repo va mot so service can thiet

echo -e "=========================================================================\n"
echo -e "Download repo va cac service thiet yeu:\n "
rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
yum -y install zabbix-server-mysql zabbix-web-mysql mysql mariadb-server httpd php zabbix-server

# Khoi dong lai mariadb
echo -e `systemctl start mariadb`
echo -e `systemctl enable mariadb`



echo -e "=========================================================================\n"
# cap nhap he thong
echo -e "Cap nhat he dieu hanh: \n"
yum update -y



echo -e "=========================================================================\n"
echo -e "Nhập mật khẩu root cho database (nếu chưa có thì để trống): \n"
read mysql_root_pass

if [ "$mysql_root_pass" = "" ]; then
	mysql_secure_installation
else 
	echo -e "=========================================================================\n"
fi


read -p "MySQL DB User: " mysql_db_user_name

read -sp "MySQL Password: " mysql_db_password


echo "create database $mysql_db_user_name character set utf8 collate utf8_bin" | mysql -h localhost -u root -p$mysql_root_pass

echo "grant all privileges on $mysql_db_user_name.* to $mysql_db_user_name@'localhost' identified by '$mysql_db_password';"  | mysql -h localhost -u root -p$mysql_root_pass

echo "flush privileges;" | mysql -h localhost -u root -p$mysql_root_pass

echo `gunzip /usr/share/doc/zabbix-server-mysql*/create.sql.gz` | mysql -h localhost -u root -p$mysql_root_pass
mysql -h localhost -u root -p$mysql_root_pass $mysql_db_user_name <  /usr/share/doc/zabbix-server-mysql*/create.sql


sed -i "s/# DBHost=localhost/DBHost=localhost/g" /etc/zabbix/zabbix_server.conf
sed -i "s/DBName=zabbix/DBName=$mysql_db_user_name/g" /etc/zabbix/zabbix_server.conf
sed -i "s/DBUser=zabbix/DBUser=$mysql_db_user_name/g" /etc/zabbix/zabbix_server.conf
sed -i "s/# DBPassword=/DBPassword=$mysql_db_password/g" /etc/zabbix/zabbix_server.conf


sed -i 's/max_execution_time = 30/max_execution_time = 600/g' /etc/php.ini
sed -i 's/max_input_time = 60/max_input_time = 600/g' /etc/php.ini
sed -i 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 32M/g' /etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 16M/g' /etc/php.ini
echo "date.timezone = Asia/Ho_Chi_Minh" >> /etc/php.ini

systemctl start zabbix-server
systemctl enable zabbix-server
systemctl start httpd
systemctl enable httpd
systemctl restart zabbix-server
systemctl restart httpd
systemctl restart mariadb

echo -e "=========================================================================\n"
echo -e "Vậy là đã cài đặt thành công zabbix server"
echo -e "=========================================================================\n"