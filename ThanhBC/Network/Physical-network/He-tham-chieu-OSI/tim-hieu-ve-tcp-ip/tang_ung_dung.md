# giao thức tầng ứng dụng.

Tầng ứng dụng  là tầng cao nhất trong mô hình tham chiếu phân cấp OSI.
Tâng ứng dụng có chức năng chính là tạo giao diện để người dùng có thể tương tác với máy tính.

Tầng này sẽ thực hiện các thao tác của người dùng và gửi các yêu cầu xuống cho tầng dưới nó là tâng presentation để thực thi.

Mô hình khách hàng / phục vụ ( client server)
- Client: là máy yêu câu sử dụng dịch vụ
- Server: là máy cung cấp các dịch vụ

Truyền thông giữa các tiến trình:   
- Các tiến trính giao tiếp với nhau bằng cách gửi các thông điệp thông qua các socket của chúng.
- Socket là điểm cuối của các cổng kết nối giữa các tiến trình các tiến trình. Từ socket của tiến trình này đi qua các port rồi đến socket của tiến trình kia.

Địa chỉ tiến trình:
- Tên hay địa chỉ của máy tính.
- Định danh xác định tiến trình trên máy tính.

Chương trình giao tiếp người dùng(user agent):
Ví dụ: 
- Trong thư điện tử user agent là gmail reader.
- Trong web service user agnet là brower.

Yêu cầu của các ứng dụng 
- Mất mát dữ liệu (data loss)
- Băng thông (bandwitch)
- Thời gian (timming)

## 3. Một số ứng dụng phổ biến trong tầng ứng dung.


## 3.1 World Wire Web, HTTP.

Http (HyperText Transfer Protocol) là giao thức truyền tải siêu văn bản được sử dụng trong www dùng để truyền tải dữ liệu giữa Web server đến các trình duyệt Web và ngược lại. Giao thức này sử dụng cổng 80 (port 80) là chủ yếu.

Tương tác giữa người dùng và web server
    + authentication (kiểm chứng): password và username.
    + cookie: ghi lại dữ liệu truy cập.
            . từ client gửi đến server nhận: set-cookies
            . Từ server gửi về client nhận :  cookies

Web cache (proxy server): Là máy server làm việc trực tiếp với client là nơi chuyển hướng và lưu trữ các phiên truy cập được sử dụng nhiều.
- Cache liên hợp (coperative caching): Kết hợp nhiều web cache lại với nhau để nâng cao hiệu suất.
- Cụm cache (cache cluster): Được đặt trong cùng 1 mạng LAN sử dụng giao thức (CARP) cache array routing.

Phân loại web:
- Web tĩnh: Là 1 file html trong Web server.
    + Không linh hoạt, không cập nhật dữ liệu. 
    + Đơn giản dễ cài đặt và sử dụng
- Web động: là tập hợp các file đc liên kết với nhau và được lưu trên Web server.
    + Dễ dàng nâng cấp và bảo trì
    + Có thể xây dụng được web lớn
    + Thường sử dụng tương tác với người dùng cao
    + Dễ dàng quản lý nội dung


## 3.2 Phương thức chuyển file (File Transfer Protocol).
FTP là giao thức truyền file giữa các máy tính. Để sử dụng thì người dùng phải được định danh qua username và password

Giao thức này sử dụng TCP thông qua cổng 20 để tạo đường truyền và cổng 21 để gửi dữ liệu.

Các lệnh cơ bản:
+ USER username: Gửi thông điệp định danh 
+ PASS passwword: Gửi mã password để xác thực
+ LIST : Yêu cầu danh sách file
+ RETR filename: Hiện thị danh sách file được hiển thị.
+ STOR filename: Tải file lên

Cấu trúc lệnh:
+ 331: username OK , password, requiered
+ 125 connection allready open; transfer staring
+ 425 can't openn data connection
+ 452 error writing file

## 3.4 Thư điện tử Email
Các phần: User agent, Mail server và các giao thức smtp hoặc imap.

User agent: là thiết bị vừa có thể nhận mail và có thể gửi mail.

SMTP ( simple mail transfer protocol)
Mã hóa từ clear text sang mã ASCII trước khi  truyền.

Các bước truyền: 
+ Sử dụng user agent đánh địa chỉ và yêu cầu gửi mail đến máy đích 
+ user agent gửi đến mail server và đưa vào hàng đợi 
+ Mail-server lấy thư và tạp kết nối đến máy cần nhận 
+ Từ mail-server của người nhận tạp kết nối TCP đến user agent người nhận  
+ Người sử dụng hay user agent có thể dùng các giao thức khác nhau như IMAP, POP3 để truy cập đến mail server và lấy mail về máy.

Có 5 câu lệnh được sử dụng :HELLO, MAIL, FROM, RCPT TO, DATA và QUIT.

## 3.4 Dịch vụ tên miền DNS (domain name server)
Mapping giữa tên miên và địa chỉ IP của máy chủ.
Dịch vụ DNS chạy qua cổng 53 và sử dụng cả 2 cách hướng nối là UDP và TCP.
###  Các dịch vụ của DNS    
DNS có cơ sở dữ liệu phân tán đặt trên nhiều hệ thông máy tính phân cấp khác nhau, Mỗi máy trong hệ thống phân cấp có chức năng khác nhau

Trên unix sử dụng BIND (Berkely Internet Name Domain)
