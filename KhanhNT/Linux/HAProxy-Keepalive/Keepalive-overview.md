# KeepAlived

## 1. Đặt vấn đề
- Khi thiết 1 `Load Balancing` cần chú ý đến 2 vấn đề:
  + Tính có sẵn của các real server sử dụng `health-checks`.
  + Tính có sẵn của các Load Balancer sử dụng `failover protocol`.
- Khi sử dụng cân bằng tải mà 1 máy chủ đảm nhiệm gặp sự cố thì không có thiết bị dự phòng nào khác đảm nhiệm vai trò của nó dẫn đến các dịch vụ phải tạm ngừng cung cấp.
- **Keepalive** giải quyết vấn đề trên bằng `LVS (Linux Virtual Server)` 
    + Thêm hoặc xóa các máy chủ dựa trên quyết định của `health-checks`.
    + Cho phép tạo ra `1 hay nhiều Virtual IP` để liên kết các máy chủ `mở rộng hệ thống Load Balancing`.

## 2. Các thuật ngữ
- `LVS: Linux Virtual Server` là 1 thành phần được thêm vào kernel của Linux để hỗ trợ tính năng `Load Balancing`.
- `LVS` hoạt động như `network bridge (NAT)` để cân bằng tải các luồng TCP/UDP.
- Các thành phần của `LVS router`:
   + WAN interface
   + LAN interface
   + Linux Kernel
- Các thành phần của `LVS`:
   + `VIP: Virtual IP` là IP để client truy cập
   + `Real server`: các server có nhiệm vụ nhận request từ client.
   + `Server pool`: Khu chứa các real servers.
   + `Virtual server`: Điểm truy cập tới Server pool.
   + `Virtual Service`: TCP/UDP service gắn liền với VIP.
- `VRRP`

## 3. VRRP
- `Virtual Router Redundancy Protocol` cho phép sử dụng chung 1 địa chỉ Gateway cho 1 nhóm router. 
- Khi router chính bị down, sẽ có backup thay thế.
- Phân Master hay Backup qua thông số `Priority`

   
__Tài liệu tham khảo__:
- https://github.com/meditechopen/meditech-thuctap/blob/master/ThaoNV/HAProxy%20%2B%20KeepAlive/docs/deep-dive-into-keepalive.md
