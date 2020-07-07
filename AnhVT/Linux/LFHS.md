# Linux file hierarchy system

Hệ thống phân cấp bậc file trong linux

![image](https://user-images.githubusercontent.com/66721505/84873798-f2f20700-b0ad-11ea-8302-ab95b742f816.png)



##  /(root)

Mọi file và đường đẫn đều bắt đầu từ root

Chỉ có user root mới có quyền chỉnh sửa trong /root

`/root` khác với `/`. `/root` là phẩn thư muc home của user root

## /var

Nơi lưu các Variables files
i.e: var/log/syslog - kiểm tra file log

## /bin

Là nơi chứa các lệnh như cp, cat, ..

## /sbin

Các binaries thiết yếu của hệ thống như fsck, init, route. Gần tương tự với `/bin` nhưng với các lệnh ở đây thường được sử dụng bởi người quản trị hệt thống ( admin ) và thường được sử dụng khi bảo trì

## /boot 

Nơi chưa file boot, lõi kernel

## /dev 

Các file thiết yếu của hệ thống được đặt tại đây, eg : /dev/null


## /etc

Các config của hệ thống được lưu trữ tại đây. Các config này được sử dụng bởi tất cả các phần mềm trên hệ thống. Cũng là nơi lưu trữ các Shell script để bắt đầu và ngừng các chương trình.
Example: /etc/resolv.conf, /etc/logrotate.conf.

## /home

Đường dẫn tới thư mục home của cá user, là nơi các user có thể lưu trữ các dữ liệu của mình
eg: /home/anhvt

## /lib 

Các thư viện cho các directory khác như `/bin` và `/sbin`

## /media

Nơi mount các Cd-rom , nơi lưu trữ tạm thời cho các thiết bị kết nối như usb hay đĩa cd

## /mnt

Đường dẫn để tạm thời lưu lại các file hệ thống

## /opt

Bao gồm các package từ các Vendor khác nhau

Các ứng dụng add-on sẽ được cài đặt tại `/opt` hoặc `/opt - sub`


eg : iptable, ifconfig

## /srv

Nơi chứa data và script cho web sever và đồng thời cũng là nơi lưu trữ các repo của Version Control Sys ( Git

## /tmp

Nơi lưu trữ các file temp được tạo bởi hệ thống hay user

## /usr

Phân cấp thứ cấp cho dữ liệu người dùng chỉ đọc; chứa phần lớn (nhiều) tiện ích và ứng dụng người dùng.

## /proc

Hệ thống tập tin ảo cung cấp quá trình và thông tin kernel dưới dạng tập tin


