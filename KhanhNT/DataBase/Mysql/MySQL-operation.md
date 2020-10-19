# Hoạt động của MySQL
## 1. Mô hình Cient - Server
### 1.1 MySQL Server
- Là máy tính hoặc 1 cụm mays cài đặt MySQL-server để lưu trữ dữ liệu để máy client có thể truy cập vào quản lí.
- Dữ liệu được đặt trong các bảng có mối liên hệ với nhau.

### 1.2 MySQL client
- Cài đặt phần mềm **RDBMS(Relational Database management system)**
- Phần mềm có thể truy vấn đến 1 MySQL-Server.

### 2. Cách hoạt động 

![](https://wiki.matbao.net/wp-content/uploads/2019/09/mysql-la-gi-cach-mysql-van-hanh-kha-don-gian.png)

- MySQL tạo ra bảng lưu dữ liệu, định nghĩa các mối quan hệ giữa các bảng đó.
- Client gửi yêu cầu SQL bằng lệnh trên MySQL.
- Ứng dụng trên Server phản hồi thông tin và trả về kết quả trên máy client.

### 3. Sử  dụng MySQL cơ bản
#### 3.1 Tạo Databases

```
mysql> create database sinhvien;
Query OK, 1 row affected (0.01 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sinhvien           |
| test               |
+--------------------+
5 rows in set (0.00 sec)
```

#### 3.2 Xóa Databases

```
mysql> drop database sinhvien;
Query OK, 0 rows affected (0.00 sec)

mysql> show databases
    -> ;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| test               |
+--------------------+
4 rows in set (0.00 sec)
```

#### 3.3 Chọn cơ sở dữ liệu

```
mysql> USE test;
Database changed
mysql> 
```

- Tất cả các hoạt động sau đó sẽ được ghi trên cơ sở dữ liệu `test`

#### 3.4 Các kiểu dữ liệu số trong MySQL
##### 3.4.1 Kiểu dữ liệu số
- INT
- TINYINT
- SMALLINT
- MEDIUMINT
- BIGINT
- FLOAT
- DOUBLE
- DECIMAL

##### 3.4.2 Kiểu dữ liệu Data và Time
- DATE (YYYY-MM-DD)
- DATETIME (YYYY-MM-DD HH:MM:SS)
- TIMESTAMP
- TIME
- YEAR(M)

##### 3.4.3 Kiểu dữ liệu chuỗi trong MySQL
- CHAR
- VARCHAR
- BLOB hoặc TEXT
- TINYBLOB hoặc TINYTEXT
- MEDIUMBLOB hoặc MEDIUMTEXT
- LONGBLOB hoặc LONGTEXT
- ENUM

#### 3.5 Tạo bảng

```
mysql> USE test;
Database changed
mysql> create table sinhvien ( mssv INT, ho VARCHAR(255), ten VARCHAR(255), tuoi INT );
Query OK, 0 rows affected (0.01 sec)
```

```
mysql> show tables
    -> ;
+----------------+
| Tables_in_test |
+----------------+
| sinhvien       |
+----------------+
1 row in set (0.00 sec)
```

#### 3.6 Xóa bảng

```
mysql> drop table sinhvien
    -> ;
Query OK, 0 rows affected (0.01 sec)

mysql> show tables
    -> ;
Empty set (0.00 sec)
```

#### 3.7 Insert

```
mysql> create table sinhvien(
    -> mssv INT,
    -> ho VARCHAR(25),
    -> ten VARCHAR(255),
    -> tuoi INT);
Query OK, 0 rows affected (0.01 sec)
```

- Cú pháp 
  + `insert into table_name (truong1, truong2, truong3,...) values (giatri1, giatri2, giatri3,...)`


```
mysql> insert into sinhvien (mssv, ho, ten) values (1, "Nguyen Tran","Khanh");
Query OK, 1 row affected (0.01 sec)
```

- Check:

```
mysql> SELECT * FROM sinhvien;
+------+-------------+-------+------+
| mssv | ho          | ten   | tuoi |
+------+-------------+-------+------+
|    1 | Nguyen Tran | Khanh | NULL |
+------+-------------+-------+------+
1 row in set (0.00 sec)
```

#### 3.8 Select
- Cú pháp 
  + `SELETE truong1, truong2,... truongN FROM table_name [menhDe WHERE ][OFFSET M][LIMIT N]`

```
mysql> select ho from sinhvien 
    -> ;
+-------------+
| ho          |
+-------------+
| Nguyen Tran |
+-------------+
1 row in set (0.00 sec)
```

#### 3.9 WHERE
- Để lọc các kết quả thu được
- Cú pháp
  + `SELECT truong1,truong2,... truongN FROM table_name [WHERE dk1]`

```
mysql> select * from sinhvien where ten = "Khanh";
+------+-------------+-------+------+
| mssv | ho          | ten   | tuoi |
+------+-------------+-------+------+
|    1 | Nguyen Tran | Khanh | NULL |
+------+-------------+-------+------+
```

#### 3.10 Update
- Sử dụng để sửa đổi dữ liệu trong bảng MySQL
- Cú pháp
  + `UPDATE table_name SET truong1=giatri_moi1, truong2=giatri_moi2;`

```
mysql> update sinhvien SET tuoi = 18;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from sinhvien where ten = "Khanh";
+------+-------------+-------+------+
| mssv | ho          | ten   | tuoi |
+------+-------------+-------+------+
|    1 | Nguyen Tran | Khanh |   18 |
+------+-------------+-------+------+
1 row in set (0.00 sec)

```

#### 3.11 DELETE
- DELETE để xóa dữ liệu từ 1 bảng
- `DELETE FROM table_name WHERE [dk];`

```
mysql> insert into sinhvien (mssv,ho,ten,tuoi) values (2, "Nguyen", "A",19);
Query OK, 1 row affected (0.01 sec)

mysql> select * FROM sinhvien;
+------+-------------+-------+------+
| mssv | ho          | ten   | tuoi |
+------+-------------+-------+------+
|    1 | Nguyen Tran | Khanh |   18 |
|    2 | Nguyen      | A     |   19 |
+------+-------------+-------+------+
2 rows in set (0.01 sec)
```

```
mysql> delete from sinhvien where tuoi=19;
Query OK, 1 row affected (0.00 sec)

mysql> select * FROM sinhvien;
+------+-------------+-------+------+
| mssv | ho          | ten   | tuoi |
+------+-------------+-------+------+
|    1 | Nguyen Tran | Khanh |   18 |
+------+-------------+-------+------+
1 row in set (0.00 sec)
```

#### 3.12 Like 
- Sử dụng kí hiệu `%` làm việc như siêu kí tự `*`

#### 3.13 ORDER BY

```
mysql> select * from sinhvien;
+------+-------------+-------+------+
| mssv | ho          | ten   | tuoi |
+------+-------------+-------+------+
|    1 | Nguyen Tran | Khanh |   18 |
|    2 | Nguyen      | A     |   20 |
|    3 | Nguyen      | B     |   21 |
|    4 | Nguyen      | C     |   25 |
+------+-------------+-------+------+
4 rows in set (0.01 sec)
```
- `ORDER BY` chỉ thị cách sắp xếp kết quả

```
mysql> select * from sinhvien;
+------+-------------+-------+------+
| mssv | ho          | ten   | tuoi |
+------+-------------+-------+------+
|    1 | Nguyen Tran | Khanh |   18 |
|    2 | Nguyen      | A     |   20 |
|    3 | Nguyen      | B     |   21 |
|    4 | Nguyen      | C     |   25 |
|    4 | Nguyen      | C     |   17 |
+------+-------------+-------+------+
5 rows in set (0.00 sec)

mysql> select * from sinhvien order by tuoi ;
+------+-------------+-------+------+
| mssv | ho          | ten   | tuoi |
+------+-------------+-------+------+
|    4 | Nguyen      | C     |   17 |
|    1 | Nguyen Tran | Khanh |   18 |
|    2 | Nguyen      | A     |   20 |
|    3 | Nguyen      | B     |   21 |
|    4 | Nguyen      | C     |   25 |
+------+-------------+-------+------+
5 rows in set (0.00 sec)
```

#### 3.14 Join
- Lệnh để kết hợp các bảng

```
mysql> create table hocphi (mssv int ,tien int );
```

```
mysql> insert  into hocphi (mssv, tien) values (1, 1000);
Query OK, 1 row affected (0.02 sec)

mysql> insert  into hocphi (mssv, tien) values (2, 2000);
Query OK, 1 row affected (0.01 sec)

mysql> insert  into hocphi (mssv, tien) values (3, 3000);
Query OK, 1 row affected (0.00 sec)

mysql> insert  into hocphi (mssv, tien) values (4, 4000);
Query OK, 1 row affected (0.01 sec)
```

```
mysql> select * from hocphi;
+------+------+
| mssv | tien |
+------+------+
|    1 | 1000 |
|    2 | 2000 |
|    3 | 3000 |
|    4 | 4000 |
+------+------+
4 rows in set (0.00 sec)
```
```
mysql> select a.mssv,a.ho,a.ten,b.tien from sinhvien a right join hocphi b on a.mssv=b.mssv;
+------+-------------+-------+------+
| mssv | ho          | ten   | tien |
+------+-------------+-------+------+
|    1 | Nguyen Tran | Khanh | 1000 |
|    2 | Nguyen      | A     | 2000 |
|    3 | Nguyen      | B     | 3000 |
|    4 | Nguyen      | C     | 4000 |
|    4 | Nguyen      | C     | 4000 |
+------+-------------+-------+------+
5 rows in set (0.00 sec)
```







__Docs__
- https://www.hostinger.vn/huong-dan/mysql-la-gi/
- https://wiki.matbao.net/mysql-la-gi-huong-dan-toan-tap-ve-mysql/
