# SMTP (Simple Mail Transfer Protocol)
## 1. Định nghĩa
- SMTP là hệ thống giao thức có nhiệm vụ nhận hoặc truyền tải dữ liệu email của người dùng.
- Hệ thống chỉ nhận và gửi thư điện tử email thông qua thiết bị có kết nối mang Internet. 
- Thiết bị nhận và gửi email gọi là SMTP server.
- Máy chủ liên kết tới port 25 - port không mã hóa.
- Port 465/587 - SSL/TLS port (__SMTPS__)

## 2. Hoạt động
- Khi gửi 1 email nào đó, hệ thống SMTP tự động dựa vào địa chỉ email và chuyển thông báo tới máy chủ SMTP.
- SMTP server nhận được tín hiệu, dựa vào tên miền địa chỉ email nhận, SMTP server và DNS server trao đổi tìm ra tiền miền gốc tạo hostname SMTP server cho tên miền đó.
- Nếu tên người dùng và trùng khớp với tài khoản được phép trong máy chủ đích thì thông báo email được gửi đến máy chủ này. 
- Trong trường hợp SMTP Server không thể liên lạc và trao đổi trực tiếp với máy chủ đích, SMTP chuyển các thông báo thông qua 1 hay nhiều SMTP Server trung gian. 

![](https://hostingviet.vn/data/tinymce/tin%20tuc%202019/smtp-la-gi-1.jpg)





