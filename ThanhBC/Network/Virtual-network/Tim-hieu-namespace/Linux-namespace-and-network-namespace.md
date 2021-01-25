# Linux Network Namespace
## 1. Giới thiệu về  Linux Namespace
- **Namespaces** là tính năng của `Linux Kernel` để cô lập và ảo hóa tài nguyên hệ thống.
- **Namespaces** phân chia các tài nguyên hệ thống như 1 tập hợp các `tiến trình (process)`
![](nsimg/ns-kernel.png)
- Có 7 loại **Namespace** bao gồm:  
   + **Process ID(pid)**
   + **Mount(mnt)**
   + **Network (net)**
   + **Interprocess Communication (ipc)**
   + **UTS**
   + **User ID (user)**
   + **Control group (cgroup)**
- Mỗi **process** được liên kết với 1 namespaces và chỉ có thể nhìn thấy hoặc sử dụng tài nguyên liên quan đến namespaces, và namespaces `con` của namespaces đó nếu có. Bằng cách này, mỗi `process` có thể có caí nhìn độc lập về tài nguyên.

## 2. Linux Network Namespaces
- **Network namespace** là khái niệm cho phép bạn cô lập môi trường mạng `network` trong 1 host.
- Mỗi network interface(`physical and virtual`) có duy nhất 1 namespaces và có thể di chuyển giữa các namespaces.
- Mỗi namespaces có 1 bộ địa chỉ IP, bảng định tuyến, danh sách socket, firewall và các nguồn tài nguyên mạng riêng.
- Khi namespaces bị hủy, nó sẽ hủy tất cả các `virtual interface` bên trong nó và di chuyển tất cả các `physical interface` trở lại `network namespace root`

## 3. Các thao tác làm việc với `linux network namespaces`
- Ban đầu khi khởi động hệ thống Linux, ta sẽ có 1 namespace mặc định đã chạy trên hệ thống và mọi tiến trình mới tạo sẽ thừa kế namespace này - **root namespace**

![](https://github.com/khanhnt99/thuctap012017/raw/master/TamNT/Virtualization/images/7.1.png)

### 3.1 List namespaces
- `ip netns` or `ip netns list`

### 3.2 Add namespaces
- `ip netns add <Namespace_name>`

![](nsimg/root-ns.png)

```
[root@congthanh ~]# ip netns add ns0
[root@congthanh ~]# ip netns add ns1
[root@congthanh ~]# ip netns add ns2
[root@congthanh ~]# ip netns
ns0
ns1
ns2
```
Kiểm tra netwwork của các namespace.
- Network của namespace root
```
[root@congthanh ~]# ip a
```
![](nsimg/ns-a-root.png)
- Network của namespace ns0
```
[root@congthanh ~]# ip netns exec ns0 ip a
```
![](nsimg/ns-ip-ns0.png)

- Với mỗi namespaces được tạo mới, mỗi file mới sẽ được tạo ra trong thư mục `/var/run/netns`
```
[root@congthanh ~]# cd /var/run/netns/
[root@congthanh netns]# ll
total 0
-r--r--r--. 1 root root 0 Jan 24 03:19 ns0
-r--r--r--. 1 root root 0 Jan 24 03:19 ns0
-r--r--r--. 1 root root 0 Jan 24 03:19 ns1
```

### 3.3 Delete namespaces
- `ip netns delete <namespaces_name>`

```
[root@congthanh ~]#~$ ip netns delete ns2
[root@congthanh ~]#~$ ip netns
ns0
ns1
```
### 3.4 Executing commands from namespaces
- Để xử lí các lệnh trong 1 `namespaces (Không phải root namespaces)` sử dụng:
  + `ip netns exec <namespaces> <command>` 

```
[root@congthanh ~]#  ip netns exec ns0 ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
```
- Liệt kê tất cả các `interface` của các namespaces sử dụng `-a` hoặc `--all`

```
[root@congthanh ~]#  ip -a netns exec ip a

netns:  ns0
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

netns:  ns1
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
```
- Để sử dụng các câu lệnh với namespace ta sử dụng command bash để xử lý các câu lệnh trong riêng namespace đã chọn:
```
ip netns exec <namespace_name> bash
ip a #se chi hien thi thong tin trong namespace <namespace_name> 
```
Thoát khỏi vùng làm việc của namespace đó gõ `exit`.

Ví dụ:

```
[root@congthanh ~]# ip netns exec ns0 bash
[root@congthanh ~]# ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
[root@congthanh ~]# exit
```

__Docs__
- https://github.com/khanhnt99/thuctap012017/blob/master/TamNT/Virtualization/docs/7.Linux_network_namespace.md
- https://github.com/khanhnt99/thuctap012017/blob/master/XuanSon/Virtualization/Linux_Network_Namespaces/Linux_Network_Namespaces.md
- https://blogd.net/linux/gioi-thieu-ve-linux-namespaces/#:~:text=Linux%20Namespaces%20l%C3%A0%20m%E1%BB%99t%20c%C3%B4ng,c%C3%A1c%20t%C3%A0i%20nguy%C3%AAn%20t%C6%B0%C6%A1ng%20%E1%BB%A9ng.