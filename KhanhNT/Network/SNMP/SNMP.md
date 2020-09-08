# SNMP (Simple Network Management Protocol)

![](https://chandat.net/testx/wp-content/uploads/2018/08/SNMP.jpg)

## 1. Khái niệm:
- SNMP là giao thức dùng để quản lí mạng.
- Được thiết kế chạy trên nền TCP/IP.
- Nó quản lí các thiết bị có nối mạng TCP?IP.

## 2. Chức năng:
- Theo dõi tốc độ đường truyền của 1 router, biết được tổng số byte đã truyền/nhận.
- Lấy thông tin về ổ cứng của máy chủ.
- Tự nhận cảnh báo khi switch khi có port bị down.
- Điều khiển shutdown port trên switch.

## 3. Thành phần:
### 3.1  SNMP Agent:
- Chạy trên phần cứng hoặc dịch vụ được giám sát.
- Thu thập dữ liệu về các số liệu khác nhau.
- Agent gửi lại thông tin cho trình quản lí.

### 3.2 Các thiết bị và tài nguyển do SNMP quản lí:
- Các node mà agent chạy trên nó.

### 3.3 Quản lí SNMP (NMS):
- Bảng điều khiển tập trung mà Agent cung cấp thông tin.

### 3.4 Cơ sở quản lí thông tin quản lí (Management Information base - MIB)
- File .mib
- Mô tả các đối tượng được sử dụng bởi 1 thiết bị cụ thể có thể được truy vấn hoặc kiểm soát bởi SNMP.
- Mỗi MIB được gán 1 định danh đối tượng (OID)

## 4. Hoạt đông:
- __GET__: được tạo bởi trình quản lí SNMP vfa gửi đến 1 agent để lấy giá trị 1 biến số (Được xác định bởi OID trong MIB)
- __Response__: Được gửi bởi agent cho người quản lí SNMP, phát đi để trả lời `GET`
- __GETNEXT__: được gửi bởi người quản lí SNMP đến agent yêu cầu lấy 1 giá trị OID tiếp theo trong hệ thống phan cấp MIB.
- __GETBULK__: Được gửi bởi Manager SNMP cho agent để có bảng dữ liệu lớn.
- ___SET__: Gửi bởi Manager SNMP cho agent để đưa ra các cấu hình lệnh.
- __TRAP__: 1 cảnh báo không đồng bộ được gửi bởi agent đến trình quản lí SNMP chỉ ra lỗi hoặc sự cố đã xảy ra.



