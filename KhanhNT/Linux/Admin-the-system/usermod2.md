# Command `usermod` and options

## `usermode [option] [username]`

## 1. Thêm/xóa user vào group
- Add 1 user vào group:
  + `sudo usermode -a -G root user1`

```  
với root là tên group
user1 là tên user cần add
```

- Add user vào nhiều group
   + `sudo usermode -a -G group1, group2, user1`
- Thêm nhiều user vào 1 group
   + `sudo gpasswd -M user1, user2, user3 group1`
- Xóa user khỏi 1 group
   + `sudo gpasswd -d username groupname`

```
corgi@ubuntu:~$ sudo groupadd test
[sudo] password for corgi: 
corgi@ubuntu:~$ cat /etc/group | tail -n5
corgi:x:1000:
lpadmin:x:110:corgi
sambashare:x:111:corgi
husky:x:1001:
test:x:1002:
```
```
corgi@ubuntu:~$ sudo useradd user1
corgi@ubuntu:~$ sudo useradd user2
corgi@ubuntu:~$ sudo useradd user3
corgi@ubuntu:~$ sudo gpasswd -M user1,user2,user3 test
```
```
corgi@ubuntu:~$ cat /etc/passwd | tail -n10
libuuid:x:100:101::/var/lib/libuuid:
syslog:x:101:104::/home/syslog:/bin/false
messagebus:x:102:106::/var/run/dbus:/bin/false
landscape:x:103:109::/var/lib/landscape:/bin/false
sshd:x:104:65534::/var/run/sshd:/usr/sbin/nologin
corgi:x:1000:1000:corgi,,,:/home/corgi:/bin/bash
husky:x:1001:1001::/home/husky:
user1:x:1002:1003::/home/user1:
user2:x:1003:1004::/home/user2:
user3:x:1004:1005::/home/user3:
```
## 2. Thay đổi thông tin user
- Thay đổi đường dẫn thư mục
 + `sudo usermode --home /home/user10/ user1
- Lock và unlock 1 user
 + `sudo usermode --lock user1`
 + `sudo usermode --unlock user1`


__Tài liệu tham khảo__
- http://gocit.vn/bai-viet/quan-ly-user-group-va-phan-quyen-tren-linux/
- https://vinasupport.com/quan-ly-user-group-tren-linux-bang-command-line/
- https://www.tecmint.com/manage-users-and-groups-in-linux/

