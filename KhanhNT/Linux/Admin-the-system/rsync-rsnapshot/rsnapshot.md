# Rsnapshot
## 1. Khái niệm:
- Rsnapshot là giải pháp sao lưu, tạo sự luôn phiên backup giữa các thư mục trong local hoặc remote server

## 2. LAB

![](https://i.ibb.co/MDbPDhD/Screenshot-from-2020-09-10-09-41-21.png)

- Mô hình:
 + __Backupserver__: Ubuntu16.04-192.168.17.50/24
 + __Client__: Ubuntu16.04-192.168.17.44

- Cài đặt 
  + `sudo apt-get install rsnapshot`

### In __Backup Server__

- Create Backup directory
```
root@ubuntu:~# mkdir rsnapbackup
root@ubuntu:~# ls
dir1  dir2  rsnapbackup  test  test.txt
```

- Setup SSH  

```
root@ubuntu:~# ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:JkiEXiKadVpC5rmvdXuibA581UT8STpIaxT7n7Bhrbo root@ubuntu
The key's randomart image is:
+---[RSA 2048]----+
| .o.. .o.        |
|.o=o+ oo. .      |
|.=oB.o.o.+ .     |
|o oo .++o.o      |
|  . ..o S..      |
| . . . + * .     |
|  o + . o o      |
|   *...o.        |
|  .o+.E+         |
+----[SHA256]-----+
```
```
root@ubuntu:~# ssh-copy-id -i /root/.ssh/id_rsa.pub root@192.168.17.44
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@192.168.17.44's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@192.168.17.44'"
and check to make sure that only the key(s) you wanted were added.

# 192.168.17.44: ip client
```

