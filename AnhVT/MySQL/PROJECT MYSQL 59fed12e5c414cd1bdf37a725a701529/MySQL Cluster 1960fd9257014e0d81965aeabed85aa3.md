# MySQL Cluster

![MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled.png](MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled.png)

---

# NDB Cluster Overview

![MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%201.png](MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%201.png)

## Ý tưởng cốt lõi

![MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/NDB_Core.png](MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/NDB_Core.png)

- NDB Cluster Engine lưu trữ dữ liệu trong bộ nhớ cung cấp khả năng HA+ LB
- Các phần tử của cluster được gọi là 1 Node và độc lập vs nhau
- Node = Process, có thể có nhiều Node trên 1 server
- Phân loại các node trong NDB Cluster
    1. NDB_MGMD : Cung cấp khả năng quản lý các Node
    2. Data Node: Node lưu trữ dữ liệu được đồng bộ hóa ( synchronized )
    3. SQL Node : Node có khả năng truy cập dữ liệu, về cơ bản là 1 MYSQL API
- Config Cluster được thực hiện tại các Node( Giả thiết các data node đồng bộ về mặt vật lý)
- NDB_MGMD có config tổng hợp của Cluster. Có lỗi → NDB_MGMD ghi vào cluster log
- Về mặt cơ bản không giới hạn về các Node ( MGMD , NDBD , SQL )
- **MySQL clients**: là các API thực hiện yêu cầu dữ liệu từ MySQL server và nhận được dữ liệu
- **NDB clients prog**: là các API bậc cao, không qua MySQL server → truy cập thẳng vào data
    - Hỗ trợ Java, Nodejs
- **Logs**: Được chia theo: kiểu loại, ưu tiên, độ nghiêm trọng. 2 loại log
    1. Cluster log: Giữ lại bản ghi của các sự kiện ảnh hưởng đến cluster
    2. Node log: log riêng của từng node
- **Check point**: Khi dữ liệu được ghi tại disk được gọi là Checkpoint. Được chia làm 2 loại:
    1. LCP ( Local ) : Xảy ra tại các node, xảy ra tại các khoảng thời gian khác nhau tùy thuộc node
    2. GCP (Global) : Xảy ra mỗi khi dữ liệu đồng bộ giữa các node.

## Nodes, Node Groups, Replicas, and Partitions

- **Data Node** : `ndbd` hoặc `ndbmtd`, chạy tại các replica, thuộc 1 node group, sao chép phân mảnh
    - Có thể host nhiều data node trên 1 server nhưng không được khuyến nghị
- **Node group** : Bao gồm 1 hoặc nhiều node , hoặc các set replica với nhau
    - Việc config thông qua `NoOfReplica` trong `[ndb_default]`
    - Giả sử có 4 `ndbd` → Group = 4 / `NoOfReplica` = 1.
    - `NoOfReplica` = 2 → Group = 2
    - Số lượng node trong các group phải cân bằng
    - Số lượng Node group max = 48 trong 1 cluster
- **Partition:** Phần dữ liệu lưu trữ tại các Cluster. Được quyết định bởi thông số `MaxNoOfExecutionThreads`
    - Mặc định với `ndbd` là 1
    - Với `ndbmtd` có thể set được nhiều hơn 1
- **Replica** : Phần copy của partition trên các node. 1 node có thể có 1 hay nhiều replica khác nhau
- Ví dụ với mô hình

![MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%202.png](MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%202.png)

- 1 Group có thể sao chép nhiều các partition khác nhau
- Mỗi partition có thể chọn node làm primary node và các node còn lại làm backup

    Cơ chế ?

![MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%203.png](MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%203.png)

- Với mỗi Node group thì việc có 1 node hoạt động là đủ để cluster hoạt động
- Nếu toàn bộ node trong group offline → mất partition → mất dữ liệu.

---

# NDB Cluster Replication

