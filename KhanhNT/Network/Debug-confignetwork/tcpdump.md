# TCPdump
## 1. Giới thiệu:
- `TCPdump` là chương trình phân tích gói tin cho phép theo dõi băng thông mạng thông qua việc lưu trữ dữ liệu (packet) truyền tải trên mạng, có thể `capture` vào file để phục vụ công việc phân tích.

## 2. Tính năng:
- Bắt các bản tin và lưu vào định dạng PCAP (có thể đọc được bởi Wireshark).
- Tạo các bộ lọc `filter` để bắt các bản tin cần thiết.

## 3. Option của TCPdump

|Option|Tác dụng|
|------|--------|
|-i|sử dụng khi cần bắt các gói tin trên interface chỉ định|
|-D|Liệt kê tất cả các interface trên máy mà có thể capture được|
|-c N|Ngừng hoạt động khi capture N gói tin|
|-n|Không phân giải địa chỉ sang hostname|

## 4. 1 số lệnh cơ bản
### 4.1 Bắt gói tin từ 1 giao diện ethernet
- `tcpdump -i [interface]` 

```
corgi@corgi:~$ sudo tcpdump -i enp1s0
[sudo] password for corgi: 
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on enp1s0, link-type EN10MB (Ethernet), capture size 262144 bytes
09:36:06.811316 ARP, Request who-has 192.168.18.76 tell 192.168.18.1, length 46
09:36:06.813552 IP 192.168.18.173.35312 > 45.124.93.62.domain: 24445+ PTR? 76.18.168.192.in-addr.arpa. (44)
09:36:06.813571 IP 192.168.18.173.35312 > dns.google.domain: 24445+ PTR? 76.18.168.192.in-addr.arpa. (44)
09:36:06.813581 IP 192.168.18.173.35312 > resolver1.opendns.com.domain: 24445+ PTR? 76.18.168.192.in-addr.arpa. (44)
09:36:06.814130 IP dns.google.domain > 192.168.18.173.35312: 24445 NXDomain* 0/1/0 (99)
09:36:06.814182 IP 45.124.93.62.domain > 192.168.18.173.35312: 24445 NXDomain* 0/1/0 (99)
09:36:06.814242 IP resolver1.opendns.com.domain > 192.168.18.173.35312: 24445 NXDomain* 0/1/0 (99)
81 packets captured
88 packets received by filter
7 packets dropped by kernel
4 packets dropped by interface

```

- Packet capture: Số lượng gói tin bắt được và xử lí.
- Packet received by filter: Số lượng gói tin nhận được bởi bộ lọc.
- Packet dropped by kernel: Số lượng packet bị dropped bởi cơ chế bắt gói tin của hệ điều hành.

### 4.2 Định dạng chung 1 dòng giao thức tcpdump

```
09:36:12.175199 IP 192.168.18.44.37387 > 239.255.255.250.1900: UDP, length 172
```

`time-stamp src > dst: flags data-seqno ack window urgent options`

|Tên trường|Mô tả|
|----------|-----|
|Time-stamp|Thời gian gói tin được capture|
|Src > dst|ip nguồn và ip đích|
|Flags| S(SYN): Quá trình bắt tay giao thức TCP
|| .(ACK): Thông báo cho bên gửi biết gói tin đã nhận được dữ liệu thành công|
|| F(FIN): Đóng kết nối TCP|  
|| P(PUSH): Đánh dấu việc truyền dữ liệu|
|| R(RST): Sử dụng khi muốn thiết lập lại đường truyền|
|Data-sqeno| Số sequence number của gói dữ liệu hiện tại|
|ACK| Số Sequence number tiếp theo của gói tin do bên gửi truyền (Số sequence number mong muốn nhận được)|
|Window| Vùng đệm có sẵn theo hướng khác|
|Urgent|Dữ liệu khẩn cấp trong gói tin|

### 4.3 Bắt số lượng gói tin nhất định
- `tcpdump -i [device_name] -c [number]`

```
corgi@corgi:~$ sudo tcpdump -i enp1s0 -c 5
[sudo] password for corgi: 
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on enp1s0, link-type EN10MB (Ethernet), capture size 262144 bytes
09:53:32.914282 ARP, Request who-has 192.168.18.42 tell 192.168.18.88, length 50
09:53:32.915840 IP 192.168.18.173.35312 > 45.124.93.62.domain: 638+ PTR? 42.18.168.192.in-addr.arpa. (44)
09:53:32.915859 IP 192.168.18.173.35312 > dns.google.domain: 638+ PTR? 42.18.168.192.in-addr.arpa. (44)
09:53:32.915878 IP 192.168.18.173.35312 > resolver1.opendns.com.domain: 638+ PTR? 42.18.168.192.in-addr.arpa. (44)
09:53:32.916270 IP dns.google.domain > 192.168.18.173.35312: 638 NXDomain* 0/1/0 (99)
5 packets captured
18 packets received by filter
8 packets dropped by kernel
```

