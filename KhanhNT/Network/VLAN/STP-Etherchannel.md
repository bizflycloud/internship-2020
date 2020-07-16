# STP (Spanning tree protocol)
![](https://vnpro.vn/upload/user/images/Th%C6%B0%20Vi%E1%BB%87n/aaa(1).jpg)
- 3 vấn đề:

    + broadcast storm
        - Giả sử PC A tiến hành gửi một broadcast frame vào hệ thống. 
        Khi SwX nhận được frame này nó sẻ đẩy frame ra tất cả các port đến SwY. 
        -   SwY nhận được broadcast frame này lại tiếp tục gửi ra tất cả các port trừ port nhận vào và quá trình frame này cứ chạy mãi một vòng giữa SwX và SwY.
        - Các Sw cứ nhân bản và flood broadcast frame này ra. Số lượng frame này sẻ ngày càng lớn. Và khi Sw không còn khả năng xử lý nữa thì sẻ khiến Sw bị treo.

    + instability MAC address table
    + Multiple Frame copies
        - PCA gửi một unicast frame đến PCB và địa chỉ MAC của B chưa được cập nhật vào bảng MAC của Sw thì Sw sẻ xử lý các frame này như một broadcast frame và flood ra tất cả các port trừ port nhận vào. 
        - Và SwX và SwY đều thực hiện chuyển flood frame này ra nhiều port khiến PCB phải xử lí frame này 2 lần.

Loop: switch đấu nối theo 1 vòng tròn khép kín
802.1D (STP): chống loop

## Hoạt động STP
+ Bầu chọn 1 Switch làm Root Switch (Root bridge)
+ Chọn root port trên các switch còn lại
+ Chọn designated port trên mỗi segment mạng
+ Còn lại là cổng bị khóa (block port)
###  Bầu chọn root switch
- Giá trị Bridge-ID gồm Bridge priority và MAC address được đặt vào BPDU quảng bá cho các switch khác 2 giây/lần
    + Priority(2byte): 0 đến 65535
    + MAC address(6byte)
- Root switch là có Bridge-ID nhỏ nhất (priority so sánh trước rồi đến MAC
- root port và designated port: dựa vào cost
    + Sau khi đã bầu chọn được Root-Bridge thì chỉ có SW làm root mới gửi BPDU ra khỏi cổng để duy trì tiến trình STP ( gửi 2s/lần). 
    + Các SW con chỉ nhận, bổ xung thông tin BPDU và forward thông tin BPDU này.
    + 
![](https://itforvn.com/wp-content/uploads/2017/09/New0154Spanning-Tree-v%C3%A0-cach-thuc-hoat-dong-6.jpg)

- Tất cả các cổng của root sw đều là designated port
- Đối diện root port là designated port (không có ý nghĩa ngược lại)

### 2. Bầu chọn Root-port
- Là port có đường về Root-bridge có cost nhỏ nhất
- Để xác định được cost tích lũy của một port đến Switch làm Root-bridge ta thực hiện tính ngược từ Root về cổng đó theo qui tắc “vào cộng ra không cộng” dựa theo chiều lan truyền BPDU

![](https://itforvn.com/wp-content/uploads/2017/09/New0155Spanning-Tree-v%C3%A0-cach-thuc-hoat-dong-7.jpg)

SW2: e0/1 là root-port
SW3: e0/1
SW4: MAC thấp hơn được ưu tiên hơn, Port-ID 

### 3. Bầu chọn Designated Port
- Tất cả các port của root-bridge đều là Designated Port
- Đối diện root-port là 1 designated port

### 4.Blocking port
- Port không có vai trò là Root hay Designated sẽ bị Block (gọi là Alternated port)
![](https://itforvn.com/wp-content/uploads/2017/09/New0149Spanning-Tree-v%C3%A0-cach-thuc-hoat-dong-11.jpg)

Note các trạng thái STP: 
+ Disabled: cổng đang không active
+ Blocking: cổng đang bị khóa ALternated port, chỉ tiếp nhận BPDU mà không cho BPDU ra khỏi cổng
+ Listening: chỉ nhận và gửi BPDU, không học dịa chỉ MAC
+ Learning: Chỉ nhận và gửi BPDU, học địa chỉ MAC không forward dữ liệu
+ Forwarding: nhận hoặc gửi BPDU, học địa chỉ MAC, có forward dữ liệu
====================================================================================================
# Etherchanel
### 1. 
- Gom 2 hay nhiều kết nối truyền tải dữ liệu vật lí thành 1 đường ảo duy nhất (Logic)
- Gom 2 đến 8 link thành 1 link
- Traffic không phải lúc nào cũng đồng đều, phụ thuộc vào load balancing mà sw sử dụng
- 1 link bị down, traffic chuyển sang các link khác
- 2 switch tương đồng: Tốc đô, băng thông, full duplex, Native VLAN và các VLANs, Switchport mode

### 2. Phân phối traffic
- Dựa vào kết quả thuật toán hash

### 3. Bảng giá trị Load Balancing
![](https://images.viblo.asia/073c115a-a13c-4477-8907-94bd4beaab32.png)

### 4. Phân loại
LACP (Link Aggregation Control Protocol)
- Tối đa 16 Link vật lí thành 1 logic (8 port active-8 port passive)
- Chế độ: on, active, passive

PAgP (Port Aggregation Protocol)

==============================================================================
Network Bonding
- Cấu hình 2 hay nhiều Card mạng chạy song song nhau, cân bằng tải và tính sẵn sàng cho server
