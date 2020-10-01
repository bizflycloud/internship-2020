# FILE SYSTEM & LFHS

![FILE%20SYSTEM%20&%20LFHS/Untitled.png](FILE%20SYSTEM%20&%20LFHS/Untitled.png)

Nếu bạn là một người sử dụng Window OS lâu năm và khi mới bắt đầu sử dụng các Unix-like OS thì có thể sẽ gặp 1 số khó khăn cơ bản. Do hệ thống Linux quản lý các tệp tin hoàn toàn khác với Window. Do nó coi toàn bộ các thiết bị và file đều như 1 ổ đĩa và quản lý tất cả dưới 1 thư mục chung là `/` ( hay còn được gọi là root directory ). Nhưng trước đó, chúng ta sẽ cùng tìm hiểu về các loại file hệ thống mà Linux làm việc cùng rồi sau đó sẽ đến với LFHS ( Linux File Hierchy Structure ). Cuối cùng là tìm hiểu sơ qua về hard disk và 1 số lệnh cơ bản để giám sát disk.

## 1. Mount và Unmount

Đầu tiên chúng ta cần tìm hiểu về 2 khái niệm này, bởi nó chính là hoạt động cốt lõi của hẹ thống. Khác với hệ điều hành nổi tiếng nhất hiện nay là Window, thì Linux có cách thức quản lý các thiết bị cũng như các tệp tương đối khác → Nó quản lý tất cả mọi thứ dưới dạng "ổ đĩa ". Tức là toàn bộ các thiết bị từ file hệ thống tới các thiết bị I/O khác như chuột, bàn phím, etc. 

Ví dụ: Nếu với các hệ điều hành cũ, việc để sử dụng 1 ổ đĩa CD/ROM có 1 quá trinh cụ thể ( Quá trình này thường được tự động hóa ngày nay ). 

- Đầu tiên, người sử dụng cần phải Mount CD/ROM tới `/media` :

    ```jsx
    mount /dev/cd /media/cd-rom
    ```

    → Để thực hiện việc gắn kết phần dữ liệu mới với hệ điều hành

- Sau đó, nếu không muốn sử dụng thì cần Unmount :

    ```jsx
    Unmount /media/cd-rom
    ```

Tuy đơn giản nhưng nó chính là ý tưởng cốt lõi ( Core Concept ) để toàn bộ hệ thống quản lý cũng như hoạt động trơn tru nhất. Tiếp theo chúng ta sẽ tìm hiểu các loại File hệ thống mà Linux OS có thể hoạt động cùng và cũng như tìm hiểu tại sao loại file thông dụng nhất lại là `Ext4` .

## 2. Các loại file hệ thống của Linux

Bao gồm các loại sau :

1. Ext : Một loại file hệ thống cũ, lâu đời, không còn được sử dụng
2. Ext2 : Một loại file hệ thống mới cho phép chứa tới 2 terabytes
3. Ext3 : Được cải thiện hơn so với Ext2 . Nhược điểm của nó là các Server thường sẽ không làm việc được cùng do không thể tạo snapshot hệ thống và không có khả năng phục hồi sau lỗi ( recovery )
4. Ext4 : Loại file được sử dụng mặc dịnh trong các hệ thống hiện nay. Có khả năng tương thích với SSD.
5. JFS : Loại file hệ thống cũ tạo bởi IBM . Tuy nhiên có khả năng lỗi sau một thời gian dài làm việc
6. XFS : Loại file có kích thước nhỏ, không còn được sử dụng

 ⇒ Ta thấy được Ext4 là loại File có hiệu năng tốt nhất và thích hợp nhất cho thời điểm hiện tại.

Nhưng nếu một ngày chúng ta cần phải kiểm tra lại file hệ thống do nhiều lí do khác nhau 

→ Bạn có thể sử dụng lệnh `fsck` ( file system consistency check ) 

```jsx
fsck /path/to/filesys
```

