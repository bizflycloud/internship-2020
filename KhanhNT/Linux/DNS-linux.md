# DNS
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
