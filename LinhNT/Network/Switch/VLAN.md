## Virtual LAN (VLAN)
___
Trước khi tìm hiểu về VLAN, chúng ta sẽ tìm hiểu trước về **broadcast domain** 
> **Broadcast domain** is the domain in which a broadcast is forwarded. Một **broadcast domain** chứa các thiết bị có thể kết nối được với nhau(một thiết bị có thể nhận được **broadcast frame** từ bất kì thiết bị nào khác trong vùng) tại **data link layer** bằng cách sử dụng **broadcast**.

**NOTE** : 
+ Tất cả các ports thuộc switch hay hub đều thuộc 1 broadcast domain
+ Các ports của router thì thuộc các broadcast domain khác nhau và routers không forward broadcasts giữa các broadcast domains.
![](https://study-ccna.com/wp-content/images/broadcast_domains.jpg)

### VLAN là gì ?
___
> **VLANs** là các nhóm thiết bị ở trong cùng một **broadcast domain**. Đây là các miền do chính **switch** tạo nên.

### Khi nào sử dụng VLAN ?
___
Mạng VLAN được dùng trong những trường hợp sau
+ Hệ thống thiết bị trong mạng LAN quá lớn (>  200 máy)
+ Bảo mật
+ Có quá nhiều lưu lượng quảng bá

**NOTE** : Để kết nối 2 VLANs với nhau -->  Cần sử dụng **router** hoặc **switch layer 3**.

### VLAN trunk
___
VLAN tổ chức trên nhiều switch như vậy, làm sao để các thiết bị thuộc cùng VLAN có thể connect tới nhau.
###### Cách 1: Dùng mỗi kết nối cho từng VLAN
![](https://www.totolink.vn/public/uploads/img_article/vtplagivlantrunkingprotocollagiduongtrunklagi.png)

**Nhược điểm** : Vậy nếu có n VLAN thì chúng ta phải tạo ra n dây nối --> Lãng phí
###### Cách 2: Sử dụng trunk
> **Trunk** : là kết nối point-to-point giữa router với switch và switch với switch, và cho phép ***vận chuyển data của nhiều VLAN thông qua 1 liên kết đơn***. Giao thức được sử dụng: **802.11Q**.

> `Trunk` giúp các gói tin thuộc nhiều VLAN khác nhau đi qua **trunk link** này. Gói tin đi từ switch này tới switch khác hoặc switch tới router được tag **vlanID** chỉ định, còn các gói tin đi qua link access thì không có vlan ID.

### Access port và trunk port
___
> `Access port` or `untagged port`: là một **switch port** - chuyển lưu lượng tới **1 VLAN**.

> `Trunk port` or `tagged port` : là một **switch port** - chuyển lưu lượng tới **nhiều VLANs**.

Khi frames đi qua **trunk port** thì **VLAN tag** được thêm vào frames để phân biệt từng frame với từng VLAN khác nhau.

`Native VLAN` là 1 một VLAN mà các traffic sẽ không có tag (**untagged traffic**) khi qua **trunk port**
**NOTE** : Để các computers ở các VLAN khác nhau thì cần phải sử dụng thiết bị ở layer3 như router hoặc switch layer 3.

### Giao thức 802.1Q
___
![](https://www.totolink.vn/public/uploads/img_article/vtplagivlantrunkingprotocollagigiaothuc8021q.png)

Đây là giao thức chuẩn để nhận dạng các VLAN bằng cách thêm vào **frame header** --> **frame tagging method**

### VLAN trunking protocol (VTP)
___
**Khái niệm**
> `VTP` là giao thức hoạt động tại **Data link layer**. **VTP** giúp việc cấu hình VLAN luôn cập nhật và đồng nhất khi có các thay đổi: thêm, sửa, xóa,..Về VLAN trong mạng bằng việc cấu hình trên **VTP server**.

**Cách hoạt động**
![](https://www.totolink.vn/public/uploads/img_article/vtplagivlantrunkingprotocollagihoatdongcuavtp.png)

+ ***VTP mesages*** được gửi trong **VTP domain** mỗi **5ph/lần** hoặc khi **có sự thay đổi** trong mạng.
+ ***Mỗi VTP message*** bao gồm: `revision-number`, **tên VLAN**, **số hiệu VLAN**. Khi cấu hình VTP server và quảng bá VTP messages thì tất cả các switch sẽ update và đồng bộ. Khi VTP server thay đổi bất cứ thông số nào VLAN, nó sẽ tăng **revision-number thêm 1** và quảng bá **VTP message** đi **VTP domain**. Nếu switch nhận được **một VTP message** với **revision-number lớn hơn** ---> Nó sẽ cập nhật cấu hình VLAN.

**Các cơ chế**
![](https://www.totolink.vn/public/uploads/img_article/vtplagivlantrunkingprotocollagi3cochehoatdongcuavtp.png)

+ **Switch ở chế độ VTP Server** : tạo, sửa, xóa, VLAN. *Lưu* cấu hình VLAN trong **NVRAM** của nó. VTP server gửi VTP message trên các tất cả các **trunk links**
+ **Switch ở chế độ VTP Client** : đáp ứng, làm theo mọi thay đổi từ VTP server và gửi thông tin quảng bá ra các **trunk links**.
+ **Switch ở chế độ VTP transparent** : chức năng quan trọng nhất là **chuyển tiếp VTP messages**.

**Kịch bản** 
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/VTP.PNG)

Xây dựng mô hình 3 VLANs (VLAN 10, 20, 30): có 3 switches (vtp client, vtp server, vtp transparent)
## References
___
[Overview](https://www.totolink.vn/article/97-vtp-la-gi-vlan-trunking-protocol-la-gi.html)


