# ADMINISTERING SYSTEM

![ADMINISTERING%20SYSTEM%206e6b1486d3044c42b64bc37433310e11/Untitled.png](ADMINISTERING%20SYSTEM%206e6b1486d3044c42b64bc37433310e11/Untitled.png)

Ngày nay, các quản trị viên ngày càng cần phải chú trọng đến quy trình quản lý hệ thống cùng với đó là những công cụ hỗ trợ quản lý để tạo sự thiện tiện cũng như tiết kiệm thời gian. Thông qua bài viết này chúng ta sẽ có cái nhìn cơ bản về quản lý user, group trên hệ thống và 1 vài công cụ backup hỗ trợ cho nguời quản trị.

# 1. Quản lý User và Group

Mỗi khi thực hiện giao tiếp với các hệ điều hành Linux thì người sử dụng cần có 1 tài khoản ( user ) được cung cấp ( có thể cần mật khẩu ). Quản trị viên hoặc người dùng `root` có khả năng tạo , xóa hoặc chỉnh sửa các quyền của bất kì 1 user cụ thể nào nhằm quản lý cũng như đảm bảo vận hành hệ thống. 

Mỗi user sẽ được liên kết với 1 UID ( User ID ) → Mỗi khi đăng nhập thì thì hệ thống sẽ hiểu đã được đăng nhập với 1 UID nhất định chứ không phải là tên user người dùng được cung cấp. Đồng thời mỗi user sẽ thuộc vào 1 Group nhất định ( Điều này có thể được thay đổi bởi `root` ). 

Dưới đây sẽ là 1 số thao tác cơ bản để quản trị viên quản lý các user cũng như các group trong hệ thống 

## 1.2 Các thao tác với User

### 1.2.1 Tạo User trên hệ thống

Trước khi bắt đầu chúng ta cần phải chạy dưới quyền user `root` thống qua lệnh `sudo -s` 

Việc thực hiện tạo user khá đơn giản và có cú pháp :

```bash
useradd user -m -s /bin/bash
```

Bạn sẽ thay : `user` bằng tên user muốn tạo. Trong đó option: `-m` có tác dụng tạo đường dẫn home của user trong `/home` và option `-s` sẽ xác định loại shell user sẽ sử dụng. Ngoài ra còn một số option hữu ích khác có thể tham khảo trong `useradd --help`.

Sau đó để tăng tính bảo mật ta sẽ sẽ đặt thêm mật khẩu cho user:

```bash
root@Localhost:/home$ sudo passwd user
New password: 
Retype new password: 
passwd: password updated successfully
```

Cần lưu ý trong quá trình tạo user thì thông tin về user sẽ được thêm vào  `/etc/passwd` và `/etc/shadow` , `/etc/group`  sẽ được tạo, trong đó :

- `/etc/passwd` : Nơi lưu thông tin login của user, được chia làm 7 phần

    ![ADMINISTERING%20SYSTEM%206e6b1486d3044c42b64bc37433310e11/Untitled%201.png](ADMINISTERING%20SYSTEM%206e6b1486d3044c42b64bc37433310e11/Untitled%201.png)

    - UID : User ID
    - GID : Group ID
- `/etc/shadow` : Nơi lưu hash password ( mật khẩu đã được mã hóa )  của người dùng
- `/etc/group` : Nơi lưu thông tin về các group trên hệ thống

### 1.2.2 Xóa User trên hệ thống

Việc xóa User được thực hiện như sau

```bash
userdel -r user
```

Với option `-r` sẽ giúp chúng ta xóa đường dẫn home của user. Sau đó bạn có thể vào đường dẫn `/home` để kiểm tra 1 lần hoặc đến `/etc/passwd` để xác nhận user đã biến mất trên hệ thống

```bash
	cat /etc/passwd | grep user 
```

## 1.3 Quản lý các Group :

### 1.3.1 Thực hiện thêm user vào Group :

Việc thêm user xác định vào group được thực hiện với 1 trong 2 cách sau :

```bash
usermod -a -G root user
```

```bash
usermod -g root user
```

Trong đó cách đầu tiên sẽ chỉ thêm `user` vào group `root` mà không thay đổi group chính của `user` bởi ta đã sử dụng 2 option `-a` ( append ) và `-G` ( Đây chính là option quyết định điều đó ).

Ngược lại là cách 2 ta đã sử dụng option `-g` khiển cho group chính của user bị thay đổi

