# Bổ sung: Quá trình bắt tay 3 bước TCP
#### SYN: 
+ Các chương trình máy con (broswer, ftp, client) bắt đầu connect với máy chủ bằng cách tạo 1 packet với cờ SYN đến máy chủ
 
+ SYN packet được gửi đến các cổng cao (1024-65535) đến những cổng trong vùng thấp (1-1023) của máy chủ.

+ Máy con yêu cầu hệ điều hành để mở 1 cổng để connect với máy chủ (client port range), tương tự máy chủ (service port) 

#### SYN/ACK:
 
+ Khi đã yêu cầu mở connection, server gửi lại packet chấp nhận với 2 bit cờ SYN và ACK

+ SYN/ACK packet được gửi lại bằng cách đổi IP của client và server.
 
+ Client IP sẽ là IP đích và server sẽ là IP đầu.

+ Nếu server không chấp nhận connect, gửi ngược lại client bit RST/ACK (Reset Acknowledgement)

#### ACK:

+ Khi client nhận được SYN/ACK thì sẽ trả lời bằng ACK packet

==========================================================================

## IPv4:

+ Gồm 2 phần net_ID và host_ID

+ Các IP có cùng phần network gọi là cùng mạng

+ Có 32bit, chia làm 4 phần (octet)

+ 5 lớp: 

- A, B, C được dùng để gán cho các host

- D địa chỉ multicast

- E chưa dùng

#### Lớp A: 

+ 1 octect đầu làm phần network, 3 octect còn lại làm phần host

+ Bit đầu tiên octet là bit 0

+ 1 đến 126 (giá trị 0 không dùng, 127 làm địa chỉ loopback)

#### Lớp B:

+ Dành 2 octet đầu tiên làm net, 2 octet còn lại làm host

+ 2 bit đầu tiên là 10

+ 128 đến 191 (dưới dạng thập phân)

#### Lớp C:
+ 3 octet đầu làm net, 1 octet sau làm host

+ 3 bit đầu là 110

+ 192 đến 223

#### Lớp D:

+ Địa chỉ multicast, 4 bit đầu tiên là 1110

+ 224 đến 239

#### Lớp E:

+ 5 bit đầu tiên của octet là 11110

Network address: Tất cả các bit phần host là bit 0

Broadcast address: Tất cả các bit phần host là bit 1

Địa chỉ IP public và private

+ Class A: 10.0.0.0 -> 10.255.255.255

+ Class B: 172.16.0.0 -> 172.31.255.255

+ Class C: 192.168.0.0 -> 192.168.255.255

Subnet Mask:

+ Có chiều dài bit bằng với chiều dài địa chỉ IP

+ Chỉ ra bit nào thuộc phần host (bit 1), bit thuộc phần network (bit 0)

Kĩ thuật chia mạng con:

+ Gọi n là số bit mượn ở phần Host để chia subnet thì số mạng con là 2^n

+ m là số bit còn lại của phần host thì số host cho mỗi mạng con là 2^m - 2

+ n+m= số bit phần host ban đầu


================================================================================
