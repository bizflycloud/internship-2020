## TCP/IP và OSI model
___
![](https://mhshohag.com/wp-content/uploads/2018/09/Screen-Shot-2017-06-08-at-1.59.05-PM.png)

| TCP/IP model | OSI model|
|:---:|:---:|
| Tương tự mô hình 1 cặp client-server + việc vận chuyển packest qua internet | Mang tính conceptal, xác định - định nghĩa một hệ thống kết nối với hệ thống khác|
| 4 layers | 7 layers |

#### TCP/IP model
___
![](https://www.guru99.com/images/1/093019_0615_TCPIPModelW2.png)

**NOTE**
###### 1. Application layer
- Cung cấp rất nhiều các dịch vu: mail services, file transfer,..+ cho phép người dùng tương tác với các software applications
- Mổ số giao thức phổ biến: SMTP, SSH. FTP,...
###### 2. Transport layer
- Phân mảnh các gói tin thành các segments - thực hiện flow control, error control (retransmition,..)
- Đảm bảo tính **reliable** and **in-order**.
- 2 giao thức phổ biến: TCP, UDP
###### 3. Internet layer
- Chức năng chính là **định tuyến**
- Một số giao thức được sử dụng: IP, ICMP, ARP.
###### 4. Network interface layer (Network access layer)
- Đơn vị sử dụng là các bits dữ liệu, truyền thông qua các loại cáp vật lí.
- Chịu trách nhiệm cho việc vận chuyển dữ liệu giữa 2 thiết bị trong cùng một mạng.

#### OSI model
___
![](https://www.guru99.com/images/1/092119_0729_LayersofOSI1.png)

**NOTE**
###### 1. Presentation layer
- Xử lí việc **đóng gói**, **mã hóa** dữ liệu
- Như một **translater** data <==> giúp data tương thích với applications.
###### 2. Session layer
- Layer này thực hiện, xử lí việc log-in hoặc xác thực pasword
- Thành lập, duy trì, kết thúc 1 session.
###### 3. Data link layer
- **Corects errors** which can occour *at the physical layer*

Data Link layer chia nhỏ thành 2 sublayers:
- [MAC layer](https://congngheviet.com/dia-chi-ip-va-dia-chi-mac-la-gi-chung-dung-de-lam-gi/) : điều khiển cách thiết bị truy cập vào cáp mạng 
- [LLCL-Logical-link-control-layer](https://searchnetworking.techtarget.com/definition/Logical-Link-Control-layer) : quản lí lưu lượng trên kết nối vật lí (đóng gói dữ liệu tới frame và cho phép phát hiện lỗi)

