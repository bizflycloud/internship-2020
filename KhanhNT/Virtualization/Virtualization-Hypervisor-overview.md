# Virtualization và Hypervisor Overview
## 1. Ring
- `Hierarchial Protection Domains (Protection Rings)` là cơ chế nhằm bảo vệ dữ liệu và chức năng của 1 chương trình tránh khỏi nguy cơ lỗi hoặc bị truy cập trái phép.
- 1 `Protection Ring` là 1 mức độ (mode/level/layer) truy cập tài nguyên hệ thống.

![](https://raw.githubusercontent.com/ImKifu/thuctapsinh/master/HungNK/Basic_Linux_Command/Picture/ring.png)

- Kiến trúc minh họa các Ring trong CPU x86:
  + `Ring 0`: có đặc quyền cao nhất, tương tác trực tiếp với phần cứng CPU, Memory,...
  + Để cho phép các ứng dụng ở Ring có trọng số cao truy cập đến các tài nguyên được quản lí bởi các chương trình nằm ở trọng số thấp hơn, người ta xây dựng các cổng gate (ví dụ như `system call` giữa các Ring).
 
- `Kernel Space` và `User Space`

![](https://github.com/niemdinhtrong/NIEMDT/raw/master/KVM/images/x861.png)

## 2. Virtualization
### 2.1 Khái niệm
- `Virtualization` (ảo hóa): là công nghệ để tạo ra tầng trung gian giữa hệ thống phần cứng của máy tính và phần mềm của nó.
- Ý tưởng của ảo hóa là `từ một máy tính vật lí đơn lẻ có thể tạo nhiều máy ảo độc lập`.
- Mỗi `máy ảo` đều có một thiết lập nguồn riêng rẽ, `hệ điều hành riêng` và `các ứng dụng riêng`.
- Các loại ảo hóa: 
  + __Ảo hóa mạng (Network virtualization):__ kết hợp các tài nguyên có sẵn trong mạng bằng cách chia băng thông sẵn thành các kênh, mỗi kênh độc lập với các kênh khác.
  + __Ảo hóa lưu trữ (Storage virtualization):__ tổng hợp Physical storage từ nhiều thiết bị lưu trữ mạng vào 1 thiết bị lưu trữ được quản lí từ bảng điều khiển trung tâm.
  + __Ảo hóa máy chủ:__ Ảo hóa tài nguyên máy chủ (bao gồm số và danh tính của máy chủ vật lí, bộ xử lí, hệ điều hành)

### Ưu điểm:
- __Availbility:__ Các ứng dụng hoạt động liên tục giảm thiểu down time 
- __Scalability:__ Thu hẹp hoặc mở rộng server dễ  dàng mà không làm gián đoạn ứng dụng
- __Optimization__: dùng triệt để nguồn tài nguyên phần cứng.
- __Management__: Khả năng quản lí tập trung.

### 2.2 Virtual Machine
- `Virtual Machine` hay còn gọi là máy ảo là một môi trường hoạt động độc lập - phần mềm hoạt động cùng nhưng độc lập với hệ điều hành.

### 2.3 Phân loại Virtualization
- RAM Virtualization
- CPU Virtualization
- Network Virtualization
- Device I/O Virtualization

### 2.4 CPU Virtualization
#### 2.4.1 Các loại :
- Full Virtualization
- Paravirtualization
- Container-based Virtualization
- Hardware Assisted Virtualization
- OS Level Virtualization
- Hybrid Virtualization

### 2.5 Full Virtualization

![](https://raw.githubusercontent.com/ImKifu/thuctapsinh/master/HungNK/Basic_Linux_Command/Picture/aohoa1.png)

![](https://raw.githubusercontent.com/ImKifu/thuctapsinh/master/HungNK/Basic_Linux_Command/Picture/aohoa2.png)

- Guest OS không bị sửa đổi hệ điều hành để tương thích với phần cứng, mà nó dịch nhị phân các yêu cầu rồi gửi cho VMM, VMM làm trung gian cho hardware xử lí.
- `Guest OS` chạy trên ring 1 còn ring 0 chạy `Hypervisor`
- Guest OS chỉ chạy trên quyền `user level` chứ không chạy trên `privilege`, không chạy trực tiếp trên `hardware` nhưng code của `OS` không bị thay đổi nên Guest không biết và làm việc bình thường như trên máy thật.

![](https://raw.githubusercontent.com/ImKifu/thuctapsinh/master/HungNK/Basic_Linux_Command/Picture/aohoa3.png)

### 2.6 Paravirtualization

![](https://github.com/ImKifu/thuctapsinh/raw/master/HungNK/Basic_Linux_Command/Picture/aohoa4.png)

- Trong `paravirtualization`, hypervisor sẽ cung cấp `hypercall interface`.
- Guest OS sẽ được chỉnh sửa kernel code để thay thế  `non-virtualizable instruction` bằng các hypercall.
- Guest OS bị sửa đổi để có thể nằm ở Ring 0

![](https://github.com/ImKifu/thuctapsinh/raw/master/HungNK/Basic_Linux_Command/Picture/aohoa6.png)

### 2.7 Hardware Assisted Virtualization

![](https://raw.githubusercontent.com/ImKifu/thuctapsinh/master/HungNK/Basic_Linux_Command/Picture/aohoa7.png)

- Xây dựng 1 CPU Mode mới dành riêng cho Virtualization layer (`root mode`)
- Các OS request từ Guest OS sẽ tự động đi xuyên qua Virtualization Layer và cũng không cần binary translation vì guest OS ở ring 0.
- Trạng thái của Guest OS sẽ được lưu trong `Virtual Machine control Structure (VT-x)` hoặc `Virtual machine control block (AMD-v)`.

## 3. Hypervisor/Virtual Machine Monitor (VMM)
### 3.1. Tổng quan
- `Hypervisor` là phần mềm giám sát máy ảo
- Là 1 chương trình phần mềm quản lí 1 hoặc nhiều máy ảo (VM).
- Được sử dụng để tạo, xóa, dừng, reset các máy ảo.
- Các `hypervisor` cho phép mỗi VM hoặc guest truy cập vào lớp tài nguyên phần cứng vật lí phía dưới (CPU,RAM,Storage).
- Giới hạn tài nguyên hệ thống mà mỗi máy ảo sử dụng để đảm bảo cho nhiều máy ảo sử dụng đồng thời trên 1 hệ thống.

### 3.2 Các loại Hypervisor
- Có 2 loại `hypervisor` là `Native(Bare metal)` và `Host based`
#### 3.2.1 Native Hypervisor (Bare metal)
- Chạy trực tiếp trên phần cứng
- Nằm giữa phần cứng và 1 hoặc nhiều hệ điều hành khách (Guest operating system).
- Khởi động trước hệ điều hành và tương tác trực tiếp với Kernel.
- Đem lại hiệu suất cao vì không có hệ điều hành chính nào cạnh tranh tài nguyên máy tính với nó.
- Hệ thống chỉ dùng để chạy các máy ảo vì `hypervisor` luôn chạy ngầm bên dưới.

![](http://2.bp.blogspot.com/-eYHy7_Puc3c/Vpr1e3-lWwI/AAAAAAAAAEQ/vm5dCernuYo/s1600/hypervisor_detail.png)

![](https://raw.githubusercontent.com/ImKifu/thuctapsinh/master/HungNK/Basic_Linux_Command/Picture/hypervisor-Native-Baremetal.png)

- Ví dụ: VMware ESXi, Microsoft Hyper-V, Apple Boot Camp.

#### 3.2.2 Hosted Hypervisor 
- 1 hypervisor dạng hosted được cài đặt trên 1 máy tính chủ (host computer) mà trong đó có 1 hệ điều hành được cài đặt sẵn.
- Hypervisor chạy như một ứng dụng trên máy tính.

![](https://raw.githubusercontent.com/ImKifu/thuctapsinh/master/HungNK/Basic_Linux_Command/Picture/Hosted-Hypervisor-type-2.png)

- VD: VMware Workstation, Oracle VirtualBox


![](https://thegioimaychu.vn/blog/wp-content/uploads/2018/10/400px-Hyperviseur.png)

__Docs:__
- https://news.cloud365.vn/kvm-tong-quan-ve-virtualization-va-hypervisor/
- https://www.thegioimaychu.vn/blog/thuat-ngu/hypervisor/ 
-http://coffeecode101.blogspot.com/2016/01/virtualization.html
- https://www.thegioimaychu.vn/blog/ao-hoa/huong-dan-tong-quan-ve-ao-hoa-vmware-p3588/
