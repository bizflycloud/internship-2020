# LVM Stripe
## 1. Tổng quan
- `LVM Stripe` là 1 tính năng của LVM quy định ghi các đĩa hình thành lên Logical Volume.
- Thay thế cách ghi mặc định bằng việc ghi dữ liệu lần lượt lên từng Physical Volume. Ví dụ:
  + Ta có 1 Logical Volume là `LV_Download` được hình thành từ 2 Physical Volume là `/dev/sdb` và `/deb/sdc`. Khi ghi dữ liệu theo cách thông thường `LV_Download` thì dữ liệu sẽ được ghi đầy vào `/dev/sdb` trước đó rồi mới ghi vào `/dev/sdc`.
  + Khi ta sử dụng LVM Stripe, dữ liệu được ghi vào `LV_Download` sẽ có 50% dung lượng ghi vào `/dev/sdb` và 50% ghi vào `/dev/sdc`
- Nói cách khác, **LVm Stripe** khiến dữ liệu được ghi vào Logical Volume được `ghi đều lên các Physical Volume tạo nên nó`. 
- Tính năng:
  + Tăng hiệu năng ghi dữ liệu lên các đĩa.
  + Tiết kiệm không gian đĩa

## 2. Lab
- Ta có 4 Physical Volume lần lượt được cho như sau:
  + `/dev/sdb`: 1GB
  + `/dev/sdc`: 1GB
  + `/dev/sdd`: 1GB

```
corgi@ubuntu:~$ sudo pvs
  PV         VG   Fmt  Attr PSize    PFree   
  /dev/sdb        lvm2 ---     1.09g    1.09g
  /dev/sdc        lvm2 ---  1003.24m 1003.24m
  /dev/sdd        lvm2 ---     1.02g    1.02g

```

- __Bước 1__: Tạo 1 Volume Group cho 3 Physical Volume đã có với tên là `LVM_VG_Stripe`
   
```
corgi@ubuntu:~$ sudo vgcreate -s 16M LVM_VG_Stripe /dev/sd\b /dev/sdc /dev/sdd
  Volume group "LVM_VG_Stripe" successfully created
corgi@ubuntu:~$ sudo vgs
  VG            #PV #LV #SN Attr   VSize VFree
  LVM_VG_Stripe   3   0   0 wz--n- 3.06g 3.06g
```

```
- `-s 16M`: Khai báo kích thước của `PE size` là 16Mb
- `LVM_VG_Stripe`: tên của Volume Group 
```

- __Bước 2__: Tạo Logical Volume từ `LVM_VG_Stripe` với dung lượng `512MB` có tên là `LVM_LV_Stripe`
   
```
corgi@ubuntu:~$ sudo lvcreate -L 500 -n LVM_LV_Stripe -i 3 LVM_VG_Stripe
  Using default stripesize 64.00 KiB.
  Rounding up size to full physical extent 512.00 MiB
  Rounding size 512.00 MiB (32 extents) up to stripe boundary size 528.00 MiB (33 extents).
  Logical volume "LVM_LV_Stripe" created.

```

`-`-i`: Khai báo số disk sử dụng Stripe`

- Check số lượng Physical Volume Stripe
  
```
corgi@ubuntu:~$ sudo lvdisplay LVM_VG_Stripe/LVM_LV_Stripe -m
  --- Logical volume ---
  LV Path                /dev/LVM_VG_Stripe/LVM_LV_Stripe
  LV Name                LVM_LV_Stripe
  VG Name                LVM_VG_Stripe
  LV UUID                0UEf9I-vSyL-MW8u-mDfw-BOEB-xY3R-2MlHOl
  LV Write Access        read/write
  LV Creation host, time ubuntu, 2020-09-05 12:13:25 +0700
  LV Status              available
  # open                 0
  LV Size                528.00 MiB
  Current LE             33
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     768
  Block device           252:0
   
  --- Segments ---
  Logical extents 0 to 32:
    Type		striped
    Stripes		3
    Stripe size		64.00 KiB
    Stripe 0:
      Physical volume	/dev/sdb
      Physical extents	0 to 10
    Stripe 1:
      Physical volume	/dev/sdc
      Physical extents	0 to 10
    Stripe 2:
      Physical volume	/dev/sdd
      Physical extents	0 to 10
```

- Kiểm tra kết quả:
```
corgi@ubuntu:~$ sudo pvs
  PV         VG            Fmt  Attr PSize   PFree  
  /dev/sdb   LVM_VG_Stripe lvm2 a--    1.08g 928.00m
  /dev/sdc   LVM_VG_Stripe lvm2 a--  992.00m 816.00m
  /dev/sdd   LVM_VG_Stripe lvm2 a--    1.02g 864.00m


**Các PV chia đều nhau để tạo Logical Volume có dung lượng `512MB`**.

__So sánh cơ chế Linear và Stripe__

![](https://raw.githubusercontent.com/khanhnt99/thuctap012017/master/TVBO/docs/LVM/pictures/linear-vs-striped-logical-volume-overview.png)
