# Hoạt động của SSH
## 1. Nguyên lí hoạt động
- SSH triển khai theo mô hình **client-server** để authenticate và encrypt data giữa chúng.
- Khi kết nối thông quan SSH, ta sẽ truy cập được vào Shell Section trên server.
- Máy tính Server phải chạy SSH daemon.
- Máy tính Client phải có SSH client.

![](https://raw.githubusercontent.com/khanhnt99/thuctap012017/master/TamNT/SSH/images/1.4.png)

- 1 phiên làm việc của SSH được thiết lập trong 2 giai đoạn:
  + Giai đoạn 1: ACCEPT và thiết lập đường truyền mã hóa để bảo vệ an toàn liên kết sau đó.
  + Giai đoạn 2: Xác thực user và gán quyền cho phép truy cập tới server.

## 2. Quy trình hoạt động
### 2.1 Negotiating Encryption for the Session - Thiết lập mã hóa phiên kết nối

![](https://raw.githubusercontent.com/khanhnt99/thuctap012017/master/TamNT/SSH/images/1.5.png)

- Client Request tới Server 1 kết nối TCP. 
- Server tạo ra 1 key pair gồm **Public Key** và **Private Key**, cung cấp Public Key, Client xác định đây là máy chủ cần kết nối.
- Client tạo 1 key bí mật để mã hóa đường truyền (sử dụng thuật toán **Mã hóa đối xứng** - **Session key**) thiết lập kết nối bí mật chỉ có client và server biết.
- Client dùng Public Key vừa nhận từ server, mã hóa session key và gửi cho server.
- Server dùng Private key để giải mã key vừa nhận được. 

`Session key = Host key`

### 2.2 Authenticating the User's Access to the Server - Xác thực người dùng
- 2 phương thức xác thực:
   + **Password ** : Thông tin xác thực kèm theo Password.
   + **SSH Keypair** :Thông tin kèm theo là id Public key trong ket pair hoặc chữ số của client để xác thực.

#### 2.2.1 Xác thực bằng mật khẩu:
- **SSH-AUTH** so sánh mã băm của Password với mã tương ứng của user trong file `/etc/shadow`.

#### 2.2.2 Xác thực bằng SSH key pair
- SSH key pair là khóa bất đối xứng, mỗi key có chức năng khác nhau.
- **Public key** được mã hóa dữ liệu mà chỉ có thể được giải mã bởi **Private key**.
- Nếu bản tin mật được mã hóa bởi server sử dụng **Public key** mà client có thể giải mã được bản tin đó thì client sẽ chứng minh server là client có **Private key**.

![](https://raw.githubusercontent.com/khanhnt99/thuctap012017/master/TamNT/SSH/images/1.9.png)

__Bước 1__: Client gửi ID của key pair tới server  (ID của Public key - Pi)

__Bước 2__: Server kiểm tra trong file `authorized_keys`của tài khoản user mà client request tới. Nếu phù hợp với ID được tìm thấy trong file, server tạo 1 mã N ngẫu nhiên và sử dụng Public Key mã hóa N.

__Bước 3__: Client có Private key tương ứng, nó sẽ giải mã được bản tin và tìm ra số N ban đầu. Client kết hợp số N với session key bí mật giữa client và server tính ra được mã hash MD5.

__Bước 4__: Client giải mã tìm ra số N ban đầu. Client kết hợp N với session key bí mật tính ra hash MD5.

__Bước 5__: Client gửi mã Hash đó lại cho server.

__Bước 6__: Server sử dụng session key và số N để tính MD5. So sánh MD5 nhận được từ client -> trùng nhau thì client chứng minh được nó có private và xác thực. 

__Tài liệu tham khảo__
- https://github.com/khanhnt99/thuctap012017/blob/master/TamNT/SSH/docs/1.Tim_hieu_SSH.md#1
- https://github.com/khanhnt99/thuctap012017/blob/master/TVBO/docs/Network_Protocol/docs/TimHieuSSH.md
- https://github.com/khanhnt99/thuctap012017/blob/master/XuanSon/Netowork%20Protocol/SSH%20Protocol.md


