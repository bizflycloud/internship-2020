# Linux Bridge
## 1. Khái niệm - Ứng dụng
- `Linux Bridge` là phần mềm được tích hợp vào nhân Linux (**nó là module trong Kernel Linux**) để giải quyết vấn đề ảo hóa phần network trong các máy tính vật lý.
- Về mặt logic: `Linux Bridge` sẽ tạo ra 1 con switch ảo layer 2 để cho các VM kết nối được vào với nhau như trong 1 mạng LAN cũng như ra ngoài mạng.
- `Linux Bridge` thường được sử dụng kết hợp với hệ thống ảo hóa KVM-QEMU.
- Sử dụng câu lệnh `brctl` để quản lí.

![](https://camo.githubusercontent.com/c1d897325250b642ecf5876123a592e3a9183a9d/687474703a2f2f696d6775722e636f6d2f4c704d6c4e6f662e6a7067)

## 2. Cấu trúc hệ thống sử dụng Linux bridge
![](https://camo.githubusercontent.com/791b703bd01298b01678ae0a377968ddd3d82141/687474703a2f2f696d6775722e636f6d2f376438625936752e6a7067)

## . Các thuật ngữ:
![](https://github.com/trangnth/Report_Intern/raw/master/ghichep-kvm/img/1.png)

- `Port`: tương tự như cổng của một switch thật
- `Bridge`: tương đương như Switch Layer 2
- `tap` : hay `tap interface` có thể hiểu là các Port để VM kết nối với Bridge do Linux Bridge tạo ra (Tap hoạt động ở lớp 2 trong mô hình OSI).
- `fd`: Forward data - Chuyển tiếp dữ liệu từ VM tới Bridge.

