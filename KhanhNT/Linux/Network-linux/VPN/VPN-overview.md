# VPN
## 1. Khái niệm
- __VPN__ - Công nghệ xây dựng mạng riêng ảo nhằm đáp ứng nhu cầu chia sẻ thông tin, truy cập từ xa và tiết kiệm chi phí.
- __VPN__ cho phép các máy tính truyền thông với nhau qua 1 môi trường chia sẻ như mạng internet nhưng vẫn đảm bảo được tính riêng tư và bảo mật.

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.1.png)

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.2.png)

-  __VPN (Virtual Private Network - Mạng riêng ảo)__ là công nghệ cung cấp cho người dùng khả năng truy cập vào 1 mạng riêng (LAN) của các máy tính cá nhận và máy chủ trong mạng riêng đó từ 1 điểm bên ngoài của mạng đó và không làm ảnh hưởng đến an ninh của mạng.

- VPN sử dụng kĩ thuật __Tunneling Protocols__ 
  + __Tunneling Protocols__
     - Đóng gói 1 gói tin dữ liệu bên trong 1 gói tin khác để tạo 1 kênh truyền an toàn.
     - Các gói thông tin được bao bọc bằng 1 `header` chứa những thông tin định tuyến cho phép dữ liệu gửi từ máy truyền qua môi trường mạng chia sẻ để đến máy nhận.
     - Đảm bảo tính bảo mật gói tin.

## 2. Ưu điểm VPN
- Tiết kiệm chi phí.
- Tính linh hoạt.
- Bảo mật.
- Bảo mật về địa chỉ IP (Các thông tin gửi đi trên VPN được mã hóa => địa chỉ IP bên trong mạng được che giấu ).

## 3. Chức năng của VPN
- Truy cập mạng doanh nghiệp khi ở xa.
- Truy câpj mạng gia đình (home network).
- Duyệt web ẩn danh.
- Truy cập đến website bị chặn.
- Tăng tốc độ tải tập tin. (`BitTorrent`)

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.3.png)

## 4. Phân loại VPN

### 4.1 Site-to-site VPN
- `Site-to-site VPN` là mô hình dùng để kết nối các hệ thống mạng ở các nơi khác nhau tạo thành 1 hệ thống mạng thống nhất.
- Việc chứng thực ban đầu phụ thuộc vào thiết bị đầu cuối ở các Site.
- Các thiết bị chứng thực hoạt động như `Gateway`.

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.5.png)

- Các host đầu cuối `không biết về kết nối VPN`, host vẫn gửi và nhận lưu lượng TCP/IP bình thường thông qua 1 `gateway` VPN.
- Cổng VPN `đóng gói` và `mã hóa` lưu lượng cho tất cả các lưu lượng truy cập, sau đó `VPN gateway` gửi nó quan 1 `VPN tunnel` quan internet đến 1 cổng VPN ngang hàng tại địa điểm mục tiêu.
- Khi nhận được, cổng VPN `giải tiêu đề`, `giải mã nội dung` rồi `chuyển tiếp gói tin đến máy chủ đích. 
- __VPN site-to-site__ có thể sử dụng khi muốn kết nối 2 site của cùng 1 công ty.

### 4.2 Remote Access VPN (Client-to-site VPN)

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.7.png)

-  __Remote Access VPN (Client to site)__ cho phép
truy cập bất kì lúc nào bằng Remote.
- __Remote Access VPN__ mô tả việc người dùng từ xa sử dụng các phần mềm VPN để truy cập vào mạng Internet của công ty thông qua `Gateway` hoặc `VPN concentrator (bản chất là 1 server)`
- __Remote Access VPN__ được xem là dạng `User-to-LAN` cho phép người dùng ở xa dùng phần mềm `VPN Client` kết nối với `VPN Server`.


__Tài liệu tham khảo__:

- https://github.com/hocchudong/thuctap012017/blob/master/TamNT/VPN-OpenVPN/docs/1.Tong_quan_VPN_(VPN_overview).md



