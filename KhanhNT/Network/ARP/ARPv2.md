# ARP v2
## 1. Truyền tin trong môi trường internet toàn cầu

![](https://raw.githubusercontent.com/doxuanson/thuctap012017/master/XuanSon/Pictures/Netowork%20Protocol/ARP%20Protocol/8.jpg)

- PC A gửi packet ra ngoài internet
- Do broadcast không thể truyền qua Router C nên PC A sẽ xem Router C như 1 cầu nối trung gian để truyền dữ liệu.
- PC A sẽ biết IP address của Router C (địa chỉ gateway) và biết nếu muốn truyền ra ngoài phải qua Router C.
- Quá trinhf truyền như sau:
  + PC A gửi ARP request tìm MAC address của Port 1 trên Router C
  + Router C gửi lại PC A 1 "ARP Reply", cung cấp cho PC A MAC address cuả Port 1
  + PC A truyền packet đến Port 1 Router
  + Router nhận được packet từ PC A và chuyển packet ra "Port Wan" và truyền ra Internet

## 2. Các bản tin ARP
### 2.1 ARP probe:
- Loại bản tin ARP dùng để thăm dò địa chỉ IP máy được cấp phát có bị trùng với địa chỉ IP nào trong mạng hay không. Đều thực hiên broadcast bản tin ARP này khi bắt đầu.
    + Bản tin có cấu trúc địa chỉ IP maý gửi là 0.0.0.0 (thể hiện bản tin **chưa xác định IP**, đồng thời để các maý khác không cập nhật MAC của máy vào ARP Caching)
    + Địa chỉ MAC đích là 00:00:00:00:00:00
    + Điạ chỉ IP đích là địa chỉ IP máy gửi được cấp phát
    + ARP request này không có reply

### 2.2 ARP annoucements
- Thông báo tới các máy trong mạng địa chỉ IP hoặc địa chỉ MAC thay đổi => **Gratuitous ARP**
  + Gratuitous ARP được gửi broadcast request trong mạng với địa chỉ MAC và IP máy gửi là IP sau khi thay đổi
  + MAC đích là 00:00:00:00:00:00
  + IP đích là chính nó
  + Các máy trong mạng cập nhật MAC và IP máy gửi vào ARP caching của mình
  + Không có repy cho bản tin này

### 2.3 ARP request
- Là bản tin máy gửi gửi broadcast để tìm địa chỉ MAC máy nhận
   + MAC và IP gửi là của máy gửi
   + MAC nhận là 00:00:00:00:00:00
   + IP nhận là IP máy cần tìm

### 2.4 ARP reply
- Bản tin mà máy sau khi nhận được ARP request sẽ đóng gói lại MAC và gửi bản tin reply về cho máy gửi
   + Đóng gói địa chỉ IP và MAC vào SHA và SPA
   + Địa chỉ máy gửi tới được đóng gói vào THA và TPA
   + Gửi bản tin unicast

## 3. ARP Caching 
- ARP là giao thức phân giải địa chỉ rộng
- Qúa trình gửi gói Request hay Reply sẽ làm tiêu tốn băng thông mạng
- ARP Cache có dạng giống như 1 bảng tương ứng giữa địa chỉ hardware và địa chỉ IP
- Có 2 cách đưa các thành phần tương ứng vào bảng ARP Caching
- Kiểm tra địa chỉ ARP trong máy: `arp -a`

### 3.1. Static ARP Cache Entries:
- Đưa vào lần lượt bởi người quản trị
- Tiến hành cấu hình thủ công
- Sử dụng câu lệnh `arp -s ip_addr mac_addr` để thêm 1 Static ARP entry vào ARP cache

### 3.2 Dynamic ARP Cache Entries
- Địa chỉ MAC và IP được đưa vào ARP cache 1 cách tự động bằng phần mềm sau khi hoàn tất phân giải địa chỉ
- Dynamic Cache sẽ tự động xóa sau 1 khoảng thời gian nhất định. Quá trình naỳ được thực hiện 1 cách hoàn toàn tự động khi sử dụng ARP trong thường là 10 đến 20 phút

## 4. ARP Proxy
- ARP thiết kế trong thiết bị nằm trong nội mạng, local network area.
- PC A và B chia cắt bởi 1 router thì được coi như không local với nhau
- A gửi thông tin đến B, A sẽ không gửi trực tiếp đến B theo địa chỉ lớp 2, mà phải gửi qua router và được coi cách nhau 1 hop ở lớp 3

### Note
- Router không truyền Broadcast ở lớp DataLink


