# LVM (Logical Volume Management)

# 1. Giới thiệu:
- Công cụ quản lí `phân vùng logic` được tạo và phân bổ từ các ổ đĩa vật lí
- Dùng để quản lí các thiết bị lưu trữ.
- Chia không gian đĩa cứng thành các Logical Volume từ đó giúp cho việc thay đổi kích thước trở nên dễ dàng.
- Dễ dàng khi mở rộng phân vùng ra lớn hơn

## 2.  Khái niệm liên quan: 
 - __Physical volume (PV)__: 
    + Ổ cứng vật lí từ hệ thống (partition, SSD, đĩa cứng,..)
    + Đơn vị cơ bản để LVM khởi tạo volume group
    + 1MB header ghi dữ liệu về cách phân bố Volume Group chứa nó.
 - __Volume group (VG)__: 
    + Nhóm các physical volume (ổ đĩa ảo) trên 1 hoặc nhiều ổ đĩa khác nhau.
    + Khi thêm 1 PV vào VG, LVM tự động chia dung lượng trên PV thành nhiều __Physical Extent__ với kích cỡ bằng nhau.
    + Từ VG tạo nhiều Logical Volume để sửa chúng

![](https://vinasupport.com/uploads/2019/01/Logical-Volume-Group.png)  

  -  __Logical volume__: 
     + Phân vùng ảo ổ đĩa ảo, chia từ Volume group. 
     + Dùng để mount tới các hệ thống tập tin (File System) và được format với định dạng chuẩn khác nhau như ext2, ext3, ext4...
     + Tương tự như các partition trên ổ cứng nhưng linh hoạt hơn vì có thể thay đổi kích thước mà không gián đoạn hệ thống.
     + LV được chia thành nhiều các **Logical Extent**, mỗi Logical Extent được mapping tương ứng với 1 Physical Extent trên ổ đĩa.

![](https://vinasupport.com/uploads/2019/01/Logical-Volume.png)




![](https://vinasupport.com/uploads/2019/01/Mo-Hinh-LVM-Logical-Volumn-Manager.png)

- **Hard drives-Drives**
  + Thiết bị lưu trữ dữ liệu, ví dụ trong linux là /dev/sda
- **Partition**
  + Phân vùng của Hard drives
  + Có 2 loại là __primary partition__ và __extended partition__
- **Primary partition**
   + Phân vùng chính, có thể khởi động
   + Tối đã 4 phân vùng này
- **Extended partition**
  + Phân vùng mở rộng




## 3. Extent
- Là đơn vị nhỏ nhất của VG
- Kích thước của các __extent__ được xác định bởi Volume Group.
- Mỗi volume được tạo ra từ VG chứa nhiều extent nhỏ với kích thước cố định = nhau.
- Các extent trên LV không nhất thiết phải nằm liên tục nhau trên ổ cứng vật lí bên dưới mà có thể nằm rải rác trên nhiều ổ cứng khác nhau.
- Là nền tảng của LVM, LV có thể mở rộng hay thu nhỏ bằng cách thêm các extent hoặc lấy bớt các extent từ volume này.
- __Extent__ trên Physical Volume gọi là __Physical extent__
- **Extent** trên Logical Volume gọi là **Logical   extent**
- **Logical volume** là ánh xạ mà LVM duy trì giữa các Logical và Physical extent.

![](https://cloudcraft.info/wp-content/uploads/2018/09/LVM-1.png)

## 4. LAB 
### 4.1 Chuẩn bị
- Ubuntu 18.04 server
- Tạo thêm ổ cứng cho máy ảo

![](https://i.ibb.co/RYyTZ6s/Screenshot-from-2020-08-23-16-58-33.png)

### 4.2 Tạo Logical Volume trên LVM
- **Kiểm tra có những Hard Drives nào trên hệ thống**
  + `lsblk`
  
![](https://i.ibb.co/5W2p6Xj/Screenshot-from-2020-08-23-17-01-33.png)

- **Tạo partition**
 + Từ sdb tạo các partition: `fdisk /dev/sdb`
 
![](https://i.ibb.co/2yywf2N/Screenshot-from-2020-08-23-17-04-37.png)

![](https://i.ibb.co/tQB3Vwh/Screenshot-from-2020-08-23-17-08-49.png)

 
- **Giải thích câu lệnh:** 
 + `n`: Bắt đầu tạo partition
 + `1`: tạo 1 partition primary
 + `+1G`: tạo có dung lượng 1G
 + `w`: lưu và thoát
 + `t`: thay đổi định dạng partition
 + `8e`: đổi thành LVM 

- **Tạo Physical volume**
 + `pvcreate /dev/sdb1`
 + `pvcreate /dev/sdc1`
 + Kiểm tra lại bằng lệnh `pvs`

![](https://i.ibb.co/tYQkXnQ/Screenshot-from-2020-08-23-20-30-34.png)

- **Tạo Volume Group**
 + Nhóm các Physical Volume thành 1 Volume Group
 + `vgcreate vg-demo1 /dev/sdb1 /dev/sdc1`
 + Kiểm tra bằng lệnh `vgs`

![](https://i.ibb.co/7jLqqKd/Screenshot-from-2020-08-23-20-34-00.png)

- **Tạo Logical Volume**
  + Từ 1 volume group, tạo thành các Logical Volume
  + `lvcreate -L 1G -n lv-demo1 vg-demo1`
  + -L: Dung lượng của Logical Volume
  + -n: Tên của Logical volume

![](https://i.ibb.co/bXCcNZQ/Screenshot-from-2020-08-23-20-37-35.png)

- **Định dạng Logical Volume**
 + Format thành các định dạng như ext2, ext3, ext4
 + `mkfs -t ext4 /dev/vg-demo1/lv-demo1`
 
 ![](https://i.ibb.co/ryyfZzb/Screenshot-from-2020-08-23-20-41-07.png)

- **Mount và sử dụng**
 + mkdir demo1
 + Mount logical volume lv-demo1 và demo1
 + `mount /dev/vg-demo1/lv-demo1 demo1`

![](https://i.ibb.co/tPL4CLQ/Screenshot-from-2020-08-23-20-44-09.png)

### 4.3 Thay đổi dung lượng Logical Volume trên LVM 
- Tăng kích thước lv-demo1
- lv-demo1 thuộc Volume group vg-demo1
- Kiểm tra xem Volume group vg-demo1 còn dung lượng để kéo dãn không
- Kiểm tra: `vgdisplay`

![](https://i.ibb.co/tqHRV8D/Screenshot-from-2020-08-23-20-50-03.png)

- Kiểm tra còn dung lương qua `VG Status resizable` và `Free PE /Size`

- Tăng kích thước dùng lệnh: `lvextend -L +50M /dev/vg-demo1/lv-demo1`
  + -L: tùy chọn kích thước
- Sau khi tăng Logical Volume nhưng file system trên volume không đổi
- Để thay đổi dùng lệnh sau: `resize2fs /dev/vg-demo1/lv-demo1`
- Để giảm kích thước trước tiên unmount Logical Volume muốn giảm
 + `unmount /dev/vg-demo1/lv-demo1`
- Giảm kích thước
  + `lvreduce -L 20M /dev/vg-demo1/lv-demo1`
- Format lại Logical volume
  + `mkfs.ext4 /dev/vg-demo1/lv-demo1`
- Mount lại Logical Volume
  + `mount /dev/vg-demo1/lv-demo1 demo1`

### 4.4 Thay đổi dung lượng Volume Group trên LVM

- Nhóm thêm Physical Volume hoặc thu hồi Physical Volume khỏi Volume Group
- `vgextend /dev/vg-demo1 /dev/sdb3`
- `vgreduce /dev/vg-demo1 /dev/sdb3`

### 4.5 Xóa Logical Volume, Volume Group, Physical Volume

#### 4.5.1 Xóa Logical volume
- Unmount Logical Volume
  + `umount /dev/vg-demo1/lv-demo1`
- Xóa
  + `lvremove /dev/vg-demo1/lv-demo1`

#### 4.5.2 Xóa Volume Group
- `vgremove /dev/vg-demo1`

#### 4.5.3 Xóa Physical Volume
- `pvremove /dev/sdb3`

Tài liệu tham khảo: https://github.com/hocchudong/Logical-Volume-Manager-LVM-
