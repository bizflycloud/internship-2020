# High Availability cho Database
## 1.Các giải pháp HA cho Database
- Giải pháp `Native`: Giải pháp được mysql/mariadb hỗ trợ:
  + Master - Slave
  + Master - Master
- Giải pháp `3rd party`: 
  + Galera
  + DRBD

## 2.Native
- Trên mỗi server sẽ có 1 user làm nhiệm vụ replication dữ liệu mục đích là giúp các server đảm bảo tính nhất quán về dữ liệu với nhau. 
- `Replication` là tính năng cho phép dữ liệu của (các) máy chủ Master được sao chép/nhân bản trên 1 hoặc nhiều máy chủ khác (Slave).
- Cơ chế hoạt động:
  + Máy chủ Master sẽ gửi các Binary-log đến máy chủ Slave. Máy chủ Slave đọc các Binary-log từ Master để yêu cầu truy cập dữ liệu vào quá trình `Replication`.
  + `Binary-log` chứa những bản ghi lại những thay đổi của các database.

### 2.1.Master - Slave
- Là kiểu giải phép HA cho DB mục đích để đồng bộ dữ liệu của DB chính (Master) sang 1 máy chủ DB khác (Slave).

![](https://camo.githubusercontent.com/2a88a7de2534edf4ffa928421565efc84ded05b0/687474703a2f2f696d6167652e70726e747363722e636f6d2f696d6167652f30643961306135353761653134663365383637376161653432383136323237632e706e67)

### 2.2.Master - Master
- 2 DB tự đồng bộ dữ liệu cho nhau.

![](https://camo.githubusercontent.com/c73010103ca9d192708d6210407fde3670706978/687474703a2f2f696d6167652e70726e747363722e636f6d2f696d6167652f34343235373762313631626534656336383030386565646266656233663839642e706e67)

## 3.Giải pháp 3rd party 
### 3.1.Galera
- __Galera Cluster__ là giải pháp tăng tính sẵn sàng cho các Database. Trong trường hợp máy chủ bị lỗi thì các máy chủ khác vẫn sẵn sàng hoạt động phục vụ các yêu cầu từ phía người dùng. 

![](https://camo.githubusercontent.com/27933150b5fb14f0f42ff755230c254c1f473486/687474703a2f2f696d6167652e70726e747363722e636f6d2f696d6167652f35333230333634326439376334383636626664666435326437653534616633332e706e67)

- Cluster có 2 mode hoạt động:
  + `Active-Passive`: Tất cả các thao tác ghi sẽ thực hiện ở `máy chủ Active`, sau đó sao chép sang `máy chủ Passive`.
  + `Active-Active`: Đọc-ghi dữ liệu diễn ra ở mỗi node. Khi có thay đổi, dữ liệu được đồng bộ tới tất cả các node.

### 3.2.DRDB (Distributed Replicated Block Device)
- Phục vụ sao chép dữ liệu từ thiết bị này sang thiết bị khác.
- Đảm bảo dữ liệu luôn được đồng nhất giữa 2 thiết bị.
- Việc sao chép ánh xạ với nhau theo thời gian thực.

### 3.3 Redundant Hardware - Sử dụng tài nguyên phần cứng.

### 3.4 Shared Storage
- NAS
- SAN

### 3.5 MySQL clustering 
### 3.6 Percona Cluster

![](https://camo.githubusercontent.com/687852af2e1cd378c5327109ca7f6e420afd2ac8/68747470733a2f2f626f6263617265732e636f6d2f77702d636f6e74656e742f75706c6f6164732f4d7953514c2d686967682d617661696c6162696c6974792d506572636f6e612d5874726144422e6a7067)

- Dữ liệu được đọc-ghi lên bất kì node nào trong mô hình. 1 máy chủ đứng trên tiếp nhận các truy vấn và phân phối lại đồng đều cho các server bên dưới.

__Tài liệu tham khả0__

- https://github.com/hoangdh/ghichep-drbd
- https://github.com/hoangdh/ghichep-database
__
