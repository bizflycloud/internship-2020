# Cách thức hoạt động của VPN

## 1. Cách thức hoạt động

- Quá trình làm việc của VPN:
  + `Tunneling`: Tạo đường hầm.
  + `Encrytion`: Mã hóa dữ liệu truyền.
  + `Encapsulation`: Đóng gói dữ liệu.
  + `Authentication`: Xác thực người dùng. 

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.9.png)

### 1.1 Tunneling - Tạo đường hầm
- Quá trình tạo đường hầm VPN là thiết lập và duy trì 1 kết nối mạng Logic.
- Thiết lập đường hầm là quá trình xử lí của việc `đưa toàn bộ 1 gói tin vào 1 gói tin khác rồi vận chuyển nó thông qua internet`.
- Gói tin bên ngoài bảo vệ nội dung gói tin bên trong khỏi mạng Public.

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.10.png)

- Nhiệm vụ:
  + Đóng gói dữ liệu trong gói tin IP và tránh khỏi định tuyến và chuyển mạch trong internet.
  + Đảm vảo toàn vẹn dữ liệu.

- Kiểu Tunnel
  + __Voluntary__: Phía client quản lí việc thiết lập đường truyền (Tự yêu cầu để cấu hình và thiết lập đường hầm).
  + __Compulsory__: Việc thiết lập đường hầm được thiết lập bởi nhà cung cấp (phía server).

- Giao thức thiết lập __Tunnel__
 + __PPTP__: `Point-to-Point Tunneling Protocol`: Là phương thức tạo VPN nhanh hơn cả. (Voluntary)
 + __L2TP__: `Layer 2 Tunneling Protocol`: Cung cấp sự bảo mật và toàn vẹn dữ liệu. Là sự kết hợp giữa `PPTP` và `L2F (Layer 2 Forwarding)`
 + __IPSec__: `Internet Protocol Security`: Giải pháp VPN hoàn chỉnh để mã hóa trong `L2TP` và `PPTP`.

### 1.2 Encryption-Mã hóa
- Mã hóa dữ liệu để chỉ máy tính có khả năng giải mã đúng dữ liệu mới có thể đọc và sử dụng.
- VPN client ở cuối mỗi tunnel mã hóa dữ liệu gửi đi và giải mã dữ liệu nhận được.

### 1.3 Encapsulation
- Là quá trình đóng gói tin dữ liệu ban đầu vào trong 1 giao thức khác để ẩn giấu dữ liệu bên trong.
- 1 số công nghệ mã hóa:
  + GRE
  + IPSec (phổ biến)
  + L2F
  + PPTP (phổ biến)
  + L2TP

### 1.4 Authentication - Xác thực
- Xác thực xem người gửi có phải người dùng được ủy quyền truy cập hay không, dữ liệu có bị chuyển hướng hay ngắt hay không.

## 2. 1 số giao thức được sử dụng trong VPN

### 2.1 PPTP (Point to point Tunneling Protocol)
- Là giao thức kết nối điểm điểm.
- Phương pháp cấu hình đơn giản nhất của VPN. bảo mật kém nhất.
- PPTP thiết lập tunnel không mã hóa.
- PPTP sử dụng 2 kênh:
  + Kênh điều khiển thiết lập kết nối. (TCP 1723)
  + Kênh truyền dữ liệu. (GRE, giao thức IP 47)

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.12.png)

### 2.2 IPSec VPN
- Hệ thống gồm các giao thức bảo mật quá trình truyền tin.
- IPSec thực hiện việc xác thực và mã hóa cho mỗi IP packet trong quá trình truyền thông tin, điều khiển truy cập, bảo mật.

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.13.png)

- IPSec sử dụng chứng năng xác thực `Authentication Header (AH)` được dùng trong việc chứng thực/mã hóa.
- IPSec sử dụng 2 kênh:
  + Kênh điều khiển thiết lập kết nối (UDP port 500/4500)
  + Kênh dữ liệu (ESP - Encapsualting Security Payload ,IP 50)

### 2.3 L2TP (Layer 2 Tunneling Protocol)

### 2.4 SSTP (Secure Socket Tunneling Protocol)
- Kết nối VPN bằng HTTPS sử dụng Port 443.
- SSTP sử dụng các kết nối HTTP đã được mã hóa `SSl - Secure Sockets Layer` để thiết lập 1 kết nối VPN đến VPN Gateway.

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.15.png)

### 2.5 OpenVPN
- Phần mềm mã nguồn mở tạo các kết nối và thực hiện bảo mật mạng lớp 2 và 3.
- Sử dụng SSL/TLS để tạo kênh truyền bảo mật.

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TamNT/VPN-OpenVPN/images/1.16.png)

**Tài liệu tham khảo**

-  https://github.com/hocchudong/thuctap012017/blob/master/TamNT/VPN-OpenVPN/docs/1.Tong_quan_VPN_(VPN_overview).md
