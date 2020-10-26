# Tool management VM

![](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Libvirt_support.svg/1280px-Libvirt_support.svg.png)

![](https://i.ibb.co/MnzCpbs/Screenshot-from-2020-10-17-11-12-42.png)

## 1. Libvirt 
### 1.1 Giới thiệu
- **Libvirt** là bộ các phần mềm cung cấp các thuận tiện để quản lí máy ảo và các chức năng của ảo hóa (ví dụ như chức năng quản lí lưu trữ và giao diện mạng).
- Những phần mềm bao gồm: 
  + Thư viện API
  + Daemon(livirtd) 
  + Các gói tiện ích giao diện dòng lệnh (virsh)
- Mục đích:
 + Cung cấp một cách duy nhất để quản lí ảo hóa từ các nhà cung cấp và các loại Hypervisor khác nhau (không cần thiết phải học 1 tool mặc định cho từng Hypervisor).

### 1.2 Các chức năng chính
- **VM management - Quản trị các máy ảo:** 
   + Quản lí vòng đời của các domain như `start`, `stop`, `pause`, `save`, `restore`, `migrate`.
   + Các hoạt động `hotplug` cho nhiều loại thiết bị bao gồm `disk`. `network interface`, `memory`,...

   + `Coldplug`: Disconnect or connect only when power off.
   + `Hotplug`: Disconnect or connect while the system is up and running.

- **Remote machine support:** 
  + Tất cả các chức năng của libvirt có thể được truy cập trên nhiều máy chạy libvirt daemon(libvirtd)
  + Hỗ trợ kết nối từ xa

![](https://i.ibb.co/4jfLYGs/Screenshot-from-2020-10-17-11-16-30.png)

- **Storage management:** 
  + Bất kì host nào đang chạy libvirt daemon có thể được sử dụng để quản lí nhiều loại storage.
  + Tạo file image với nhiều định dạng (qcow2, vmdk,raw,...)
  + Mount NFS shares
  + Liệt kê các phân vùng LVM, tạo nhóm phân vùng LVM mới, phân vùng ổ cứng.
  
- **Network interface management:**
  + Bất kì host nào chạy libvirt daemon có thể sử 
dụng để quản lí network vật lí và logic.
  + Liệt kê các interface đang tồn tại, cấu hình tạo, xóa các interface, bridge, vlans, bond devices.

- **Virtual NAT and Route based networking:**
  + Quản lí và tạo các mạng ảo.
  + Libvirt network sử dụng firewall để hoạt động như là router, cung cấp các máy ảo trong suốt quá trình truy cập tới mạng của host.


## 2. Virt-manager tool
### 2.1 Cài đặt:
- `sudo apt-get install virt-manager`

### 2.2 Sử dụng:

- Tạo máy ảo:
  + `File` -> `New virtual machine`

- Làm việc với máy ảo:
  
![](https://i.ibb.co/XtJMpzT/Screenshot-from-2020-10-20-09-51-21.png)

- **Note:**
   + Các thông số của máy ảo chỉ có hiệu lực thay đổi khi máy ảo tắt
   + Ctrl+Alt để thoát khỏi màn hình máy ảo
   + Có thể  clone hoặc xóa máy ảo (Chuột phải)

- Quản lí mạng của máy ảo:
   + `Edit` -> `Connection details` -> `Virtual network`

![](https://i.ibb.co/KzSNHr5/Screenshot-from-2020-10-20-09-55-02.png)
  
__Docs__
  
- https://github.com/khanhnt99/thuctap012017/blob/master/TamNT/Virtualization/docs/KVM/2.Cong_cu_quan_ly_KVM.md#1
- https://github.com/khanhnt99/thuctap012017/blob/master/XuanSon/Virtualization/Virtual%20Machine/KVM/Tool%20use%20KVM.md#2.4
