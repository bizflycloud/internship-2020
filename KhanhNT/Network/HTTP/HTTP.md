# HTTP (HyperText Transfer Protocol)

## 1. Khái niệm
- HyperText Transfer Protocol là giao thức truyền tải siêu văn bản được dùng để **liên hệ thông tin** giữa máy cung cấp dịch vụ (Web server) và máy sử dụng dịch vụ (Web client)
- Là giao thức Client/Server dùng cho World Wide Web - WWW
- Là giao thức trong bộ giao thức TCP/IP

![](https://topdev.vn/blog/wp-content/uploads/2019/10/7da268f1-718b-465c-87df-700e766df185.png)

- Là **stateless protocol**: Request hiện tại không biết những gì hoàn thành trong request đó.

## 2. Uniform Resource Locator (URL)
- URL: được sử dụng để xác định duy nhất 1 tài nguyên trên web
- Cấu trúc:
  + `protocol://hostname:port/path-and-file-name`
- Các thành phần:
  + Protocol: giao thức tầng ứng dụng được sử dụng bởi client và server
  + Hostname: tên DNS domain
  + Port: Cổng TCP để server lắng nghe request từ client
  + Path-and-file-name: tên và vị trí tài nguyên yêu cầu

![](https://topdev.vn/blog/wp-content/uploads/2019/10/1596a7ea-09cc-4a36-82ac-48768e0cb24f.png)

## 3. Các thành phần chính của HTTP
- Http session là 1 chuỗi các giao dịch yêu cầu-phản hồi
- Http client khởi tạo 1 request bằng cách thiết lập 1 kết nối TCP đến 1 cổng trên server (default là 80)
- Multi-threading hoặc Multi-processing: kết hợp cho phép 1 phiên kết nối client có thể gửi nhiều request mà chưa cần response từ server và ngược lại

### 3.1 HTTP-Request
- **HTTP Request Method**: là phương thức để chỉ ra hành động mong muốn thực hiện trên tài nguyên đã xác định
- Cấu trúc HTTP Request:
   + __Request-line__ = **Phương thức** + **URL-REQUEST** + __Phiên bản HTTP __
   + Có thể có hoặc không các trường header
- Khi request đến server. Server thực hiện 1 trong 3 hành động sau:
  + Server phân tích request nhận được, maps yêu cầu với tập tin trong tập tài liệu của server, và trả lại tập tin yêu cầu cho client.
  + Server phân tích request nhận được, maps yêu cầu vào 1 chương trình trên server, thực thi chương trình và trả lại kết quả chương trình đó.
  + Request từ client không thể đáp ứng, server trả lại thông báo lỗi. 

![](https://topdev.vn/blog/wp-content/uploads/2019/10/87ee0c1c-abac-4d08-973e-e8bae533cbf0.png)

- HTTP định nghĩa 1 tập các phương thức request, client có thể sử dụng 1 trong những phương thức này để tạo request tới HTTP server

 ![](https://topdev.vn/blog/wp-content/uploads/2019/10/b986dced-c499-4051-8efb-5ea5d9b93c02.png)

#### 3.1.1 GET
- Sử dụng lấy thông tin từ server bởi sử dụng 1 URL đã cung cấp.
- Chỉ nhận dữ liệu và không có tác dụng khác

![](https://vnsys.files.wordpress.com/2016/12/get-method.jpg?w=341&h=225)

#### 3.1.2 HEAD
- Phản hồi tương tự yêu cầu GET
- Không phản hồi phần body
- Hữu ích lấy thông tin meta trong phần header, không cần chuyển toàn bộ nội dung

#### 3.1.3 POST
- Yêu cầu web server chấp nhận và lưu trữ các dữ liệu kèm theo trong phần body của request message được xác định bởi URL
- Thường được sử dụng khi upload 1 tệp tin hoặc submit các web form, nhóm tin,...

![](https://vnsys.files.wordpress.com/2016/12/post-method.jpg?w=338&h=219)

### 3.2 HTTP-Responses
- Cấu trúc:
  + **Status-line**=**Phiên bản HTTP** + **Mã trạng thái** + **Trạng thái** 
- Mã trạng thái: thông báo về kết quả nhận được yêu cầu và xử lí bên server cho client.
  
  +  1xx: Thông tin (request) đã được nhận, tiếp tục xử lí
     - `100 Continue`: Server nhận được yêu cầu header.
     - `101 Switching Protocol`.
     - `103 Checkpoint`.
  
  + 2xx: Thành công
     - `200 OK`: yêu cầu gửi lên server tiếp nhận thành công.
     - `201 Created`
     - `202 Accepted`
     - `203 Non-Authoritative Infomation`
     - `204 No Content`
     - `205 Reset Content`
     - `206 Partial Content`
  
  +  3xx: Điều hướng
     - `300 Multiple Choices`
     - `301 Moved Permanently`: Trang web yêu cầu đã chuyển đến 1 địa chỉ URL mới
     - `302 Found`: Trang web yêu cầu đã chuyển tạm thời đến 1 địa chỉ URL mới
     - `303 See Other`
     - `304 Not Modified`
     - `306 Switch Proxy`
     - `307 Temporary Redirect`
     - `308 Resume Imcomplete`

  + 4xx: Lỗi client
     - `400 Bad Request`: Lỗi cú pháp, yêu cầu không thực hiện được.
     - `401 Unauthorized`
     - `402 Payment Required`
     - `403 Forbidden`: Không được phép truy cập vào đây
     - `404 Not Found`: Không tìm thấy trang địa chỉ với URL hiện tại

  + 5xx: Lỗi Server
     - `500 Internal Server Error`: Một thông báo lỗi chung, được đưa ra khi không có thông báo cụ thể nào khác phù hợp
     - `501 Not Implemented`: Máy chủ hoặc không nhận ra phương thức yêu cầu, hoặc nó không có khả năng thực hiện yêu cầu
     - `502 Bad Gateway`: Máy chủ đã hoạt động như một cổng hoặc proxy và nhận được phản hồi không hợp lệ từ máy chủ
     - `503 Service Unavailable`: Máy chủ hiện không có (quá tải)
     - `504 Gateway Timeout`: Máy chủ hoạt động như một gateway hoặc proxy và không nhận được phản hồi kịp thời từ máy chủ phía trên

### 3.3 Kiểm tra Port HTTP bằng netstat
- `netstat -ant | grep 80`

## 4. Https
- HyperText Transfer protocol secure
- Giao thức Http có sử dụng thêm SSL(Secure Sockets Layer) để mã hóa dữ liệu nhằm gia tăng thêm tính an toàn cho việc truyền dữ liệu giữa Web server và trình duyệt Web 
- Sử dụng cổng 443 để truyền dữ liệu

## 5. So sánh Http và Https

![](https://vnreview.vn/image/15/86/87/1586874.jpg?t=1477504006940)

Tài liệu tham khảo: https://vnsys.wordpress.com/2016/12/16/http-la-gi-va-cach-no-lam-viec/
