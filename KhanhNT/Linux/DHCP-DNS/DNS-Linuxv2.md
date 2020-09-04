# DNS version2
## 1. DNS là gì
- Hệ thống cho phép tương ứng địa chỉ IP và tên miền internet

## 2. Chức năng của DNS
- Website có 1 tên (là tên miền hoặc đường dẫn URL: Uniform Resource Locator) và 1 địa chỉ IP
- Khi mở trình duyệt web, trình duyệt đến thẳng website mà không cần nhập IP trang web
- Quá trình dịch tên miền thành địa chỉ IP là việc của DNS server

## 3. Nguyên tắc làm việc

![](https://raw.githubusercontent.com/hocchudong/ghichep-DNS/master/images/dns-diagram.png)

## 4. Kiến trúc DNS
### 4.1 Không gian tên miền (Domain name space)

![](https://raw.githubusercontent.com/hocchudong/ghichep-DNS/master/images/domain-name-space.png)

- Là 1 kiến trúc dạng cây, có chứa nhiều node. Mỗi node trên cây sẽ có 1 nhãn, có 0 hoặc nhiều resource record (RR), chúng giữ thông tin liên quan tới tên miền.

### 4.2 Tên miền (Domain name)
- Được tạo thành từ các nhãn và phân cách nhau bằng dấu (.)

### 4.3 Cú pháp tên miền 
- Hệ thống tên miền tính theo hướng từ phải sang trái
- Ví dụ `example.com` là tên miền con của `com`, `www` là tên miền con của tên miền `example.com`

### 4.4 Máy chủ tên miền (Name servers)
- Chứa thông tin lưu trữ của không gian tên miền
- Hệ thống tên miền được vận hành bởi hệ thống dữ liệu phân tán, dạng client-server.
- Thông tin máy chủ tên miền sẽ được lưu trữ trong các **zone**.
- Có 2 dạng Name server (NS) là primary và secondary

### 4.5 Cách phân giải địa chỉ IP

![](https://raw.githubusercontent.com/hocchudong/ghichep-DNS/master/images/dns-resolve.png)

- Client của DNS gọi là DNS resolver
- Truy vấn non-recursive: DNS resolver client truy  vấn DNS server để tìm record của tên miền chứa trên server đó
- DNS query

![](https://raw.githubusercontent.com/hocchudong/ghichep-DNS/master/images/dns-request.jpg)

## 5. DNS Record
- Có 2 loại bản ghi được sử dụng trong DNS
- Các bản ghi `question` được sử dụng trong phần `question` của truy vấn và `response message`.
- ### 5.1 Bản ghi loại A
   + `Address Mapping Records`: Chuyển đổi 1 `domain name` thành 1 địa chỉ Ipv4.
- ### 5.2 Bản ghi loại AAAA
   + `IP Version 6 Address records`: chuyển đổi 1 `domain name` thành địa chỉ IPv6
- ### 5.3 Bản ghi loại NS
   + `Name Server records`: Lưu thông tin về name server
   + Định danh cho 1 máy chủ có thẩm quyền về 1 zone nào đó.
- ### 5.4 Bản tin loại CNAME
   + `Canonical Name records`: Bản ghi CNAME chỉ định 1 tên miền cần phải được truy vấn DNS ban đầu
- ### 5.5 Bản ghi HINFO 
   + `Host infomation records`: thu thập thông tin tổng quát về máy chủ
   + Ghi loại CPU và hệ điều hành
- ### 5.6 Bản ghi loại SOA
   + `Start of Authority records`: thông tin về vùng DNS: name server chính, email quản trị viện tên miền, số seri tên miền,...
- ### 5.7 Bản ghi loại PTR
   + `Reverse-lookup Pointer records`:bản ghi PTR sử dụng tra cứu tên miền dựa vào địa chỉ IP
- ###  5.8 Bản ghi loại MX
   + `Mail exchanger record`: MX chỉ định 1 máy chủ trao đổi thư cho 1 tên miền DNS.
   + Sử dụng bởi giao thức SMTP để định tuyến email đến máy chủ thích hợp

Tài liệu tham khảo: https://github.com/hocchudong/ghichep-DNS/blob/master/docs/dns-about.md
