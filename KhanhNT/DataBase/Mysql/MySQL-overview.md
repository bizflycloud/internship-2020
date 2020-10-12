# Tổng quan về  MySQL

## 1. Cơ bản MySQL:
- `SQL (Structed Query Language)`: ngôn ngữ truy vấn có cấu trúc dùng để tìm và xử lí dữ liệu trong cơ sở dữ liệu quan hệ. 
- `MySQL` là hệ quản trị cơ sở dữ liệu tự do mã nguồn mở.

### Ưu điểm :
- MySQL có tốc độ nhanh.
- Dễ sử dụng
- MySQL Free
- Hỗ trợ ngôn ngữ truy vấn SQL
- Nhiều Client có thể truy cập đến Server trong cùng 1 thời gian.
- Kết nối và bảo mật

## 2. Cài đặt mysql (Ubuntu)
- `sudo apt update`
- `wget -c https://repo.mysql.com//mysql-apt-config_0.8.13-1_all.deb`
- `sudo dpkg -i mysql-apt-config_0.8.13-1_all.deb `
- `sudo apt-get install mysql-server`

```
corgi@nagios:~$ /etc/init.d/mysql restart
stop: Rejected send message, 1 matched rules; type="method_call", sender=":1.8" (uid=1000 pid=1325 comm="stop mysql ") interface="com.ubuntu.Upstart0_6.Job" member="Stop" error name="(unset)" requested_reply="0" destination="com.ubuntu.Upstart" (uid=0 pid=1 comm="/sbin/init ")
start: Rejected send message, 1 matched rules; type="method_call", sender=":1.9" (uid=1000 pid=1318 comm="start mysql ") interface="com.ubuntu.Upstart0_6.Job" member="Start" error name="(unset)" requested_reply="0" destination="com.ubuntu.Upstart" (uid=0 pid=1 comm="/sbin/init ")
corgi@nagios:~$ /etc/init.d/mysql status
mysql start/running, process 988
```

## 3. Sử dụng cơ bản

### 3.1 Truy cập MySQL:

```
corgi@nagios:~$ mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 36
Server version: 5.5.62-0ubuntu0.14.04.1 (Ubuntu)

Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
```

### 3.2 Xem danh sách các Database

```
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
3 rows in set (0.00 sec)
```

#### Note: Database Mysql chứa các thông tin của mysql như user, password.

### 3.3 Tạo database

- `CREATE DATABASE IF NOT EXISTS database_name;`

```
mysql> create database if not exists test;
Query OK, 1 row affected (0.00 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| test               |
+--------------------+
4 rows in set (0.01 sec)
```

### 3.4 Xóa database
- `DROP DATABASE IF EXISTS database_name`

```
mysql> drop database if exists test
    -> ;
Query OK, 0 rows affected (0.00 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
3 rows in set (0.00 sec)
```

### 3.5 Thao tác với 1 database

- `use database_name;`

```
mysql> create database if not exists test;
Query OK, 1 row affected (0.00 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| test               |
+--------------------+
4 rows in set (0.00 sec)

mysql> use test;
Database changed
```

### 3.6 Xem các bảng có trong database
- `show tables;`

### 3.7 Xem toàn bộ dữ liệu của bảng

- `SELETE * FROM database_name;`


__Docs__
- https://github.com/lacoski/mysql-1/blob/master/docs/mysql-overview.md



