# DHCP
## 1. Khái niệm:
- Dynamic Host configuration protocol (Giao thức cấu hình máy chủ động)
- Laf giao thức để quản lí nhanh, tự động và tập trung vào việc phân phối địa chỉ IP bên trong 1 mạng.

## 2. Hoạt động:
- DHCP hoạt động dựa trên mô hình client-server.
- Mội thiết bị client yêu cầu 1 địa chỉ IP từ 1 router (host), sau đó host sẽ gán 1 địa chỉ IP khả dụng cho phép client giao tiếp mạng.
- DHCP server quản lí pool của IP address và thông số configuration client như default gateway, domain name, name servers và time servers.

## 3. Cách DHCP server allocating IP address:
- Dynamic allocation:
 + Network admin dự trữ 1 range của IP address cho DHCP, mỗi DHCP client trong LAN được cấu hình yêu cầu IP address từ DHCP server trong quá trình khởi động.
 + Quá trình request and grant sử dụng khái nệm "lease" với 1 khoảng time, cho phép DHCP server lấy lại IP address đã được assign trước đó.
- Automatic allocation: 
 + DHCP server gán vĩnh viễn IP address cho client yêu cầu từ range được định nghĩa bới admin.
 + DHCP server giữ table cung cấp IP address trong quá khứ để nó ưu tiên assign IP address giống IP address đã được assign trước đó.
- Manual allocation (static allocation): DHCP server assign IP address phụ thuộc vào MAC address từng client.

## 4. Hoạt động DHCP
![](https://blog.cloud365.vn/images/img-dhcp/2019-04-09_10-01.png)

- DHCP sử dụng UDP
- Hoạt động trong 4 bước:
 + Server discovery
 + IP lease offer
 + IP lease request 
 + IP lease acknowledgement

**(dora)**

- B1: Khi máy client khởi động, Client gửi __broadcast__ packet `DHCP DISCOVER`. Gói tin chứa địa chỉ MAC của client. Nếu client không liên lạc được tới DHCP server sau 4 lần truy cập, nó sẽ phát ra 1 địa chỉ IP riêng cho mình trong dãy 169.254.0.0 đến 169.254.255.255. Client vẫn duy trì phát tín hiệu Broadcast.

- B2: DHCP server khi nhận được yêu cầu, gửi lại cho máy client `DHCP offer`(bản tin broadcast), đề nghị được gửi 1 địa chỉ IP trong 1 khoảng thời gian. Kèm theo nó là Subnet Mask và Server IP address. 

- B3: Client gửi broadcast với gói tin `DHCP request` chấp nhận lời đề nghị.

- B4: Máy server được client chấp nhận gửi gói tin `DHCP ACK` xác nhận, cho biết địa chỉ IP, Subnet Mask, ngoài ra còn default gateway, DNS server. 

https://news.cloud365.vn/hoat-dong-cua-he-thong-dns/#more-4799

https://news.cloud365.vn/dns-va-cac-khai-niem-lien-quan/#more-4542
