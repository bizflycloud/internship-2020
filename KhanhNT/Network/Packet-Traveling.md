# Packet Traveling

![](https://i.imgur.com/HW63g82.png)

## 1. Tại lớp Application
- Dữ liệu, yêu cầu người dùng được sử dụng thành khối data lớn.

## 2. Tại lớp Transport
- Data chia nhỏ thành các khối dữ liệu có kích thước phù hợp, sau đó đóng gói lại.
- Một **Header** được thêm nhằm theo dõi luồng dữ liệu và tập hợp dữ liệu tại máy đích.
- Gói tin này gọi là **Segment**
- Có nhiều ứng dụng, dịch vụ chạy trên mỗi host, để chuyển chính xác dữ liệu cho các ứng dụng dịch vụ, lớp Transport gán cho mỗi Application 1 **port number**.
   + HTTP: 80
   + FTP: 21
   + DNS: 53
   + SMTP: 25
- Tùy vào ứng dụng Transport sử dụng giao thức TCP hoặc UDP cho phù hợp.

## 3. Tại lớp network
- Segment được gắn thêm 1 header gọi là **IP Header**
- IP Header gồm 2 thông tin chính:
   + __Source IP__
   + __Destination IP__
- Các gọi tin bây giờ gọi là các __Datagram__

## 4. Datalink và Physical
- Để gói tin tới đích, ta cần thêm 1 địa chỉ nữa là địa chỉ MAC.
- Thêm 1 header vào Datagram với 2 thông tin chính là:
   + __Source MAC__
   + __Destination MAC__
- Gói tin baayh giờ là __Frame__

## 5. Switch
- Frame được đặt trong 1 hàng đợi.
- Frame có ưu tiên khác nhau, Switch dựa vào điều này để xử lí frame quan trọng trước
- Switch mở gói tin ra và đọc địa chỉ __Source MAC__.
- Lưu vào __MAC Address Table__
   + Lưu số port và địa chỉ MAC kết nối với port
- Tiếp theo đọc Destination MAC gói tin, so sánh với bảng MAC Address Table của Switch:
   + Nếu Dest MAC tồn tại trên MAC Address Table, Switch gửi gói tin qua Port tương ứng.
   + Nếu Dest MAC không tồn tại trong MAC Address Table hoặc là địa chỉ Broadcast, Switch gửi gói tin ra tất cả các port trừ cổng nhận vào.
   + Dest MAC trùng với Source MAC, frame sẽ bị DROP.

## 6. Router
- Gỡ bỏ lớp __header__ của __Datalink__ (Bao gồm Source MAC và Destination MAC)
- Đọc thông tin lớp __Network__ (Source IP và Destination IP)
- Sử dụng Destination IP, __so sánh với Routing Table__.
- Routing Table chứa danh sách các đường đi được sử dụng để chuyển gói tin và interface đầu ra tương ứng.
- Nếu không tìm được đường tương ứng với Dest IP, hoặc trường __TTL__ trong IP Header giảm về 0 =>> Gói tin sẽ bị DROP (Destination host unreachable).
- Nếu tìm được đường đi tương ứng, Router thêm lại header chứa Source MAC và Destinstion MAC.

