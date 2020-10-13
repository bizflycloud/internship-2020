# KVM overview
## 1. Giới thiệu 
- **KVM (Kernel-based virtual machine):** là giải pháp ảo hóa cho hệ thống Linux trên nền tảng phần cứng x86 có các module mở rộng hỗ trợ ảo hóa (Intel VT-x hoặc AMD-v)
- **KVM** `không` thực sự là 1 `hypervisor` có chức năng giả lập phần cứng để chạy máy ảo.
- **KVM** là một **module của kernel Linux** hỗ trợ cơ chế **mapping** các chỉ dẫn trên `CPU ảo (Guest VM)` sang chỉ dẫn `CPU vật lí (Máy chủ chứa VM)`.
- **KVM** giống như 1 driver cho `Hypervisor` để sử dụng các tính năng ảo hóa của các vi xử lí như Intel VT-x, AMD-v (mục tiêu tăng hiệu suất cho guest VM).

![](https://camo.githubusercontent.com/8943edb62d927a7d6643570fedc3ce027818002e/687474703a2f2f696d6775722e636f6d2f4a65764a6774372e6a7067)

![](https://i2.wp.com/blogit.edu.vn/wp-content/uploads/2015/08/Kien-truc-KVM.jpg?w=597)

![](https://github.com/khanhnt99/kvm/raw/master/images/tongquan-3.jpg)

## 2. Các tính năng ảo hóa KVM 
### 2.1 Security (Bảo mật)
- Vì Virtual Machine như một tiến trình xử lí cảu Linux nên nó tận dụng được mô hình bảo mật tiêu chuẩn của Linux để cung cấp khả năng điều khiển và cô lập tài nguyên.

### 2.2 Memory management (Quản lí bộ nhớ)
- KVM thừa kế tính năng quản lí bộ nhớ của Linux.

### 2.3 Storage (Lưu trữ)
- KVM sử dụng khả năng lưu trữ hộ trợ của Linux để lưu trữ các images máy ảo.

### 2.4 Live Migration
- Cung cấp khả năng di chuyển các máy ảo đang chạy giữa các host vật lí mà không làm gián đoạn dịch vụ.
- KVM cho phép lưu trạng thái hiện tại của máy ảo để cho phép lưu trữ và khôi phục trạng thái đó vào lần sử dụng tiếp theo.

__Docs__:
- https://github.com/khanhnt99/Linux/blob/master/KVM/01_Overview.md
- https://github.com/hocchudong/thuctap012017/blob/master/TamNT/Virtualization/docs/KVM/1.Tim_hieu_KVM.md
- https://github.com/khanhnt99/thuctap012017/blob/master/XuanSon/Virtualization/Virtual%20Machine/KVM/KVM%20basic.md




