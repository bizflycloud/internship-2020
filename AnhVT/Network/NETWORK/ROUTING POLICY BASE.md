# ROUTING POLICY BASE

![ROUTING%20POLICY%20BASE/Untitled.png](ROUTING%20POLICY%20BASE/Untitled.png)

Các thuật toán tìm kiếm đường đi của TCP/IP thông thường chỉ phụ thuộc vào địa chỉ đích. Tuy nhiên, trong một số trường hợp Admin của hệ thống lại muốn dựa vào các thông số khác nhau của hệ thống để quyết định đường đi như: địa chỉ đích, nguồn, port đích,...

Linux cung cấp cho người sử dụng 1 giải pháp để giải quyết vấn đề này, chính là **Ip rule** và **Ip route**. Đây là công cụ cung cấp rất nhiều tính năng cũng như cách thức để chúng ta có thể thực hiện việc chọn đường đi của các gói tin dựa trên các yêu cầu khác nhau.

Các *table* và *rule* tạo nên khái niệm `Routing Policy Database` 

# 1.IP RULE

## 1.1 Xem các Rule:

Để thực hiện xem các rule hiện đang có trên hệ thống, ta sử dụng lệnh:

```bash
ip rule show
```

```bash
vutuananh@Localhost:~ ip rule show
0:	from all lookup local
32766:	from all lookup main
32767:	from all lookup default
```

## 1.2 Thực hiện thêm Rule

Để thực hiện thêm Rule, chúng ta cần xác định 3 thứ sau: **Điều kiện** - **Table** ( Bảng) - **Priority** (Mức ưu tiên)

***Đầu tiên chúng ta sẽ làm quen trước với các Điều kiện :***

- Source IP : Thực hiện xét địa chỉ nguồn của gói tin

    ```bash
    ip rule add from 192.168.1.0/24
    ```

- Destination IP : Thực hiện xét đại chỉ đích của gói tin

    ```bash
    ip rule add to 8.8.8.8 
    ```

- FWMARK : Sử dụng Iptable để đánh dấu gói tin, sau đó thực hiện chuyển các gói tin đi theo các đường khác nhau. Đây là 1 khái niệm tuy phức tạp hơn 1 chút nhưng bù lại cung cấp khả năng linh hoạt hơn rất nhiều. Giả sử chúng ta muốn định tuyến các gói tin HTTP từ giao diện mạng `ens0` :

    ```bash
    iptable -t mangle -A FORWARD -i ens0 --dport 80 -j MARK --set-mark 1
    ip rule add fwmark1 
    ```

- Dev: Xét dựa trên giao diện mạng

    ```bash
    ip rule add dev ens2
    ```

***Tiếp theo, chúng ta sẽ tìm hiểu tới các Table và Priority:***

Một Table cũng có thể coi như 1 rule → Nhiều Table khác nhau sẽ tạo nên 1 chuỗi Rule trong hệ thống của chúng ta. Chúng có thể được đánh số từ 0 → 400 triệu ( Thông thường chúng ta hoàn toàn không sử dụng nhiều đến như vậy ), tuy nhiên con số mặc định sẽ là từ 0 tới 32767. Số được gán cho 1 bảng được gọi là TableID.

Các Table sẽ được xét thứ tự từ 0 → 32767, con số càng nhỏ thì thứ tự ưu tiên càng lớn hay còn được gọi là Priority.

Vậy dựa trên các ví dụ bên trên, các câu lệnh hoàn chỉnh nên có dạng như sau:

```bash
ip rule add from 192.168.1.0/24 table 10 prio 10
```

hay

```bash
iptable -t mangle -A FORWARD -i ens 0 --dport 80 -j MARK --set-mark 1
ip rule add fwmark1 table 20 prio 5
```

Nếu mặc định không đặt Table ID thì các nó sẽ có giá trị từ cuối ( Mặc định là 32766 ) trừ đi 1.

Vậy các Table ban đầu có ý nghĩa gì ?

```bash
root@Localhost:~# ip rule show
0:	from all lookup local
32766:	from all lookup main
32767:	from all lookup default
```

