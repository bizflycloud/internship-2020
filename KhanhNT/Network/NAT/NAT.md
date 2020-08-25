# NAT (Network Address Translation)
## 1.Khái niệm
- Là một kĩ thuật cho phép chuyển đổi từ 1 địa chỉ IP thành 1 địa chỉ IP Khác.
- Thường được sử dụng phổ biến trong mạng sử dụng địa chỉ cục bộ cần truy cập internet. 
- Vị trí thực hiện NAT là router biên kết nối giữa 2 mạng.

![](https://www.totolink.vn/public/uploads/img_article/3loainatnetworkaddresstranslationbancanbietnatlagi.png)

## 2. Địa chỉ IP private và địa chỉ IP public
### 2.1 Địa chỉ IP private
- 10.0.0.0 - 10.255.255.255
- 172.16.0.0 - 172.31.255.255
- 192.168.0.0 - 192.168.255.255

### 2.2 Địa chỉ IP public
- Các địa chỉ còn lại

## 3. Chức năng của NAT
- Giống 1 Router, nó chuyển tiếp các gói tin giữa những mạng khác nhau trong 1 hệ thống mạng lớn
- Chuyển đổi địa chỉ mạng riêng thành địa chỉ mạng công cộng
- Là 1 Firewall cơ bản

## 4. Các khái niệm liên quan
![](https://www.totolink.vn/public/uploads/img_article/3loainatnetworkaddresstranslationbancanbietmotsothuatngucanbietcuanat.png)

- Địa chỉ inside local: 
    + Là địa chỉ IP gán cho 1 thiết bị mạng bên trong.
    + Địa chỉ này không phải địa chỉ được cung cấp bởi NIC (Network Infomation Center)

- Địa chỉ inside global: là địa chỉ được đăng kí với NIC, dùng để thay thế 1 hay nhiều địa chỉ IP inside local.

- Địa chỉ outside local: 
    + Địa chỉ IP của 1 thiết bị bên ngoài khi nó xuất hiện trong mạng.

- Địa chỉ outside global: 
   + Địa chỉ IP gán cho 1 thiết bị mạng ngoài

![](https://camo.githubusercontent.com/e22662554c933f1c2e0b01876d27727b4324ad01/687474703a2f2f7777772e636973636f2e636f6d2f632f64616d2f656e2f75732f737570706f72742f646f63732f69702f6e6574776f726b2d616464726573732d7472616e736c6174696f6e2d6e61742f343630362d38612e676966)

- Các gói tin trong `Inside Network` sẽ có `SA` kiểu `Inside local` và `DA` kiểu `Outside Local`.Gói tin đo đi qua NAT, gửi tới mạng `Outside Network` thì gói tin có `SA` kiểu `Inside Global` và `DA` kiểu `Outside Global`.
- Các gói tin từ `Outside Network` được gửi trở lại với `DA` kiểu `Inside Global` và `SA` kiểu `Outside Global`. Gói tin này được gửi qua Router và xử lí bởi kĩ thuật NAT thì trong `Inside Network` đã có thông tin của máy dạng `Inside Local`

## 5. Static NAT
- 1 địa chỉ Inside Local luôn được ánh xạ vào địa chỉ Inside Global
- 1 địa chỉ Outside Local luôn ánh xạ vào 1 địa chỉ Outside Global (nếu có).

![](https://www.totolink.vn/public/uploads/img_article/3loainatnetworkaddresstranslationbancanbietcauhinhstaticnat.png)

- Cấu hình
 + `Router(config)# ip nat inside source static [local ip] [global ip]` 
 + `Router(config-if)# ip nat inside`
 + `Router(config-if)# ip nat outside`

## 6. Dynamic NAT
- Ánh xạ 1 địa chỉ IP này sang 1 địa chỉ IP khác 1 cách tự động

![](https://www.totolink.vn/public/uploads/img_article/3loainatnetworkaddresstranslationbancanbietdynamicnat.png)

- Xác định dải địa chỉ đại diện bên ngoài(public): các địa chỉ NAT
  + `Router(config)#ip nat pool [name start ip ][name end ip] netmask [netmask]/prefix-lenght [prefix-lenght]`

- Thiết lập ACL cho phép những địa chỉ nội bộ bên trong nào được chuyển đổi
  + `Router(config)#access-list [access-list-number-permit] source [source-wildcard]`

- Thiết lập mối quan hệ giữa các địa chỉ nguồn đã được xác định trong ACL với dải địa chỉ ra bên ngoài
   + `Router(config)#ip nat inside source list <acl-number> pool <name>`

- Xác định cổng kết nối mạng nội bộ
  + `Router(config-if) #ip nat inside`
- Xác định cổng kết nối ra ngoài
  + `Router(config-if) #ip nat outside`

## 6. NAT Overload
- 1 dạng Dynamic NAT, ánh xạ nhiều địa chỉ IP thành 1 địa chỉ IP (many to one)
- Dùng địa chỉ số cổng khác nhau để phân biệt từng chuyển đổi
- NAT overload còn có tên gọi là PAT(Port Address Translation)
- Mã hoá 16 bit, có 65536 địa chỉ chỉ nội bộ có thể chuyển sang địa chỉ Public

![](https://www.totolink.vn/public/uploads/img_article/3loainatnetworkaddresstranslationbancanbietoverloadnat.png)

- Xác định địa chỉ bên trong cần dịch chuyển ra ngoài
  + `Router(config)# access-list <ACL-number> permit <source> <wildcard mask>`
- Chuyển đổi địa chỉ IP sang cổng nối ra ngoài
  + `Router(config)# ip nat inside source list <ACL-number> interface <interface> overload`

- Xác định cổng nối với mạng trong và ngoài
  + `Router (config-if)# ip nat inside`
  + `Router (config-if)# ip nat outside`

## 6. Kiểm tra cấu hình NAT
- Kiểm tra NAT đang hoạt động
  + `R#show ip nat translation`
- Hiển thị trạng thái hoạt động của NAT
  + `R#show ip nat statistics`
- Xóa bảng NAT
  + `R#clear ip nat translation`

## 7. NAT trên Linux
- Công nghệ chuyển đổi địa chỉ NAT động và đóng giả IP Masquerade
- NAT router đảm nhận việc chuyển dãy IP nội bộ 192.168.0.x thành dãy IP mới 203.162.2.x.
- Packet với IP nguồn là 192.168.0.200 đến router, router chuyển IP nguồn thành 203.162.2.200 rồi gửi ra ngoài. (Source-NAT, NAT nguồn)
- Ngược lại packet gửi từ ngoài đổi địa chỉ đích 203.162.2.200 thành địa chỉ là 192.168.0.200. (Destination-NAT)
- NAT router chuyển dãy IP nội bộ thành 1 địa chỉ IP duy nhất, phân biệt từng liên kết qua các port
- Packet với nguồn 192.168.0.168:1204, đích 211.200.51.15:80 đến router.
  + Router sẽ đổi nguồn thành 203.162.2.4:26314
  + Lưu dữ liệu vào bảng masquerade động.  
  + Khi có gói dữ liệu từ  ngoài vào với nguồn là 221.200.51.15:80, đích 203.162.2.4:26314 đến router, router sẽ căn cứ vào bảng masquerade để đổi địa chỉ đích từ 203.162.2.4:26314 thành 192.168.0.164:1204

