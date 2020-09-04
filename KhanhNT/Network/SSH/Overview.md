# Tổng quan về SSH
## 1. Giới thiệu SSH
- **SSH - Secure Shell** là các phổ biến nhất để truy cập vào các Remote Linux Server.
- Là 1 giao thức mạng dùng để thiết lập kết nối mạng 1 cách bảo mật.
- Hoạt động ở tầng Application trong mô hình TCP/IP.
- Các công cụ SSH như: OpenSSH, PuTTY,...
-  Kết nối qua port default là 22.

## 2. Đặc điểm của SSH
-  **Tính bí mật (Privacy)**: dữ liệu thông qua được mã hóa mạnh mẽ. 
- **Tính toàn vẹn (integrity)**: Đảm bảo dữ liệu trên kênh truyền gửi và nhận giữa 2 bên toàn vẹn, không bị thay đổi.
- **Authentication**: Cung cấp khả năng xác thực giữ bên gửi và bên nhận.
- **Authorization**: Cung cấp khả năng ủy quyền dùng để điều khiển truy cập thông qua các tài khoản.
- **Forwarding-Chuyển tiếp hoặc tạo đường hầm (tunneling)**: để mã hóa những phiên khác dựa trên giao thức TCP/IP. SSH hỗ trợ 3 kiểu chuyển tiếp:
   + TCP port forwarding
   + X forwarding
   + Agent forwarding

## 3. Encryption 
- Để bảo mật thông tin kênh truyền, SSH triển khai 1 số công nghệ với dữ liệu tại từng thời điểm khác nhau của phiên làm việc.
   + **Mã hóa đối xứng (symmetrical encryption)**
   + **Mã hóa bất đối xứng (asymmetrical encryption)**
   + **Hàm băm (Hashing)**

### 3.1 Symmetric Encrypton - Mã hóa đối xứng
- Mã hóa đối xứng là loại mã chỉ có 1 key được sử dụng để mã hóa cho dữ liệu tại bên gửi, và cũng dùng để giải mã dữ liệu nhận được ở bên nhận.
- Mã hóa này gọi là **Shared secret** hoặc **secret key**
- Chỉ 1 key duy nhất được dùng cho tất cả các bên cho tất cả các thao tác mã hóa dữ liệu.

![](https://raw.githubusercontent.com/khanhnt99/thuctap012017/master/TamNT/SSH/images/1.1.png)
- Mã hóa đối xứng được sử dụng để **mã hóa kết nối**.
- Cho phép xác thực bằng mật khẩu để chống lại Snooping.
- Cả Client và server đều góp phần thiết lập key này. Key được thông qua 1 quá trình gọi là quá trình **thuật toán trao đổi khóa**.
- Key mã hóa đối xứng được tạo trong quá trình được gọi là **khóa phiên (session key hay session-based)**

### 3.2 Asymmetrical Encryption - Mã hóa bất đối xứng
- Dữ liệu chỉ gửi đi theo 1 chiều.
- 2 Key liên quan tới nhau, 1 key là private key, 1 key là Public Key.
- Public key có thể chia sẻ thỏa mái. Public key liên kết với Private Key, Private key không chia sẻ.
- Public key và Private key mã hóa bản tin mà chỉ Private key với có thể giải mã bảng tin đó.
- Thực tế Public Key và Private key là nghịch đảo của nhau nên key nào dùng để mã hóa thì key còn lại sẽ giải mã. 

![](https://raw.githubusercontent.com/khanhnt99/thuctap012017/master/TamNT/SSH/images/1.2.png)
- SSH sử dụng mã hóa bất đối xứng trong quá trình trao đổi key ban đầu để thiết lập mã hóa đối xứng.
- Server gửi key pair và Public key cho client, client sẽ tạo **Mã hóa đối xứng** và được mã hóa bằng Public key sau đó gửi lại cho server, server dùng private key để giải mã. 
