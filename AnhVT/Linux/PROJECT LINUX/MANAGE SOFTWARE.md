# MANAGE SOFTWARE

![MANAGE%20SOFTWARE/Untitled.png](MANAGE%20SOFTWARE/Untitled.png)

## 1. Khái niệm về Package

Một Package là 1 tập hợp các file phối hợp với nhau có nhiệm vụ cài đặt 1 ứng dụng cụ thể. Package bao gồm: script, thư viện, file text, ... Những thứ vừa được liệt kê được gọi là `dependencies` . Các `dependencies` này đảm bảo cho trình ứng dụng có thể cài đặt trên nền OS mà không gặp trở ngại gì. Một khi đảm bảo được điều kiện này thì việc cài đặt sẽ diễn ra mượt mà không diễn ra lỗi. 

## 2. Cách sử dụng Package

![MANAGE%20SOFTWARE/Untitled%201.png](MANAGE%20SOFTWARE/Untitled%201.png)

Trên ubuntu có các loại trình quản lý Package như : `dpkg` , `apt` , `apt-get` , `apt-get` . Việc cài đặt cũng như xóa gói tin hoàn toàn có thể thực hiện thông qua các trình quản lý này. 

*Một số câu lệnh cơ bản với các trình quản lý*

```bash
1. sudo apt-get update # Cau lenh nay update danh sach cac goi tin va phien ban cua no nhung khong tien hanh cai dat
2. sudo apt-get upgrade # Cau lenh nay tien hanh cai dat cac phien ban moi hon cua cac ung dung
3. sudo apt install <package_name> #Tien hanh cai dat 1 Package
4. sudo apt remove <package_name> # Go bo 1 package
5. sudo apt purge <package_name> # Go bo cac file config cua package
6. sudo apt autoremove # Don dep cac package cua he thong nhu cac thu vien,... sau khi go bo package
```

```bash
1. dpkg -i <package_name> # Tien hanh cai dat package
2. dpkg -l # liet ke cac package tren he thong hien tai
3. dpkg -r <package_name> # Xoa package
4. dpkg -P <package_name> # Xoa cac file config cua Package 
```

## 3. Cài đặt service systemd

![MANAGE%20SOFTWARE/Untitled%202.png](MANAGE%20SOFTWARE/Untitled%202.png)

Sau khi cài đặt package thì 1 số gói tin sẽ không tự động cài đặt nó làm service của `systemd` → Không tự khởi động khi hệ thống bootup. Việc cài đặt service sẽ làm cho process dễ quản lý hơn và đồng thời dễ dàng khôi phục nếu xảy ra lỗi. Các bước thực hiện có thứ tự như sau:  

- Bước 1 : Thực hiện tạo file cấu hình config cho `systemd`

```bash
sudo nano /etc/systemd/system/test.service
```

- Bước 2 : chỉnh sửa file cấu hình với nội dung có dạng như sau :

```bash
[Unit]
Description= Service # Mieu ta don gian ve service
After=network.target auditd.service # Service se khoi dong sau 2 dich vu nay

[Service]
Type=forking # Tien hanh Fork Child Process va thoat Parent Process
ExecStart=/usr/sbin/test # Noi luu cac lanh nhi phan cua ung dung
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process 
Restart=on-failure

[Install]
WantedBy=multi-user.target # Co the su dung boi nhieu user khac nhau
```

- Bước 3 : Tiên hành reload lại các dịch vụ nền ( daemon )

```bash
systemctl daemon-reload
```

- Bước 4 : Tiến hành Enable dịch vụ để nó tự khởi động khi hệ thống bootup

```bash
systemctl enable test
```

- Bước 5 : Tiến hành bật dịch vụ

```bash
systemctl start test
```

## 4. Cài đặt ứng dụng từ Source

![MANAGE%20SOFTWARE/Untitled%203.png](MANAGE%20SOFTWARE/Untitled%203.png)

Ngoài ra nếu người sử dụng không muốn cài đặt gói tin binary đã được compiled sẵn thì hoàn toàn có thể tự cài đặt gói tin từ Source để có thể có khả năng tùy chỉnh một số tính năng của ứng dụng. Việc cài đặt khá đơn giản và theo các bước sau:

1. Tiến hành cập nhật danh sách các phiên bản mới nhất của các package

    ```bash
    sudo apt-get update
    ```

2. Để có thể cấu hình được các gói tin nhị phân thì chúng ta cần 1 số `dependencies` để có thể giúp chúng ta làm điều này

    ```bash
    apt install build-essential dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev -y
    ```

3. Tiếp tục tải gói tin từ Source 

    Ở đây chúng ta sẽ ví dụ tải tệp tin Nginx v 1.18 

    ```bash
    wget http://nginx.org/download/nginx-1.18.0.tar.gz
    ```

4. Tiến hành cài đặt 

    ```bash
    $ make install 
    ```

    ```bash
    $ ./configure # Kiem tra cac dependencies cua goi tin 
    $ make all # Tien hanh Build Source code
    $ make install # Tien hanh cai dat
    ```

    Sau khi cài đặt có thể kiểm tra lại, ở ví dụ này chúng ta sử dụng

    ```bash
    nginx --version 
    ```

**Vậy là quá trình cài đặt đã hoàn tất, chúc bạn thành công!**

---

## Nguồn tham khảo

[Hướng dẫn sử dụng lệnh apt trên Ubuntu Linux - VinaSupport](https://vinasupport.com/huong-dan-su-dung-lenh-apt-tren-ubuntu-linux/)

[Linux Commands for Beginners 11 - Intro to Package Management on Debian-based Distributions](https://www.youtube.com/watch?v=yxc2ntmH9xY)

[What Is a Linux Package and How Do You Install Them](https://www.lifewire.com/guide-to-linux-packages-2202801)

[How To Install Software From Source on Ubuntu | Liquid Web](https://www.liquidweb.com/kb/how-to-install-software-from-source-on-ubuntu/)