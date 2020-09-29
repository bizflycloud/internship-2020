# LAB IP route

![](https://i.ibb.co/GcGJ9BD/Screenshot-from-2020-09-26-09-54-33.png)

- Sử dụng `ip route` để định tuyến giữa 2 vùng mạng.

- Trên Linux1:
  + `ip route add 192.168.2.0/24 via 192.168.1.2 dev ens3`
  
- Trên Linux3: 
  + `ip route add 192.168.1.0/24 via 192.168.2.2 dev ens3`

- Trên Linux2: 
  + `echo 1 > /proc/sys/net/ipv4/ip_forward`
  + `sysctl -w net.ipv4.ip_forward=1`
  + `cat /proc/sys/net/ipv4/ip_forward`