### 1.3.2 Thực hiện xóa 1 Group :

Thông qua lệnh (Trong đó `error_group` là group bạn muốn xóa ):

```bash
groupdel error_group
```

Sau đó người sử dụng có thể truy cập vào `/etc/group` để xác nhận lệnh.

```bash
	cat /etc/group | grep error_group
```

# 2. Các lệnh thay đổi quyền sở hữu

## 2.1 Lệnh `Chown` và `Chgrp` :

`Chown` là viết tắt của Change-Owner → Thay đổi chủ sở hữu của 1 file trên hệ thống. Trong đó việc thực hiện sẽ có cú pháp như sau:

1. Đầu tiên liệt kê các  file để xem quyền truy cập 

    ```bash
    root@virtual-machine:/home/user/Desktop# ls -l
    total 12
    drwxrwxr-x 5 user user 4096 Thg 8  21 16:21 LinuxVcc
    -rw-rw-r-- 1 user user  798 Thg 9   2 07:15 server.txt
    -rwxrwxr-x 1 user user  431 Thg 7  25 19:24 test.sh~
    ```

    → Ta có thể thấy file `server.txt` đang có chủ sở hữu ( owner ) là `user`

2. Thực hiện sử dụng lệnh `chown` để thay đổi quyền sở hữu với file `server.txt` :

    ```bash
    root@virtual-machine:/home/user/Desktop# chown root server.txt 
    root@virtual-machine:/home/user/Desktop# ls -al
    total 24
    drwxr-xr-x  4 user user 4096 Thg 9   2 07:15 .
    drwxr-xr-x 25 user user 4096 Thg 9  17 17:22 ..
    drwxrwxr-x  7 user user 4096 Thg 6  13 17:02 .git
    drwxrwxr-x  5 user user 4096 Thg 8  21 16:21 LinuxVcc
    -rw-rw-r--  1 root user  798 Thg 9   2 07:15 server.txt
    -rwxrwxr-x  1 user user  431 Thg 7  25 19:24 test.sh~
    root@vutuananh-virtual-machine:/home/vutuananh/Desktop#
    ```

    → Owner của file đã được chuyển thành root tuy nhiên cần lưu ý group sở hữu vẫn là user

    → Để thay đổi điều đó ta cần thay đổi một chút:

    ```bash
    root@virtual-machine:/home/user/Desktop# chown root:root server.txt 
    root@virtual-machine:/home/user/Desktop# ls -l
    total 12
    drwxrwxr-x 5 user user 4096 Thg 8  21 16:21 LinuxVcc
    -rw-rw-r-- 1 root      root       798 Thg 9   2 07:15 server.txt
    -rwxrwxr-x 1 user user 431 Thg 7  25 19:24 test.sh~
    ```

- Ngoài ra ta có thể thực hiện lệnh `Chgrp` với cú pháp như sau và có tác dụng tương đương với ví dụ ta xét ở trên

    ```bash
    chgrp root server.txt
    ```

Vậy ta có thể thấy việc thay đổi owner trong Linux khá đơn giản và chỉ cần vài thao tác cơ bản là bạn sẽ thành thạo sử dụng nó phục vụ nhu cầu sau này 

## 3. Crontab :

`Crontab` là 1 ứng dụng được tích hợp sẵn trên khá nhiều hệ điều hành được sử dụng để chạy các tác vụ đơn giản có tính lặp lại( backup log , ... ). 

Việc sử dụng `Crontab` được thực hiện như sau

```bash
crontab -e 
```

Nhận được kết quả ( mặc định ) :

```bash
# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
```

Giải thích ý nghĩa các cột

```bash
1.m : phut
2.h : gio
3.dom : Ngay trong thang
4.mon : Thang
5.dow : Ngay trong tuan ( 0 -> 6 / 1 - Thu 2 ; 2 - Thu 3 ; .. ; 0 - Chu nhat)
```

Xét ví dụ sau :

```bash
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
```

→ Ý nghĩa : Hệ thống sẽ tiến hành nén file `/var/backups/home.tgz` vào đường dẫn `/home` vào 5 sáng thứ 2 hàng tuần .

Ví dụ 2 :

```bash
15 3 * * * command
```

→ Command sẽ được chạy vào 3:15am hằng ngày .

