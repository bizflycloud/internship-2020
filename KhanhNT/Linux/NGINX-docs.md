# NGINX
## 1. Tổng quan về NGINX
- Sản phẩm mã nguồn mở dành cho web server.
- Là 1 reverse proxy cho các giao thức HTTP, SMTP, POP3, IMAP.

![](https://topdev.vn/blog/wp-content/uploads/2019/04/ad1ad442-f39b-49b9-81ad-1102c8a7ccf6.jpg)

## 2. Cách hoạt động:
- Cách 1 web server hoạt động:
 - Khi gửi yêu cầu mở 1 trang web:
    - Trình duyệt sẽ liên lạc với server chứa website đó.
    - Server sẽ tìm đúng file yêu cầu của trang đó để gửi ngược về server. 
    - Ví dụ trên là 1 Single thread: Web server truyền thống tạo thread cho mỗi request.
- NGINX hoạt động:
 - Kiến trúc bất đồng bộ (asynchoronous)
 - Những thread tương đồng nhau sẽ quản lí trong 1 tiến trình.
 - Tiến trình hoạt động chứa các worker connections. Chịu trách nhiệm xử lí các thread.
 - Worker connections sẽ gửi các truy vấn cho 1 worker process, worker process gửi đến master process. Master process trả kết quả cho những yêu cầu đó,.

## 3. Cài đặt NGINX from source
