# Manager files and Filesystems

## 1. Check file system: `fsck`
- `fsck [option] [partition]`
- Dùng để kiểm tra và sửa lỗi Linux filesystem
- -A:Duyệt khắp tập tin /etc/fstab và kiểm tra tất cả các hệ thống tập tin trong 1 lần duyệt.
- -V: chế độ chi tiết, cho biết fsck đang làm gì
- -t: xác định hệ thống tập tin cần kiểm tra
- -a: Tự động sửa chữa hệ thống tập tin.
- -l: Liệt kê tất cả các tên tập tin trong hệ thống tập tin
- -r: hỏi trước khi sửa chữa hệ thống tập tin

## 2. Monitoring Disk: `df`, `du`
#### 1. df (disk filesystems):
- -a: Hiển thị tất cả thông tin dung lượng ổ đĩa đã đọc.
- -h: Hiển thị thông tin ổ đĩa theo định dạng dễ đọc
- -hT /home/: Hiển thị dung lượng của /home/
- -k: Hiển thị theo byte
- -m: Hiển thị theo megabyte
- -i: Hiển thị thông tin Inode của filesystem

- **inode**
  - index node trong filesystem của linux
  - inode xác định file và thược tính cảu file
  - Nó Lưu các thông tin sau của file:
     +  Loại file
     + Permissions
     + Chủ sở hữu
     + Nhóm
     + Kích thước file
     + Thời gian truy cập, thay đổi, sửa đổi file
     + Thời gian file bị xóa
     + Số lượng liên kết
     + Thuộc tính mở rộng
     + Danh sách truy cập file
- -Th: hiển thị tất cả các loaị filesystems

#### 2. du (disk usage) 
- Báo các tập tin trên đĩa được sử dụng bởi các tập tin và thư mục
- `du <option> <file>`
- `du <option> <path|file>
- `du <option> <path1> <path2> <path3>`
- Đơn vị mặc định là bytes

### 3. Creating filesystems: `mkfs`
- `mkfs <option> Devicename (partition)`
- `-t`: Chỉ định type cho hệ thống. Nếu không chỉ định type thì mặc định là ext2.
- `-c`: trước khi tạo file hệ thống thì tiến hành check bad block.
- Định dạng cho partition bằng command: 
 + mkfs.ext4 <new_partition>

### 4. Mounting and Unmounting Filesystems:
-  Linux có thể truy cập/sử dụng các thiết bị phân vùng ổ cứng, các tài nguyên qua mạng, trước hết các thiết bị này phải được __mount__ vào 1 thư mục trống (gọi là mount point). 
- Khi muốn tháo gỡ thiết bị đang hoạt động khỏi hệ thống thì phải unmount. 
- Toàn bộ mount trong hệ thống lưu trong /etc/fstab.
- mount -t <fstype> -o <options> <device> <mount_point>
- Liệt kệ các file system được mount
   + `mount` 
   + cat /etc/mtab
-  `umount <mount point> hoặc <device>`
- /etc/fstab đọc khi hệ thống khởi động

### 5. Partitioning Disks
- Phân vùng nhỏ (phân vùng logic) được chia ra từ  ổ cứng vật lí.
- 1 ổ cứng có thể có 1 hoặc nhiều partition
- 3 loại partition
   + Primary partition: phân vùng dùng để boot hệ điều hành
   + Extended partition: vùng dữ liệu còn lại khi ta phân chia các primary partition, extended partition chứa các logical partition trong đó.
   + Logical partition: nằm trong extended partition, dùng để chứa dữ liệu.

#### fdisk
- Công cụ phân chia phân vùng ổ đĩa
- `fdisk -l dev/sdb` : Kiểm tra phân vùng ổ đĩa
- `fdisk /dev/sdb`: Tiến hành phân vùng
- Phím m nếu muốn hiển thị danh sách command hõ trợ

![](https://vinasupport.com/uploads/2019/09/fdisk-Help-Menu.png)

- n: tạo phân vùng mới
- d: xóa phân vùng
- q: xóa mà không làm thay đổi
- u: lưu thay đổi