Sau khi hoàn tất nhập các lệnh trên thì chúng ta cần khởi động lại crontab daemon để thực hiện sự thay đổi  :

```bash
/etc/init.d/crond restart
```

Thông qua 2 ví dụ trên chúng ta đã có nhìn tổng quan về chức năng của Crontab cũng như cách hoạt động của nó !

## 5. Backup hệ thống `rsnapshot` `rsync`

![ADMINISTERING%20SYSTEM%206e6b1486d3044c42b64bc37433310e11/Untitled%202.png](ADMINISTERING%20SYSTEM%206e6b1486d3044c42b64bc37433310e11/Untitled%202.png)

`rsync` là một công cụ vô cùng hữu ích bất kể với người dùng Linux mới bắt đầu hay với người đã sử dụng thành thạo có kinh nghiệm. `rsync` có rất nhiều công dụng khác nhau mà chúng ta sẽ cùng đi tìm hiểu. Nó tiết kiệm rất nhiều thiều gian cho người sử dụng hơn so với việc copy backup thủ công. Và đồng thời giữa 2 hệ thống có băng thông không được lớn thì việc sử dụng `rsync` sẽ vô cùng nhanh. Trong 1 thử nghiệm của `Chris Titus Tech` thì việc backup 100GB thì dữ liệu từ server remote chỉ mất hơn 5 phút. `rsync` thường được cài đặt sẵn trên rất nhiều bản Linux hiện nay. Và cùng với đó chúng ta sẽ tìm hiểu thêm cả vê `rsnapshot` ( dựa trên công nghệ của `rsync` ) 

### 5.1 `rsync`

Nếu server của bạn chưa có `rsync` thì có thể cài thông qua lệnh sau:

```bash
– Trên Red Hat/CentOS

yum install rsync

– Trên Debian/Ubuntu

apt-get install rsysnc
```

Cú pháp tổng quan của `rsync` :

```bash
rsync [optional modifiers] [SRC] [DEST]
```

**Các option thường được sử dụng**

```bash
-v: hiển thị trạng thái kết quả
-r: copy dữ liệu recursively, nhưng không đảm bảo thông số của file và thư mục
-a: cho phép copy dữ liệu recursively, đồng thời giữ nguyên được tất cả các thông số của thư mục và file
-z: nén dữ liệu khi transfer, tiết kiệm băng thông tuy nhiên tốn thêm một chút thời gian
-h: human-readable, output kết quả dễ đọc
--delete: xóa dữ liệu ở destination nếu source không tồn tại dữ liệu đó.
--exclude: loại trừ ra những dữ liệu không muốn truyền đi, nếu bạn cần loại ra nhiều file hoặc folder ở nhiều đường dẫn khác nhau thì mỗi cái bạn phải thêm --exclude tương ứng.
```

**Backup trên hệ thống hiện tại**

```bash
rsync -av ori/ bak/
```

`rsync` sẽ thực hiện copy các file từ thư mục `ori` sang thư mục `bak` . 

*Lưu ý: việc có dấu `/` sau ori sẽ có ảnh hưởng tới kết quả nhận được*

- Nếu có dấu `/` : `rsync` sẽ thực hiện copy các file thuộc vào thư mục `ori` tới thư mục `bak/`

    → kết quả nhận được có dạng: `/bak/[files]`

- Nếu không có dấu `/` : `rsync` sẽ thực hiện copy cả thư mục `ori` tới thư mục `bak`

    → kết quả nhận được có dạng : `/bak/ori/[files]` 

 **Backup file từ ssh**

Khi sử dụng backup file trên ssh thì ta cần thêm option `-e` 

Cùng với đó option `-P` sẽ hiện thị quá trình progress ra STDOUT của Terminal :

Với chiều từ Server → Local 

```bash
rsync -azveP ssh user@ip:/back/up /bak-server
```

Với chiều từ Local → Server

```bash
rsync -azveP ssh /sql-bak user@ip:/bak-db
```

**Sử dụng option  `- - delete`**

Nếu người sử dụng muốn xóa các file không thuộc thư mục gốc tại thư mục đích đơn giản chỉ cần thêm option `--detlete` . Tuy nhiên cần lưu ý khi sử dụng option này do nó có thể xóa những file không mong muốn → nên chạy thử trước với option `--dry-run` và `-v` để có thể xem trước được kết quả :

```bash
rsync -avhP --delete ori/ bak/
```

