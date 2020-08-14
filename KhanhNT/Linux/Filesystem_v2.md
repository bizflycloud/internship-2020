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
####1. df (disk filesystems):
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
- Đơn vị mặc định là bytes
- 

