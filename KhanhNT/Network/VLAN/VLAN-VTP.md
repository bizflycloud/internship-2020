# Switching
======================================================
## VLAN và ứng dụng VLAN
### 1. Collision domain: Miền đụng độ
  + Đụng độ xảy ra khi 2 hay nhiều máy truyền dữ liệu đồng thời trong 1 mạng chia sẻ
  + Đụng độ xảy ra các gói tin truyền đều bị phá hủy, các máy ngưng việc truyền dữ liệu và chờ 1 khoảng thời gian ngẫu nhiên theo luật của CSMA/CD
- Broadcast domain: Miền quảng bá
  + Unicast: gửi trực tiếp từ 1 máy đến 1 máy
  + Multicast: 1 máy gửi gói tin cho 1 nhóm máy
  + Broadcast: 1 máy gửi cho tất cả các máy trong mạng
  + Gói tin quảng bá thì địa chỉ MAC sẽ là FF:FF:FF:FF:FF:FF.
- Switch: ở tầng datalink, khi nhận được gói tin quảng bá thì nó sẽ gửi tất cả cổng của nó trừ cổng gói tin vào

### 2. VLAN:
+ Virtual LAN: kĩ thuật được sử dụng trên Switch, chia 1 switch vật lí thành nhiều switch logic.
+ Mỗi switch logic gọi là 1 VLAN, VLAN là tập hợp các cổng switch nằm trong cùng 1 miền quảng bá
+ Gói tin quảng bá truyền đến các thiết bị nằm trong cùng 1 VLAN, và không được truyền đến các VLAN khác
+ VLAN: là 1 tập hợp các switchport nằm trong cùng 1 broadcast domain, các cổng trên switch khác nhau có thể được nhóm vào các VLAN khác nhau trên từng switch hoặc trên nhiều switch

### 3. Các loại VLAN:
- Static VLAN:
  + Các cổng switch được cấu hình thuộc về 1 VLAN nào đó, các thiết bị thuộc cổng đó thuộc về VLAN định trước
- Dynamic VLAN:
  + Sử dụng 1 server lưu trữ điện chỉ MAC của các thiết bị mà VLAN đó thuộc về
  + Khi 1 thiết gắn vào Switch, Switch sẽ lấy địa chỉ MAC của thiết bị và gửi cho server kiểm tra và cho vào VLAN định trước

- Trunk:
    + Giải quyết vấn đề VLAN trên nhiều switch của thể kết nối với nhau
    + Kĩ thuật này cho phép dùng chung 1 đường kết nối vật lí cho dữ liệu của các VLAN đi qua
    + Để phân biệt người ta gán vào gói tin  1 dấu hiệu gọi là "tagging"
    + Dùng 1 kiểu đóng gói riêng cho các gói tin khi di chuyển qua đường "trunk" này.(801.1Q)(dot1q)

- Giao thức 802.1Q
    + Nhận dạng các vlan vào "frame header" đặc điểm 1 VLAN.(frame tagging)

            #switchport mode trunk
            #switchport trunk encapsulation dot1q

### 4. VLAN Trunking Protocol (VTP)
- Giao thức hoạt động ở tầng datalink ở mô hình OSI
- VTP giúp cấu hình VLAN luôn đồng nhất khi thêm, xóa, sửa thông tin về VLAN trong hệ thống mạng
- Cơ chế hoạt động:
    + VTP gửi thông điệp quảng bá "VTP domain" 5 phút 1 lần hoặc khi có sự thay dổi xảy ra trong cấu hình VLAN
    + Thông điệp VTP bao gồm: rivision number, VLAN name, VLAN number, thông tin switch có cổng gắn với mỗi VLAN
![](https://www.totolink.vn/public/uploads/img_article/vtplagivlantrunkingprotocollagihoatdongcuavtp.png)
+ Mỗi lần VTP Server điều chỉnh thông tin VLAN, tăng revision-number lên 1, rổi VTP Server gửi thông tin quảng bá VTP đi
+ Khi switch nhận VTP với revision number lớn hơn, nó sẽ cập nhật cấu hình VLAN
- VTP hoạt động 3 chế độ:
    + Server
    + Client
    + Transparent
![](https://www.totolink.vn/public/uploads/img_article/vtplagivlantrunkingprotocollagi3cochehoatdongcuavtp.png)
- VTP Server: 
    + Tạo, chỉnh sửa, xóa VLAN
    + VTP Server lưu cấu hình trong NVRAM 
    + Gửi thông điệp đến tất cả cổng trunk
- VTP Client:
    + Không tạo, sửa, xóa thông tin VLAN
    + Đáp ứng mọi sự thay đổi VLAN từ Server và gửi ra tất cả các cổng trunk 
- VTP transparent
    + Nhận và chuyển tiếp các thông điệp VTP mà không quan tâm nội dung thông điệp
    + Không cập nhật vào cơ sở dữ liệu của nó, chỉ có chức năng chuyển tiếp thông điệp
===============================================================================================

## VLAN Routing
- 1 máy tính trong 1 VLAN A muốn liên lạc với 1 máy tính khác trong 1 VLAN B thì phải qua thiết bị định tuyến
- Router trong VLAN:
    + Ngăn chặn quảng bá, bảo mật và quản lí các lưu lượng mạng
- Định tuyến cho các VLAN: switch tạo 3 VLAN, 1 cổng router kết nối với 1 cổng trên switch
-> trunk (trunk layer 3)
![](https://www.upsieutoc.com/images/2020/07/06/vlan-routing.png)
Ưu điểm: giảm số lượng cổng cần sử dụng của router và switch
===============================================================================================