**Sử dụng option `--include` và `--exclude` :**

Hai option được sử dụng để người sử dụng có thể tùy chọn thư mục hoặc file mong muốn để đồng bộ dữ liệu. 

```bash
rsync -avze ssh --include 'R*' --exclude '*' root@192.168.0.101:/var/lib/rpm/ /root/rpm
```

Sẽ tiến hành đồng bộ những file bắt đầu với R và loại bỏ không đồng bộ những file còn lại

Tương tự với quá trình `--exclude` 

**Tự động xóa dữ liệu nguồn sau khi thực hiện đồng bộ :**

Bạn cần thêm option `--remove-source-files` khi thực hiện `rsync` khi muốn thực hiện yêu cầu này

```bash
rsync --remove-source-files -zvh backup.tar /tmp/backups/
backup.tar

sent 14.71M bytes  received 31 bytes  4.20M bytes/sec

total size is 16.18M  speedup is 1.10

ll backup.tar

ls: backup.tar: No such file or directory
```

**Việc sử dụng `rsync` đem lại vô cùng nhiều lợi ích đối với người sử dụng tùy vào nhu cầu và cũng hoàn toàn có thể kết hợp với crontab để tự động hóa quá trình này !** 

---

### 5.2 `rsnapshot` :

![ADMINISTERING%20SYSTEM%206e6b1486d3044c42b64bc37433310e11/Untitled%203.png](ADMINISTERING%20SYSTEM%206e6b1486d3044c42b64bc37433310e11/Untitled%203.png)

`rsnapshot` là 1 ứng dụng mã nguồn mở cho phép tạo snapshot của hệ thống tùy theo nhu cầu của người sử dụng ( theo giờ, ngày , .. )
`rsnapshot` sẽ tạo backup theo `hardlink` nên sẽ tiết kiệm không gian bộ nhớ của hệ thống hơn.Để hiểu rõ hơn về `hardlink` ta xét tới ví dụ sau:

```bash
du -csh /backup/rsnapshot/*
```

```bash
254G    /store/backup_athena/rsnapshot/daily.0
26G       /store/backup_athena/rsnapshot/daily.1
18G       /store/backup_athena/rsnapshot/daily.10
494M    /store/backup_athena/rsnapshot/daily.11
643M    /store/backup_athena/rsnapshot/daily.12
545M    /store/backup_athena/rsnapshot/daily.13
9.5G    /store/backup_athena/rsnapshot/daily.2
9.3G    /store/backup_athena/rsnapshot/daily.3
9.4G    /store/backup_athena/rsnapshot/daily.4
9.5G    /store/backup_athena/rsnapshot/daily.5
728M    /store/backup_athena/rsnapshot/daily.6
646M    /store/backup_athena/rsnapshot/daily.7
761M    /store/backup_athena/rsnapshot/daily.8
561M    /store/backup_athena/rsnapshot/daily.9
40G       /store/backup_athena/rsnapshot/monthly.0
709M    /store/backup_athena/rsnapshot/weekly.0
718M    /store/backup_athena/rsnapshot/weekly.1
1.5G    /store/backup_athena/rsnapshot/weekly.2
382G    total

```

Ở trường hợp này `hardlink` của `daily.1` là `daily.0` . File `daily.1` chỉ thực hiện backup những thay đổi so với `daily.0` 

⇒ Tiết kiệm dung lượng bộ nhớ hơn rất nhiều và đồng thời cũng thấy được 1 phần nào đó chức năng của `rsync` trong `rsnapshot` .

**Cài đặt `rsnapshot`**

Thường thì mặc định các hệ thống sẽ không tiến hành cài đặt `rsnapshot` vậy nên nếu có nhu cầu sử dụng, bạn sẽ phải cài đặt thông qua:

```bash
1.Debian/Ubuntu
sudo apt-get install rsnapshot

2.Redhat/Fedora
yum install rsnapshot

3.Archlinux
pacman -S rsnapshot
```

**Cấu hình `rsnapshot`**

Mặc định thì file cấu hình sẽ nằm ở trong `/etc/rsnapshot.cnf` ( có thể thay đổi tùy theo OS bạn đang sử dụng ) :

```bash
nano /etc/rsnapshot.conf
```

Nhận được kết quả như sau :

