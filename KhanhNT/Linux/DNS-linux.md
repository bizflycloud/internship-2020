## 1. Giới thiệu:
- DNS (Domain Name System): Hệ thống phân giải tên miền.
- DNS server thực hiện việc gán domain, lập bản đồ tên miền tới địa chỉ IP.

## 2. Kiến trúc DNS
- Không gian tên miền (Domain name space)
- Tên miền (Domain name)
- Cú pháp tên miền (Domain name syntax)
- Internationalized domain names
- Name servers
- Authoritative name server

## 3. Nguyên tắc làm việc
![](https://media.bkns.vn/uploads/2019/12/nguyen-tac-lam-viec-cua-may-chu-dns.jpg)

- 1 trình duyệt tìm kiếm địa chỉ trang web thì DNS server phân giải.
- INTERNIC theo dõi các domain và DNS server tương ứng.
- Hệ thống phân giải tên miền có khả năng truy vấn DNS server khác để có tên đã phân giải.

## 4. Chức năng
![](https://media.bkns.vn/uploads/2019/12/chuc-nang-cua-dns.jpg)

- Các địa chỉ IP dùng để định danh tài nguyên mạng. Khi kết nối mạng với internet, mỗi địa chỉ IP gán cho 1 máy tính. Hệ thống phân giải domain giúp chuyển đổi những địa chỉ IP thành kí tự dễ hiểu. 
- Mỗi hệ thống phân giải tên miền có chức năng ghi nhớ domain mà nó đã phân giải và ưu tiên cho lần truy cập tiếp theo.
 
## 5. Nguyên lí hoạt động
![](https://media.bkns.vn/uploads/2019/12/dns-hoat-dong-nhu-the-nao.jpg)

- Ví dụ truy cập web abc.com
- B1: yêu cầu tìm kiếm địa chỉ IP ứng với tên miền abc.com được gửi từ client tới Name server cục bộ.
- B2: máy chủ domain cục bộ chuyển đổi từ tên miền sang địa chỉ IP của domain yêu cầu

## 6. DNS trên Linux server
- DNS server là 1 loại máy chủ dùng để quản lí và xử lí các tên miền.
- Cung cấp các dịch vụ phân giải tên miền cho máy chủ và máy khách web trên mạng dựa trên IP
 
### 6.1 Các loại DNS
- Recursive resolver
- Root nameserver
- TLD nameserver 
- Authoritative nameserver

### 6.2 Recursive resolver 
- Điểm dừng đầu tiên trong quá trình truy vấn DNS
- Cầu nối trung gian giữa client và DNS nameserver
- Truy vấn từ client web, recursive resolver phản hồi dữ liệu được lưu trong bộ nhớ cache hoặc gửi yêu cầu đến root nameservers, rồi đến TLD nameserver, cuối cùng là authoritative nameserver 
- Recursive resolver sẽ lưu trữ thông tin được nhận từ authoritative nameserver. Nếu yêu cầu IP giống với tên miền đã có thì sẽ cung cấp các bản ghi từ bộ nhớ cache. Bỏ qua hỏi nameservers.

### 6.3 Root nameservers
- Chứa các bản ghi gồm toàn bộ thông tin về tên miền cùng với địa chỉ IP ứng với tên miền đó.
- Thực hiện trả lời bằng cách hướng recursive resolver đến TLD nameservers dựa vào phần mở rộng tên miền đó. 

### 6.4 TLD nameservers
- Duy trì thông tin cho tất cả các tên miền có chung phần mở rộng. (.com, .net, ...)

### 6.5 Authoritative nameserver
- Recursive resolver nhận phản hồi từ TLD name server, phản hồi hướng đến authoritative nameserver. 

![](https://news.cloud365.vn/wp-content/uploads/2020/02/6a4a49_50da300f2194485f99e844f2b47d96f3mv2.png)

## 7. Lệnh dig
- dig: có thể truy vấn thông tin từ bản ghi DNS
- `dig <server> <name> <type>`

