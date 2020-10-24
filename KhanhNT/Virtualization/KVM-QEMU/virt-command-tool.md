# Virt-command tool
## 1. Giới thiệu
- Bộ câu lệnh virt gồm rất nhiều câu lệnh để quản lí máy ảo gồm:
  + virt-install: Cài đặt máy ảo
  + virt-viewer: console tới máy ảo
  + virt-log: Đọc log của máy ảo
  + virt-xml: dùng để sửa các cấu hình trong file xml
  + virt-edit: sửa cấu hình máy ảo

## 2. virt-install
### 2.1 Giới thiệu
- Là công cụ để tạo các máy ảo KVM, XEN hoặc LXC
- Sử dụng thư viện quản lí `hypervisor` là `libvirt`
- Hỗ trợ giao diện đồ họa cho máy ảo sử dụng VNC hoặc SPICE cũng như chế độ text thông qua console.
- VM có thể được cấu hình sử dụng 1 hoặc nhiều ổ đĩa ảo, nhiều interface mạng,...

### 2.2 Sử dụng
- Câu lệnh:
  + `virt-install [option]`

- Tạo máy ảo từ một image có sẵn

```
root@ubuntu:~# virt-install --connect qemu:///system --name ubuntu18 --name ubuntu18 --memory 1024 --vcpus 2 --disk /root/bionic-server-cloudimg-amd64.img --import --network network=default --graphics vnc,listen='0.0.0.0'
WARNING  KVM acceleration not available, using 'qemu'

(process:10819): Gtk-WARNING **: Locale not supported by C library.
	Using the fallback 'C' locale.

Starting install...

```