1. `local` : Thực hiện việc định tuyến ( routing ) trong local host
2. `main` : Nếu các giao diện mạng được cấu hình chính xác, thì đây sẽ là nơi lưu các đường routing mặc định
3. `default` : Mục này thường được bỏ trống, các đường routing trong mục này sẽ có mức độ ưu tiên thấp nhất

## 1.3 Xóa 1 Rule

Việc thực hiện xóa rule có rất nhiều cách khác nhau. Có thể lựa chọn xóa rule dựa theo điều kiện, table hay là mức ưu tiên

```bash
ip rule del prio 10
ip rule del from 192.168.1.0/24
ip rule del table 1
ip rule del from 192.168.1.0/24 table 1 prio 10
```

Tùy theo độ tiện dụng có thể sử dụng khác nhau 

# 2. IP ROUTE

Như vậy chúng ta đã hiểu các khái niệm cơ bản như: Rule, Table, ... Nếu như 1 đường định tuyến khớp với 1 rule → nó sẽ được chuyển tới bảng đó → được áp dụng các điều kiện trong bảng. Các điều kiện trong bảng này được định nghĩa bằng **Ip route.**

## 2.1 Thực hiện xem các đường định tuyến trong 1 Table

Việc xem các đường Routing trong Table được thực hiện như sau: 

```bash
root@localhost /]# ip rule show  
0: from all lookup local  
32766: from all lookup main  
32767: from all lookup default  
[root@localhost /]#  
[root@localhost /]# ip route show table main  
10.10.15.0/25 dev eth0 proto kernel scope link src 10.10.15.46  
192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.10  
default via 10.10.15.1 dev eth0  
[root@localhost /]#
```

## 2.2 Thực hiện thêm đường định tuyến vào 1 Table

Việc thêm 1 đường Routing được thực hiện như sau :

```bash
[root@localhost /]# ip route show table main  
10.10.15.0/25 dev eth0 proto kernel scope link src 10.10.15.46  
192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.10  
default via 10.10.15.1 dev eth0  
[root@localhost /]#  
[root@localhost /]# ip route add 192.168.2.0/24 via 10.10.15.50 table main  
[root@localhost /]#  
[root@localhost /]# ip route show table main   
10.10.15.0/25 dev eth0 proto kernel scope link src 10.10.15.46  
192.168.2.0/24 via 10.10.15.50 dev eth0  
192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.10  
default via 10.10.15.1 dev eth0  
[root@localhost /]#
```

*Cần lưu ý rằng: Nếu chỉ thực hiện thêm 1 rule, thì rule đó theo mặc định sẽ không được xét ( do rỗng)*

Để tạo được 1 Table thực hiện được yêu cầu của chúng ta cần tuân thủ theo các bước sau:

1. Tạo rule : Như trong phần 1.2
2. Thêm các đường Routing vào Table vừa tạo.

→ Chỉ khi đó thì hệ thống sẽ thực hiện xét tới Rule bạn vừa tạo

## 2.3 Thực hiện xóa đường định tuyến trong 1 Table

Việc xóa được thực hiện thông lệnh `ip route del` , được thể hiện qua ví dụ sau:

```bash
[root@localhost ~]# ip route show table 10   
192.168.1.0/24 dev virbr0 scope link  
default via 192.168.1.254 dev eth1  
[root@localhost ~]#  
[root@localhost ~]# ip route del default table 10   
[root@localhost ~]#  
[root@localhost ~]# ip route show table 10   
192.168.1.0/24 dev virbr0 scope link  
[root@localhost ~]#  
[root@localhost ~]# ip route del 192.168.1.0/24 table 10   
[root@localhost ~]#  
[root@localhost ~]# ip route show table 10   
[root@localhost ~]#
```

---

## Nguồn tham khảo

[Linux Series - Policy Routing, ip rule, ip route](https://programmer.help/blogs/linux-series-policy-routing-ip-rule-ip-route.html)

[You Can't Get There From Here (Policy Based Routing)](https://dev.to/rkeene/you-can-t-get-there-from-here-policy-based-routing-55bh)

[Policy Routing in Linux](https://www.drdobbs.com/policy-routing-in-linux/199100936)

[Simple source policy routing](https://tldp.org/HOWTO/Adv-Routing-HOWTO/lartc.rpdb.simple.html)

[Linux policy routing](https://www.slideshare.net/thaobuithiphuong/linux-policy-routing)