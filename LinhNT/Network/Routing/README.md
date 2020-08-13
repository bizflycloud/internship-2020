## Routing 
___
##### 1. Static routing

##### 2. Dynamic routing
Đối với những topo mạng phức tạp, lớn việc sử dụng static routing là cực kì khó khăn. Vì vậy, **dynamic routing** ra đời với các protocols đi kèm giải quyết những mặt hạn chế của **static routing**. 

| Distance Vector Routing Protocols | Link State Routing protocols |
|---|---|
| RIP, IGRP,.. | OSPF, IS-IS|
|Gửi toàn bộ **routing table** tới neighbors kết nối trực tiếp với nó|Gửi **thông tin về các connected links** tới tất cả các router trong mạng|
|Chỉ biết thông tin các neighbors kết nối trực tiếp với nó| Mỗi router có cái nhìn về toàn mạng (chứa LSD - bản đồ toàn mạng ) | 
| |Gồm 3 bảng riêng biệt: **neighbor table**, **topology table** và **actual routing table** | 

**Tham khảo thêm**
![](https://i2.wp.com/study-ccna.com/wp-content/images/differences_distance_vector_link_state.jpg?resize=1400%2C9999&ssl=1)

## References
[All about distance vector and link state routing protocols](https://www.pluralsight.com/blog/it-ops/dynamic-routing-protocol#:~:text=Dynamic%20Routing%20Protocols-,Distance%20vector%20protocols%20send%20their%20entire%20routing%20table%20to%20directly,the%20routers%20in%20the%20network.&text=Link%20state%20routing%20protocols%20are,fast%20convergence%20and%20high%20reliability.)

[Different between distance vector protocols and Link state routing protocol](https://community.cisco.com/t5/switching/what-different-between-distance-vector-and-link-state-routing/td-p/2900912)
