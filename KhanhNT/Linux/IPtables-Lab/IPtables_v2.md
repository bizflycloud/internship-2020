# IPTables v2

## 1. Netfilter Hooks
- Có 5 hook `netfilter`:
 - NF IP PRE_ROUTING: được kích hoạt bởi bất kì lưu lượng truy cập nào ngay khi vào mạng. Xử lí trước khi bất kì quyết định định tuyến nào được đưa ra.
 - NF IP LOCAL_IN: kích hoạt sau khi gói đến được định tuyến nếu gói được định sẵn cho hệ thống local.
 - NF IP FORWARD: kích hoạt sau khi gói đến được định tuyến nếu gói được chuyển tiếp đến máy chủ khác.
 - NF IP LOCAL_OUT: kích hoạt bởi lưu lượng truy cập ngoài được tạo cục bộ ngay sau khi nó tới ngăn xếp mạng.
 - NF IP POST_ROUTING: kích hoạt bởi lưu lượng đi hoặc chuyển tiếp sau khi định tuyến đã diễn ra và trước khi qua dây.


`Note: IPtables là giao diện dòng lệnh để tương tác với tính năng packet filtering của netfilter framework`

![](https://raw.githubusercontent.com/ImKifu/thuctapsinh/master/HungNK/Basic_Linux_Command/Picture/firewalld1.png)

![](https://news.cloud365.vn/wp-content/uploads/2019/08/hook-and-chain.png)

1. Chain PREROUTING: Rule trong chain được thực thi ngay khi có gói tin vừa vào đến network interface. Ở table: nat. mangle, raw
2. Chain INPUT: RULE trong chain này được thực thi ngay trước khi gói tin gặp tiến trình. Table: mangle và nat.
3. Chain OUTPUT: RULE thực thi sau khi gói tin được tiến trình tạo ra. Table: raw, mangle, nat và filter.
4. Chain FORWARD: RULE thực thi khi gói tin được định tuyến qua HOST hiện tại. Table: mangle và filter.
5. Chain POSTROUTING: RULE thực thi ngay sau khi gói tin rời giao diện mạng. Table: mangle và nat.

![](https://camo.githubusercontent.com/66e00a1be4adb9e6288545f12fde2dbe57163b99/687474703a2f2f692e696d6775722e636f6d2f5572304f35317a2e6a7067)

- Bước 1: Gói tin đi vào bảng raw, chain PREROUTING. IPTables xử lí là có hay không theo dõi kết mối này.
- Bước 2: chuyển gói tin đến bảng Mangle, chain PREROUTING. Nếu cần phải thay đổi giá trị của 1 số gói tin trước khi định tuyến thì ở bảng này. 
- Bước 3: gói tin đi vào bảng NAT, chain PREROUTING. Nếu cần DNAT thì sẽ xử lí bước này. 
- Bước 4: định tuyến 2 TH
 - TH1: gói tin vào mạng khác: nhánh phải
 - TH2: gói tin thuộc firewall: nhánh trái
- __TH1:__ 
 - Bước 5: gói tin đến bảng MANGLE với chain FORWARD
 - Bước 6: gói tin đến bảng FORWARD, chain filter. Ở đây sẽ lọc các rules. Rule cho phép đi qua gói tin sẽ đến bảng tiếp theo, không thì sẽ dừng lại. 
- __TH2:__
 - Bước 7: gói tin đi vào bảng MANGLE, chain INPUT
 - Bước 8: Đến bảng filter, chain INPUT: lọc gói tin đi vào firewall
 - Bước 9: xử lí các gói tin. Nếu được cho phép, gói tin sẽ đến các dịch vụ server còn không thì bị bỏ đi.
 - Bước 10: định tuyến đến server

`Quá trình tiếp theo là các service từ firewall server đi ra`

- Bước 11: Bảng raw, chain OUTPUT: cho phép gói tin ra mạng khác, xem có cần theo dõi kết nối hay không.
- Bước 12: Bảng mangle, chain OUTPUT
- Bước 13: Bảng NAT, chain OUTPUT
- Bảng 14: Bảng filter, chain OUTPUT: lọc gói tin từ filter ra mạng khác.
- Bước 15: gói tin đi ra mạng khác
- Bước 16: Đến mảng MANGLE, chain POSTROUTING.
- Bước 17: Bảng NAT, chain POSTROUTING 


## 2. IPTables Rules:
- 2 yếu tố của rules là : _match_ và _target_.
- Cấu trúc của bảng IPTables:

`iptables -> Tables -> Chains -> Rules.`

![](https://raw.githubusercontent.com/ImKifu/thuctapsinh/master/HungNK/Basic_Linux_Command/Picture/netfilter1.png)

### 2.1 Matching:
- Để 1 rule trong iptables được xem là matched thì gói tin đi qua phải đáp ứng các tiêu trí rule đó để hành động tiếp hoặc __target__ được thực thi.
- Tiêu chí match: protocol, dest, source address, input/output interface, header, state kết nối. 

### 2.2 Target:
- **Terminating target**
- **Non-terminating target**

### 2.3 Các rule:
- Kiểm tra các rule trong iptables:
`iptables -L -v`

- TARGET: Hành động sẽ thực thi
- PROT: protocol
- IN: rule áp dụng cho gói tin từ interface đi nào
- OUT: rule áp dụng cho các gói tin từ interface ra.
- DESTINATION: địa chỉ các lượt truy cập được phép áp dụng quy tắc. 
 
![](https://www.upsieutoc.com/images/2020/08/07/Screenshot-from-2020-08-07-15-47-07.png)

## 3.Các tùy chọn:

### 3.1 Các tùy chọn chỉ thông số

- Chỉ định tên table: **-t**
 - **-t filter**,** -t nat**, nếu không có -t mặc định là table filter. 
- Chỉ định loại giao thức: __-p__
 - __-p tcp __, __-p udp__, __-p!udp__
- Chỉ định card mạng vào: __-i__
- Chỉ định card mạng ra: __-o__
- Chỉ source add: __-s <ip nguon>__ 
- Chỉ dest add: __-s <ip dich>__
- Chỉ định cổng nguồn\đích: __--sport__, __--dport__


### 3.2 Các tùy chọn với chain:
- Tạo chain mới: iptables -N
- Xóa các rule đã tạo trong chain: iptables -X 
- Đặt các chính sách cho các chain: iptables -P
- Liệt kê các rule có trong chain: iptables -L
- Xóa các rule có trong chain: iptables -F

### 3.3 Các tùy chọn với rule: 
- Thêm rule: -A (append)
- Xóa rule: -D (delete)
- Thay thế rule: -R (replace)
- Chèn thêm rule: -I (insert)
