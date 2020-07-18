## Công nghệ EtherChannel
___
##### Tổng quan
> **EtherChannel** là công nghệ giúp **tăng băng thông** và **tăng khả năng dự phòng** bằng cách **kết hợp các links** mà vẫn đảm bảo **chống loop**.

> Đây là kĩ thuật kết hợp nhóm các đường truyền kết nối vật lí (**Link aggregation**) thành **1 đường ảo duy nhất** - có **port ảo** (thậm chí cả MAC ảo).

**NOTE**
+ Traffic không phải lúc nào cũng được phân bố đồng đều qua các link mà còn phụ thuộc vào **load balancing** mà switch sử dụng
+ Nếu 1 trong các link thuộc EtherChannel bị down thì traffic sẽ tự động được chuyển sang link khác. Khi link kia up, traffic sẽ được phân phối trở lại.

![](https://orbit-computer-solutions.com/wp-content/uploads/2015/10/Understanding-EtherChannel-Configuration-on-Cisco-Routers.png)

##### Điều kiện để cấu hình EtherChannel
-Các switch đều phải hỗ trợ EtherChannel và cấu hình đồng nhất giữa các port kết nối với nhau
-Các ports kết nối giữa 2 switches phải tương đồng nhau về:
+ Cấu hình
+ Tốc độ
+ Bandwidth
+ Full Duplex
+ Native VLAN và các VLANs
+ Switchport modes (Trunk, access)

##### Phân loại EtherChannel
Có 2 loại giao thức EtherChannel
###### 1. LACP (Link Agregation Control Protocol)
-Là giao thức cấu hình EtherChannel chuẩn quốc tế IEEE 802.3ad. Dùng được cho hầu hết các thiết bị khác nhau
-Hỗ trợ ghép tối đa 16 links vật lí (8 actives - 8 passives)
-LACP có 3 chế độ:
+ **on** : cấu hình tĩnh --> không có bước trao đổi policy giữa 2 bên switches --> dẫn đến loop và bị STP block
+ **active** : chế độ tự động - tự động thương lượng với đối tác.
+ **passive** : chế độ bị động - chờ được thương lượng.
###### 2. PAgP (Port Aggregation Protocol)
-Là giao thức cấu hình EtherChannel độc quyền cho các thiết bị của Cisco 
-Chỉ hỗ trợ ghép 8 links vật lí.
-PAgP cũng có 3 chế độ với các chức năng theo thứ tự tương ứng với LACP
+ **On**
+ **Desirable**
+ **Auto**


##### References
[](https://www.quora.com/Why-does-a-VLAN-interface-need-an-IP-address)
https://www.youtube.com/watch?v=d3x537-FBvE&t=729s
