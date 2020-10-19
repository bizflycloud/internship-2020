# Cài đặt KVM và QEMU
### 1.Kiểm tra hệ thống và cài đặt
- `KVM` chỉ làm việc trên hệ thống mà CPU hỗ trợ ảo hóa phần cứng mở rộng Intel VT-x hoặc AMD-V.
- Kiểm tra CPU có hỗ trợ tính năng ảo hóa

```
corgi@ubuntu:~$ egrep -c '(svm|vmx)' /proc/cpuinfo
1

hoặc 

corgi@ubuntu:~$ grep -c -E '(svm|vmx)' /proc/cpuinfo 
1

trong đó:
-c: in ra số  dòng nhưng không phải dòng

```


- Nếu kết quả đầu ra là 0 thì CPU không hỗ trợ, đầu ra lớn hơn không thì CPU hỗ trợ

- Kiểm tra hệ thống có hỗ trợ KVM trong Kernel

```
corgi@ubuntu:~$ lsmod | grep kvm
kvm_intel             180224  0
kvm                   561152  1 kvm_intel
irqbypass              16384  1 kvm
```
- Cài đặt KVM/QEMU
  + `sudo apt-get update`
  + `sudo apt-get install qemu-kvm libvirt-bin bridge-utils virt-manager -y`

- Kiểm tra KVM/QEMU đã được cài đặt

```
corgi@ubuntu:~$ sudo virsh -c qemu:///system list
setlocale: No such file or directory
 Id    Name                           State
----------------------------------------------------
```

### 2. Note:

- Đường dẫn đến file cấu hình:
  + `/etc/libvirtd`
- Pool chứa các VM
  + `/var/lib/libvirt/images`
- File Log:
  + `/var/log/libvirt/qemu`

```
corgi@ubuntu:/var/log/libvirt/qemu
```

- Các công nghệ:
  + Virtual Switch: Dùng Linux bridge hoặc Openvswitch
  + Virtual Network: Dùng Libvirt
- Image Cirros:
  + Là image rút gọn củâ Ubuntu Server 
  + Cirros chỉ DHCP cho card mặc định eth0
  + Chỉ dùng được 1 số lệnh như: `poweroff`, `reboot`, `ifdown -a`, `ifup -a`, `ifconfig`.




__Docs:__

- https://ostechnix.com/how-to-enable-nested-virtualization-in-virtualbox/
- https://github.com/hocchudong/thuctap012017/blob/master/TamNT/Virtualization/docs/KVM/1.Tim_hieu_KVM.md
- https://github.com/khanhnt99/thuctap012017/blob/master/XuanSon/Virtualization/Virtual%20Machine/KVM/KVM%20basic.md