```
corgi@ubuntu:~$ sudo tcpdump -i eth0 -c 10
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
08:44:04.003433 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 1135157062:1135157170, ack 934733836, win 270, options [nop,nop,TS val 4294949190 ecr 2215200538], length 108
08:44:04.004210 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 108, win 6175, options [nop,nop,TS val 2215200550 ecr 4294949190], length 0
08:44:04.004240 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 108:288, ack 1, win 270, options [nop,nop,TS val 4294949191 ecr 2215200550], length 180
08:44:04.004430 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 288, win 6175, options [nop,nop,TS val 2215200551 ecr 4294949191], length 0
08:44:04.005206 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 288:508, ack 1, win 270, options [nop,nop,TS val 4294949191 ecr 2215200551], length 220
08:44:04.005445 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 508, win 6175, options [nop,nop,TS val 2215200552 ecr 4294949191], length 0
08:44:04.005458 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 508:544, ack 1, win 270, options [nop,nop,TS val 4294949192 ecr 2215200552], length 36
08:44:04.005655 IP 192.168.56.1.53378 > 192.168.56.114.ssh: F
```

### 4.4 Bắt gói tin và ghi vào 1 file.
- `tcpdump -i [device_name] -c [number] -w [file path/file_name.pcap]`

```
corgi@corgi:~$ sudo tcpdump -i enp1s0 -c 5 -w /home/corgi/Desktop/test.pcap
tcpdump: listening on enp1s0, link-type EN10MB (Ethernet), capture size 262144 bytes
5 packets captured
17 packets received by filter
0 packets dropped by kernel
```

- Đọc gói tin pcap `tcpdump -r [file_name]`
  
```
corgi@corgi:~/Desktop$ tcpdump -r test.pcap
reading from file test.pcap, link-type EN10MB (Ethernet)
09:56:22.297916 IP 192.168.18.165.59955 > 239.255.255.250.1900: UDP, length 172
09:56:22.317488 IP hkg12s11-in-f14.1e100.net.https > 192.168.18.173.50002: Flags [P.], seq 4142402214:4142402267, ack 1316078479, win 628, options [nop,nop,TS val 2215752440 ecr 3093356127], length 53
09:56:22.317507 IP 192.168.18.173.50002 > hkg12s11-in-f14.1e100.net.https: Flags [.], ack 53, win 501, options [nop,nop,TS val 3093385582 ecr 2215752440], length 0
09:56:22.318663 IP hkg12s11-in-f14.1e100.net.https > 192.168.18.173.50002: Flags [P.], seq 53:84, ack 1, win 628, options [nop,nop,TS val 2215752441 ecr 3093356127], length 31
09:56:22.318675 IP 192.168.18.173.50002 > hkg12s11-in-f14.1e100.net.https: Flags [.], ack 84, win 501, options [nop,nop,TS val 3093385583 ecr 2215752441], length 0
```

### 4.5 Bắt gói tin với các địa chỉ IP
- `tcpdump -n`

```
corgi@corgi:~$ sudo tcpdump -i enp1s0 -c 5 -n
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on enp1s0, link-type EN10MB (Ethernet), capture size 262144 bytes
10:00:26.227033 IP 192.168.18.160.17500 > 255.255.255.255.17500: UDP, length 134
10:00:26.227224 IP 192.168.18.160.17500 > 192.168.18.255.17500: UDP, length 134
10:00:26.717717 IP 192.168.18.147.60110 > 239.255.255.250.1900: UDP, length 172
10:00:26.836863 ARP, Request who-has 192.168.18.132 tell 192.168.18.1, length 46
10:00:26.952791 STP 802.1w, Rapid STP, Flags [Learn, Forward, Agreement], bridge-id 8000.50:f7:22:de:02:95.8005, length 43
5 packets captured
5 packets received by filter
0 packets dropped by kernel
```

### 4.6 Bắt gói tin theo địa chỉ nguồn và đích
- `tcpdump -i [device_name] src [ip]`
- `tcpdump -i [device_name] dst [ip]`

