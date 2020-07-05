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


