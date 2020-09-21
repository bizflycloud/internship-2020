# ARP Telnet Ping Traceroute

# ARP
- Lệnh dùng để xem hoặc thêm nội dung của bảng Kernel ARP.
- `arp ipaddress`
- `arp -a`
  + Hiển thị các giá trị hiện tại trong bảng ARP
- `arp -s [ipaddress] -i eth_addr [MAC address]`
  + Thêm 1 địa chỉ IP vào bảng ARP với địa chỉ IP và địa chỉ MAC.
- `arp -d [ip]`
  + Xóa địa chỉ IP khỏi ARP table

## Telnet
- Dùng để kết nối và giao tiếp với 1 máy chủ từ xa thông qua Telnet Protocol trong TCP/IP.
- `telnet [domain_name/ipaddress]`

## Ping
- Xác định khả năng máy tính người dùng có kết nối được đến máy tính đích.
- `ping [domain_name/ipaddress]`

## Traceroute
- Xác định đường đi được sử dụng đến đích 1 gói tin.
- Trong Linux, traceroute sử dụng gói UDP ở port (33434-33534).
- `traceroute [domain_name/ipaddress]`



