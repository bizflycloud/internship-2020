# Channel and Mode, Data in FTP
## 1. Channel Data FTP (Kênh dữ liệu)
- Mỗi lệnh và phản hồi trao đổi giữa PI (Protocol Interpreter) qua kênh điều khiển, nhưng dữ liệu thì không.

=> Mỗi khi truyền dữ liệu, 1 kênh dữ liệu phải tạo ra.
- Kênh dữ liệu kết nối __User-DTP__ và __Server-DTP__
- 2 Phương thức tạo kênh dữ liệu:
  + **Nomal (Active) Data Connections (mặc định)**
  + **Passive Data Connections**

### 1.1 Normal (Active) Data Connections
- Phía Server-DTP tạo kênh dữ liệu bằng cách mở cổng kết nối đến User-DTP.
- Mặc định dùng cổng 20 cho kết nối dữ liệu.
- Client mặc định dùng cổng sử dụng để kết nối điều khiển, Server chuyển cổng khác nhau cho mỗi chuyển giao. 

### 1.2 Passive Data Connections
- Server chấp nhận 1 yêu cầu kết nối dữ liệu được khởi tạo từ client.
- Server trả lời phía Client với địa chỉ IP và địa chỉ cổng mà Server sử dụng.
- Server-DTP lắng nghe trên cổng 1 kết nối TCP đến từ User-DTP.
- Client có thể chọn sử dụng 1 cổng khác cho Data Connection nếu cần thiết.

## 2. FTP Mode (Các phương thức truyền)
- Có 3 phương thức truyền:
  + __Stream mode__
  + __Block mode__
  + __Compressed mode__

### 2.1 Stream mode
- Dữ liệu được truyền dưới dạng byte không cấu trúc.
- Thiết bị gửi chỉ đơn thuần đẩy luồng dữ liệu qua kết nối TCP tới phía nhận.
- Không có cấu trúc Header, nên việc báo hiệu kết thúc file sẽ đơn giản được thực hiện khi thiết bị ngắt kết nối dữ liệu khi đã truyền dữ liệu xong.
- Được sử dụng nhiều nhất trong 3 phương thức trong triển khai FTP trong thực tế do:
  + Mặc định và đơn giản nhất
  + Phổ biến nhất vì nó xử lí các file chỉ đơn thuần là xử lí dòng byte, mà không cần để ý đến nội dung.
  + Không tốn 1 lượng Byte overload nào để thông báo Header.