- NDB Cluster hỗ trợ sao chép không đồng bộ ( aka Replication )
- Mô hình cơ bản : Master - Slave . Slave nhận dữ liệu từ Master
- Mô hình NDB Cluster : Ý tưởng cơ bản giống như vậy nhưng có thêm các cấu hình phức tạp
- Việc sao chép không bắt buộc phải chạy engine NDB Cluster
- Xét mô hình:

    ![MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%204.png](MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%204.png)

    - Các thay đổi trong cluster được NDB Binary Log ghi lại và sao chép.
- **NDB API replica status variables**: Cung cấp các thông số giám sát tại cluster replica.
    - Giám sát được ảnh hưởng tới các table sau khi thực hiện các lệnh
- **Replication from NDB to non-NDB tables:** Có thể sao chép Table giữa các engine khác nhau( InnoDB,MyISAM,..) dựa trên 1 số điều kiện.

## Yêu cầu

- Yêu cầu 2 server ( 1 Source - 1 Replica ). Ví dụ 2 replica channel → 4 server ( 2 master 2 replica )
- Các server có các ID khác nhau không trùng lặp ( Xét trên toàn bộ hệ thống )
- Các Mysqld có khả năng hoạt động với nhau (sử dụng cùng phiên bản NDB cluster )
- Phương án tốt nhất là các node nằm trong 1 VPN bảo mật với mạng bên ngoài
- Các node cần kết nối với nhau để trao đổi thông tin → Độ trễ ảnh hưởng tới performance
    - Trong mạng LAN độ trễ sẽ lớn hơn → set up thời gian timeout lớn hơn

## Giải pháp khi gặp xung đột

