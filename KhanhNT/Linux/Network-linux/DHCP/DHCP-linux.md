# DHCP in Linux
## 1. Khái niệm DHCP (Dynamic Host Configuration Protocol)
- Giao thức hoạt động ở lớp `Application` trong mô hình TCP/IP.
- Giao thức cấu hình tự động địa chỉ IP.
- DHCP sử dụng `port 67,68` và `giao thức UDP`.

## 2. Thuật ngữ DHCP:
- **Scope**: Phạm vi liên tiếp của các địa chỉ IP từ DHCP Server.
- **DHCP Relay Agent**: `DHCP Relay Agent` là 1 máy tính hoặc 1 Router được cấu hình để lắng nghe và chuyển tiếp các gói tin giữa `DHCP Client` và `DHCP Server` từ subnet này sang subnet khác. 

## 3. DHCP Relay Agent:
- `DHCP Relay Agent` cho phép chuyển các yêu cầu DHCP từ bootp từ 1 subnet không có DHCP Server trong đấy tới 1 hoặc nhiều `DHCP Server` trên các subnet khác.
- Khi 1 Client yêu cầu thông tin, `DHCP Relay Agent` chuyển các yêu cầu đấy đến danh sách các `DHCP Server` xác định.
- Khi `DHCP Server` gửi reply, reply có thể là `broadcast` hoặc `unicast` gửi đến yêu cầu từ nguồn ban đầu.
- Mặc định DHCP Server lắng nghe tất cả yêu cầu DHCP từ tất cả các card mang, trừ khi nó được chỉ định trong `/etc/sysconfig/dhcprelay`

**Tài liệu tham khảo**

- https://github.com/khanhnt99/thuctap032016/blob/master/LTLinh/LTLinh-B%C3%A1o%20c%C3%A1o%20giao%20th%E1%BB%A9c%20DHCP/LTLinh-caidatwireshark-phantichgoitinDHCP.md
