# Virt-command tool
## 1. Giới thiệu
- Bộ câu lệnh virt gồm rất nhiều câu lệnh để quản lí máy ảo gồm:
  + virt-install: Cài đặt máy ảo
  + virt-viewer: console tới máy ảo
  + virt-log: Đọc log của máy ảo
  + virt-xml: dùng để sửa các cấu hình trong file xml
  + virt-edit: sửa cấu hình máy ảo

## 2. virt-install
### 2.1 Giới thiệu
- Là công cụ để tạo các máy ảo KVM, XEN hoặc LXC
- Sử dụng thư viện quản lí `hypervisor` là `libvirt`
- Hỗ trợ giao diện đồ họa cho máy ảo sử dụng `VNC` hoặc `SPICE` cũng như chế độ text thông qua console.
- VM có thể được cấu hình sử dụng 1 hoặc nhiều ổ đĩa ảo, nhiều interface mạng,...

### 2.2 Sử dụng
- Câu lệnh:
  + `virt-install [option]`

- Tạo máy ảo từ một image có sẵn

```
root@ubuntu:~# virt-install --connect qemu:///system --name ubuntu18 --ram 1024 --vcpus 2 --disk /root/ubuntu18.img --import --network network=default --graphics vnc,listen='0.0.0.0'
WARNING  KVM acceleration not available, using 'qemu'

(process:16964): Gtk-WARNING **: Locale not supported by C library.
	Using the fallback 'C' locale.

Starting install...
Creating domain...                                 |    0 B  00:07     

(process:17007): Gtk-WARNING **: Locale not supported by C library.
	Using the fallback 'C' locale.
```

```
trong đó:
- name: Tên máy ảo
- description: Mô tả Server
- os-type: các loaị hệ điều hành
- os-variant: Biến thể của hệ điều hành
- ram: bộ nhớ cho VM
- vcpu: tổng số Virtual CPU cho VM
- disk: đường dẫn đến file img
```

![](https://i.ibb.co/YNJSk4s/Screenshot-from-2020-10-24-09-34-58.png)

## 3. Webvirtmgr
### 3.1 Giới thiệu: 
- **Webvirtmgr** là một công cụ quản lí ảo hóa của libvirt tương tác dựa trên giao diện web.
- Cho phép tạo, sửa, xóa cấu hình mới các domain (bao gồm mạng ảo, máy ảo) và quản lí sự phân bố tài nguyên trên các domains.
- User có thể console với giao diện đồ họa tới máy ảo thông qua màn hình VNC viewer.

### 3.2. Cài đặt Webvirtmgr trên Ubuntu16.04
#### 3.2.1 Mô hình LAB

![](https://i.ibb.co/F3d9Dch/Screenshot-from-2020-10-24-10-12-56.png)

- **Webvirt-host**: Cài đặt Webvirtmgr
- **Linux1**: Cài đặt qemu để tạo các máy ảo
- **Linux2**: Cài đặt qemu để tạo các máy ảo

#### 3.2.2 Cài đặt Webvirtmgr

**Bước 1:**
- `apt-get update`
- `apt-get install git python-pip python-libvirt python-libxml2 novnc supervisor nginx`

**Bước 2: Cài đặt python và môi trường Django**
- Chạy các lệnh 
  + `git clone git://github.com/retspen/webvirtmgr.git`
  + `cd webvirtmgr`
  + `pip install -r requirements.txt`
  + `./manage.py syncdb`
  + `./manage.py collectstatic`

```  
root@ubuntu:~/webvirtmgr# ./manage.py syncdb
WARNING:root:No local_settings file found.
Creating tables ...
Creating table auth_permission
Creating table auth_group_permissions
Creating table auth_group
Creating table auth_user_groups
Creating table auth_user_user_permissions
Creating table auth_user
Creating table django_content_type
Creating table django_session
Creating table django_site
Creating table servers_compute
Creating table instance_instance
Creating table create_flavor

You just installed Django's auth system, which means you don't have any superusers defined.
Would you like to create one now? (yes/no): yes
Username: corgi
Email address: corgi@domain.local
Password: 
Password (again): 
Superuser created successfully.
Installing custom SQL ...
Installing indexes ...
Installed 6 object(s) from 1 fixture(s)
```

**Bước 3: Cài đặt Nginx**
- `cp -r webvirtmgr /var/www/`
- `vim /etc/nginx/conf.d/webvirtmgr.conf`

```
server {
    listen 80 default_server;

    server_name $hostname;
    #access_log /var/log/nginx/webvirtmgr_access_log; 

    location /static/ {
        root /var/www/webvirtmgr/webvirtmgr; # or /srv instead of /var
        expires max;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-for $proxy_add_x_forwarded_for;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_connect_timeout 600;
        proxy_read_timeout 600;
        proxy_send_timeout 600;
        client_max_body_size 1024M; # Set higher depending on your needs 
    }
}
```
- Comment tất cả các dòng trong `/etc/nginx/sites-enabled/default`
- `service nginx restart`
- `vi /etc/insserv/overrides/novnc`

```
#!/bin/sh
### BEGIN INIT INFO
# Provides:          nova-novncproxy
# Required-Start:    $network $local_fs $remote_fs $syslog
# Required-Stop:     $remote_fs
# Default-Start:     
# Default-Stop:      
# Short-Description: Nova NoVNC proxy
# Description:       Nova NoVNC proxy
### END INIT INFO
```
- `chown -R www-data:www-data /var/www/webvirtmgr`
- `vim /etc/supervisor/conf.d/webvirtmgr.conf`

```
[program:webvirtmgr]
command=/usr/bin/python /var/www/webvirtmgr/manage.py run_gunicorn -c /var/www/webvirtmgr/conf/gunicorn.conf.py
directory=/var/www/webvirtmgr
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/webvirtmgr.log
redirect_stderr=true
user=www-data

[program:webvirtmgr-console]
command=/usr/bin/python /var/www/webvirtmgr/console/webvirtmgr-console
directory=/var/www/webvirtmgr
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/webvirtmgr-console.log
redirect_stderr=true
user=www-data
```
- `service supervisor restart`

![](https://i.ibb.co/n6NXKPz/Screenshot-from-2020-10-24-10-43-13.png)


**Bước 4: Cài đặt QEMU trên Linux1 và Linux2**

- `apt-get install qemu-kvm libvirt-bin bridge-utils`




  




__Docs__
- https://dev.to/deepika_banoth/how-to-fix-locale-error-unsupported-locale-setting-on-pip-install-4noj








