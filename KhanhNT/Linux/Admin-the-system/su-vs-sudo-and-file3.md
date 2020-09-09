# Admin System
## 1. Phân biệt `su` và `sudo`
- Ta có thể sử dụng lệnh `su` để khởi chạy shell mới với tư cách người dùng khác.
  + `su [username]`
- Lệnh `su` là quyền hạn cao nhất của người dùng (root user)
- `sudo` chạy dòng lệnh sau khi được root cho phép.
- Khi dùng lệnh `sudo`, user phải nhập tài khoản và password hiện tại để chạy như 1 root. 

`sudo /usr/sbin/visudo`

## 2. File `/etc/passwd`
- File cung cấp thông tin về mỗi user như:
   + User ID
   + Group ID
   + Home Directory
   + Shell
- Định dạng mỗi dòng trong file là 1 thông tin user.
- 1 thông tin có 7 trường, tách nhau bởi dấu ':'
  
```
corgi@ubuntu:~$ cat /etc/passwd | tail -n3
user1:x:1002:1003::/home/user1:
user2:x:1003:1004::/home/user2:
user3:x:1004:1005::/home/user3:/bin/bash
1     2  3    4   5  6              7 
```
### 7 trường:
- 1: username 
- 2: Password 
- 3: User ID
- 4: Group ID
- 5: User ID info
- 6: Home directory 
- 7: Shell

## 3. File `/etc/shadow`
- Lưu thông tin mật khẩu đăng nhập của người dùng hệ thống.
- Chỉ quyền root mới được đăng nhập.

## 4. File `/etc/group`

```
corgi@ubuntu:~$ cat /etc/group | tail -n5
husky:x:1001:
test:x:1002:user1,user2,user3
user1:x:1003:
user2:x:1004:
user3:x:1005:

1     2  3   4
```

### 4 trường 
- 1: groupname
- 2: grouppassword (x cho biết mật khẩu shadow được sử dụng)
- 3: GID
- 4: Group-Password: danh sách người dùng là thành viên của nhóm

## 5. File `etc/sudoers`

```
corgi@ubuntu:~$ sudo cat  /etc/sudoers
Defaults	env_reset
Defaults	mail_badpass
Defaults	secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

# Host alias specification

# User alias specification

# Cmnd alias specification

# User privilege specification
root	ALL=(ALL:ALL) ALL

# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL

# Allow members of group sudo to execute any command
%sudo	ALL=(ALL:ALL) ALL

# See sudoers(5) for more information on "#include" directives:

#includedir /etc/sudoers.d
```

- __root ALL=(ALL:ALL) ALL__:root user có đặc quyền không giới hạn và có thể chạy bất kì lệnh nào trên hệ thống.
- __%admin ALL=(ALL) ALL__: `%` chỉ định 1 nhóm, bất cứ ai trong nhóm quản trị đều có quyền như root user.
- __%sudo ALL=(ALL:ALL) ALL__: Tất cả các users trong nhóm sudo có đặc quyền chạy bất kì lệnh nào.

__Tài liệu tham khảo__:
- https://www.hostinger.vn/huong-dan/cach-su-dung-sudo-va-file-sudoers/
- https://viblo.asia/p/difference-between-su-and-sudo-and-how-to-configure-sudo-in-linux-gDVK2822lLj
