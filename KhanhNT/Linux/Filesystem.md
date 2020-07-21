# 1. File system
File system dùng để quản lí cách dữ liệu được đọc và lưu trên thiết bị
![](https://blogd.net/linux/tong-quan-ve-filesystem-tren-linux/img/minh-hoa-cho-filesystem.png)

# 2. Các loại filesystem
+ Các lại cơ bản: EXT2, EXT3, XFS, JFS
+ Dành cho dạng lưu trữ Flash: thẻ nhớ
+ Dành cho hệ cơ sở dữ liệu
+ Dành cho mục đích khác

# 3. Phân vùng
+ Là 1 vùng chứa trong đó có 1 filesystem được lưu trữ

# 4. In LINUX
+ File system của LINUX được tổ chức theo tiêu chuẩn cấp bậc của Filesystem Hierarchy Standard (FHS)

/bin: Chứa các chương trình cơ bản (ls, cat, cp, mv)
/boot: Chứa nhân linux để khởi động và các file system máp cũng như các file khởi động sau
/dev: Chứa các tập tin thiết bị (CDRom, HDD, FDD)
/etc: Chứa các tập tin cấu hình hệ thống 
/home: thư mục dành cho người dùng khác root
/lib: CHứa các thư viện dùng chung cho các lệnh nằm trong /bin và /sbin
/mnt hoặc /media: mount point mặc định cho những hệ thống file kết nối bên ngoài
/opt: chứa các phần mềm cài thêm
/sbin: các chương trình duy trì quản trị hệ thống
/usr: chứa các file cố định phục vụ tất cả người dùng
/var: dữ liệu biến được xử lí bởi daemon. Bao gồm các tệp nhật kí, hàng đợi, bộ đệm, bộ nhớ cache
/root: Tệp các nhân của root
/proc: chứa thông tin về quá trình xử lí hệ thống, Xuất dữ liệu sang không gian người dùng 
/tmp: dùng tạm thời bởi hệ thống, xóa đi khi reboot hoặc shutdown

# 5. Kiểm tra và sủa lỗi
+ lost+found: chứa dữ liệu khôi phục của tập tin bị lỗi
+ fsck (file system check)
+ Phải unmount trước khi sử dụng
+ fsck -a /path/
+ fsck -A: kiểm tra tất cả hệ thống tập tin
+ fsck -AR -y: ngăn quét đến tệp gốc và sửa tất cả các lỗi
+ fsck -M: ngăn kiểm tra hệ thống được gắn


