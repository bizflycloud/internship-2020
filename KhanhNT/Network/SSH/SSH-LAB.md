# LAB-SSH
## 1. Cài đặt SSH
- Trên Client
 + `sudo apt update`
 + `sudo apt install openssh-client`

- Trên server 
 + `sudo apt update`
 + `sudo apt install openssh-server`

## 2. Sử dụng SSH client
### 2.1 Kết nối tới SSH server
- `ssh <user_name>@<server_ip>`
- Sửa file cấu hình để kết nối qua port 
  + `ssh <user_name>@<server_ip> -p <port_number>`

- `vim  /etc/ssh/sshd_config`

```
# Package generated configuration file
# See the sshd_config(5) manpage for details

# What ports, IPs and protocols we listen for
Port 4444
# Use these options to restrict which interfaces/protocols sshd will bind to
#ListenAddress ::
#ListenAddress 0.0.0.0
...


RSAAuthentication yes
PubkeyAuthentication yes
#AuthorizedKeysFile     %h/.ssh/authorized_keys

# Don't read the user's ~/.rhosts and ~/.shosts files
IgnoreRhosts yes
# For this to work you will also need host keys in /etc/ssh_known_hosts
RhostsRSAAuthentication no
# similar for protocol version 2
HostbasedAuthentication no
# Uncomment if you don't trust ~/.ssh/known_hosts for RhostsRSAAuthentication
#IgnoreUserKnownHosts yes

# To enable empty passwords, change to yes (NOT RECOMMENDED)
PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no

# Change to no to disable tunnelled clear text passwords
PasswordAuthentication yes


```

- **PermitRootLogin**: 
  + Thay đổi `PermitRootLogin without-password` thành `PermitRootLogin yes` 
  + Nếu không cho phép tài khoản root đăng nhập đổi `yes` thành `no`.

- **Password Authentication**
  + Muốn enable `Password Authentication no` đổi thành `Password Authentication yes`

- `service ssh restart`

### 2.2 SSH-keygen
#### Bước 1: Tạo SSH key
- Bước đầu để cấu hình xác thực SSH key tới server là tạo **1 SSH key pair** trên client.
- Sử dụng **ssh-keygen** tạo ra 1 gặp key 2048 bit RSA.

```
root@ubuntu:~# ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): y
```
  + Key pair được lưu trữ trong thư mục `/root/.ssh/`
  + Private key được lưu trong `id_rsa`
  + Public key được lưu trong file `id_rsa.pub`
- `Enter passphrase (empty for no passphrase): `
  + Đây là cấu hình tùy chọn dùng `passphrase` để mã hóa **private key** để không người nào biết private key. 
  + Lợi ích của `passphrase`
      - Private key không bao giờ được chia sẻ trên mạng. Passphrase chỉ dùng để giải mã trên máy local.
      - Private key trong thư mục hạn chế với người dùng khác.
  + Thay đổi `passphrase của private key: `ssh-keygen -p`.

```
root@ubuntu:~# ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:CEXf47LgfcOcmkmINtSub/27mfydKE059YDzOqa2QRU root@ubuntu
The key's randomart image is:
+---[RSA 2048]----+
|     .o     E    |
|     . . .   .   |
|    .   . o ..   |
|     o . . oo o  |
|    . + S o  = o |
|   . + + * .+ . .|
|    + +.+ Bo o   |
|   . o...*o==o . |
|    .o. +oXOo.o  |
+----[SHA256]-----+

```

#### Bước 2: Gửi public-key lên SSH server
##### a) Sử dụng ssh-copy-id
- `ssh-copy-id` sẽ copy public key lên SSH server.
- `ssh-copy-id username@remote-host -p number_port`

```
root@ubuntu:~# ssh-copy-id root@192.168.17.50 -p 4444
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@192.168.17.50's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh -p '4444' 'root@192.168.17.50'"
and check to make sure that only the key(s) you wanted were added.
```
- Truy cập vào server mà không cần pass
 `root@ubuntu:~# ssh root@192.168.17.50 -p 4444
  Enter passphrase for key '/root/.ssh/id_rsa': `
 ( vì nhập passphrase nên vẫn cần nhập passphrase)

##### b) Copy public key sử dụng SSH
- `cat ~/.ssh/id_rsa.pub | ssh username@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"`

## 3. Sử dụng SCP
- Lệnh `scp` cho phép truyền file thông qua SSH.
- Cách sử dụng: 
   + Copy file từ remote server về máy SSH client.
   + Copy từ SSH client lên server.
- Copy 1 file từ SSH server về SSH client
 
 ```
root@ubuntu:~# scp root@192.168.17.50:/root/test.txt /root 
Enter passphrase for key '/root/.ssh/id_rsa': 
test.txt                                                                                                     100%    0     0.0KB/s   00:00    
root@ubuntu:~# ls
test.txt
```
  + Copy folder thêm tiền tố `-r`

## 4. Checking
- Các thông tin về ssh log lưu tại file `/var/log/auth.log`
 
```
root@ubuntu:~# tailf /var/log/auth.log 
Sep  4 08:09:08 ubuntu sshd[1143]: Received signal 15; terminating.
Sep  4 08:09:08 ubuntu sshd[1491]: Server listening on 0.0.0.0 port 22.
Sep  4 08:09:08 ubuntu sshd[1491]: Server listening on :: port 22.
Sep  4 08:09:20 ubuntu sshd[1495]: Accepted publickey for root from 192.168.17.44 port 35824 ssh2: RSA SHA256:CEXf47LgfcOcmkmINtSub/27mfydKE059YDzOqa2QRU
Sep  4 08:09:20 ubuntu sshd[1495]: pam_unix(sshd:session): session opened for user root by (uid=0)
Sep  4 08:09:20 ubuntu systemd-logind[827]: New session 5 of user root.
Sep  4 08:09:21 ubuntu sshd[1495]: Received disconnect from 192.168.17.44 port 35824:11: disconnected by user
Sep  4 08:09:21 ubuntu sshd[1495]: Disconnected from 192.168.17.44 port 35824
Sep  4 08:09:21 ubuntu sshd[1495]: pam_unix(sshd:session): session closed for user root
Sep  4 08:09:21 ubuntu systemd-logind[827]: Removed session 5.
```

**Tài liệu tham khảo:**
- https://github.com/khanhnt99/thuctap012017/blob/master/XuanSon/Netowork%20Protocol/SSH%20Protocol.md
- https://github.com/khanhnt99/thuctap012017/blob/master/TamNT/SSH/docs/2.Cau_hinh_va_Su_dung_SSH.md
- https://github.com/khanhnt99/thuctap012017/blob/master/TVBO/docs/Network_Protocol/docs/TimHieuSSH.md



