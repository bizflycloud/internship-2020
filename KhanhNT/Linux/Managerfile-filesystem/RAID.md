#  6. Understanding RAID, 'mdadm' command

## 6.1 Giới thiệu:
- RAID: Redundant Array of Indepndent Disks
- GHép nhiều ổ đĩa vật lí lại với nhau nhằm dung lỗi và tăng tốc.
- RAID tập hợp các đĩa trong 1 nhóm để trở thành 1 logical volume
- Hiệu suất thấp do sử dụng tài nguyên từ máy chủ. 

### 6.2 Các khái niệm về RAID
- __Parity__: Tạo lại nội dung bị mất từ thông tin parity. (RAID5 và RAID6)
- __Stripe__: chia sẻ dữ liệu ngẫu nhiên nhiều đĩa
- __Mirroring__: Sử dụng trong RAID1 và RAID10. Tạo ra bản sao cùng 1 dữ liệu
- __Hot spare__: Ổ đĩa dự phòng trong máy chủ có thể tự động thay thế các ổ bị lỗi. 
- __Chunks__: một kích thước của dữ liệu có thể tối thiểu từ 4Kb trở lên.

### 6.3 Cấp đội của RAID
#### RAID0:

![](https://blogd.net/linux/software-raid-toan-tap-tren-linux/img/raid0.png)

   + __RAID0 (Striping)__ : dữ liệu được ghi vào đĩa theo phương pháp chia sẻ
   + Một nửa nội dung nằm ở 1 đĩa còn nửa còn lại nằm ở đĩa khác
   + Cho phép ghi và đọc được hoàn thành nhanh hơn
   + Không có tính parity hay khả năng dự phòng
   + Sử dụng tốt nhất lưu trữ văn bản có yêu cầu đọc và ghi tốc độ cao.

#### RAID1

![](https://blogd.net/linux/software-raid-toan-tap-tren-linux/img/raid1.png)

- __Mirroring__: sao chép dữ liệu vào 2 hay nhiều đĩa
- Ghi chậm vì thao tác ghi phải thực hiện 2 lần

#### RAID5

![](https://blogd.net/linux/software-raid-toan-tap-tren-linux/img/raid5.png)

- __ Distributed Parity__: Thông tin chẵn lẻ được sử dụng để xây dựng lại dữ liệu.

#### RAID6
 ![](https://blogd.net/linux/software-raid-toan-tap-tren-linux/img/raid6.png)

- Cũng theo phương phapsn parity
- Cần tối thiểu 4 ổ đĩa

#### RAID10

![](https://blogd.net/linux/software-raid-toan-tap-tren-linux/img/raid10.png)

- RAID1 + RAID0
- Làm cả 2 công việc Mirror và Striping.
- Mirror trước rồi Stripe trong RAID10
- Ngược lại với RAID01

#### Note: 
- Muốn kiểm tra RAID array đang sử dụng xem trong file **proc/mdstat**

# mdadm
- RAID quản lí bằng gói `mdadm`
- `mdadm --version `
- Chức năng:
  + Tạo 1 RAID mới
  + Tập howpk các thiêt bị để tạo RAID
  + Monitor: theo dõi thiết bị
  + Build
  + Grow: thay đổi kích thước của mảng
  + Manage: thêm ổ đĩa, gỡ thiết bị sai hỏng
  + Misc: tẩy hoặc xóa các superblock cũ, thu thập thông tin
 

## Tạo RAID

- Tạo RAID0
 + `mdadm -C /dev/md0 -l raid0 -n 2 /dev/sd[b-c]1`
 + -c: Tạo RAID mới
 + -l: Level của RAID
 + -n: Không có thiết bị RAID
- Kiểm tra đã được tạo:
 + `mdadm -E /dev/sd[b-c]1`
- Tạo file system (ext4) cho RAID
  + ` mkfs.ext4 /dev/md0`
