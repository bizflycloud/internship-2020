# LVM Thin Provisioning
## 1. Tổng quan
- Thin Provisioning là tính nanưg cấp phát ổ cưngs dựa trên LVM.

Ví dụ:
``` 
 - Giả sử ta có 1 **Volume Group**, ta sẽ tạo 1 **Thin pool** từ **VG** này với dung lượng 20GB cho nhiều khách hàng sử dụng.
 - Giả sử có 3 khách hàng, mỗi khách hàng được cấp 6GB lưu trữ => Ta tốn 6x3=18GB => Ta chỉ còn 2GB cấp cho khách hàng thứ 4. 

```
![](https://cloudcraft.info/wp-content/uploads/2018/09/LVM-20.png)

- Với kĩ thuật **Thin Provisioning**, ta vẫn có thể cấp thêm 6GB cho khách hàng thứ 4 vì mỗi user tuy được cấp 6GB nhưng user không sử dụng hết số tài nguyên này (Nếu sử dụng hết sẽ gặp tình trang **Over Provisioning**) 
- Tức là khách hàng dùng đến đâu ta cung cấp dung lượng đến đó.
- Đôí với cấp phát bình thường, LVM sẽ cấp **1 dãy Block liên tục** mỗi khi người dùng tạo volume mới. Nhưng với `thin pool` thì LVM chỉ cấp phát block ổ cứng (Tập hợp các con trỏ trỏ tới ổ cứng).

Ưu điểm:
- Tiết kiệm dung lượng cho hệ thống, tận dụng tối ưu dung lượng lưu trữ.

Nhược điểm:
- Dễ gây phân mảnh hệ thống.
- Gây ra tình trạng Over Provisioning.

## 2. LAB
### 2.1 Kịch bản:
- Tạo 1 Volume Group từ sdb và sdc.
- Tạo 1 __Thin Pool__ (thực chất là **Logical Volume** với cờ **-thinpool**.
- Tạo 4 **Thin Volume** (thực chất là **Logical Volume**) cho 4 user.
   + Tạo **filesystem** cho 4 volume này.
   + Tạo **mount point** và **mount** 4 volume này

### 2.2 Thực hành
#### Tạo Physical Volume

```
corgi@ubuntu:~$ sudo pvcreate /dev/sdb /dev/sdc /dev/sdd
  Physical volume "/dev/sdb" successfully created
  Physical volume "/dev/sdc" successfully created
  Physical volume "/dev/sdd" successfully created
corgi@ubuntu:~$ sudo lvmdiskscan
  /dev/sda1 [       9.04 GiB] 
  /dev/sda5 [     975.00 MiB] 
  /dev/sdb  [       1.09 GiB] LVM physical volume
  /dev/sdc  [    1003.24 MiB] LVM physical volume
  /dev/sdd  [       1.02 GiB] LVM physical volume
  0 disks
  2 partitions
  3 LVM physical volume whole disks
  0 LVM physical volumes
```

#### Tạo **Volume Group**

```
corgi@ubuntu:~$ sudo pvs
  PV         VG   Fmt  Attr PSize    PFree   
  /dev/sdb        lvm2 ---     1.09g    1.09g
  /dev/sdc        lvm2 ---  1003.24m 1003.24m
  /dev/sdd        lvm2 ---     1.02g    1.02g
corgi@ubuntu:~$ sudo vgcreate ThinVolGroup /dev/sdb /dev/sdc
  Volume group "ThinVolGroup" successfully created

```

#### Tạo Thin Pool (Dung lượng 1GB)

```
corgi@ubuntu:~$ sudo vgs
  VG           #PV #LV #SN Attr   VSize VFree
  ThinVolGroup   2   0   0 wz--n- 2.06g 2.06g
corgi@ubuntu:~$ sudo lvcreate -L 1G --thinpool "ThinVolGroup" ThinVolGroup
  Logical volume "ThinVolGroup" created.

```
- -L 1G: Khai báo kích thước của thin pool
- --thinpool: Khai báo Logical Volume kiểu Thin Pool.
- "ThinVolGroup": Tên của thin pool được tạo ra.
- ThinVolGroup: tên của Volume Group để tạo ra Thin Pool.

```
corgi@ubuntu:~$ sudo lvs
  LV           VG           Attr       LSize Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  ThinVolGroup ThinVolGroup twi-a-tz-- 1.00g             0.00   10.94                           
corgi@ubuntu:~$ sudo lvdisplay
  --- Logical volume ---
  LV Name                ThinVolGroup
  VG Name                ThinVolGroup
  LV UUID                dmf3an-jUdl-mEs5-fkMs-JXLH-NCV3-1JrcOs
  LV Write Access        read/write
  LV Creation host, time ubuntu, 2020-09-05 09:14:05 +0700
  LV Pool metadata       ThinVolGroup_tmeta
  LV Pool data           ThinVolGroup_tdata
  LV Status              available
  # open                 0
  LV Size                1.00 GiB
  Allocated pool data    0.00%
  Allocated metadata     10.94%
  Current LE             256
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:
```

#### Tạo Thin Volume

`lvcreate -V 1G --thin -n "Thin_User1" VG_name/LV_name`


__Tài liệu tham khảo__:
- https://github.com/khanhnt99/thuctap012017/blob/master/TVBO/docs/LVM/docs/lvm-thin.md
