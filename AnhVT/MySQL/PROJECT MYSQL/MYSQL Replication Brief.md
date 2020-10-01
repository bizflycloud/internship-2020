# MYSQL Replication Brief

![MYSQL%20Replication%20Brief/Untitled.png](MYSQL%20Replication%20Brief/Untitled.png)

# 1. Replication Brief ( Nhân rộng / Sao chép )

## Tổng quan

- Sao chép( Replication ) cho phép dữ liệu từ một máy chủ cơ sở dữ liệu MySQL (được gọi là Master ) được sao chép sang một hoặc nhiều máy chủ cơ sở dữ liệu MySQL khác ( được gọi là Slave )
- Đặc điểm của quá trình này là Asynchronous ( không đồng bộ ) hoặc Semi-Asynchronous ( bán đồng bộ )
- Không cần kết nối liên tục tới máy nguồn ( thể hiện tính không đồng bộ )
- Có thể lựa chọn loại dữ liệu, bảng dữ liệu để sao chép

## Ưu điểm

![MYSQL%20Replication%20Brief/Untitled%201.png](MYSQL%20Replication%20Brief/Untitled%201.png)

- Scale-out : Việc viết dữ liệu sẽ diễn ra trên máy Master . Tuy nhiên việc đọc thì có thể diễn ra ở cả máy Master và Slave → Cải thiện tốc độ đầu ra
- Data Security : Các máy Slave hoàn toàn có thể hủy bỏ quá trình sao chép → tao điều kiện thuận lợi cho việc sử dụng làm backup dữ liệu trong trường hợp xảy ra lỗi
- Analytics : Việc ghi dữ liệu trực tuyến sẽ diễn ra ở trên máy Master. Còn việc phân tích dữ liệu có thể diễn ra ở trên các máy Slave → Không gây ảnh hướng tới quá trình tại máy Master
- Long distance Data Distribution : sử dụng máy Slave gần nhất ( ví dụ theo khoảng cách địa lý ) để copy dữ liệu về máy

## Phân loại

MySQL 8 hỗ trợ nhiều các phương thức sao chép khác nhau

- Phương thức truyền thống, đọc events từ file log của máy Master để đồng bộ dữ liệu
- Phương thức mới và tiện hơn, đó chính là GTID

    → Phương thức này đảm bảo tính ổn định do không cần phải đọc dữ liệu từ file log của máy Master

Việc sao chép của MySQL có thể hỗ trợ nhiều loại đồng bộ khác nhau

- Asynchronous replication

    Ở quá trình này, việc sao chép dữ liệu giữa server Master và server Slave là không đồng bộ. Dẫn tới việc có thể các server Slave sẽ có 1 độ trễ nhất định. Khi server Master chuyển trạng thái sang không hoạt động thì cần chuyển 1 server có dữ liệu được đồng bộ và được cập nhật thường xuyên nhất làm server Master mới

- Semi - Asynchronous replication

    Được sử dụng trong hệ thống Asynchronous. Khác với hệ thống Asynchronous thì server Master chỉ thực hiện thay đổi sau khi xác nhận các server Slave cũng đã nhận biết được về sự thay đổi diễn ra. Việc này có ảnh hưởng tới hiệu năng của server.

- Synchronous replication : Là 1 đặc tính của NDB Cluster

Để hiểu rõ hơn bạn có thể tham khảo đường dẫn sau:

