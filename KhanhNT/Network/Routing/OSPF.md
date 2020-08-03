# OSPf: 
+ OSPF tự động nhận diện 3 kiểu mạng: Đa truy nhập quảng bá, Đa truy nhâp không quảng bá, Điểm-điểm.
+ Giao thức định tuyến nội miền dựa trên giao thức trạng thái liên kết (Link state protocol)
+ Trên mỗi router có bảng định tuyến của cả vùng mạng thông qua việc đồng nhất bảng cơ sở trạng thái đường link (Link state database). 
+ Router có thể tự tính toán đường đi ngắn nhất (Dijkstra) và xây dựng bảng định tuyến cho nó.
+ Chia AS (Autonomous system) thành nhiều miền nhỏ để xử lí hiệu quả và nhanh hơn. 
+ Metric phụ thuộc vào Bandwidth
#### Nguyên tắc hoạt động:
- Thiết lập mối quan hệ láng giềng
        * Gửi gói tin Hello để thiết lập neighbor (10s/lần)
        * OSPF sử dụng địa chỉ Multicast: 224.0.0.5
        * Gói tin hello chỉ dùng để định neighbor
        * Để làm neighbor gói tin hello 2 router giống 1 số thông số: area ID, cùng subnet và subnet mask
- Tìm đường đi tối ưu:
    * Trạng thái 2 way thì gửi thông tin cho nhau tạo thành bảng Link State database
    * Gửi thông tin trạng thái đường Link (Link state advertisement)
- Tính cost trong OSPF:
    + cost = 10^8 / Bandwidth
- DR và BDR
    + DR: Trước khi trao đổi thông tin thì router sẽ bầu chọn ra 1 Designated router đóng vai trò tiếp nhận các thông tin trao đổi và gửi ra các router khác.
    + BDR: backup designated router: dự phòng cho DR
    + DR other: không nói chuyện trực tiếp với nhau mà thông qua DR. DR gửi thông tin cho BDR để backup
    + Bình bầu DR, BDR: 
        + priority: Router có priority cao nhất làm DR, cao thứ 2 làm BDR, còn lại là DR other
        + priotity = 0, không được làm DR lẫn BDR
        Riêng DR và BDR nói chuyện qua 224.0.0.6, còn lại qua 224.0.0.5

#### Ưu điểm:
+ Tốc độ nhanh
+ Hỗ trợ VLSM
+ Kích thước mạng vừa và lớn
+ Sử dụng băng thông hiệu quả
+ Chọn tuyến tối ưu thông qua cost (cân bằng tải khi cost bằng nhau)

#### Nhược điểm:
+ Yêu cầu các thiết bị mạng có cấu hình mạnh

============================================================================

