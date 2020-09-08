# Migrating LVM
## 1. Tính năng:
- Tạo 1 bản sao lưu dữ liệu từ 1 `Logical Volume` này đến 1 ổ đĩa mới mà không làm mất dữ liệu hay xảy ra tình trạng downtime.
- **Mục đích**: Di chuyển dữ liệu từ 1 đĩa cứng cũ đến 1 đĩa cứng mới.

## 2. Thực hành:
### 2.1 Kiểm tra các thông số của disk

```
corgi@ubuntu:~$ sudo fdisk -l
[sudo] password for corgi: 

Disk /dev/sda: 10.7 GB, 10737418240 bytes
255 heads, 63 sectors/track, 1305 cylinders, total 20971520 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x000dd30a

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048    16777215     8387584   83  Linux
/dev/sda2        16779262    20969471     2095105    5  Extended
/dev/sda5        16779264    20969471     2095104   82  Linux swap / Solaris

Disk /dev/sdb: 2147 MB, 2147482624 bytes
255 heads, 63 sectors/track, 261 cylinders, total 4194302 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/sdb doesn't contain a valid partition table

```
### 2.2 Sử dụng `/dev/sdb` để tạo 2 phân vùng `/dev/sdb1` và `/dev/sdb2`

```
corgi@ubuntu:~$ sudo fdisk /dev/sdb 
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
Building a new DOS disklabel with disk identifier 0x7f055da0.
Changes will remain in memory only, until you decide to write them.
After that, of course, the previous content won't be recoverable.

Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)

Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): 
Using default response p
Partition number (1-4, default 1): 1
First sector (2048-4194301, default 2048): 
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-4194301, default 4194301): +1G

Command (m for help): t
Selected partition 1
Hex code (type L to list codes): 8e
Changed system type of partition 1 to 8e (Linux LVM)

Command (m for help): n
Partition type:
   p   primary (1 primary, 0 extended, 3 free)
   e   extended
Select (default p): 
Using default response p
Partition number (1-4, default 2):  
Using default value 2
First sector (2099200-4194301, default 2099200): 
Using default value 2099200
Last sector, +sectors or +size{K,M,G} (2099200-4194301, default 4194301): +1G
Value out of range.
Last sector, +sectors or +size{K,M,G} (2099200-4194301, default 4194301): +500M

Command (m for help): t
Partition number (1-4): 2
Hex code (type L to list codes): 8e
Changed system type of partition 2 to 8e (Linux LVM)

Command (m for help): p

Disk /dev/sdb: 2147 MB, 2147482624 bytes
255 heads, 63 sectors/track, 261 cylinders, total 4194302 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x7f055da0

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1            2048     2099199     1048576   8e  Linux LVM
/dev/sdb2         2099200     3123199      512000   8e  Linux LVM

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.

```

### 2.3 Tạo các `Physical Volume` từ 2 đĩa `/dev/sdb1` và `/dev/sdb2`
```
corgi@ubuntu:~$ sudo pvcreate /dev/sdb[1-2]
  Physical volume "/dev/sdb1" successfully created
  Physical volume "/dev/sdb2" successfully created
```

### 2.4 Tạo `Volume Group` từ 2 `Physical Volume` tạo ra:

```
corgi@ubuntu:~$ sudo vgcreate LVM_VG_Pool /dev/sdb[1-2]
  Volume group "LVM_VG_Pool" successfully created
```

### 2.5 Tạo `Mirror Volume` từ `Volume Group` tạo ra:

```
corgi@ubuntu:~$ sudo lvcreate -L 300M -m 1 -n LVM_MIRROR_LV LVM_VG_Pool
  Logical volume "LVM_MIRROR_LV" created
```

trong đó:

```
-L : Dung lượng logical volume được tạo ra
-m : số bản sao lưu dữ liệu, ở đây là 1 nhưng sẽ tạo ra 2 bản.
```

- Kiểm tra lại bằng lệnh
```
corgi@ubuntu:~$ sudo lvdisplay -v
    Finding all logical volumes
  --- Logical volume ---
  LV Path                /dev/LVM_VG_Pool/LVM_MIRROR_LV
  LV Name                LVM_MIRROR_LV
  VG Name                LVM_VG_Pool
  LV UUID                l9t9qZ-LFUD-XTB8-msv1-V2C7-xH7Z-ampFXs
  LV Write Access        read/write
  LV Creation host, time ubuntu, 2020-09-08 09:04:19 +0700
  LV Status              available
  # open                 0
  LV Size                300.00 MiB
  Current LE             75
  Mirrored volumes       2
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:3
```


### 2.6  Tạo filesystem cho `Mirror volume`, gán nó vào thư mục `/mnt/Mirror`:

#### 2.6.1 Tạo filesystem:
```
corgi@ubuntu:~$ sudo mkfs.ext4 /dev/LVM_VG_Pool/LVM_MIRROR_LV
mke2fs 1.42.9 (4-Feb-2014)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
Stride=0 blocks, Stripe width=0 blocks
76912 inodes, 307200 blocks
15360 blocks (5.00%) reserved for the super user
First data block=1
Maximum filesystem blocks=67633152
38 block groups
8192 blocks per group, 8192 fragments per group
2024 inodes per group
Superblock backups stored on blocks: 
	8193, 24577, 40961, 57345, 73729, 204801, 221185

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done 
```

#### 2.6.2 Mount vào /mnt/Mirror:

```
corgi@ubuntu:~$ sudo mkdir /mnt/Mirror
corgi@ubuntu:~$ sudo mount /dev/LVM_VG_Pool/LVM_MIRROR_LV /mnt/Mirror
```

## 3. Kiểm tra tính năng:
### 3.1 Kiểm tả thông tin về Logical Volume


```
corgi@ubuntu:~$ sudo lvs -a -o +devices
  LV                       VG          Attr      LSize   Pool Origin Data%  Move Log                Copy%  Convert Devices                                            
  LVM_MIRROR_LV            LVM_VG_Pool mwi-aom-- 300.00m                         LVM_MIRROR_LV_mlog 100.00         LVM_MIRROR_LV_mimage_0(0),LVM_MIRROR_LV_mimage_1(0)
  [LVM_MIRROR_LV_mimage_0] LVM_VG_Pool iwi-aom-- 300.00m                                                           /dev/sdb1(0)                                       
  [LVM_MIRROR_LV_mimage_1] LVM_VG_Pool iwi-aom-- 300.00m                                                           /dev/sdb2(0)                                       
  [LVM_MIRROR_LV_mlog]     LVM_VG_Pool lwi-aom--   4.00m                                                           /dev/sdb2(75)               
```

__Note: Ta thấy `LVM_MIRROR_LV` đang có 2 bản sao lưu là `LVM_MIRROR_LV_mimage_0` và `LVM_MIRROR_LV_mimage_1` gán với 2 Physical volume là `sdb1` và `sdb2`__

### 3.2 Xóa dữ liệu trên 1 `Mirror Volume`

```
corgi@ubuntu:~$ sudo lvconvert -m 0 /dev/LVM_VG_Pool/LVM_MIRROR_LV /dev/sdb1
  Logical volume LVM_MIRROR_LV converted.
```

```
corgi@ubuntu:~$ sudo lvs -a -o +devices
  LV            VG          Attr      LSize   Pool Origin Data%  Move Log Copy%  Convert Devices     
  LVM_MIRROR_LV LVM_VG_Pool -wi-ao--- 300.00m                                            /dev/sdb2(0)
```

