# ARP (Address Resolution Protocol)
## 1. Giới thiệu
### 1.1 Vấn đề
- Trong 1 hệ thống mạng, có 2 loại địa chỉ được gắn cho máy tính:
  + **Địa chỉ Logic**: 
      - Là địa chỉ của giao thức mạng như IP, IPX,...
      - Loại địa chỉ có tính chất tương đối, có thể thay đổi theo sự cần thiết
      - Chia thành 2 phần riêng biệt là địa chỉ mạng và địa chỉ máy
      - Tìm kết nối giữa mạng này và mạng khác dễ hơn
  + **Địa chỉ vật lí**:
      - Địa chỉ **MAC-Medium Access Controll Address**
      - Địa chỉ 48 bit
      - Định danh **duy nhất** do nhà cung cấp gán cho mỗi thiết bị
      - Địa chỉ phẳng, không phân lớp, khó cho định tuyến 
- Các card mạng (NIC) chỉ có thể kết nối với nhau qua địa chỉ MAC

=>> Cơ chế ánh xạ địa chỉ logic (Lớp 3) sang địa chỉ vật lí (Lớp 2) 

=>> Giao thức phân giải địa chỉ **ARP-Address Resolution Protocol**

### 1.2 Khái niệm
- **ARP(Address resolution protocol)** là protocol có nhiệm vụ map địa chỉ IPv4 thành địa chỉ MAC
- __ARP__ là giao thức tại OSI layer 3 và encapsulated tại OSI layer 2.

## 2. Cấu trúc bản tin ARP

![](https://camo.githubusercontent.com/2f7dcd904c165ab4c4c22058c4414c1a3fffc072/687474703a2f2f696d6775722e636f6d2f5a6d4b6f3570552e6a7067)

![](https://raw.githubusercontent.com/hocchudong/thuctap012017/master/TVBO/docs/Network_Protocol/docs/images/ARP/cautruc.png)

- **Hardware type (HTYPE)**
   + Xác định bộ giao tiếp phần cứng máy gửi cần biết
   + Có giá trị là 1 với đường truyền Ethernet
   + Nằm trong 16 bit đầu tiên gói tin
- **Protocol Type (PTYPE)**
   + Chiếm 16 bit gói tin
   + Kiểu giao thức do máy gửi cung cấp (IPv4 là 0x0800)
- **Hardware length (HLEN)**
   + Độ dài (octets) của hardware address (Ethernet address có độ dài 6 octets)
- **Protocol length (PLEN)**
   + Độ dài protocol address được sử dụng 
- **Operation**
    + Cho biết ARP request hay ARP reply. 
    + `ARP requets là 1`, `ARP reply là 2`,`RARP request là 3`, `RARP reply là 4`
- **Sender hardware address (SHA)**
    + MAC address của máy gửi
- **Sender protocol address (SPA)**
    + Protocol của máy gửi
- **Target hardware address (THA)**
    + MAC máy nhận 
- **Target protocol address (TPA)**
    + Protocol máy nhận 

## 3. Cơ chế hoạt động 
### 3.1 Hoạt động ARP trong môi trường mạng LAN
- Mô hình: PC A và PC B cùng trong 1 mạng LAN có địa chỉ mạng 192.168.1.0/24
- PC A gửi packet cho PC B

![](https://raw.githubusercontent.com/doxuanson/thuctap012017/master/XuanSon/Pictures/Netowork%20Protocol/ARP%20Protocol/4.jpg)

- Nguyên tắc hoạt động
  +**Bước 1**: PC A kiểm tra cache. Nếu đã có MAC address IP của 192.168.1.10 thì PC A gửi packet cho PC B
  + **Bước 2**: Khởi tạo gói tin ARP Request. Gửi gói tin **Broadcast** đến toàn bộ máy khác trong mạng với MAC address và IP maý gửi là địa chỉ chính nó, địa chỉ máy nhận là 192.168.1.20, MAC address máy nhận là ff:ff:ff:ff:ff:ff.
  + **Bước 3**: PC A phát gói tin ARP Request trên toàn mạng. KHi switch nhận gói tin broadcast này sẽ chuyển gói tin này tới tất cả các máy trong mạng LAN.
  + **Bước 4**: Các PC trong mạng đều nhận được ARP request. PC kiểm tra trường địa chỉ **Target Protocol Address**. Nếu trùng với địa chỉ của mình thì tiếp tục xử lí, không thì hủy gói tin.
  + **Bước 5**: PC B có IP trùng trường **Target Protocol Address** sẽ bắt đầu khởi động gói tin **ARP Reply**:
     -  Lấy các trường **Sender Hardware Address** và **Sender Protocol Address** trong gói tin ARP nhận được làm **Target** cho gói tin gửi đi. 
     - Lấy địa chỉ MAC của PC B để đưa vào trường **Sender Hardware Address**
  + **Bước 6**: PC B cập nhật bảng ánh xạ IP address và MAC address của PC A vào bảng ARP cache
  + **Bước 7**: PC B gửi gói tin reply đến PC A
  + **Bước 8**: PC A xử lí bằng cách lưu trường **Sender Hardware Address** trong gói reply vào **ARP cache** làm MAC address tương ứng với IP address của PC B. 

### 3.2 Hoạt động ARP trong môi trường liên mạng

![](https://camo.githubusercontent.com/ad7b585a9a1734c678b55394dcb4f28450248536/687474703a2f2f696d6775722e636f6d2f585849614954722e6a7067)

- PC A thuộc mạng A muốn gửi gói tin tới PC B thuộc mạng B. 2 mạng này kết nối nhau thông qua router C
- Do **broadcast** lớp MAC không thể truyền qua Router  nên PC A sẽ xem Router C như 1 cầu nối trung gian (Agent) để truyền dữ liệu.
- PC A có được địa chỉ của Router C(gateway) để biết truyền gói tin tới B phải đi qua C.
- PC A gửi gói tin đến **port X** của Router C
  + PC A gửi **ARP request** để tìm **MAC của port X**
  + Router C reply, cung cấp cho A địa chỉ MAC của port X.
  + PC A truyền gói tin tới port X của router C **(với địa chỉ MAC đích là MAC port X, IP đích là IP máy B)**
  + Router C nhận được gói tin của A, forward ra port Y. Gói tin chứa địa chỉ IP máy B, router C gửi ARP request để tìm MAC máy B
  + Máy B gửi router C MAC của máy B, sau đó router gửi gói tin của A tới B.

Tài liệu tham khảo:

https://github.com/khanhnt99/thuctap012017/blob/master/TamNT/T%C3%ACm%20hi%E1%BB%83u%20giao%20th%E1%BB%A9c%20ARP.md

https://github.com/khanhnt99/thuctap012017/blob/master/XuanSon/Netowork%20Protocol/ARP%20Protocol.md