```bash

#################################################
# rsnapshot.conf - rsnapshot configuration file #
#################################################
#                                               #
# PLEASE BE AWARE OF THE FOLLOWING RULE:        #
#                                               #
# This file requires tabs between elements      #
#                                               #
#################################################
 
#######################
# CONFIG FILE VERSION #
#######################
 
config_version  1.2
 
###########################
# SNAPSHOT ROOT DIRECTORY #
###########################
 
# All snapshots will be stored under this root directory.
#
snapshot_root   /store/rsnapshot/
 
# If no_create_root is enabled, rsnapshot will not automatically create the
# snapshot_root directory. This is particularly useful if you are backing
# up to removable media, such as a FireWire or USB drive.
#
no_create_root  1#################################################
# rsnapshot.conf - rsnapshot configuration file #
#################################################
#                                               #
# PLEASE BE AWARE OF THE FOLLOWING RULE:        #
#                                               #
# This file requires tabs between elements      #
#                                               #
#################################################
 
#######################
# CONFIG FILE VERSION #
#######################
 
config_version  1.2
 
###########################
# SNAPSHOT ROOT DIRECTORY #
###########################
 
# All snapshots will be stored under this root directory.
#
snapshot_root   /store/rsnapshot/
 
# If no_create_root is enabled, rsnapshot will not automatically create the
# snapshot_root directory. This is particularly useful if you are backing
# up to removable media, such as a FireWire or USB drive.
#
no_create_root  1
.......
```

Tại đây bạn có thể tự thay đổi các tham số tùy vào nhu cầu sử dụng. Trong đó các tham số cơ bản như :

```bash
config_version 1.2 = Configuration file version
snapshot_root = Nơi lưu các snapshot
cmd_cp = Path -> copy command
cmd_rm = Path -> remove command
cmd_rsync = Path -> rsync
cmd_ssh = Path -> SSH
cmd_logger = Path to shell command interface to syslog
cmd_du = Path -> disk usage command
interval hourly = Số lượng backups theo giờ được giữ lại.
interval daily = Số lượng backups theo ngày được giữ lại.
interval weekly = Số lượng backups theo tuần được giữ lại.
interval monthly = Số lượng backups theo tháng được giữ lại.
ssh_args = Được sử dụng nếu port ssh thay đổi 
```

**Exclude File**

Đôi khi trong quá trình sử dụng, có 1 số file bạn không muốn `rsnapshot` back up nó. Bạn có thể sử dụng option sau :

```bash
############################################
#              GLOBAL OPTIONS              #
# All are optional, with sensible defaults #
############################################
 
# The include_file and exclude_file parameters, if enabled, simply get
# passed directly to rsync. Please look up the --include-from and
# --exclude-from options in the rsync man page for more details.
#
 
exclude_file   /path/to/exclude/file
```

Trong đó bạn thêm đường dẫn (Absolute Path ) tới file không muốn back up vào sau `exclude_file` 

**Remote backup**

Trong phiên bản hiện tại (v1.2 ), `rsnapshot` chưa hỗ trợ việc backup từ local → remote. Hay có nghĩa là bạn không thể chuyển backup từ máy đang sử dụng tới máy remote ( đặt biến `snapshot_root` ở trên server remote ) . Nhưng việc pull backup từ remote → local có thể được thực hiện qua lệnh :

```bash
##############################
### BACKUP POINTS / SCRIPTS ###
###############################
 
backup  root@xxxxxx:/etc/ my-remote1/
backup  root@xxxxxx:/data/    my-remote1/
```

*Khi thực hiện, thường thì `rsnapshot` yêu cầu kết nối ssh không có passphrase và 1 user có quyền chạy tương đương với root để cung cấp quyền chạy server.*

**Sau khi thực hiện bất kì thay đổi nào với file cnf của `rsnapshot` thì chúng ta nên kiểm tra lại thông qua**:

```bash
rsnapshot configtest
```

```bash
rsnapshot -t daily
# Dry-test hay còn gọi là chạy thử
```

**Chạy `rsnapshot` thủ công / tự động**

Do `rsnapshot` không có cơ cấu chạy tư động nên việc chạy cần phải được thực hiện thủ công.Được thực hiện qua lệnh sau :

```bash
rsnapshot hourly
rsnapshot daily
rsnapshot weekly
rsnapshot monthly
```

Tuy nhiên chúng ta hoàn toàn có thể dựa vào Crontab để tự động hóa quá trình này tương tự như các công việc khác trên Linux. Việc setup Crontab có dạng như sau:

```bash
0 * * * * root /usr/bin/rsnapshot hourly
45 5 * * 1 root /usr/bin/rsnapshot weekly
0 22 * * * root /usr/bin/rsnapshot daily
```

⇒ Trong đó có thể hiểu 3 câu lệnh như sau :

1. Vào mỗi giờ hàng ngày của tháng thì sẽ thực hiện chạy lệnh `rsnapshot hourly` với quyền root
2. Vào 5h45 thứ 2 hàng tuần thực hiện chạy lệnh `rsnapshot weekly` với quyền root
3. Vào 22h hằng ngày sẽ thực hiện chạy lệnh `rsnapshot daily` với quyền root

**Qua 1 vài ví dụ ta có thể thấy việc sử dụng `rsnapshot` là vô cùng tiện dụng cho phép chúng ta backup các file hệ thống vô cùng nhanh chóng và cũng có thể được thực hiện hóa 1 cách tự động qua Crontab**

---

## Nguồn tham khảo

[Group Management in Linux - GeeksforGeeks](https://www.geeksforgeeks.org/group-management-in-linux/)

[User and Group Management in Linux](https://www.pluralsight.com/guides/user-and-group-management-linux)

[Managing Users & Groups, File Permissions & Attributes and Enabling sudo Access on Accounts - Part 8](https://www.tecmint.com/manage-users-and-groups-in-linux/)

[How to Manage Users with Groups in Linux - Linux.com](https://www.linux.com/topic/desktop/how-manage-users-groups-linux/)

[Unix / Linux - User Administration](https://www.tutorialspoint.com/unix/unix-user-administration.htm)

[Linux Users and Groups](https://www.linode.com/docs/tools-reference/basics/linux-users-and-groups/)

[Beginners Guide to User and Group Administration in Linux](https://www.thegeekdiary.com/beginners-guide-to-user-and-group-administration-in-linux/)

[Group Management in Linux - GeeksforGeeks](https://www.geeksforgeeks.org/group-management-in-linux/)

[chgrp command in Linux with Examples - GeeksforGeeks](https://www.geeksforgeeks.org/chgrp-command-in-linux-with-examples/)

[Các lệnh chown command trong linux và cách sử dụng chúng](https://www.hostinger.vn/huong-dan/chown-command/)

[Tổng quát về crontab - Học VPS](https://hocvps.com/tong-quat-ve-crontab/)

[rsnapshot](https://rsnapshot.org/)

[Set Up Rsnapshot, Archiving Of Snapshots And Backup Of MySQL Databases On Debian](https://www.howtoforge.com/set-up-rsnapshot-archiving-of-snapshots-and-backup-of-mysql-databases-on-debian)

[How To Create Fast And Reliable Backup Using Rsnapshot - pontikis.net](https://www.pontikis.net/blog/howto-rsnapshot-backup)

[Rsnapshot (Rsync Based) - A Local/Remote File System Backup Utility for Linux](https://www.tecmint.com/rsnapshot-a-file-system-backup-utility-for-linux/)

[Rsync Backup on Linux](https://www.youtube.com/watch?v=OEfboN-Nb2s)

[Linux/Mac Terminal Tutorial: How To Use The rsync Command - Sync Files Locally and Remotely](https://www.youtube.com/watch?v=qE77MbDnljA)

[Rsync - Công cụ đồng bộ dữ liệu hiệu quả - Học VPS](https://hocvps.com/rsync/)

[Sử dụng Rsync đồng bộ thư mục trên Linux và Windows](https://xuanthulab.net/su-dung-rsync-dong-bo-thu-muc-tren-linux-va-windows.html)

[Lệnh Rsync Linux (Remote Synchronization): đồng bộ hóa từ xa](https://www.hostinger.vn/huong-dan/rsync-linux/)

[Rsync : command đồng bộ dữ liệu trên linux](https://viblo.asia/p/rsync-command-dong-bo-du-lieu-tren-linux-djeZ1R7YlWz)

[How To Use Rsync to Sync Local and Remote Directories on a VPS | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps)

[Rsync và những điều cần biêt](https://finalstyle.com/danh-cho-ky-thuat-vien/rsync-va-nhung-dieu-can-biet.html)

[Easy Automated Snapshot-Style Backups with Rsync](http://www.mikerubel.org/computers/rsync_snapshots/#Abstract)