[NDB Conflict Resolve](https://www.notion.so/NDB-Conflict-Resolve-79b4820fd8394817807da55a6cda7743)

---

# Cài đặt mô hình NDB Cluster

![MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%205.png](MySQL%20Cluster%201960fd9257014e0d81965aeabed85aa3/Untitled%205.png)

## Giới thiệu

Mô hình MySQL Cluster (v8.0.21) cung cấp cho người dùng khả năng High Availability cùng với khả năng quản lý thông qua `ndb_mgmd` ( Management Server ) để quản lý các Node dữ liệu ( Data Node ). Các API sau khi giao tiếp với `ndb_mgmd` thì các API có thể thông qua MySQLd để truy cập dữ liệu ( Có 1 số API được thiết kế đặc biệt có khả năng truy cập thẳng vào cơ sở dữ liệu )

Trong MySQL Cluster các Node dữ liệu sẽ thực hiện đồng bộ hóa dữ liệu với nhau. Và vì vậy cần phải sử dụng 1 engine riêng biệt để làm điều này là NDB. Các thành phần trong MySQL NDB Cluster về cơ bản thì nên độc lập hoàn toàn về phần cứng ( Share-nothing-architecture) cùng với 1 đường truyền ổn định để tránh độ trễ.

Ở đây chúng ta cần hiểu 1 Node trong NDB Cluster chỉ là 1 tiến trình ( Process ) vì vậy nên hoàn toàn có thể tiến hành cài đặt nhiều các thành phần trên cùng 1 server. 

Vì việc giao tiếp giữa các Node dữ liệu là hoàn toàn không được bảo vệ nên người sử dụng nên đảm bảo Cluster nên ở trong 1 VPN độc lập với bên ngoài tránh sự tấn công để đánh cắp dữ liệu người dùng

Phần ở dưới đây chúng ta sẽ dựng mô hình bao gồm 1 máy chủ quản lý ( `ndb_mgmd` ) và 2 Node dữ liệu ( `ndbd` ) và 1 MySQL ( API ) trực tiếp trên máy chủ ( Ở cuối sẽ hướng dẫn cài đặt thêm 1 server  API riêng khác )

## Yêu cầu

1. Ubuntu v18.04 và kiến thức cơ bản về cài đặt gói tin cũng như các thao tác cơ bản trên Ubuntu
2. 4 ( hoặc 3 nếu bạn không muốn cài đặt 1 server riêng để chạy API )  server để tiến hành xây dựng mô hình
- Các gói `.deb` có thể tải tại trang chủ:

[MySQL :: Download MySQL Cluster](https://dev.mysql.com/downloads/cluster/)

**Chú ý : Để tránh xung đột, người sử dụng nên cân nhắc xóa cài đặt các bản MySQL cũ trên máy.**

- Có thể thông qua quy trình sau để xóa cài đặt `MySQL` trên máy:

```bash
apt-get -f install -o Dpkg::Options::="--force-overwrite"
apt-get purge mysql\*
rm -rf /var/lib/mysql
rm -rf /etc/mysql
apt-get clean
updatedb
dpkg -l | grep -i mysql *Thuc hien tim kiem cac goi mysql de xoa 
sudo apt-get purge xxx *Sau do thuc hien xoa qua lenh nay
```

## Bước 1 : Tiến hành cài đặt Node quản lý ( Management Server - `ndb_mgmd` )

- Đầu tiên chúng ta cần tải gói `DEB Package, NDB Management Server` ( Tùy vào thời gian mà sẽ có số hiệu phiên bản khác nhau và lưu ý phiên bản chúng ta sử dụng không có phần `sym`)
    - Sử dụng `wget` để tiến hành tải : `wget [https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-management-server_8.0.21-1ubuntu18.04_amd64.deb](https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-management-server_8.0.21-1ubuntu18.04_amd64.deb)`
- Tiến hành cài đặt thông qua `dpkg`

```bash
sudo dpkg -i mysql-cluster-community-management-server_8.0.21-1ubuntu18.04_amd64.deb
```

- Sau khi việc cài đặt hoàn tất việc tiếp theo là thực hiện cấu hình cho server quản lý:

```bash
sudo mkdir /var/lib/mysql-cluster
sudo nano /var/lib/mysql-cluster/config.ini
```

```bash
[ndbd default]
NoOfReplicas=2  # So Data Node

[ndb_mgmd]
hostname=xxxxxxxx # Dia chi Server quan li
datadir=/var/lib/mysql-cluster  # Duong dan du lieu

[ndbd]
hostname=xxxxxxxx # Dia chi Data Node
NodeId=2            # NodeID - Neu bo trong thi ndb_mgm se tu dong cap nhat 
datadir=/usr/local/mysql/data   # Duong dan du lieu

[ndbd]
hostname=xxxxxxxx
NodeId=3           
datadir=/usr/local/mysql/data   

[mysqld] # MySQL( API )
hostname=xxxxxxxx 
```

- Tiến hành lưu lại file config và cập nhật `ndb_mgmd` để sử dụng file config này thông qua lệnh:

```bash
sudo ndb_mgmd --initial --config-file=/var/lib/mysql-cluster/config.ini
```

- Tiếp đó thực hiện cài `ndb_mgmd` làm service với `systemd` :

```bash
sudo pkill -f ndb_mgmd
sudo nano /etc/systemd/system/ndb_mgmd.service
```

```bash
[Unit]
Description=MySQL NDB Cluster Management Server # Thong tin ve service
After=network.target auditd.service #Khoi dong sau khi 2 dich vu duoc liet ke

[Service]
Type=forking # Tien hanh Fork tien trinh con va sau do thoat tien trinh Parent 
ExecStart=/usr/sbin/ndb_mgmd -f /var/lib/mysql-cluster/config.ini # Load config khi khoi dong
ExecReload=/bin/kill -HUP $MAINPID #Thu tuc tien hanh Reload
KillMode=process #Tien hanh Kill tien trinh khi can 
Restart=on-failure #Dieu kien Restart

[Install]
WantedBy=multi-user.target # Co the su dung boi cac user khac nhau

```

- Khởi động lại dịch vụ để cập nhật các thay đổi

```bash
sudo systemctl daemon-reload
sudo systemctl enable ndb_mgmd
sudo systemctl start ndb_mgmd
```

## Bước 2 : Tiến hành cài đặt Data Node

- Đầu tiên chúng ta cần tải gói `DEB Package, NDB Data Node Binaries` ( Tùy vào thời gian mà sẽ có số hiệu phiên bản khác nhau và lưu ý phiên bản chúng ta sử dụng không có phần `sym`)
    - Sử dụng `wget` để tiến hành tải : `wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-data-node_8.0.21-1ubuntu18.04_amd64.deb`
- Tiến hành update đường dẫn và 1 số thư viện đi kèm:

```bash
sudo apt update
sudo apt install libclass-methodmaker-perl
```

- Cài đặt thông qua `dpkg`

```bash
dpkg -i mysql-cluster-community-data-node_8.0.21-1ubuntu18.04_amd64.deb
```

- Sau khi cài đặt xong cần tiến hành cấu hình Data Node để có thể kết nối tới `ndb_mgmd`:

```bash
sudo nano /etc/my.cnf
```

```bash
[mysql_cluster]

ndb-connectstring=xxxx  # Dia chi cua Management Server
```

- Sau đó tạo đường dẫn để có thể lưu lại các log cũng như dữ liệu

```bash
sudo mkdir -p /usr/local/mysql/data
```

- Chạy thử tiến trình `ndbd` :

```bash
sudo ndbd
```

kết quả nhận được có dạng như sau :

```bash
2018-07-18 19:48:21 [ndbd] INFO     -- Angel connected to 'xxxxxx:1186'
2018-07-18 19:48:21 [ndbd] INFO     -- Angel allocated nodeid: 2
```

- Sau đó cài đặt `ndbd` làm service cho `systemd` :

```bash
sudo pkill -f ndbd
sudo nano /etc/systemd/system/ndbd.service
```

```bash
[Unit]
Description=MySQL NDB Data Node Daemon
After=network.target auditd.service

[Service]
Type=forking
ExecStart=/usr/sbin/ndbd
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

- Restart lại dịch vụ để cập nhật các thay đổi :

```bash
sudo systemctl daemon-reload
sudo systemctl enable ndbd
sudo systemctl start ndbd
```

## Bước 3 : Tiến hành cài đặt MySQL API

- Tiến hành tải và cài đặt các gói tin sau từ trang chủ, việc tải và cài đặt giống với 2 phần trước đó, lưu ý quá trình cài đặt cần theo thứ tự như dưới :

```bash
mysql-common_8.0.21-1ubuntu18.04_amd64.deb
mysql-cluster-community-client-core_8.0.21-1ubuntu18.04_amd64.deb
mysql-cluster-community-client_8.0.21-1ubuntu18.04_amd64.deb
mysql-client_8.0.21-1ubuntu18.04_amd64.deb
mysql-cluster-community-server-core_8.0.21-1ubuntu18.04_amd64.deb
mysql-cluster-community-server_8.0.21-1ubuntu18.04_amd64.deb
mysql-server_8.0.21-1ubuntu18.04_amd64.deb
```

- Sau khi cài đặt phần `mysql-cluster-community-server_8.0.21-1ubuntu18.04_amd64.deb` sẽ yêu cầu mật khẩu cho user `root` để truy cập `MySQL` sau này.
- Để tiết kiệm thời gian cài đặt bạn có thể tải các gói tin trên và sau đó sử dụng:

```bash
dpkg -i *.deb
```

- Sau đó tiến hành cấu hình( Ở đây lưu ý khác với phần Data Node, file config này hoàn toàn có nhiệm vụ khác nhau, cần phải phân biệt rõ ) :

```bash
sudo nano /etc/mysql/my.cnf
```

Thêm phần sau vào cuối file config

```bash
[mysqld]
ndbcluster       # Chay engine NDB             

[mysql_cluster]
ndb-connectstring=xxxxx # Dia chi Management Server
```

- Restart lại dịch vụ `MySQL` :

```bash
sudo systemctl restart mysql
sudo systemctl enable mysql
```

## Bước 4 : Kiểm tra việc cài đặt

- Truy cập vào MySQL tại SQL node :

```bash
mysql - u root -p
SHOW ENGINE NDB STATUS\G
```

```bash
*************************** 1. row ***************************
  Type: ndbcluster
  Name: connection
Status: cluster_node_id=4, connected_host=xxxxx, connected_port=1186, number_of_data_nodes=2, number_of_ready_data_nodes=2, connect_count=0
```

- Nếu nhận được kết quả tương tự như trên thì việc cài đặt đã thành công
- Ngoài ra có thể sử dụng công cụ `ndb_mgm` để kiểm tra cũng như quản lý

```bash
ndb_mgm -e show
```

```bash
Connected to Management Server at: xxxxx:1186
Cluster Configuration
---------------------
[ndbd(NDB)] 2 node(s)
id=2    @xxxxxxxx  (mysql-5.7.22 ndb-7.6.6, Nodegroup: 0, *)
id=3    @xxxxxxxx  (mysql-5.7.22 ndb-7.6.6, Nodegroup: 0)

[ndb_mgmd(MGM)] 1 node(s)
id=1    @xxxxxxxx  (mysql-5.7.22 ndb-7.6.6)

[mysqld(API)]   1 node(s)
id=4    @xxxxxxxx  (mysql-5.7.22 ndb-7.6.6)
```

**LƯU Ý** : Khi tiến hành tạo database và table, nếu muốn sử dụng đầy đủ tính năng của Engine NDB thì khi tạo data cần phải thêm :

```bash
CREATE TABLE..... ENGINE=ndbcluster;
```

## Mở rộng : Thêm 1 API server vào trong mô hình

- Việc thêm tuy đơn giản nhưng lại yêu cầu theo 1 quy trình nhất định, để tránh gặp phải các lỗi không mong muốn bạn có thể tham khảo quy trình sau:
1. Việc cài đặt gói tin tương tự tại Bước 3 
2. Quy trình tiến hành thêm:
    1. Tiến hành dừng dịch vụ `ndb_mgmd`

        ```bash
        systemctl stop ndb_mgmd
        ```

    2. Chỉnh sửa file Config của Server quản lý:
        - Thêm vào cuối file config tại `/var/lib/mysql-cluster/config.ini` :

            ```bash
            [mysqld] # MySQL( API )
            hostname=xxxxxxxx 
            ```

        - Cập nhật lại file `config.ini` cho Server quản lý:

        ```bash
        sudo ndb_mgmd --initial --config-file=/var/lib/mysql-cluster/config.ini
        ```

    3. Sau đó tại server API thứ 2, tạo file cấu hình:

        ```bash
        sudo nano /etc/mysql/my.cnf
        ```

        ```bash
        [mysqld]
        ndbcluster       # Chay engine NDB             

        [mysql_cluster]
        ndb-connectstring=xxxxx # Dia chi Management Server
        ```

        ```bash
        sudo systemctl restart mysql
        sudo systemctl enable mysql
        ```

    4. Quay trở lại Server quản lý :

        ```bash
        systemctl start mysql
        ```

        Kiểm tra lại qua `ndb_mgm -e show` , kết quả nhận được có dạng tương tự:

        ```bash
        [ndbd(NDB)]	2 node(s)
        id=2	@xxxxxxxxxx  (mysql-8.0.21 ndb-8.0.21, Nodegroup: 0)
        id=3	@xxxxxxxxxx  (mysql-8.0.21 ndb-8.0.21, Nodegroup: 0, *)

        [ndb_mgmd(MGM)]	1 node(s)
        id=1	@xxxxxxxxxx (mysql-8.0.21 ndb-8.0.21)

        [mysqld(API)]	2 node(s)
        id=4	@xxxxxxxxxxx  (mysql-8.0.21 ndb-8.0.21)
        id=5	@xxxxxxxxxxx (mysql-8.0.21 ndb-8.0.21)
        ```

# Chúc bạn thành công 😇 !

## Nguồn tham khảo

[How To Create a Multi-Node MySQL Cluster on Ubuntu 18.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-create-a-multi-node-mysql-cluster-on-ubuntu-18-04#step-3-%E2%80%94-configuring-and-starting-the-mysql-server-and-client)

[MySQL :: MySQL 8.0 Reference Manual :: 22 MySQL NDB Cluster 8.0](https://dev.mysql.com/doc/refman/8.0/en/mysql-cluster.html)

[MySQL :: MySQL Forums](https://forums.mysql.com)