```jsx
#Mot so option co ban 
1. -A – kiem tra tat ca cac file he thong. Danh sach duoc lay tu /etc/fstab
2. -V – Liet ke nhung thay doi 
3. -r – Hien cac tham so thong ke
4. -C – Hien thanh progress.
```

Vậy là ta đã có cái nhìn khá bao quát về File hệ thống. Sau đây sẽ giải thích về LFHS và một số thư mục quan trọng của hệ thống

## 3. LFHS

Hệ thống Linux quản lý tát cả các file và thiết bị dưới dạng như ổ đĩa. Hệ thống sẽ tiến hành quản lý 1 sơ đồ cây ( bao gồm tất cả các phần tử của máy ). Nếu một thiết bị như chuột, bàn phím, etc kết nối tới hệ thống sẽ được mount tới `/dev` . Để tìm hiểu sâu hơn ta xét mô hình sau :

![FILE%20SYSTEM%20&%20LFHS/Untitled%201.png](FILE%20SYSTEM%20&%20LFHS/Untitled%201.png)

Ở đây chúng ta sẽ chỉ xét 1 vài thư mục quan trọng, nếu có nhu cầu tìm hiểu sâu bạn có thể tham khảo link sau:

[The Linux Filesystem Explained - Linux.com](https://www.linux.com/training-tutorials/linux-filesystem-explained/)

1. **/boot** : Thư mục chứa các file để bootup hệ thống. Tốt nhất bạn không nên thay đổi những file trong này nếu không có kiến thức sâu về hệ thống Linux
2. **/home** : Đường dẫn home của các user, chứa các file của user cụ thể.
3. **/bin** : Các lệnh Binary của hệ thống được sử dụng bởi các user thường
4. **/sbin** : Các lệnh System Binary của hệ thống được sử dụng bởi quản trị viên của hệ thống ( thường là `root` )
5. **/etc** : Nơi lưu các file cấu hình của hầu hết các package trên hệ thống
6. **/var** : Thường được sử dụng làm nơi lưu giữ log của các package trên hệ thống 
7. **/lib** : Nơi các thư viện được lưu, có thể được chia thêm làm lib64 và lib32

## 4. Lệnh `df` và `du`

### 4.1. `df` ( Disk Free ) :

Trong quá trình sử dụng, nếu không có GUI ( Graphical User Interface ), người sử dụng hoàn toàn có thể sử dụng lệnh `df` để kiểm tra tổng dung lượng disk và phần free disk.

```jsx
df 
```

 Kết quả nhận được có dạng .

```jsx
Filesystem     1K-blocks     Used Available Use% Mounted on
udev             3996816        0   3996816   0% /dev
tmpfs             804624    10020    794604   2% /run
/dev/sda9       68117056 18036160  46597712  28% /
tmpfs            4023116    29848   3993268   1% /dev/shm
tmpfs               5120        4      5116   1% /run/lock
tmpfs            4023116        0   4023116   0% /sys/fs/cgroup
/dev/loop0         88832    88832         0 100% /snap/simplescreenrecorder/1
/dev/loop2         85888    85888         0 100% /snap/core/3748
/dev/loop3         85888    85888         0 100% /snap/core/3604
/dev/loop1         83328    83328         0 100% /snap/core/3887
/dev/sda10      78873504 67530504   7313356  91% /home
/dev/sda1         507904    30908    476996   7% /boot/efi
tmpfs             804624       12    804612   1% /run/user/121
tmpfs             804624       64    804560   1% /run/user/1000
```

Một số các option cơ bản

```jsx
1. --total : Hien thi dong the hien so luong disk da dung va so luong free disk
2. -h : Ket qua hien thi duoi dang de doc
3. -a : Quet toan bo cac filesystem 
```

### 4.2 `du` (Disk usage ) :

Lệnh  này sẽ tiến hành kiếm tra lượng dữ liệu mà file hoặc đường dẫn đang sử dụng trên hard disk

```jsx
du
```

Kết quả nhận được có dạng :

```jsx
44    /home/mandeep/test/data
2012    /home/mandeep/test/system design
24    /home/mandeep/test/table/sample_table/tree
28    /home/mandeep/test/table/sample_table
32    /home/mandeep/test/table
100104    /home/mandeep/test
```

Các option cơ bản :

```jsx
1. -h : Ket qua viet duoi dang de hieu
2. -s : Chi hien thi tong du lieu su dung cua duong dan
3. -a : Quet toan bo cac file + Duong dan 
4. -exclude=pattern : Voi cac file co pattern thi khong thuc hien quet
5. -c : Cung cap ket qua tong hop cuoi cung
```

## 5. Quản lý các phân vùng ổ cứng ( Partition ) của disk

![FILE%20SYSTEM%20&%20LFHS/Untitled%202.png](FILE%20SYSTEM%20&%20LFHS/Untitled%202.png)

Thường trong các ổ lưu trữ hard disk có dung lượng lớn, thì nó sẽ được chia làm các phần nhỏ hơn được gọi phân vùng ( Partition ). Mỗi Partition sẽ hoạt động như một một hard disk thực sự. Để quản lý các phân vùng thì Linux cung cấp cho người sử dụng 1 công cụ vô cùng hữu ích và cũng tương đối dễ sử dụng đó chính là `fsdisk` . Cho phép người sử dụng có thể thêm, xóa , copy các partition.

**Thực hiện kiểm tra các phân vùng trên hệ thống**

```jsx
fdisk -l

Disk /dev/sda: 637.8 GB, 637802643456 bytes
255 heads, 63 sectors/track, 77541 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          13      104391   83  Linux
/dev/sda2              14        2624    20972857+  83  Linux
/dev/sda3            2625        4582    15727635   83  Linux
/dev/sda4            4583       77541   586043167+   5  Extended
/dev/sda5            4583        5887    10482381   83  Linux
/dev/sda6            5888        7192    10482381   83  Linux
/dev/sda7            7193        7845     5245191   83  Linux
/dev/sda8            7846        8367     4192933+  82  Linux swap / Solaris
/dev/sda9            8368       77541   555640123+  8e  Linux LVM
```

Các đĩa được thể hiện với dạng như sau:  `/dev/sdb` , `/dev/sdc` , ...

**Kiểm tra phân vùng trên 1 disk**

```jsx
fdisk -l /dev/sda

Disk /dev/sda: 637.8 GB, 637802643456 bytes
255 heads, 63 sectors/track, 77541 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          13      104391   83  Linux
/dev/sda2              14        2624    20972857+  83  Linux
/dev/sda3            2625        4582    15727635   83  Linux
/dev/sda4            4583       77541   586043167+   5  Extended
/dev/sda5            4583        5887    10482381   83  Linux
/dev/sda6            5888        7192    10482381   83  Linux
/dev/sda7            7193        7845     5245191   83  Linux
/dev/sda8            7846        8367     4192933+  82  Linux swap / Solaris
/dev/sda9            8368       77541   555640123+  8e  Linux LVM
```

**Xem các lệnh có thể thực thi trên disk**

```jsx
fdisk /dev/sda

WARNING: DOS-compatible mode is deprecated. It's strongly recommended to
         switch off the mode (command 'c') and change display units to
         sectors (command 'u').

Command (m for help): m
a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition
   l   list known partition types
   m   print this menu
   n   add a new partition
   o   create a new empty DOS partition table
   p   print the partition table
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)
```

**Xem bảng phân vùng trên disk**

Để xem Parition table trên disk ta sử dụng option `p` :

```jsx
Command (m for help): p

Disk /dev/sda: 637.8 GB, 637802643456 bytes
255 heads, 63 sectors/track, 77541 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          13      104391   83  Linux
/dev/sda2              14        2624    20972857+  83  Linux
/dev/sda3            2625        4582    15727635   83  Linux
/dev/sda4            4583       77541   586043167+   5  Extended
/dev/sda5            4583        5887    10482381   83  Linux
/dev/sda6            5888        7192    10482381   83  Linux
/dev/sda7            7193        7845     5245191   83  Linux
/dev/sda8            7846        8367     4192933+  82  Linux swap / Solaris
/dev/sda9            8368       77541   555640123+  8e  Linux LVM
```

**Xóa 1 phân vùng trên disk**

Việc thực hiện xóa 1 partition trên ổ đĩa có thể thực hiện qua option `d` và sau đó nhập thứ tự của phân vùng cần xóa. Trước khi kết thúc, thì ta cần sử dụng option `w` để lưu bảng phân vùng ( partition table) vào disk ( giống như việc ta save lại khi edit text ).

```jsx
 fdisk /dev/sda

WARNING: DOS-compatible mode is deprecated. It's strongly recommended to
         switch off the mode (command 'c') and change display units to
         sectors (command 'u').

Command (m for help): d
Partition number (1-4): 4

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
```

Việc xóa phân vùng sẽ gây mất dữ liệu nên trước khi thực hiện hãy chắc chắn rằng bạn đã backup toàn bộ dữ liệu

**Tạo 1 phân vùng mới**

Option `n` sẽ giúp chúng ta thực hiện điều này, chúng ta cũng cần xác định xem phân vùng đó là phân vùng mở rộng hay phân vùng chính ( primary / extend ) . Phân vùng `primary` thường là phân vùng chứa các file hệ thống trong đó phân vùng `extend` thường chứa dữ liệu của người dùng :

```jsx
fdisk  /dev/sda

WARNING: DOS-compatible mode is deprecated. It's strongly recommended to
         switch off the mode (command 'c') and change display units to
         sectors (command 'u').

Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
```

Sau đó bạn có thể lựa chọn kích thước của file theo cú pháp `+ 5000M` . Trong đó bạn có thể tùy thay đổi theo số MB mong muốn

Tuy nhiên, trước khi lưu chúng ta cần sửa lại thứ tự của disk trước khi lưu thay đổi. Ví dụ: Chúng ta có 9 phân vùng trên hệ thống, ta thực hiện xóa các phân vùng có thứ tự 4 5 6 rồi sau đó tạo 1 phân vùng mới. Tuy nhiên, trong quá trình đó, phân vùng thứ 7 đã chuyển về làm phân vùng thứ 4 mới → Phân vùng mới được tạo ra sẽ có thứ tự phân vùng 5 

→ Xảy ra xung đột trong thứ tự phân vùng

⇒ Cách giải quyết

```jsx
fdisk  /dev/sda

WARNING: DOS-compatible mode is deprecated. It's strongly recommended to
         switch off the mode (command 'c') and change display units to
         sectors (command 'u').

Command (m for help): x

Expert command (m for help): f
Done.

Expert command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.
```

Sau đó thực hiện chạy option `w` để lưu lại thay đổi và thoát 

**Tạo file hệ thống sau khi có phân vùng mới**

Giả sử chúng ta vừa tạo 1 phân vùng 4 mới → Tạo File System để hệ thống nhận phân vùng :

```jsx
mkfs.ext4 /dev/sda4
```

---

## Nguồn tham khảo:

[What is Linux File System? Easy Guide - Like Geeks](https://likegeeks.com/linux-file-system/)

[Tổng quan về filesystem trên Linux](https://blogd.net/linux/tong-quan-ve-filesystem-tren-linux/)

[](http://gocit.vn/bai-viet/file-system-linux/)

[The Linux Filesystem Explained - Linux.com](https://www.linux.com/training-tutorials/linux-filesystem-explained/)

[How to Use 'fsck' to Repair File System Errors in Linux](https://www.tecmint.com/fsck-repair-file-system-errors-in-linux/)

[df command in Linux with Examples - GeeksforGeeks](https://www.geeksforgeeks.org/df-command-linux-examples/)

[du command in Linux with examples - GeeksforGeeks](https://www.geeksforgeeks.org/du-command-linux-examples/)

[10 fdisk Commands to Manage Linux Disk Partitions](https://www.tecmint.com/fdisk-commands-to-manage-linux-disk-partitions/)