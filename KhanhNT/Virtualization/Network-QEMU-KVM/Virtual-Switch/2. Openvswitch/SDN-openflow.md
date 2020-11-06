# SDN và OpenFlow
## 1. SDN (Software Defined Networking)
### 1.1 Giới thiệu

![](https://github.com/hocchudong/thuctap012017/raw/master/TamNT/TimHieuSDN/images/1.1.png)

- **SDN(Software Defined Networking)** hay mạng điều khiển bằng phần mềm là kiến trúc đem lại sự tự động, dễ dàng quản lí, tiết kiệm chi phí và có tính tương thích cao, đặc biệt phù hợp với những ứng dụng yêu cầu tốc độ băng thông cũng như sự tự động.
- Kiến trúc tách riêng 2 chức năng điều khiển(**Control Plane**) và truyền tải dữ liệu(**Data Plane**).

**Tóm lại**
- **SDN** tách biệt phần điều khiển **Control Plane** và truyền tải dữ liệu **Data plane**.
- Các thành phần trong network có thể được quản lí bởi các phần mềm được lập trình chuyên biệt.
- Tập trung vào kiểm soát và quản lí network.

### 1.2 Mô hình SDN
![](https://camo.githubusercontent.com/d06cd32fa0e879bd0c6a68d191479cd25ca43394081a5cc8ebb22cf0c64257b0/687474703a2f2f692e696d6775722e636f6d2f306631394374492e706e67)

- **Network infrastructure**: Bao gồm các thiết bị mạng như Router, Switch.
- **Controller**: Bao gồm các phần mềm dựa trên bộ điều khiển tập trung, có thể đặt trên server để giao tiếp với tất cả các thiết bị mạng bằng cách sử dụng API như `OpenFlow` hoặc `OVMDB`
- **Application**: Bao gồm hàng loạt ứng dụng có sự tồn tại của network. Các ứng dụng này có thể nói chuyên với **Controller** sử dụng API để thực hiện những yêu cầu.

## 2. OpenFlow
### 2.1 Vấn đề:
- **SDN** đặt ra 2 vấn đề khi triển khai thực tế
  + Cần phải có 1 kiến trúc logic chung cho tất cả các Switch, Router và các thiết bị khác được quản lí bởi **SDN controller**. **SDN controller** thấy được chức năng chuyển mạch thống nhất.
  + Một giao thức chuẩn, bảo mật để giao tiếp giữa các **SDN controller** và các thiết bị mạng.
  => **OpenFlow** đưa ra giải quyết cả 2 vấn đề đó

### 2.2 Tổng quan
- **OpenFlow** là giao thức cung cấp khả năng **truyền thông** giữa các **interface** của **Openflow Controller** và **Openflow Switch** trong kiến trúc SDN

### 2.3. Kiến trúc logical của Openflow Switch
![](https://camo.githubusercontent.com/f0cf794751e86be205ee062ef1c8ca441ecf414c1ac10ec07c9e80562b696943/687474703a2f2f7777772e636973636f2e636f6d2f632f64616d2f656e5f75732f61626f75742f61633132332f61633134372f696d616765732f69706a2f69706a5f31362d312f3136315f73646e5f66696730335f736d2e6a7067)

- Mỗi Switch kết nối với các **OpenFlow Switch** khác và kết nối với các thiết bị của người dùng đầu cuối của nguồn dữ liệu.
- 1 OpenFlow Switch bao gồm ít nhất 3 thành phần:
   + **Flow table**: trách nhiệm kết nối với switch để chỉ ra cách xử lí flow ra sao, mỗi hành động tương ứng 1 **Flow-entry**
   + **Secure Channel**: Kết nối switch với controller sử dụng giao thức **OpenFlow** chạy qua **Secure Socket Layer** để gửi các **commands** và **Packets**.
   + **Openflow Protocol**


**Docs**
- https://github.com/hocchudong/thuctap032016/blob/master/ThaiPH/SDN/ThaiPH_SDN_OpenFlow.md
- https://github.com/hocchudong/thuctap012017/blob/master/TamNT/TimHieuSDN/docs/1.Gioi_thieu_SDN-OpenFlow.md
- https://github.com/hocchudong/thuctap032016/blob/master/ThaiPH/SDN/ThaiPH_SDN_OpenFlow.md
