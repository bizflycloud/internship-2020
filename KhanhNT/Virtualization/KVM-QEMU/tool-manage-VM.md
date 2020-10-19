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














## 3. Virtsh
## 3.1. Giới thiệu
- Là bộ công cụ để tương tác với **libvirtd(libvirt daemon)** có hỗ trợ quản lí KVM.
- Phân biệt giữa **virt** và **virtsh**
  + `virsh` là bộ công cụ tương tác `libvirtd` đi kèm sẵn khi cài đặt `libvirt-bin`, còn `virt** phải cài đặt riêng.
  + `virsh` không tương tác trực tiếp với `libvirtd` để sử dụng tài nguyên mà chỉ có thể sử dụng tài nguyên mà `hypervisor` quản lí thông qua việc thực thi các file **xml**.

## 2.2 Sử dụng virsh
- Cấu trúc lệnh cơ bản:
  + `virsh [option]... <command> <domain> [ARG]...`
- Hiện thông số cơ bản của node

```
corgi@ubuntu:~$ sudo virsh nodeinfo
[sudo] password for corgi: 
setlocale: No such file or directory
CPU model:           x86_64
CPU(s):              1
CPU frequency:       1795 MHz
CPU socket(s):       1
Core(s) per socket:  1
Thread(s) per core:  1
NUMA cell(s):        1
Memory size:         3080240 KiB
```

- Liệt kê tất cả các máy ảo: 

```
corgi@ubuntu:~$ sudo virsh list --all
setlocale: No such file or directory
 Id    Name                           State
----------------------------------------------------
```

- Liệt kê các máy ảo đang hoạt động
  + `virsh list`

- Tạo máy ảo

  + `vim host1.xml`

```
<domain type='kvm'>
  <name>host</name>
  <memory unit='MB'>512</memory>
  <currentMemory unit='MB'>512</currentMemory>
  <vcpu>1</vcpu>
  <os>
    <type>hvm</type>
    <boot dev='cdrom'/>
  </os>
  <features>
    <acpi/>
  </features>
  <clock offset='utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/bin/kvm</emulator>
    <disk type="file" device="disk">
      <driver name="qemu" type="raw"/>
      <source file="/var/lib/libvirt/images/cirros-0.4.0-x86_64-disk.img"/>
      <target dev="hda" bus="ide"/>
      <address type="drive" controller="0" bus="0" target='0'/>
    </disk>
    <interface type='network'>
      <source network='default'/>
      <target dev='vnet-'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
function='0x0'/>
    </interface>
    </devices>
    <seclabel type='none'/>
</domain>
```

trong đó:

- **type**: loại
- **id**: id của máy ảo
- **name**: tên máy ảo sẽ hiển thị
- **memory**: lượng RAM của máy ảo
- **vcpu**: lượng CPU máy ảo
- **/var/lib/libvirt/images/cirros-0.4.0-x86_64-disk.img**: đường dẫn tới image 

- Check

```
sudo virsh list --all                               
setlocale: No such file or directory
 Id    Name                           State
----------------------------------------------------
 9     host                           running
```

- Tạo máy ảo:

```
corgi@ubuntu:~⟫ sudo virsh create host1.xml                           
Domain host created from host1.xml
```

- Export thông tin máy ảo ra XML:

```
corgi@ubuntu:~$ sudo virsh dumpxml host > /tmp/host1.xml
```

- Các thao tác liên quan:

|Câu lệnh|Mô tả|
|--------|-----|
|help|Hiển thị phần trợ giúp|
|start|Bật máy ảo đang stop|
|shutdown|Tắt máy ảo|
|destroy|Đóng tất cả các ứng dụng và shutdown máy ảo|
|reboot|Khởi động lại máy ảo|
|autostart|Tự động bật máy ảo khi khởi động hệ thống|

- Lưu trạng thái hoạt động của máy ảo vào 1 file để có thể restore lại:

  + `virsh save <vm_name> <vm_name_time>.state














__Docs__:
- https://github.com/hocchudong/thuctap012017/blob/master/TamNT/Virtualization/docs/KVM/1.Tim_hieu_KVM.md



