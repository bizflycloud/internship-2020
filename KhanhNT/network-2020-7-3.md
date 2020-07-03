# 1.	Mô hình OSI, TCP/IP
##	Mô hình OSI:
### Tầng 1 - Physical: 
Tầng vật lý liên quan các vấn đề về điện tử, cơ khí; xử lý dữ liệu
dạng bit; thiết bị mạng hoạt động ở tầng này là Hub.

### Tầng 2 – Data link: 
Tầng liên kết dữ liệu liên quan đến việc định dạng dữ liệu theo các chuẩn, điều khiển cách thức truy xuất đến môi trường vật lý; xử lý dữ liệu dạng khung
(frame); liên quan đến địa chỉ vật lý (phổ biến là địa chỉ MAC); thiết bị mạng hoạt động ở
tầng này là Switch.

### Tầng 3 - Network: 
Tầng mạng thực hiện chức năng định tuyến cho các gói tin; xử lý dữ liệu dạng gói (packet); liên quan đến địa chỉ luận lý (phổ biến là địa chỉ IP,…); thiết bị
hoạt động ở tầng này là Router.

### Tầng 4 - Transport: 
Tầng vận chuyển thực hiện chức năng đảm bảo việc vận chuyển dữ liệu từ nguồn đến đích thông qua hệ thống mạng. Thực hiện việc chia nhỏ dữ liệu phù hợp
với kích thước tối đa của kênh truyền ở bên gửi và tái lập ở bên nhận.

### Tầng 5 - Session:
 Tầng phiên thực hiện việc thiết lập, quản lý và kết thúc các phiên làm việc của các chương trình ứng dụng.

### Tầng 6 - Presentation:
 Tầng trình bày thực hiện việc đảm bảo dữ liệu đọc được ở tầng ứng dụng. Các chức năng của tầng này liên quan đến định dạng dữ liệu, cấu trúc dữ liệu, nén
dữ liệu, mã hóa dữ liệu.

### Tầng 7 - Application: 
Tầng ứng dụng là tầng cao nhất trong mô hình OSI, liên quan đến các chương trình ứng dụng làm việc trực tiếp với người dùng (như Email, FTP, Web,…)

## Mô hình TCP/IP
### Tầng 1 - Network access (link):
Đặc điểm của tầng này bao gồm đặc điểm của 2
tầng thấp nhất của mô hình OSI là tầng vật lý và tầng liên kết dữ liệu. Tầng này mô tả về các đặc điểm vật lý của các kết nối, điều khiển truy cập và định dạng
dữ liệu để truyền tải.

### Tầng 2 - Internet:
Cung cấp tính năng định tuyến cho dữ liệu từ nguồn đến đích trong các gói tin và thông tin về địa chỉ, di chuyển dữ liệu giữa tầng Link và tầng transport

### Tầng 3 - Transport: 
là tầng quan trọng của kiến trúc TCP/IP. Tầng này cung cấp các dịch vụ truyền thông trực tiếp đến quá trình xử lý của ứng dụng đang
chạy trên mạng.

### Tầng 4 – Application: 
cung cấp các ứng dụng cho việc truyền tập tin, xử lý sự cố và các hoạt động Internet

   Điểm khác biệt lớn nhất giữa hai giao thức này có 
lẽ là sự kết hợp giữa các tầng với nhau. Đối với giao thức TCP/IP thì tầng phiên và tầng trình diễn được kết hợp với nhau trong tầng ứng dụng. Còn đối với mô hình OSI thì mỗi tầng khác nhau sẽ thực hiện một nhiệm vụ khác nhau.

###	Phân biệt UDP và TCP
TCP:
- TCP (Transmission Control Protocol) là một giao thức mạng quan trọng được sử dụng trong việc truyền dữ liệu qua một mạng nào đó.

- So sánh với UDP:
 TCP và UDP đều là hai giao thức cốt lõi nằm ở tầng giao vận (Transport) thuộc giao thức TCP/IP có khả năng gửi tin đến các máy chủ khác trong mạng giao thức Internet.

+ Điểm giống nhau
   -	TCP và UDP đều là các giao thức được sử dụng để gửi các bit dữ liệu - được gọi là các gói tin - qua Internet. Cả hai giao thức đều được xây dựng trên giao thức IP. Nói cách khác, dù bạn gửi gói tin qua TCP hay UDP, gói này sẽ được gửi đến một địa chỉ IP. Những gói tin này được xử lý tương tự bởi vì chúng được chuyển tiếp từ máy tính cá nhân bạn đến router trung gian và đến điểm đích.
+ Điểm khác nhau:
  -	TCP sẽ đảm bảo chất lượng truyền gửi gói tin, nhưng tốn khá nhiều thời gian để kiểm tra đầy đủ thông tin từ thứ tự dữ liệu cho đến việc kiểm soát vấn đề tắc nghẽn lưu lượng dữ liệu.
   -	Trái với TCP, UDP có thấy tốc độ truyền tải nhanh hơn nhưng lại không đảm bảo được chất lượng dữ liệu được gửi đi (tức là nó không quan tâm dữ liệu có đến được đích hay không).
   -	Các header của TCP và UDP khác nhau ở kích thước (20 và 8 byte) nguyên nhân chủ yếu là do TCP phải hỗ trợ nhiều chức năng hữu ích hơn(như khả năng khôi phục lỗi). UDP dùng ít byte hơn cho phần header và yêu cầu xử lý từ host ít hơn.

#### TCP				
Dùng cho mạng WAN
		  
Không cho phép mất gói tin	 

Đảm bảo việc truyền dữ liệu
	  
Tốc độ truyền thấp hơn UDP
	 
VolP truyền tốt qua UDP.

#### UDP
Dùng cho mạng LAN

Cho phép mất dữ liệu

Không đảm bảo truyển dữ liệu

Tốc độ truyền cao

Quá trình vận chuyển dữ liệu qua mạng:

1. Quá trình đóng gói dữ liệu diễn ra bên máy gửi. 

2. Dữ liệu xuất phát từ tầng ứng dụngđược đóng gói và chuyển xuống các tầng kế tiếp, đến mỗi tầng dữ liệu được gắn thêm thông tin mô tả của tầng tương ứng gọi là header.

3. Khi dữ liệu đến tầng “transport”, tại đây diễn ra quá trình chia nhỏ gói tin nếu kích thước dữ liệu lớn hơn so với kích thước truyền tối đa cho phép.

4. Dữ liệu đến đến tầng “network”, mỗi gói tin sẽ gắng thêm thông tin tương ứng ở tầng này gọi là “IP header”,trong đó có chứa thông tin quan trọng là địa chỉ IP nguồn và IP đích được sử dụng trong quá trình định tuyến. 

5. Dữ liệu đến tầng “Data-Link” sẽ gắng thêm thông tin mô tả tầng này gọi là“Frame header”, trong đó có chứa thông tin về địa chỉ MAC nguồn và MAC đích. Trường hợp địa chỉ MAC đích không biết, máy tính sẽ dùng giao thức ARP để tìm. Sau đó dữ liệu chuyển xuống tầng “Physical”, chuyển thành các tín hiệu nhị phân để truyền đi.

