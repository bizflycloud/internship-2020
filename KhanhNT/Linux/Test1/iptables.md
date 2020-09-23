# Ôn tập Iptables
## 1. Khái niệm:
- `iptables` là công cụ `firewall` sử dụng để tương tác với `netfilter-packet filtering framework trong Linux kernel`.
- `iptables` là giao diện dòng lệnh để tương tác với các tính năng packet filtering của `netfilter`.
- Iptables hoạt động gồm 3 thành phần:
  + `tables`
  + `chains`
  + `targets`

## 2. Tables trong iptables (5 tables)
### 2.1 Tables filter
- `Filter table` sử dụng để đưa ra quyết định về việc có nên để gói tin (network packet) tiếp tục đến đích dự định hay từ chối yêu cầu của nó.

### 2.2 Tables nat
- `Tables NAT` sử dụng các rule về `NAT (Network Address Translation)`
- Có nhiệm vụ chỉnh sửa source hoặc destination của gói tin để thực hiện cơ chế NAT.

### 2.3 Tables Mangle
- `Tables Mangle` cho phép chỉnh sửa header của gói tin. (ví dụ như TTL)

### 2.4 Tables raw
- `Iptables` là một stateful firewall - các gói được kiểm tra trạng thái  (state) của nó.
- `Tables raw` cho phép làm việc với gói trước khi kernel bắt đầu theo dõi trạng thái của gói.

### 2.5 Tables security
- Thiêt lập các chính sách bảo mật.

## 3. Các chain trong iptables (5 chain)
- `Chain Prerouting`: Rule trong chain được thực thi ngay khi gói tin vừa đến Network interface.
   + Bảng `nat`, `mangle`,`raw`
- `Chain Input`: Rule thực thi khi gói tin gặp process.
   + Bảng `mangle`, `nat`.
- `Chain Output`: Rule trong chain được thực thi khi gói tin được tiến trình tạo ra.
   + Bảng `raw`, `mangle`, `nat`, `filter`.
- `Chain Forward`: Rule trong chain được thực thi cho gói tin được định tuyến qua host hiện tại.
   + Bảng `mangle`, `filter`.
- `Chain Postrouting`: Rule trong chain được thực thi khi gói tin rời giao diện mạng.
   + Bảng `mangle`, `nat`

- Bảng `Filter` 
   + Chain `Output`
   + Chain `Forward`

- Bảng `NAT`
   + Chain `Prerouting`
   + Chain `Input`
   + Chain `Output`
   + Chain `PostRouting`

- Bảng `Mangle`
   + Chain `Prerouting`
   + Chain `Input`
   + Chain `Output`
   + Chain `Forward`
   + Chain `Postrouting`

- Bảng `Raw`
   + Chain `Prerouting`
   + Chain `Output`

![](https://news.cloud365.vn/wp-content/uploads/2019/08/2019-08-03_10-17.png)

__Tài liệu tham khảo__
- https://news.cloud365.vn/chuyen-sau-ve-iptables-command-va-netfilter/


   


