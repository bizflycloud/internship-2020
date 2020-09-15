# Filesystem Hierarchy Standard (FHS)
## 1. Khái niệm:
- Là 1 tiêu chuẩn thiết kế các thư mục trong hệ thống các distribute Linux.
- Mục đích tạo ra:
  + Giúp các phần mềm khi cài đặt có thể đoán được nơi lưu trữ các file hay thư mục của mình.
  + Giúp người dùng đoán được nơi lưu trữ các file hay thư mục.

## 2. Thuộc tính file
- FHS chia các file theo 2 thuộc tính:
  + Shareable hoặc unshareable.
  
`và`
 
  + Variable hoặc static.

### 2.1 Shareable files and Unshareable files
- __Shareable files__: Là những file được lưu ở host này nhưng có thể được `share`, `access` ở host khác.
- __Unshareable files__: Là những file phải nằm trên hệ thống của nó thì mới được sử dụng.

Example:
- Thư muc chứa Shareable files: 
  +  `/home`
  + `/var/www`
  + `opt`
- Thư mục chứa Unsharesable files:
  + `/etc`
  + `/var/lock`
  + `boot`

### 2.2 Static và Variable file
- __Static__: Gồm các file binaries, libraries, documention files hay tất cả các file không thể bị thay đổi nội dung nếu không có users với quyền admin ca thiệp.
- __Variable__: Các file được tạo ra, có thể thay đổi bởi Users hoặc system process.

## 3. Phân bố thư mục trong hệ thống

![](https://camo.githubusercontent.com/bd567bd1fe568d2ab5c1e3f059a85a8d8f484dd7/687474703a2f2f696d6775722e636f6d2f6b647135594f4a2e6a7067)

- `/bin`: 
  + Là thư muc chứa file `bin`aries tức là những command cở bản, chủ yếu của hệ thống. 
  + Những command có thể được sử dụng trong Single User Mode. 
  + 1 số command: `cat`, `chgrp`, `cp`, `date`,...
- `/boot`:
  + Chứa các file cần thiết cho quá trình khởi động hệ thống.
- `/dev`:
  + Chứa các `dev`vices files. (/dev/disk0, /dev/sda1,...)
  +  `/dev/null`: NULL device, thiết bị sẽ bị bỏ qua mọi dữ liệu ghi vào nó.
- `/etc`: `etc`etera dictonory  
  + Chứa các file config cho những phần mềm thuộc về hệ thống hiện tại. 
  + Configure file là file dùng để điều khiển hoạt động của 1 chương trình.
  + Là 1 __static file__ , file binary không thể thực thi.
  + Chứa các shell scripts để khởi động hoặc tắt chương trình khác VD: `/etc/resolve.conf, sysctl.conf`. 

- `/home`:
  + Chứa các file, personal settings cảu người dùng.

- `/lib`: 
  + Thư mục chứa các file libraries cần thiết cho việc boot hệ thống.
  + Thực thi các câu lệnh bên trong `/bin` và `/sbin`.

- `/media`
   + Thư mục nơi mount các thiết bị như `floppy` (đĩa mềm), `cdrom`(ổ đĩa CD)...

- `/mnt`
   + Thư mục chứa filesystem được mount tạm thời.

- `/opt`
   + `opt`ional cài đặt các packages cho add-on application software.
   + Nếu muốn xóa phần mềm trong `opt` chỉ cần xóa thư mục của phần mềm đó.

- `/proc`
 + `Proc`ess chứa các process đang chạy hoặc thông tin về kernel ở dạng files.
 + Example: `cat /proc/cpuinfo` để xem thông số CPU.

- `/root`
 + Thư mục home của root.

- `/run`
  + Chứa thông tin về hệ thông đang chạy.
  + Những file trong này thường remove hoặc truncate khi hệ thống được boot lại. 

- `/sbin`
  + Chứa các file binary command của hệ thống.
  + `/sbin` thư mục thường dành cho `superuser` (tức là cần đến quyền root để thực thi. 
   Example: `cron`, `sshd`, useradd`, `userdel`.

- `/srv`
  + `s`e`rv`ices là thư mục cung cấp ra bên ngoài bởi hệ thống.
  + Có thể là các data hay scripts cho web servers, data cung cấp bởi FTP server.

- `sys`
  + `sys`tem chứa các thông tin về devices, drivers.
   + Chứa các file hệ thống.

- `/tmp`
   + `t`e`mp`oary chứa các file tạm thời.
   + Sinh ra bởi chương trình đã và đang chạy. 

- `/var`
   + Thư mục chứa `var`iable files - những file mà  thay đổi liên tục trong quá trình vận hành hệ thống (file logs, lock file,..._
  
- `/usr`: Unix System Resources 
    + Chứa hầu hết các dữ liệu read-only và shareable user data.

## 4. Phân biệt `/bin`, `/sbin`, `/usr/bin`, `/usr/sbin`, `/usr/local/bin`, `/usr/local/sbin`
- `/usr/sbin`: dành cho quản trị cả hệ thống.
- `/usr/local`: Phiên bản thu nhỏ của `usr`.
- `/usr/local` giúp người dùng tự cài đặt những phần mềm của họ viết ra không bị conflict với hệ thống hay phiên bản khác. 

## 5 Phân biệt `/tmp` và `/var/tmp`
- `/tmp`: lưu các file tạm mà bị clear sau mỗi lần reboot. 
- `/var/tmp`: không bị xóa giữa các lần reboot.  
