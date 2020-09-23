# netstat
## 1. Giới thiệu
- `Netstat` là công cụ kiểm tra những dịch vụ đang kết nối đến hệ thống.

## 2. Các command
### 2.1 Liệt kê các port ở 2 trạng thái UDP và TCP
- `netstat -aut`

```
corgi@corgi:~$ netstat -aut
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 corgi:domain            *:*                     LISTEN     
tcp        0      0 localhost:ipp           *:*                     LISTEN     
tcp        0      0 corgi:41614             hkg12s16-in-f8.1e:https TIME_WAIT  
tcp        0      0 corgi:59040             server-13-225-89-:https TIME_WAIT  
tcp        0      0 corgi:32992             hkg12s17-in-f4.1e:https TIME_WAIT  
tcp        0      0 corgi:39556             sin10s06-in-f3.1e:https TIME_WAIT  
tcp        0      0 corgi:45446             ec2-18-136-214-20:https ESTABLISHED
tcp        0      0 corgi:35746             lb-140-82-112-25-:https ESTABLISHED
tcp        0      0 corgi:60752             hkg07s28-in-f14.1:https TIME_WAIT  
tcp        0      0 corgi:59892             151.101.65.195:https    ESTABLISHED
tcp        0      0 corgi:46840             hkg12s17-in-f2.1e:https TIME_WAIT  
tcp        0      0 corgi:55556             117.18.237.29:http      TIME_WAIT  
tcp        0      0 corgi:45364             ec2-18-136-214-20:https ESTABLISHED
tcp        0      0 corgi:54482             server-13-225-89-:https TIME_WAIT  
tcp        0      0 corgi:48530             hkg07s34-in-f2.1e:https TIME_WAIT  
tcp        0      0 corgi:46680             185.199.109.154:https   ESTABLISHED
tcp        0      0 corgi:40712             server-13-225-89-:https TIME_WAIT  
tcp        0      0 corgi:35240             hkg12s02-in-f13.1:https TIME_WAIT  
tcp        0      0 corgi:55586             117.18.237.29:http      TIME_WAIT  
tcp        0      0 corgi:36498             hkg07s24-in-f6.1e:https TIME_WAIT  
tcp        0      0 corgi:40714             server-13-225-89-:https TIME_WAIT  
tcp        0      0 corgi:39878             hkg07s24-in-f8.1e:https ESTABLISHED
tcp        0      0 corgi:56290             hkg07s34-in-f3.1e:https TIME_WAIT  
tcp        0      0 corgi:46676             185.199.109.154:https   ESTABLISHED
tcp        0      0 corgi:37542             ec2-52-35-220-92.:https ESTABLISHED
tcp        0      0 corgi:34118             hkg12s18-in-f14.1:https ESTABLISHED
tcp        0      0 corgi:46838             hkg12s17-in-f2.1e:https TIME_WAIT  
tcp        0      0 corgi:59552             sin10s06-in-f78.1:https TIME_WAIT  
tcp6       0      0 ip6-localhost:ipp       [::]:*                  LISTEN     
udp        0      0 *:51902                 *:*                                
udp        0      0 corgi:domain            *:*                                
udp        0      0 *:bootpc                *:*                                
udp        0      0 *:ipp                   *:*                                
udp        0      0 *:mdns                  *:*                                
udp        0      0 *:34576                 *:*                                
udp6       0      0 [::]:51292              [::]:*                             
udp6       0      0 [::]:mdns               [::]:*                             

```

```
-a: all tất cả các kết nối có trong hệ thống
-u: liệt kê các port ở trạng thái UDP
-t: Liệt kê các port ở trạng thái TCP
```

```
Proto: tên giao thức
Local Address: Địa chỉ IP của hệ thống và port kết nối
Foreign Address: Địa chỉ dịch vụ đang kết nối đến và số port
```

### 2.2 Liệt kê các port ở trạng thái Listening

- `netstat -l`

```
corgi@corgi:~$ netstat -l
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 corgi:domain            *:*                     LISTEN     
tcp        0      0 localhost:ipp           *:*                     LISTEN     
tcp6       0      0 ip6-localhost:ipp       [::]:*                  LISTEN     
udp        0      0 *:51902                 *:*                                
udp        0      0 corgi:domain            *:*                                
udp        0      0 *:bootpc                *:*                                
udp        0      0 *:ipp                   *:*                                
udp        0      0 *:mdns                  *:*                                
udp        0      0 *:34576                 *:*                                
udp6       0      0 [::]:51292              [::]:*                             
udp6       0      0 [::]:mdns               [::]:*                             
raw6       0      0 [::]:ipv6-icmp          [::]:*                  7          
Active UNIX domain sockets (only servers)
```
### 2.3 Thống kê giao thức
- `netstat -s`

```

corgi@corgi:~$ netstat -st
IcmpMsg:
    InType3: 104
    OutType3: 106
Tcp:
    1084 active connections openings
    1 passive connection openings
    14 failed connection attempts
    12 connection resets received
    6 connections established
    87716 segments received
    53248 segments send out
    199 segments retransmited
    2 bad segments received.
    980 resets sent
```

### 2.4 Hiển thị service name với PID

- `netstat -p`

### 2.5 Kiểm tra các dịch vụ kết nối đến port của hệ thống

- `netstat -tulnp`

```
corgi@corgi:~$ netstat -tulnp
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.1.1:53            0.0.0.0:*               LISTEN      -               
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      -               
tcp6       0      0 ::1:631                 :::*                    LISTEN      -               
udp        0      0 0.0.0.0:51902           0.0.0.0:*                           -               
udp        0      0 127.0.1.1:53            0.0.0.0:*                           -               
udp        0      0 0.0.0.0:68              0.0.0.0:*                           -               
udp        0      0 0.0.0.0:631             0.0.0.0:*                           -               
udp        0      0 0.0.0.0:5353            0.0.0.0:*                           -               
udp        0      0 0.0.0.0:34576           0.0.0.0:*                           -               
udp6       0      0 :::51292                :::*                                -               
udp6       0      0 :::5353                 :::*   

trong đó:


l: listen-các port của hệ thống đang mở và cho phép kết nối đến
n: numeric - output trả về các số
t: tcp - các kết nối dùng giao thức tcp
u: udp - các kết nối dùng giao thức udp
p: program - các chương trình đang kết nối đến

```

### 2.6 Tìm các cổng ứng với 1 chương trình đang chạy

- `netstat -ap | grep [protocol]`

```
corgi@ubuntu:~$ sudo netstat -ap | grep ssh
tcp        0      0 *:ssh                   *:*                     LISTEN      847/sshd        
tcp        0      0 192.168.56.114:ssh      192.168.56.1:53378      ESTABLISHED 1094/sshd: corgi [p
tcp6       0      0 [::]:ssh                [::]:*                  LISTEN      847/sshd        
unix  3      [ ]         STREAM     CONNECTED     10733    1094/sshd: corgi [p 
unix  2      [ ]         DGRAM                    10531    1094/sshd: corgi [p 
unix  3      [ ]         STREAM     CONNECTED     10740    1094/sshd: corgi [p 
```

### 2.7 Hiển thị bảng đinh tuyến

- `netstat -nr`

```
corgi@ubuntu:~$ netstat -nr
Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
192.168.56.0    0.0.0.0         255.255.255.0   U         0 0          0 eth0
corgi@ubuntu:~$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.56.0    *               255.255.255.0   U     0      0        0 eth0
```




