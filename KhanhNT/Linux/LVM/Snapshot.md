# Snapshot
## 1. Khái niệm
- Snapshot trong LVM là 1 tính năng cho phép tạo ra các bản sao lưu dữ liệu của 1 Logical Volume.
- Cung cấp tính năng phục hồi dữ liệu của một Logical Volume trước thời điểm tạo ra nó.
- Snapshot thường có dung lượng lớn hơn hoặc bằng dung lượng volume ban đầu.

## 2. Thực hiện tạo Snapshot
```
root@ubuntu:/home/corgi# lvmdiskscan
  /dev/LVMVolGroup/Public  [       2.00 GiB] 
  /dev/sda1                [       9.04 GiB] 
  /dev/LVMVolGroup/Private [       1.00 GiB] 
  /dev/sda5                [     975.00 MiB] 
  /dev/sdb                 [       1.02 GiB] LVM physical volume
  /dev/sdc                 [       1.02 GiB] LVM physical volume
  /dev/sdd                 [       1.25 GiB] LVM physical volume
  /dev/sde                 [       1.25 GiB] LVM physical volume
  2 disks
  2 partitions
  4 LVM physical volume whole disks
  0 LVM physical volumes
root@ubuntu:/home/corgi# vgdisplay LVMVolGroup
  --- Volume group ---
  VG Name               LVMVolGroup
  System ID             
  Format                lvm2
  Metadata Areas        4
  Metadata Sequence No  4
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                2
  Open LV               2
  Max PV                0
  Cur PV                4
  Act PV                4
  VG Size               4.53 GiB
  PE Size               4.00 MiB
  Total PE              1160
  Alloc PE / Size       768 / 3.00 GiB
  Free  PE / Size       392 / 1.53 GiB
  VG UUID               2e0yhM-Y0GC-FJwi-Z44W-h4K3-C01o-DnRMgI
  ```

- Ở Free PE có dung lượng còn trống, ta sẽ sử dụng 1 phần dung lượng này để tạo 1 snapshot cho `/dev/LVMVolGroup/Private`

  + `root@ubuntu:/home/corgi# lvcreate -l 50 --snapshot -n Private_Snapshot /dev/LVMVolGroup/Private 
  Logical volume "Private_Snapshot" created.`

**Private_Snapshot là tên Logical volume đóng vai trò Snapshot**

```
root@ubuntu:/home/corgi# lvs
  LV               VG          Attr       LSize   Pool Origin  Data%  Meta%  Move Log Cpy%Sync Convert
  Private          LVMVolGroup owi-aos---   1.00g                                                     
  Private_Snapshot LVMVolGroup swi-a-s--- 200.00m      Private 0.01                                   
  Public           LVMVolGroup -wi-ao----   2.00g   
```
- Thêm dung lượng cho snapshot 
   
```
root@ubuntu:/home/corgi# lvextend -L +1G /dev/LVMVolGroup/Private_Snapshot 
  Reached maximum COW size 1.01 GiB (258 extents).
  Size of logical volume LVMVolGroup/Private_Snapshot changed from 200.00 MiB (50 extents) to 1.01 GiB (258 extents).
  Logical volume Private_Snapshot successfully resized.
root@ubuntu:/home/corgi# lvs
  LV               VG          Attr       LSize Pool Origin  Data%  Meta%  Move Log Cpy%Sync Convert
  Private          LVMVolGroup owi-aos--- 1.00g                                                     
  Private_Snapshot LVMVolGroup swi-a-s--- 1.01g      Private 0.00                                   
  Public           LVMVolGroup -wi-ao---- 2.00g                                 

```
- Xóa snapshot
  + `lvremove /dev/LVMVolGroup/Private_Snapshot`

## 3. Sử dụng Snapshot
- Để phục hồi 1 Snapshot cho Logical Volume, umount Logical Volume trước r sử dụng snapshot.
 
```
root@ubuntu:/home/corgi# umount -v /dev/LVMVolGroup/Private
umount: /mnt/Private (/dev/mapper/LVMVolGroup-Private) unmounted
root@ubuntu:/home/corgi# lvconvert --merge /dev/LVMVolGroup/Private_Snapshot 
  Merging of volume Private_Snapshot started.
  Private: Merged: 100.0%
root@ubuntu:/home/corgi# 

```

**Tài liệu tham khảo**
- https://github.com/khanhnt99/thuctap012017/blob/master/TVBO/docs/LVM/docs/lvm-snapshot.md
