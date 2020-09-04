# LAB: Cài đặt và sử dụng cơ bản LVM
## 1. Một số lưu ý cần nhớ
### 1.1. Physical volume
- Đối với các thao tác về Physical Volume, ta sử dụng tiền tố `*pv`
  
```
pvchange pvck pvcreate pvdisplay pvmove 

pvremove pvresize pvs pvscan
```
- 1 Physical volume là 1 đĩa vật lí hoặc 1 phân vùng đĩa như /dev/sda1, /dev/sdb1,...
-  Muốn sử dụng Physical volume ta cần mount nó để sử dụng.
- LVM sử dụng Physical Volume để tạo lên 1 Volume Group.

### 1.2 Volume Group
- Đối với thao tác về Volume Group. Ta sử dụng tiền tố `vg*`

```
vgcfgbackup vgck vgdisplay vgimport vgrename 

vgsplit vgconvert vgexport vgchange vgcreate 

vgextend vgmerge vgremove vgscan vgreduce
``` 

### 1.3 Logical Volume
- Sử dụng tiền tố `lv*`

```
lvchange lvdisplay lvmchange lvmdiskscan lvreduce

lvcovert lvextend lvcreate lvmconfig lvrename
```
- Volume hoàn chỉnh bước cuối cùng để mount vào hệ điều hành.
- Kết hợp Physical Volume vào 1 Volume Group để thống nhất không gian lưu trữ sẵn trên hệ thống. Sau đó chia chúng thành các phân vùng có kích thước khác nhau.
- Các bước để sử dụng LVM cho việc quản lí ổ đĩa:
  + Tạo Physical Volumes từ không gian của 1 hay nhiều đĩa cứng.
  + Tạo Volume Groups từ không gian của các Physical Volume.
  + Tạo Logical Volume từ Volume Groups và sử dụng.

## 2. Thực hành Cơ bản
- Kiểm tra LVM có thể can thiệp vào ổ đĩa nào bằng câu lệnh:
  + `sudo lvmdiskscan`

