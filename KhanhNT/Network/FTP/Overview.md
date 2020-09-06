# FTP (File Transfer Protocol)
## 1. Tổng quan về FTP
- Giao thức internet trên tầng ứng dụng.
- Là giao thức truyền tập tin phổ biến hiện nay. 

![](https://news.cloud365.vn/wp-content/uploads/2020/01/FTP_Server.png)

## 2. Mục đích sử dụng
- Ứng dụng chạy trên mô hình TCP/IP.
- Sử dụng tải xuống máy tính các file từ máy chủ.
- FTP thiết lập 2 kết nối với máy chủ:
   + 1 kết nối sử dụng truyền dữ liệu.
   + 1 kết nối còn lại dùng để điều khiển kết nối.

## 3. Mô hình FTP
### 3.1 Kết nối TCP trong FTP

![](https://news.cloud365.vn/wp-content/uploads/2020/01/FTP1.png)

- FTP dựa trên vô hình Client-Server.
- Như đã nói ở trên, FTP cần 2 kết nối TCP:
  + **Control connection (port 21)** : Kết nối TCP logic được tạo ra khi phiên làm việc được thiết lập. Nó duy trì trong suốt phiên làm việc và chỉ cho thông tin điều khiển đi qua hoặc response (phản hồi).
  + **Data connection (port 20)** : Thực hiện giữa quá trình truyền dữ liệu. Kết nối mở khi có lệnh truyền tệp và đóng khi truyền tệp xong. 

### 3.2 Mô hình FTP

![](https://media.geeksforgeeks.org/wp-content/uploads/FTP.jpg)

- Do thiết lập điều khiển kết nối và truyền dữ liệu được chia riêng biệt nên FTP chia mỗi thiết bị thành 2 phần giao thức logic chịu trách nhiệm cho mỗi phần.
   + `Control Connection <-> Protocol interpreter(PI)`: Quản lí điều khiển kết nối, nhận lệnh và phản hồi.
   + `Data Connection <-> Data Transfer process (DTP)`: gửi và nhận dữ liệu trên client và server.

### 3.3 Chức năng từng thành phần

![](https://news.cloud365.vn/wp-content/uploads/2020/01/Screenshot_2.png)

#### 3.3.1. Phía server
- **Server Protocol Interpreter (Server-PI)**: 
   + Quản lí Control Connection trên Server.
   + Lắng nghe User từ port 21.
   + Nhận lệnh từ User-PI.
   + Gửi phản hồi và quản lí tiến trình truyền dữ liệu trên Server.

- **Server Data Transfer Process (Server-DTP)**: 
   + Nhận và gửi file từ User-DTP.
   + Thiết lập Data Connection.
   + Lắng nghe qua port 20.
   + Tương tác với Server File System để đọc và chép file.

#### 3.3.2. Phía Client
- **User Interface**: 
   + Chương trình chạy trên máy cung cấp giao diện cho người dùng.
- **User Protocol Interpreter (User-PI)**:
   + Quản lí Control Connection phía Client.
   + Khởi tạo phiên kết nối FTP bằng việc phát ra Request tới Server-PI.
   + Kết nối được thiết lập, xử lí các lệnh nhận được trên UI rồi gửi tới Server-PI rồi đợi Response.
   + Quản lí các tiến trình trên Client.
- **User Data Transfer Process (User-DTP)**
   + Gửi hoặc nhận dữ liệu từ Server-DTP
   + Có thể thiết lập hoặc lắng nghe Data Connection từ server qua cổng 20.
   + Tương tác Client File System trên Client để lưu trữ file. 

## 4. Nguyên lí hoạt động của FTP
- Cần 2 kết nối TCP trong phiên làm việc của FTP:
   + Control Connection: port 21 (luôn mở mọi thời điểm khi dữ liệu hoặc lệnh được gửi)
   + Data Connection: port 20 (chỉ mở khi có trao đổi dữ liệu)
- __Trình tự hoạt động__:
  + __Bước 1__: FTP client mở Control Connection tới FTP Server __(port 21)__ và chỉ định cổng trên Client để Server gửi lại phản hồi. Đây là đường kết nối truyền lệnh không phải dữ liệu. Control Connection sẽ mở trong suốt thời gian phiên làm việc (Telnet giữa 2 hệ thống).
  + __Bước 2__: Client chuyển thông tin Username, Password tới Server để authentication. Server sẽ response bằng chấp nhận hoặc từ chối các request.
  + __Bước 3__: Client gửi thêm các lệnh với tên tệp, kiểu dữ liệu để vận chuyển, luồng dữ liệu. Server sẽ phản hồi mã (__Reply code__) chấp nhận hoặc từ chối. 
  +__Bước 4__: Khi ACCEPT, 2 bên mở **port 20** để truyền dữ liệu.

## 5. FTP Reply 
- Mỗi lần User-PI gửi lệnh đến Server-PI quan Control Connection, server sẽ gửi lại phản hồi dưới dạng code.
- Mục đích: 
 + Xác nhận máy chủ đã nhận được lệnh.
 + Cho biết lệnh từ phía người dùng có được chấp nhận hay không, phát hiện và cho biết lỗi.
 + Cho biết thông tin khác nhau cho Client về phiên truyền.

Reply Code: dạng `xyz`
```
200: Command okay
530: Not logged in
331: User name okay, need a password
225: Data connection open; no transfer in progress
221: Service closing control connection
502: Command not implemented
503: Bad sequence of commands
504: Command not implemented for that parameter
```

 


__Tài liệu tham khảo:__
- https://news.cloud365.vn/ftp-tim-hieu-ve-giao-thuc-ftp/
