# 1. Managing file:
+ ls: Hiện danh sách các file
+ touch: tạo mới file
+ cat: xem nội dung file
+ cp: copy nội dung file
+ mv: di chuyển file
+ rm: xóa file
+ rm -rf <folder_name>: xóa thư mục 
+ wc: tính số lượng từ trong file
+ pwd: hiện thư mục đang làm việc

![](https://www.upsieutoc.com/images/2020/07/21/Screenshot-from-2020-07-21-10-09-10.png)

+ Cột 1: miêu tả kiểu file và quyền truy cập file
    -: file thông thường
    d: thư mục chứa các file hoặc thư mục con khavs
    l: link tới file hoặc thư mục

+ Cột 2: số lượng khối nhớ file chiếm dụng
+ Cột 3: tên người sử hữu file
+ Cột 4: Nhóm người sở hữu file (có thể có nhiều user)
+ Cột 5: Kích thước file theo bytes
+ Cột 6,7,8: thời gian file bị sửa đổi
+ Cột 9: Tên file

#### Kí tự meta : ?, *
*: đại diện cho chuỗi kí tự dài tùy ý. *.doc thì tất cả các file có đuôi là .doc
?: đại diện cho 1 kí tự (??.doc có 2 kí tự)



# Thiết lập security cho thư mục và tập tin
- Các quyền cở bản:
    + Read
    + Write
    + Excute
    + Deny

Thay đổi quyền sở hữu dùng lệnh chown
Thay đổi quyền dùng lệnh chmod
+ 4=Read
+ 3=Write
+ 1=Excute

chmod 777:
+ Số đầu tiên quyền hạn nhóm owner
+ Số thứ 2 quyền hạn của group
+ Số thứ 3 quyền other/Public/world
 
VD: drwx-rx-rx: owner quyền read write excute, group quyền read excute, public read excute (tương đương 755)