![](https://i.ibb.co/RBFvVGd/Screenshot-from-2020-09-03-15-08-41.png)
- Tạo Physical Volume để kết thúc cho bước 1:
  + `pvcreate /dev/sdb /dev/sdc /dev/sdd`

![](https://i.ibb.co/cLbLStb/Screenshot-from-2020-09-03-15-10-22.png)

- Kiểm tra bằng lệnh `pvs`

```
corgi@ubuntu:~$ sudo pvs
  PV         VG   Fmt  Attr PSize PFree
  /dev/sdb        lvm2 ---  1.02g 1.02g
  /dev/sdc        lvm2 ---  1.02g 1.02g
  /dev/sdd        lvm2 ---  1.25g 1.25g
```

- Tiếp theo `Tạo Volume Groups từ không gian các Physical Volume`
 
```
corgi@ubuntu:~$ sudo vgcreate LVMVolGroup /dev/sdb /dev/sdc /dev/sdd
  Volume group "LVMVolGroup" successfully created
```

( Trong đó LVMVolGroup là tên của Volume Group) 

```
corgi@ubuntu:~$ sudo pvs
  PV         VG          Fmt  Attr PSize PFree
  /dev/sdb   LVMVolGroup lvm2 a--  1.02g 1.02g
  /dev/sdc   LVMVolGroup lvm2 a--  1.02g 1.02g
  /dev/sdd   LVMVolGroup lvm2 a--  1.25g 1.25g
```

```
corgi@ubuntu:~$ sudo vgs
  VG          #PV #LV #SN Attr   VSize VFree
  LVMVolGroup   3   0   0 wz--n- 3.29g 3.29g
```
( Volume Group có dung lượng 3.29GB xấp xỉ tổng dung lượng 3 đĩa /dev/sdb /dev/sdc /dev/sdd)

- `Tạo Logical Volume từ Volume Groups`
  + Tạo 2 Logical Volume lần lượt có tên như sau:
     - Public: 2 GB
     - Private: 1 GB

```
corgi@ubuntu:~$ sudo lvcreate -L 2G -n Public LVMVolGroup
  Logical volume "Public" created.
corgi@ubuntu:~$ sudo lvcreate -L 1G -n Private LVMVolGroup
  Logical volume "Private" created.
corgi@ubuntu:~$ vgs -o +lv_size,lv_name
  WARNING: Running as a non-root user. Functionality may be unavailable.
  /run/lvm/lvmetad.socket: connect failed: Permission denied
  WARNING: Failed to connect to lvmetad. Falling back to internal scanning.
  /dev/mapper/control: open failed: Permission denied
  Failure to communicate with kernel device-mapper driver.
  Incompatible libdevmapper (unknown version) and kernel driver (unknown version).
corgi@ubuntu:~$ sudo vgs -o +lv_size,lv_name
  VG          #PV #LV #SN Attr   VSize VFree   LSize LV     
  LVMVolGroup   3   2   0 wz--n- 3.29g 292.00m 2.00g Public 
  LVMVolGroup   3   2   0 wz--n- 3.29g 292.00m 1.00g Private
```
- Để sử dụng Logical Volume vừa tạo ra, cần phải format và mount chúng với hệ điều hành.
   + Logical Volume có thể được truy cập ở 2 nơi:
      - `/dev/volume_group_name/logical_volume_name`
      - `/dev/mapper/volume_group_name-logical_volume_name`

- Khi format ta có thể dụng lệnh sau
  + `mkfs.ext4 /dev/LVMVolGroup/Public`
  + `mkfs.ext4 /dev/LVMVolGroup/Private`

```
corgi@ubuntu:~$ sudo mkfs.ext4 /dev/mapper/LVMVolGroup-Private 
mke2fs 1.42.13 (17-May-2015)
Creating filesystem with 262144 4k blocks and 65536 inodes
Filesystem UUID: 2adc6519-e6ae-4dc4-a10a-891f23f569a9
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done

corgi@ubuntu:~$ sudo mkfs.ext4 /dev/mapper/LVMVolGroup-Public 
mke2fs 1.42.13 (17-May-2015)
Creating filesystem with 524288 4k blocks and 131072 inodes
Filesystem UUID: 3d7d762d-95e7-4e98-8dff-cd5ef42dad22
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 
```

- Trước khi mount để sử dụng ta cần tạo 1 thưc mục để `gán` với Logical Volume đã format.
   + `sudo mkdir -p /mnt/{Public,Private}`
- Mount tương ứng vào tên thư mục
  
```
corgi@ubuntu:~$ sudo mount /dev/LVMVolGroup/Public /mnt/Public/
corgi@ubuntu:~$ sudo mount /dev/LVMVolGroup/Private /mnt/Private/
corgi@ubuntu:~$ df -H
Filesystem                       Size  Used Avail Use% Mounted on
udev                             1.1G     0  1.1G   0% /dev
tmpfs                            210M  3.4M  207M   2% /run
/dev/sda1                        9.5G  1.7G  7.3G  19% /
tmpfs                            1.1G     0  1.1G   0% /dev/shm
tmpfs                            5.3M     0  5.3M   0% /run/lock
tmpfs                            1.1G     0  1.1G   0% /sys/fs/cgroup
tmpfs                            210M     0  210M   0% /run/user/1000
/dev/mapper/LVMVolGroup-Public   2.1G  3.2M  2.0G   1% /mnt/Public
/dev/mapper/LVMVolGroup-Private  1.1G  1.4M  952M   1% /mnt/Private
```
- Để disk sẽ tự động mount sau khi reboot ta sửa file /etc/fstab
   + `sudo vim /etc/fstab`

```
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda1 during installation
UUID=912aa286-ce35-43a6-8ffe-31402503701e /               ext4    errors=remount-ro 0       1
# swap was on /dev/sda5 during installation
UUID=94081b71-9c1d-4188-ac8d-891335cda70f none            swap    sw              0       0

/dev/mapper/LVMVolGroup-Public /mnt/Public ext4 defaults 0 0
/dev/mapper/LVMVolGroup-Private /mnt/Private ext4 defaults 0 0
```

- Kiểm tra bằng lệnh `mount -av`

## 3. Thay đổi dung lượng cho Volume Group
- Thêm 1 đĩa trống dung lượng 1GB. Phân vùng nằm ở /dev/sde.

```
corgi@ubuntu:~$ sudo lvmdiskscan
[sudo] password for corgi: 
  /dev/LVMVolGroup/Public  [       2.00 GiB] 
  /dev/sda1                [       9.04 GiB] 
  /dev/LVMVolGroup/Private [       1.00 GiB] 
  /dev/sda5                [     975.00 MiB] 
  /dev/sdb                 [       1.02 GiB] LVM physical volume
  /dev/sdc                 [       1.02 GiB] LVM physical volume
  /dev/sdd                 [       1.25 GiB] LVM physical volume
  /dev/sde                 [       1.25 GiB] 
  3 disks
  2 partitions
  3 LVM physical volume whole disks
  0 LVM physical volumes
```

- Tăng kích thước cho Volume Group. Thêm phân vùng /dev/sde vào trong VolumeGroup LVMVolGroup.

```
corgi@ubuntu:~$ sudo vgextend /dev/LVMVolGroup /dev/sde
  Physical volume "/dev/sde" successfully created
  Volume group "LVMVolGroup" successfully extended
```

- Giảm kích thước 1 Volume Group
  ```
  corgi@ubuntu:~$ sudo vgreduce /dev/LVMVolGroup /dev/sde
  Removed "/dev/sde" from volume group "LVMVolGroup"
  ```

## 4. Thay đổi kích thước của Logical Volume
- Kiểm tra dung lượng trống trong Volume Group mà Logical Volume đấy đang ở trong.
 
```
corgi@ubuntu:~$ sudo vgs
  VG          #PV #LV #SN Attr   VSize VFree
  LVMVolGroup   4   2   0 wz--n- 4.53g 1.53g
```

```
corgi@ubuntu:~$ sudo lvs
  LV      VG          Attr       LSize Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  Private LVMVolGroup -wi-ao---- 1.00g                                                    
  Public  LVMVolGroup -wi-ao---- 2.00g   
```

#### 4.1 Tăng kích thước của Logical Volume: Private
  + Bước 1: Kiểm tra dung lượng tối đã có thể dùng để tăng kích thước.
  + Bước 2: Thêm dung lượng cho Logical Volume.
  + Bước 3: Thay đổi kích thước

##### Bước 1: Kiểm tra dung lượng tối đa có thể dùng để tăng kích thước.
  
```
corgi@ubuntu:~$ sudo vgdisplay LVMVolGroup
  --- Volume group ---
  VG Name               LVMVolGroup
  System ID             
  Format                lvm2
  Metadata Areas        4
  Metadata Sequence No  6
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
  VG UUID               Ai81Be-rdxg-kDA4-Gpz5-HlVz-8b9D-nRUPg2
```

  __ Free PE/Size 392/1.53 GiB__: Giá trị mà ta có thể thêm vào cho Logical Volume cần mở rộng

##### Bước 2: Thêm dung lượng cho Logical Volume

```
corgi@ubuntu:~$ sudo lvextend -L +392 /dev/LVMVolGroup/Private
  Size of logical volume LVMVolGroup/Private changed from 1.00 GiB (256 extents) to 1.38 GiB (354 extents).
  Logical volume Private successfully resized.
```

/dev/LVMVolGroup/Private là Logical cần tăng kích thước.

##### Bước 3: Thực hiện thay đổi kích thước (LV phải đang được mount)

```
corgi@ubuntu:~$ sudo resize2fs /dev/LVMVolGroup/Private
resize2fs 1.42.13 (17-May-2015)
Filesystem at /dev/LVMVolGroup/Private is mounted on /mnt/Private; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 1
The filesystem on /dev/LVMVolGroup/Private is now 362496 (4k) blocks long.
```

#### 4.2 Giảm kích thước Logical Volume
- Bước 1: Unmount Logical Volume.
- Bước 2: Kiểm tra file system.
- Bước 3: Giảm kích thước.
- Bước 4: Thực hiện thay đổi.

##### Bước 1: Unmount Logical Volume

```
corgi@ubuntu:~$ sudo umount -v /mnt/Private/
umount: /mnt/Private/ unmounted
```
##### Bước 2: Kiểm tra file system

```
corgi@ubuntu:~$ sudo e2fsck -ff /dev/LVMVolGroup/Private 
e2fsck 1.42.13 (17-May-2015)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/LVMVolGroup/Private: 11/98304 files (0.0% non-contiguous), 14756/362496 blocks
```
```
corgi@ubuntu:~$ df -H
Filesystem                      Size  Used Avail Use% Mounted on
udev                            1.1G     0  1.1G   0% /dev
tmpfs                           210M  3.4M  207M   2% /run
/dev/sda1                       9.5G  1.7G  7.3G  19% /
tmpfs                           1.1G     0  1.1G   0% /dev/shm
tmpfs                           5.3M     0  5.3M   0% /run/lock
tmpfs                           1.1G     0  1.1G   0% /sys/fs/cgroup
/dev/mapper/LVMVolGroup-Public  2.1G  3.2M  2.0G   1% /mnt/Public
tmpfs                           210M     0  210M   0% /run/user/1000
```

##### Bước 3: Giảm kích thước 
```
corgi@ubuntu:~$ sudo lvreduce -L -1G /dev/LVMVolGroup/Private
  WARNING: Reducing active logical volume to 392.00 MiB
  THIS MAY DESTROY YOUR DATA (filesystem etc.)
Do you really want to reduce Private? [y/n]: y
  Size of logical volume LVMVolGroup/Private changed from 1.38 GiB (354 extents) to 392.00 MiB (98 extents).
  Logical volume Private successfully resized.
```

##### Bước 4: Thực hiện thay đổi:

```
corgi@ubuntu:~$ sudo resize2fs /dev/LVMVolGroup/Private 1G
resize2fs 1.42.13 (17-May-2015)
The containing partition (or device) is only 100352 (4k) blocks.
You requested a new size of 262144 blocks.
```

## 5. Xóa các Volume 
- Để xóa volume cần phải unmount 

```
corgi@ubuntu:~$ sudo  umount /dev/LVMVolGroup/Public 
corgi@ubuntu:~$ sudo  umount /dev/LVMVolGroup/Private
```
- Xóa Logical Volume

```
corgi@ubuntu:~$ sudo lvremove /dev/LVMVolGroup/Public
Do you really want to remove and DISCARD active logical volume Public? [y/n]: y
  Logical volume "Public" successfully removed
corgi@ubuntu:~$ sudo lvremove /dev/LVMVolGroup/Private
Do you really want to remove and DISCARD active logical volume Private? [y/n]: y
  Logical volume "Private" successfully removed
```

- Xóa volume Group

```
corgi@ubuntu:~$ sudo vgremove /dev/LVMVolGroup
  Volume group "LVMVolGroup" successfully removed
```

- Xóa Physical Volume
 
```
corgi@ubuntu:~$ sudo lvmdiskscan
  /dev/sda1 [       9.04 GiB] 
  /dev/sda5 [     975.00 MiB] 
  /dev/sdb  [       1.02 GiB] LVM physical volume
  /dev/sdc  [       1.02 GiB] LVM physical volume
  /dev/sdd  [       1.25 GiB] LVM physical volume
  /dev/sde  [       1.25 GiB] LVM physical volume
  0 disks
  2 partitions
  4 LVM physical volume whole disks
  0 LVM physical volumes
```

```
corgi@ubuntu:~$ sudo pvremove /dev/sdb
  Labels on physical volume "/dev/sdb" successfully wiped
corgi@ubuntu:~$ sudo pvremove /dev/sdc
  Labels on physical volume "/dev/sdc" successfully wiped
corgi@ubuntu:~$ sudo pvremove /dev/sdd
  Labels on physical volume "/dev/sdd" successfully wiped
corgi@ubuntu:~$ sudo pvremove /dev/sde
  Labels on physical volume "/dev/sde" successfully wiped
```
- Check lại

```
corgi@ubuntu:~$ sudo lvmdiskscan
  /dev/sda1 [       9.04 GiB] 
  /dev/sda5 [     975.00 MiB] 
  /dev/sdb  [       1.02 GiB] 
  /dev/sdc  [       1.02 GiB] 
  /dev/sdd  [       1.25 GiB] 
  /dev/sde  [       1.25 GiB] 
  4 disks
  2 partitions
  0 LVM physical volume whole disks
  0 LVM physical volumes
```

Tài liệu tham khảo
- https://github.com/khanhnt99/thuctap012017/blob/master/TVBO/docs/LVM/docs/lvm-change-size.md#delete