[MySQL :: MySQL 8.0 Reference Manual :: 17 Replication](https://dev.mysql.com/doc/refman/8.0/en/replication.html)

---

# 2. Tiến hành Replication trên Ubuntu 18.04

Việc sao chép dữ liệu trên MySQL có nhiều cách khác nhau theo nhiều mô hình khác nhau và chúng ta sẽ cùng liệt kê một vài phương pháp khá đơn giản để thực hiện điều này

### 1. Master-Slaves ( Single Replication / Sao chép đơn )

![MYSQL%20Replication%20Brief/Untitled%202.png](MYSQL%20Replication%20Brief/Untitled%202.png)

Về cơ bản dữ liệu được lấy từ 1 server master chính và được sao chép ra các server slave khác nhau.Nếu server master chuyển trạng thái sang không hoạt động thì server slave có dữ liệu được cập nhật thường xuyên nhất phải được đặt làm server master mới. Đây là mô hình sao chép (replicaition) đơn giản nhất

- **Cách tiến hành**
    1. *Trên server Master*
        - Tiến hành chỉnh sửa file `mysql.conf`  tại đường dẫn `/etc/mysql/mysql.conf.d/`:

            ```bash
            server-id=1 # Luu y: Moi server co 1 ID rieng biet khong duoc trung lap
            log-bin=mysql-bin # Noi cac thay doi duoc luu lai. Cac slave se tien hanh sao chep cac thay doi co trong file log nay
            binlog_do_db=testdb # database duoc tien hanh sao chep
            ```

        - Lưu lại các thay đổi. Thực hiện restart lại MySQL thông qua lệnh

            ```bash
            systemctl restart mysql.service
            ```

        - Thực hiện việc backup dữ liệu của database được chọn để sao chép:

            ```bash
            mysqldump -u root -p testdb > testdb.sql
            ```

        - Truy cập MySQL trên máy Master và sau đó tạo user để các slave có thể thực hiện việc sao chép dữ liệu:

            ```bash
            mysql -u root -p
            Enter password:
            create user 'rpl_user'@'%' identified by 'password'; # O cac muc nhu user va password ban hoan toan co the tu thay doi
            grant replication slave on *.* to 'rpl_user'@'%'; # Cung cap quyen sao chep ( replication ) cho user nay
            flush privileges; #Reload lai cac quyen
            show grants for 'rpl_user'@'%' # Kiem tra lai cac quyen da cap

            ```

        - Sau đó hiển thị 1 số các thông tin cần thiết cho các quá trình sau này thông qua lệnh

            ```bash
            show master status ; # Hien thi trang thai master
            ```

            Kết quả nhận được có dạng như sau

            ```bash
            mysql> show master status;
            +------------------+----------+--------------+------------------+-------------------+
            | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
            +------------------+----------+--------------+------------------+-------------------+
            | mysql-bin.000006 |      966 | testdb       |                  |                   |
            +------------------+----------+--------------+------------------+-------------------+
            1 row in set (0.00 sec)
            ```

        - Chuyển file `testdb.sql` sang các server slave:

            ```bash
            scp testdb.sql root@xxx.xxx.xxx.xxx:/root/
            ```

        Vậy là công việc tại máy chủ Master đã kết thúc. Tiếp theo chúng ta sẽ đến với bước 2 - Tại các máy chủ Slave

    2. *Trên server Slave*
        - Tiến hành chỉnh sửa file `mysql.conf`  tại đường dẫn `/etc/mysql/mysql.conf.d/`:

            ```bash
            server-id=2 # Luu y: Moi server co 1 ID rieng biet khong duoc trung lap
            log-bin=mysql-bin # Noi cac thay doi duoc luu lai. Cac slave se tien hanh sao chep cac thay doi co trong file log nay
            replication-do-db=testdb # database duoc tien hanh sao chep
            ```

        - Tiên hành Restart MySQL để chạy lại các thay đổi:

            ```bash
            systemctl restart mysql.service
            ```

        - Truy cập MySQL trên máy chủ Slave, tạo database :

            ```bash
            mysql -u root -p
            Enter password:
            create database testdb;
            ```

        - Sử dụng `mysqldump` để chuyển phần dữ liệu nhận được từ server Master vào database vừa tạo:

            ```bash
            mysqldump testdb < testdb.sql
            ```

        - Truy cập lại MySQL và thay đổi các thông số sau ( Dựa trên các thông tin ở máy chủ ):

            ```bash
            mysql> change master to master_host='xxx.xxx.xxx.xxx',
            -> master_user='rpl_user',
            -> master_password='password',
            -> master_log_file='mysql-bin.000006',
            -> master_log_pos=966;
            ```

            ```bash
            mysql -u root -p
            Enter password:
            mysql> change master to master_host='xxx.xxx.xxx.xxx' #Dia chi cua server Master
            		->master_user='rpl_user', # User su dung de sao chep tren server Master
                -> master_password='password', #Pass cua user 
                -> master_log_file='mysql-bin.000006', #Ten file Log 
                -> master_log_pos=966; # vi tri cua file log
            start slave; # Bat che do slave
            show slave status\G # Kiem tra trang thai
            ```

            Slave status có các trạng thái quan trọng như sau:

            1. Slave_IO_State - Trạng thái hiện tại của Server Slave
            2. Slave_IO_Running 
            3. Slave_SQL_Running - Trạng thái cơ sở dữ liệu trên Server Slave
        - **Nếu bạn có nhiều hơn 1 slave thì có thể lặp lại bước 2 ở các server Slave khác nhau**

---

### 2. Master + Relay Slaves (Chain Replication/Chuỗi sao chép)

![MYSQL%20Replication%20Brief/Untitled%203.png](MYSQL%20Replication%20Brief/Untitled%203.png)

Mô hình này khắc phục được nhược điểm ở mô hình thứ nhất. Bởi server Master có thể bị quá tải băng thông (nhận request từ clients,... ). Ở đây xuất hiện 1 server Slave Relay ( hoạt động như 1 Master và cũng như 1 Slave ). Dữ liệu được sao chép từ server Master sang Slave Relay và dữ liệu từ server này sẽ được sao chép xuống các server Slave ở bậc dưới ( Ví dụ như hình trên ).

Các nhược điểm của Chain Replication:

1. log_slave_updates ảnh hưởng tới hiệu năng của server
2. Nếu việc sao chép tại server Relay bị trễ → Tất cả các server Slave khác sẽ bị trễ
3. Nếu Sever Relay chuyển sang trạng thái offline thì cần phải tiến hành cấu hình lại toàn bộ hệ thống. ( Single Dead Point ) 
- **Cách tiến hành**

    Ta xét mô hình với 3 server ( 1 Master - 1 Slave Relay - 1 Slave ):

    1. *Trên server Master*
        - Tiến hành chỉnh sửa file file `mysql.conf` :

            ```bash
            cd /etc/mysql/mysql.conf.d/
            nano mysql.cnf
            ```

            Tiến hành chỉnh sửa các thông số sau: 

            ```bash
            server-id=1 
            log-bin=mysql-bin #file log
            binlog_do_db=testdb #Luu cac thay doi cua 1 database vao log 
            ```

        - Tiếp đó tiến hành backup database:

            ```bash
            mysqldump -u root -p testdb > testdb.sql
            ```

        - Khởi động lại để chạy lại các thay đổi đã chỉnh sửa ở bên trên:

            ```bash
            systemctl restart mysql.service
            ```

        - Sau đó đăng nhập MySQL và tạo user để thực hiện việc sao chép:

            ```bash
            mysql -u root -p
            Enter password:
            create user 'rpl_user'@'%' identified by 'password'; # O cac muc nhu user va password ban hoan toan co the tu thay doi
            grant replication slave on *.* to 'rpl_user'@'%'; # Cung cap quyen sao chep ( replication ) cho user nay
            flush privileges; #Reload lai cac quyen
            show grants for 'rpl_user'@'%' # Kiem tra lai cac quyen da cap
            ```

        - Việc cuối cùng cần làm chính là hiện các thông số cần thiết để cung cấp cho các thao tác sau này:

            ```bash
            show master status;
            ```

            Kết quả nhận được có dạng như sau :

            ```bash
            mysql> show master status;
            +------------------+----------+--------------+------------------+-------------------+
            | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
            +------------------+----------+--------------+------------------+-------------------+
            | mysql-bin.000006 |      966 | testdb       |                  |                   |
            +------------------+----------+--------------+------------------+-------------------+
            1 row in set (0.00 sec)
            ```

    2. *Trên server Slave Relay*
        - Chính sửa file `mysql.conf` tại đường dẫn `/etc/mysql/mysql.conf.d/`:

            ```bash
            server-id=2 
            log-bin=mysql-bin
            replicate-do-db=testdb
            log-slave-updates
            skip-slave-start
            ```

            Một option quan trọng đó là `log-slave-update` : option này được sử dụng để Slave ghi lại các thay đổi vào file log của server đó.

            Ngoài ra còn có 1 option khác đó chính là `replication-do-db=testdb` : option này cho phép việc đọc log từ relay log ( cho 1 database nào đó ). 

        - Tiến hành Restart lại MySQL để chạy lại các thay đổi:

            ```bash
            systemctl restart mysql.service
            ```

        - Sử dụng `mysqldump` để chuyển phần dữ liệu nhận được từ server Master vào database vừa tạo:

            ```bash
            mysqldump testdb < testdb.sql
            ```

        - Truy cập vào MySQL tạo user để cho phép việc sao chép dữ liệu:

            ```bash
            mysql -u root -p
            Enter password:
            create user 'rpl_user'@'%' identified by 'password'; # O cac muc nhu user va password ban hoan toan co the tu thay doi
            grant replication slave on *.* to 'rpl_user'@'%'; # Cung cap quyen sao chep ( replication ) cho user nay
            flush privileges; #Reload lai cac quyen
            show grants for 'rpl_user'@'%' # Kiem tra lai cac quyen da cap
            ```

        - Sau đó thực hiện các chỉnh sửa sau để cấu hình Slave (Lưu ý:  Các thông số này phụ thuộc vào các thông số tại máy chủ thông qua lệnh `show master status` tại server Master ):

            *Thông số tại server Master*

            ```bash

            +------------------+----------+--------------+------------------+-------------------+
            | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
            +------------------+----------+--------------+------------------+-------------------+
            | mysql-bin.000006 |      966 | testdb       |                  |                   |
            +------------------+----------+--------------+------------------+-------------------+
            1 row in set (0.00 sec)
            ```

            ```bash

            mysql> change master to master_host='xxx.xxx.xxx.xxx' #Dia chi cua server Master
            		->master_user='rpl_user', # User su dung de sao chep tren server Master
                -> master_password='password', #Pass cua user 
                -> master_log_file='mysql-bin.000006', #Ten file Log 
                -> master_log_pos=966; # vi tri cua file log
            start slave; # Bat che do slave
            show slave status\G # Kiem tra trang thai
            ```

        Công việc trên server Slave Relay đã hoàn thành !

    3. *Trên Server Slave*
        - Tiến hành chỉnh sửa file `mysql.conf`  tại đường dẫn `/etc/mysql/mysql.conf.d/`:

            ```bash
            server_id=3
            log-bin=mysql.bin
            replication-do-db=testdb
            ```

        - Tiên hành Restart MySQL để chạy lại các thay đổi:

            ```bash
            systemctl restart mysql.service
            ```

        - Truy cập MySQL trên máy chủ Slave, tạo database :

            ```bash
            mysql -u root -p
            Enter password:
            create database testdb;
            ```

        - Sử dụng `mysqldump` để chuyển phần dữ liệu nhận được từ server Master vào database vừa tạo:

            ```bash
            mysqldump testdb < testdb.sql
            ```

        - Truy cập lại MySQL và thay đổi các thông số sau ( Dựa trên các thông tin ở máy chủ Slave Relay ):

            *Thông số tại máy chủ Slave Relay*

            ```bash
            mysql> show master status;
            +------------------+----------+--------------+------------------+-------------------+
            | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
            +------------------+----------+--------------+------------------+-------------------+
            | mysql-bin.000013 |      755 | testdb       |                  |                   |
            +------------------+----------+--------------+------------------+-------------------+
            1 row in set (0.00 sec)
            ```

            ```bash
            mysql -u root -p
            Enter password:
            mysql> change master to master_host='xxx.xxx.xxx.xxx' #Dia chi cua server Slave Relay
            		->master_user='rpl_user', # User su dung de sao chep tren server Slave Relay
                -> master_password='password', #Pass cua user 
                -> master_log_file='mysql-bin.000013', #Ten file Log 
                -> master_log_pos=755; # vi tri cua file log
            start slave; # Bat che do slave
            show slave status\G # Kiem tra trang thai
            ```

        **Nếu bạn có nhiều hơn 1 slave thì có thể lặp lại bước 3 ở các server Slave khác nhau**

        **Vậy là chúng ta đã hoàn tất quá trình sao chép chuỗi ( Chain Replication )** 

---

### 3. Circular Replication ( Sao chép vòng )

![MYSQL%20Replication%20Brief/Untitled%204.png](MYSQL%20Replication%20Brief/Untitled%204.png)

Mô hình này được thực hiện với 2 server trở lên nhưng cả 2 server sẽ hoạt động như 2 Master riêng biệt. Quá trình sao chép diễn ra không đồng bộ.

Một số nhược điểm:

1. Cần phải cấu hình `auto-increment offset` trên mỗi server tránh việc xung đột primary key trên các databases
2. Không có giải pháp khắc phục xung đột
3. Không hoàn toàn đảm bảo việc không bị mất dữ liệu trong quá trình cập nhật dữ liệu

**Cách tiến hành**

Thực hiện xét mô hình với 2 server Master ( Master A và Master B )

Server A là master của server B và ngược lại

1. *Tại server A*
    - Tiến hành chỉnh sửa file file `mysql.conf`  tại đường dẫn `/etc/mysql/mysql.conf.d/`:

    ```bash
    [mysqld]
    server-id=1
    log-bin=mysql-bin
    log-slave-updates
    ```

    - Tiên hành Restart MySQL để chạy lại các thay đổi:

    ```bash
    systemctl restart mysql.service
    ```

    - Truy cập MySQL và tạo user để thực hiện việc sao chép :

    ```bash
    mysql -u root -p
    Enter password:
    create user 'rpl_user'@'%' identified by 'password'; # O cac muc nhu user va password ban hoan toan co the tu thay doi
    grant replication slave on *.* to 'rpl_user'@'%'; # Cung cap quyen sao chep ( replication ) cho user nay
    flush privileges; #Reload lai cac quyen
    show grants for 'rpl_user'@'%' # Kiem tra lai cac quyen da cap
    ```

    - Xem thông số Master A :

    ```bash
    +------------------+----------+--------------+------------------+-------------------+
    | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
    +------------------+----------+--------------+------------------+-------------------+
    | mysql-bin.000007 |      1966 | testdb       |                  |                   |
    +------------------+----------+--------------+------------------+-------------------+
    1 row in set (0.00 sec)
    ```

2. *Tại server B*
    - Tiến hành chỉnh sửa file file `mysql.conf` tại đường dẫn `/etc/mysql/mysql.conf.d/`:

    ```bash
    [mysqld]
    server-id=2
    log-bin=mysql-bin
    log-slave-updates
    ```

    - Tiên hành Restart MySQL để chạy lại các thay đổi:

    ```bash
    systemctl restart mysql.service
    ```

    - Truy cập MySQL và tạo user để thực hiện việc sao chép :

    ```bash
    mysql -u root -p
    Enter password:
    create user 'rpl_user'@'%' identified by 'password'; # O cac muc nhu user va password ban hoan toan co the tu thay doi
    grant replication slave on *.* to 'rpl_user'@'%'; # Cung cap quyen sao chep ( replication ) cho user nay
    flush privileges; #Reload lai cac quyen
    show grants for 'rpl_user'@'%' # Kiem tra lai cac quyen da cap
    ```

    - Xem thông số Master B :

    ```bash
    +------------------+----------+--------------+------------------+-------------------+
    | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
    +------------------+----------+--------------+------------------+-------------------+
    | mysql-bin.000008 |      2966 | testdb       |                  |                   |
    +------------------+----------+--------------+------------------+-------------------+
    1 row in set (0.00 sec)
    ```

3. Cấu hình Master cho 2 server A và B:
    - Tại server A

    ```bash
    mysql -u root -p
    Enter password:
    mysql> change master to master_host='xxx.xxx.xxx.xxx' #Dia chi cua server B	
    ->master_user='rpl_user', # User su dung de sao chep tren server B
        -> master_password='password', #Pass cua user 
        -> master_log_file='mysql-bin.000008', #Ten file Log 
        -> master_log_pos=2966; # vi tri cua file log
    start slave; # Bat che do slave
    show slave status\G # Kiem tra trang thai
    ```

    - Taị server B

    ```bash
    mysql -u root -p
    Enter password:
    mysql> change master to master_host='xxx.xxx.xxx.xxx' #Dia chi cua server A
    ->master_user='rpl_user', # User su dung de sao chep tren server A
        -> master_password='password', #Pass cua user 
        -> master_log_file='mysql-bin.000007', #Ten file Log 
        -> master_log_pos=1966; # vi tri cua file log
    start slave; # Bat che do slave
    show slave status\G # Kiem tra trang thai
    ```

     Nếu nhận được kết quả như sau thì việc sao chép đã được cấu hình thành công :

    ```bash
    Slave_IO_Running=Yes ; Slave_SQL_Running=Yes
    ```

---

### 4.Multi-Source Replication

![MYSQL%20Replication%20Brief/Untitled%205.png](MYSQL%20Replication%20Brief/Untitled%205.png)

Server Slave trong mô hình này có khả năng nhận dữ liệu từ nhiều nguồn khác nhau. Mô hình này có khả năng backup dữ liệu cho nhiều server cũng như 1 server. 

Nhược điểm:

Tuy nhiên mô hình nay đòi hỏi server slave phải có khả năng lưu trữ lớn, hoạt động ổn định, tốc độ cao. Do khi server Slave này chuyển trạng thái sang không hoạt động hoặc khi gặp lỗi mất dữ liệu thì không chỉ 1 server Master sẽ mất toàn bộ dữ liệu backup.

→ Tuy không ảnh hưởng trực tiếp tới hoạt động của server master nhưng có thể coi là điểm chết ( single dead point ) cho rất nhiều các server Master

**Cách tiến hành**

Chúng ta thực hiện xét mô hình với 2 Master A và B và 1 Slave C ( phục vụ cho cả 2 server A và B ) :

1. *Trên 2 server Master  A và B ( server-id-A = 1 ; server-id-B = 2 ):*
    - Tiến hành chỉnh sửa file file `mysql.conf` tại đường dẫn `/etc/mysql/mysql.conf.d/`:

    ```bash
    server-id=1 
    log-bin=mysql-bin #file log
    binlog_do_db=testdb #Luu cac thay doi cua 1 database vao log
    ```

    - Restart lại dịch vụ MySQL để thực hiện các thay đổi

    ```bash
    systemctl restart mysql.service
    ```

    - Đăng nhập MySQL tạo user để sao chép dữ liệu :

    ```bash
    mysql -u root -p
    Enter password:
    create user 'rpl_user'@'%' identified by 'password'; # O cac muc nhu user va password ban hoan toan co the tu thay doi
    grant replication slave on *.* to 'rpl_user'@'%'; # Cung cap quyen sao chep ( replication ) cho user nay
    flush privileges; #Reload lai cac quyen
    show grants for 'rpl_user'@'%' # Kiem tra lai cac quyen da cap
    ```

    - Hiển thị thông số của server Master ( lặp lại với các server Master )

    ```bash
    show master status;
    ```

2. *Trên server Slave C:*
    - Tiến hành chỉnh sửa file file `mysql.conf` tại đường dẫn `/etc/mysql/mysql.conf.d/`:

    ```bash
    server-id=3
    log-bin=mysql.bin
    replicate-do-db=testdb
    ```

    - Restart lại dịch vụ MySQL để thực hiện các thay đổi :

    ```bash
    systemctl restart mysql.service
    ```

    - Truy cập MySQL và thực hiện các thay đổi sau đây:

    ```bash
    mysql -u root -p
    Enter password:
    mysql> change master to master_host='xxx.xxx.xxx.xxx' #Dia chi cua server A
    ->master_user='rpl_user', # User su dung de sao chep tren server A
        -> master_password='password', #Pass cua user 
        -> master_log_file='mysql-bin.xxxxxx', #Ten file Log 
        -> master_log_pos=xxx for channel='master1'; # vi tri cua file log
    start slave; # Bat che do slave
    show slave status\G # Kiem tra trang thai
    ```

    ```bash
    mysql> change master to master_host='xxx.xxx.xxx.xxx' #Dia chi cua server B
    ->master_user='rpl_user', # User su dung de sao chep tren server B
        -> master_password='password', #Pass cua user 
        -> master_log_file='mysql-bin.xxxxxx', #Ten file Log 
        -> master_log_pos=xxx for channel='master2'; # vi tri cua file log
    		
    start slave; # Bat che do slave
    show slave status\G # Kiem tra trang thai
    ```

    ```bash
    start slave for channel='master1'; # Cho server A
    start slave for channel='master2'; # Cho server B
    ```

     Nếu nhận được kết quả như sau thì việc sao chép đã được cấu hình thành công :

    ```bash
    Slave_IO_Running=Yes ; Slave_SQL_Running=Yes
    ```

---

### 5. Multiple Replication

![MYSQL%20Replication%20Brief/Untitled%206.png](MYSQL%20Replication%20Brief/Untitled%206.png)

Trong mô hình này bao gồm 2 server Master ( 1 Active và 1 Passive ). Việc đồng bộ giữa 2 server Master là Semi - Sync. Khi server Master ( Active ) muốn tiến hành 1 thay đổi dữ liệu, nó sẽ gửi yêu cầu xác nhận sự thay đổi này cho phía Master còn lại ( Backup ). Server Backup nhận được yêu cầu, thay đổi dữ liệu, viết thay đổi vào relay log, sau đó gửi xác nhận. Server Master sau khi nhận được xác nhận sẽ tiến hành thực thi sự thay đổi này

Việc sao chép dữ liệu với các Slave vẫn là quá trình Async ( Không đồng bộ ). Quá trình Semi-Sync có làm giảm về mặt hiệu năng nhưng bù lại là khả năng giảm thiểu mất dữ liệu.

**Cách tiến hành**

Xét mô hình bao gồm 1 Master Active và 1 Master Passive. Quá trình Async từ server Master Active xuống các slave có thể tham khảo ở phần đầu bài viết. Ở đây chúng ta sẽ tập trung vào phần Semi-Sync giữa 2 master. 

1. *Trên Server Master Active*
    - Thực hiện tải Plugin Semi-Sync:

    ```bash
    mysql -u root -p -e"INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';"
    ```

    - Tiến hành chỉnh sửa file file `mysql.conf` tại đường dẫn `/etc/mysql/mysql.conf.d/`:

    ```bash
    server-id=1
    binlog-do-db=testdb
    rpl_semi_sync_master_enabled = 1
    ```

    - Restart lại dịch vụ MySQL để thực hiện các thay đổi :

    ```bash
    systemctl restart mysql.service
    ```

    - Đăng nhập MySQL tạo user để sao chép dữ liệu :

    ```bash
    mysql -u root -p
    Enter password:
    create user 'rpl_user'@'%' identified by 'password'; # O cac muc nhu user va password ban hoan toan co the tu thay doi
    grant replication slave on *.* to 'rpl_user'@'%'; # Cung cap quyen sao chep ( replication ) cho user nay
    flush privileges; #Reload lai cac quyen
    show grants for 'rpl_user'@'%' # Kiem tra lai cac quyen da cap
    ```

    - Show trạng thái của semi_sync:

    ```bash
    show status like 'rpl_semi_sync%'
    ```

    Kết quả nhận được có dạng như sau:

    ```bash
    +--------------------------------------------+-------+
    | Variable_name                              | Value |
    +--------------------------------------------+-------+
    | Rpl_semi_sync_master_clients               | 1     |
    | Rpl_semi_sync_master_net_avg_wait_time     | 0     |
    | Rpl_semi_sync_master_net_wait_time         | 0     |
    | Rpl_semi_sync_master_net_waits             | 24    |
    | Rpl_semi_sync_master_no_times              | 2     |
    | Rpl_semi_sync_master_no_tx                 | 6     |
    | Rpl_semi_sync_master_status                | ON    |
    | Rpl_semi_sync_master_timefunc_failures     | 0     |
    | Rpl_semi_sync_master_tx_avg_wait_time      | 1510  |
    | Rpl_semi_sync_master_tx_wait_time          | 33238 |
    | Rpl_semi_sync_master_tx_waits              | 22    |
    | Rpl_semi_sync_master_wait_pos_backtraverse | 0     |
    | Rpl_semi_sync_master_wait_sessions         | 0     |
    | Rpl_semi_sync_master_yes_tx                | 22    |
    +--------------------------------------------+-------+
    14 rows in set (0.01 sec)
    ```

    Trong đó có các thông số quan trọng như :

    `Rpl_semi_sync_master_clients` : Số lượng slave 

    `Rpl_semi_sync_master_status` : Trạng thái Semi - Sync

    - Hiển thị các thông số của server Master Active :

    ```bash
    show master status;
    ```

    - Kết quả nhận được có dạng như sau

    ```bash
    +------------------+----------+--------------+------------------+-------------------+
    | File             | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
    +------------------+----------+--------------+------------------+-------------------+
    | mysql-bin.000008 |      2966 | testdb       |                  |                   |
    +------------------+----------+--------------+------------------+-------------------+
    1 row in set (0.00 sec)
    ```

2. *Trên Server Master Passive ( Read Only )*
    - Thực hiện tải Plugin Semi-Sync:

        ```bash
        mysql -u root -p -e"INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave';"
        ```

    - Tiến hành chỉnh sửa file file `mysql.conf` tại đường dẫn `/etc/mysql/mysql.conf.d/`:

        ```bash
        server-id = 2
        replicate-do-db=testdb
        rpl_semi_sync_slave_enabled=1
        ```

    - Restart lại dịch vụ MySQL để thực hiện các thay đổi :

        ```bash
        systemctl restart mysql.service
        ```

    - Đăng nhập MySQL và thực hiện việc sao chép dữ liệu từ Server Master Active:

        ```bash
        mysql -u root -p
        Enter password:
        mysql> change master to master_host='xxx.xxx.xxx.xxx' #Dia chi cua server Active
        ->master_user='rpl_user', # User su dung de sao chep tren server Active
            -> master_password='password', #Pass cua user 
            -> master_log_file='mysql-bin.xxxxxx', #Ten file Log 
            -> master_log_pos=xxx for channel='master1'; # vi tri cua file log
        start slave; # Bat che do slave
        show slave status\G # Kiem tra trang thai
        ```

    - Sau đó có thể hiển thị trạng thái của Semi-Sync :

    ```bash
    show status like 'rpl_semi_sync%';
    ```

    Kết quả nhận được có dạng như sau :

    ```bash
    +----------------------------+-------+
    | Variable_name              | Value |
    +----------------------------+-------+
    | Rpl_semi_sync_slave_status | ON    |
    +----------------------------+-------+
    1 row in set (0.01 sec)
    ```

    Nếu nhận được `Rpl_semi_sync_slave_status` ở trạng thái On thì việc thiết lập Semi-Sync giữa 2 server đã thành công !

---

### Tài liệu tham khảo :

[MySQL :: MySQL 8.0 Reference Manual :: 17 Replication](https://dev.mysql.com/doc/refman/8.0/en/replication.html)

[Sync two MySQL databases in two different locations](https://dba.stackexchange.com/questions/65351/sync-two-mysql-databases-in-two-different-locations)

[MySQL :: MySQL Workbench Manual :: 9.5.1 Database Synchronization](https://dev.mysql.com/doc/workbench/en/wb-database-synchronization.html)

[How To Set Up Master Slave Replication in MySQL | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-master-slave-replication-in-mysql)

[How to Configure MySQL 8.0 Master Slave Replication on Ubuntu 18.04 | ComputingForGeeks](https://computingforgeeks.com/how-to-configure-mysql-8-0-master-slave-replication-on-ubuntu-18-04/)

[MySQL Replication for High Availability - Tutorial](https://severalnines.com/resources/database-management-tutorials/mysql-replication-high-availability-tutorial)

[MySQL: chained replication M1>S1>S2 - Supportex.NET blog](https://supportex.net/blog/2011/11/mysql-chained-replication-m1s1s2/)

[MySQL 5.7 multi-source replication](https://www.percona.com/blog/2013/10/02/mysql-5-7-multi-source-replication/)

[What is the difference between binlog-do-db and replicate-do-db?](https://stackoverflow.com/questions/44431961/what-is-the-difference-between-binlog-do-db-and-replicate-do-db)

[MySQL Circular Replication](https://icicimov.github.io/blog/high-availability/database/MySQL-Circular-Replication/)

[MySQL :: MySQL 5.7 Reference Manual :: 21 MySQL NDB Cluster 7.5 and NDB Cluster 7.6](https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster.html)

[Establish Semi-Synchronous Replication](http://mysql.wingtiplabs.com/documentation/sem40sk7/establish-semi-synchronous-replication.html)