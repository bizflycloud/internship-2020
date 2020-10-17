# KVM/QEMU
## KVM overview
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
- Vì Virtual Machine như một tiến trình xử lí của Linux nên nó tận dụng được mô hình bảo mật tiêu chuẩn của Linux để cung cấp khả năng điều khiển và cô lập tài nguyên. Nhân Linux sử dụng `SELINUX (Security Enhanced Linux)` để thêm quyền điều khiển truy cập, bảo mật đa mức và bảo mật đa tiêu chí.

### 2.2 Memory management (Quản lí bộ nhớ)
- KVM thừa kế tính năng quản lí bộ nhớ của Linux.
- KVM hỗ trợ `NUMA (Non-Uniform Memory Access - bộ nhớ thiết kế cho hệ thống đa xử lí)` cho phép tận dụng hiệu quả vùng nhớ có kích thước lớn.
- KVM hỗ trợ các tính năng ảo hóa.
- Việc chia sẻ bộ nhớ được hỗ trợ thông qua một tính năng của nhân gọi là `Kernel Same-page Merging (KSM)`. KSM quét tất cả các yêu cầu về vùng nhớ cần thiết co máy ảo và định danh cho từng máy ảo, sau đó tổ hợp thành một yêu cầu về vùng nhớ duy nhất để chia sẻ chung cho các máy ảo, lưu trữ vào một bản copy.

### 2.3 Storage (Lưu trữ)
- KVM sử dụng khả năng lưu trữ hộ trợ của Linux để lưu trữ các images máy ảo.

### 2.4 Live Migration
- Cung cấp khả năng di chuyển các máy ảo đang chạy giữa các host vật lí mà không làm gián đoạn dịch vụ.
- KVM cho phép lưu trạng thái hiện tại của máy ảo để cho phép lưu trữ và khôi phục trạng thái đó vào lần sử dụng tiếp theo.

### 2.5 Performance and scalability
- KVM kế thừa khả năng mở rộng của Linux, hỗ trợ các máy ảo với 16CPU ảo, 256GB RAM, 256 cores, trên 1TB RAM. 

## 3. KVM hoạt động:
- `KVM` chuyển đổi một `nhân Linux (Linux Kernel) thành một bare-metal hypervisor` và thêm vào đó những đặc trưng riêng của bộ xử lí Intel như `Intel VT-X` hay `AMD như AMD-V`.
- Khi đã `trở thành 1 Hypervisor`, KVM hoàn toàn có thể setup các máy ảo với các hệ điều hành khác nhau và không phụ thuộc vào hệ điều hành của máy chủ vật lí.

## QEMU
### 1. Khái niệm 
- **QEMU (Quick Emulator)** là một chương trình ảo hóa dung type2 (chạy trên hê điều hành máy chủ) để thực hiện việc ảo hóa phần cứng.
- Có thể mô phỏng CPU qua dịch nhị phân động.
- Kiểu mô phỏng QEMU:
  + Toàn bộ hệ thống: QEMU sẽ tiến hành ảo hóa toàn bộ hệ thống, bao gồm CPU và các thành phần khác.
  + Một phần: ảo hóa ứng dụng trên 1 nền CPU khác.

### 2. KVM làm việc với QEMU:

![](https://camo.githubusercontent.com/35ed680bfee92e09ae2377055f0cddcef96921b5/687474703a2f2f696d6775722e636f6d2f777341356846372e6a7067)

- **Cấu trúc `KVM` làm việc với `QEMU` gồm 4 tầng**
   + **User-facing tools:** 
      + Là **`công cụ quản lí máy ảo hỗ trợ KVM`**. 
      + Gồm các công cụ có `giao diện đồ họa (virt-manager)` hoặc `giao diện dòng lệnh (virsh) `và `virt-tool (công cụ được quản lí bởi thư viện libvirt)`.
   + **Management layer:** 
      + Lớp mà thư viện **`libvirt cung cấp API`** để các công cụ quản lí máy ảo hoặc các hypervisor tương tác với KVM thực hiện thao tác quản lí tài nguyên ảo hóa.
      + Vì `KVM` chỉ là 1 module của nhân hỗ trợ cơ chế `mapping` các chỉ dẫn của `CPU ảo` để thực hiện trên `CPU thật` nên tự KVM `không` có khả năng `giả lập` và `quản lí tài nguyên ảo hóa`. Mà phải nhờ công nghệ Hypervisor khác (QEMU).
   + **Virtual Machine:** 
      + Các máy ảo do người dùng tạo ra. Thông thường nếu không sử dụng các công cụ như `virtsh`, `virt-manager` KVM sẽ phối hợp với 1 hypervisor khác điển hình là QEMU.
   + **Kernel Support:** 
       + `Là KVM`, cung cấp một module hạt nhân cho hạ tầng ảo hóa (kvm.ko) và một module đặc biệt chỉ hỗ trợ các vi xử lí VT-x hoặc AMD-v (kvm-intel.ko, kvm-amd.ko)

![](https://camo.githubusercontent.com/7d3302af554fc4350b909f50587c2347e7cf69e4/687474703a2f2f692e696d6775722e636f6d2f6a6e4b704179592e706e67)

#### Note:
- **KVM** giống như 1 driver cho `Hypervisor` sử dụng được `virtualization extension` của CPU vật lí để boost perfoemance cho guest VM.
- **QEMU** là một `Emulator` để xử lí các yêu cầu trên CPU ảo và giả lập kiến trúc của máy ảo (Sử dụng bộ dịch `T`iny `C`ode `G`enerate)
- **QEMU** như 1 `hypervisor` type 2.
- Để nâng cao hiệu suất của VM: kết hợp KVM và QEMU
   + Lúc tạo VM bằng QEMU có VirtType là KVM thì khi đó các `Instruction` đối với `Virtual CPU` sẽ được QEMU `sử dụng KVM` để `mapping` thành các instruction đối với `Physical CPU`.
   + Khi đó sẽ nhanh hơn là chỉ chạy độc lập QEMU vì nếu `không có KVM` thì `QEMU` sẽ phải sử dụng `translator` để `chuyển dịch các instruction` của `virtual CPU` rồi đem `thực thi trên Physical CPU`.

=>  Tạo thành `Type-1 Hypervisor`


=> **QEMU cần KVM để tăng hiệu suất và KVM cần QEMU để cung cấp full virtualization**


__Docs__:

- https://github.com/khanhnt99/Linux/blob/master/KVM/01_Overview.md
- https://github.com/hocchudong/thuctap012017/blob/master/TamNT/Virtualization/docs/KVM/1.Tim_hieu_KVM.md
- https://github.com/khanhnt99/thuctap012017/blob/master/XuanSon/Virtualization/Virtual%20Machine/KVM/KVM%20basic.md

