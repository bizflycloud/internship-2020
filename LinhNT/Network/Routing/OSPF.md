## OSPF (open shortest path first)
___
#### Khái niệm

> **OSPF** là một giao thức định tuyến `link-state`. Sử dụng trong mạng doanh nghiệp có kích thước lớn.

#### Cách hoạt động
> Mỗi router sau khi chạy giao thức sẽ gửi các trạng thái đường link của nó cho tất cả các router khác trong **area**. Sau một khoảng thời gian trao đổi, các router sẽ đồng bộ được LSDB (Link state Database) với nhau và trên mỗi router đều ***có bản đồ mạng của cả vùng***. Từ đó, mỗi router sẽ chạy giải thuật **Dijkstra** để tìm **SPT** (Shortest Path Tree) và từ SPT này để xây dựng nên **bảng định tuyến**.

#### Các yêu cầu để OSPF hoạt động
###### 1. Chọn Router-id
> Là **unique** để định danh mỗi router. Có định dạng như 1 địa chỉ IP.

> By default, các OSPF processes trên mỗi router sẽ tự động chọn **router-id** là địa chỉ IP cao nhất trong các interface đang active, ưu tiên cổng loopback.

Hoặc, chúng ta có thể cấu hình bằng cách sử dụng cmd :
```
Router (config) # router ospf 1

Router (config-router) # router-id A.B.C.D
```

###### 2. Thiết lập quan hệ với neighbor
> Routet chạy OSPF sẽ gửi **hello packet** tới tất cả các port chạy OSPF, **default** : **10s/lần**. **Hello packet** được gửi đến **multicast address** đành riêng cho OSPF là 224.0.0.5, đến tất cả các router. **Hello packet** giúp các router `tìm kiếm`, `thiết lập` và `duy trì` mỗi quan hệ này.

![](https://fossbytes.com/wp-content/uploads/2017/12/OSPF-Hello-packets-1200x723.jpg)

###### 3. Trao đổi LSDB
> **LSDB** là một tấm bản đồ mạng và router cần căn cứ bao đó để tính toán bàng định tuyến. **LSDB** trên các router phải hoàn toàn giống nhay đối với các router **trong cùng 1 area**.

**NOTE**

+ Các router sẽ không trao đổi với nhau cả bảng LSDB mà sẽ trao đổi với nhau từng đơn vị **LSA** (Link State Advertisement). 
+ Các đơn vị thông tin **LSA** được chứa trong gói tin **LSU** (Link State Update) mà các router trao đổi cùng nhau.

###### 4. Tính toán xây dựng bảng định tuyến.
> **By default**, OSPF sử dụng 100Mpbs làm reference BW. Nhưng hiện nay 1Gbps, 10 Gbps links trở nên phổ biến hơn. Do đó, chúng ta nên điều chỉnh **auto-cost** trong các OSPF routing process ở tất cả các router.

```
Metric = cost = 100 / BW (bps) 
```

![](https://s8182.pcdn.co/wp-content/uploads/2014/07/070214_1759_OSPFPART21.png)

**NOTE** : `loopback interface`

+ **loopback interface** là **logical interface**, chỉ là các interface ảo.
+ Việc sử dụng **loopback interface** cùng với cấu hình OSPF đảm bảo các OSPF processes luôn active.
+ Trong trường hợp chúng ta không configure 1 **loopback interface** thì **the highest active IP address** sẽ được lựa chọn làm **router-id**.

#### Demo
Sau đây, chúng ta sẽ thực hiện demo OSPF theo topo dưới đây: 
![](https://vnpro.vn/upload/user/images/Th%C6%B0%20Vi%E1%BB%87n/394.jpg)

## References
https://vnpro.vn/thu-vien/cau-hinh-dinh-tuyen-dong-ospf-2351.html

https://www.computernetworkingnotes.com/ccna-study-guide/ospf-configuration-step-by-step-guide.html