```
corgi@ubuntu:~$ sudo tcpdump -i eth0 src 192.168.56.1 -c 5
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
08:46:35.765816 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 1135666458, win 8641, options [nop,nop,TS val 2215352312 ecr 19835], length 0
08:46:35.766024 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 181, win 8641, options [nop,nop,TS val 2215352312 ecr 19836], length 0
08:46:35.767088 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 369, win 8641, options [nop,nop,TS val 2215352313 ecr 19836], length 0
08:46:35.767285 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 405, win 8641, options [nop,nop,TS val 2215352314 ecr 19836], length 0
08:46:35.767443 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 585, win 8641, options [nop,nop,TS val 2215352314 ecr 19836], length 0
5 packets captured
12 packets received by filter
1 packet dropped by kernel
```

### 4.7 Bắt gói tin trên 1 cổng cụ thể
- `tcpdump -i [device_name] port [port_number]`

```
corgi@ubuntu:~$ sudo tcpdump -i eth0 port 22 -c 5
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
08:47:25.378234 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 1135669534:1135669642, ack 934741416, win 270, options [nop,nop,TS val 32238 ecr 2215401913], length 108
08:47:25.378639 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 108, win 8641, options [nop,nop,TS val 2215401925 ecr 32238], length 0
08:47:25.378842 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 108:144, ack 1, win 270, options [nop,nop,TS val 32239 ecr 2215401925], length 36
08:47:25.379062 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 144, win 8641, options [nop,nop,TS val 2215401925 ecr 32239], length 0
08:47:25.379206 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 144:252, ack 1, win 270, options [nop,nop,TS val 32239 ecr 2215401925], length 108
5 packets captured
28 packets received by filter
16 packets dropped by kernel
```

### 4.8 Bắt gói tin theo 1 giao thức cụ thể
- `tcpdump -i [device_name] (not) [protocol]`

```
corgi@ubuntu:~$ sudo tcpdump -i eth0 tcp -c 3
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
08:48:37.873168 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 1136749838:1136749946, ack 934745776, win 270, options [nop,nop,TS val 50362 ecr 2215474409], length 108
08:48:37.873533 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 108:144, ack 1, win 270, options [nop,nop,TS val 50363 ecr 2215474409], length 36
08:48:37.873822 IP 192.168.56.1.53378 > 192.168.56.114.ssh: Flags [.], ack 108, win 12465, options [nop,nop,TS val 2215474420 ecr 50362], length 0
3 packets captured
18 packets received by filter
9 packets dropped by kernel
```

 + `not` sử dụng khi muốn bắt hết tất cả gói tin ngoại trừ gói tin thuộc protocol đó.

```
corgi@corgi:~$ sudo tcpdump -i enp1s0 -c 5 tcp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on enp1s0, link-type EN10MB (Ethernet), capture size 262144 bytes
10:03:08.407996 IP 192.168.18.173.46290 > 104.27.188.151.https: Flags [P.], seq 1937102988:1937103094, ack 1474474800, win 6785, length 106
10:03:08.408136 IP 192.168.18.173.46290 > 104.27.188.151.https: Flags [P.], seq 106:156, ack 1, win 6785, length 50
10:03:08.441586 IP 104.27.188.151.https > 192.168.18.173.46290: Flags [.], ack 156, win 83, length 0
10:03:08.493844 IP 104.27.188.151.https > 192.168.18.173.46290: Flags [P.], seq 1:153, ack 156, win 83, length 152
10:03:08.493904 IP 192.168.18.173.46290 > 104.27.188.151.https: Flags [.], ack 153, win 6785, length 0
5 packets captured
7 packets received by filter
0 packets dropped by kernel
2 packets dropped by interface
```

```
corgi@ubuntu:~$ sudo tcpdump -i eth0 dst 192.168.56.1 and port 22 -c 5
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
08:50:04.267233 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 1141539334:1141539442, ack 934749980, win 270, options [nop,nop,TS val 71961 ecr 2215560793], length 108
08:50:04.267569 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 108:144, ack 1, win 270, options [nop,nop,TS val 71961 ecr 2215560814], length 36
08:50:04.268338 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 144:288, ack 1, win 270, options [nop,nop,TS val 71961 ecr 2215560815], length 144
08:50:04.270028 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 288:508, ack 1, win 270, options [nop,nop,TS val 71962 ecr 2215560815], length 220
08:50:04.270501 IP 192.168.56.114.ssh > 192.168.56.1.53378: Flags [P.], seq 508:544, ack 1, win 270, options [nop,nop,TS val 71962 ecr 2215560815], length 36
5 packets captured
12 packets received by filter
1 packet dropped by kernel
```

__Tài liệu tham khảo__

- https://github.com/khanhnt99/meditech-thuctap/blob/master/MinhNV/Network%20Commands/docs/tcpdump.md
