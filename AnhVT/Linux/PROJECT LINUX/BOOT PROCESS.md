# BOOT PROCESS

![BOOT%20PROCESS/Untitled.png](BOOT%20PROCESS/Untitled.png)

Việc hiểu về quá tình bootup và startup của Linux sẽ giúp người sử dụng có cái nhìn sâu hơn về hệ điều hành này và từ đó có thể cấu hình và đưa ra các giải pháp phù hợp khi gặp vấn đề startup. Quá trình này tương đối đơn giản và sẽ được giải thích ở phần dưới

Đầu tiên chúng ta sẽ bắt đầu với mô hình tổng quan khi bootup 1 hệ thống Linux và rồi từ đó sẽ đi sâu vào từng quá trình :

![BOOT%20PROCESS/Untitled%201.png](BOOT%20PROCESS/Untitled%201.png)

## 1. Quá trình BIOS:

![BOOT%20PROCESS/Untitled%202.png](BOOT%20PROCESS/Untitled%202.png)

`BIOS` có nghĩa là " Basic I/O System " . Về cơ bản, BIOS được cài đặt sẵn trên ROM của máy tính và là phần tử đầu tiên khởi động. Sau khi khởi động, BIOS sẽ thực hiện POST ( Quá trình kiểm tra bộ nhớ, hard disk, etc ) Tiếp đó nó sẽ tìm kiếm các `bootable disk` ( thường sẽ là MBR ). MBR thuộc phần đầu tiên của disk. 

Mục tiêu của quá trình này là việc tìm được MBR → load vào bộ nhớ và nhường quyển điều khiển lại. 

## 2. Quá trình MBR :

MBR thường thuộc vào phần dầu của disk, tại `dev/hda` hoặc `dev/sda`. Có kích thước 512 byte, trong đó 446 byte sẽ được dành cho phần code, 46 bytes dành cho các phân mảnh `partition` và 2 byte kiểm tra ( validation) MBR

Tại giai đoạn này có nó có chức năng load phần code `boot loader` để kích hoạt `GRUB2` .

## 3. Quá trình GRUB:

![BOOT%20PROCESS/Untitled%203.png](BOOT%20PROCESS/Untitled%203.png)

Sau khi được load từ MBR thì `GRUB2` sẽ có nhiệm vụ đọc các Kernel Image. Nếu trên máy tính của bạn có sử dụng nhiều Kernel image khác nhau ( thường được lưu trữ tại `/boot/vmlinuz` ) thì `GRUB2` sẽ hiển thị 1 màn hình để bạn chọn. Nếu không được chọn hoặc người sử dụng chỉ có 1 Kernel Image thì `GRUB2` sẽ tự động load lõi Kernel được cấu hình theo mặc định trong file cấu hình của nó ( Tại đường dẫn `/boot/grub/grub2.conf` ). Sau đây là 1 file cấu hình ví dụ của `GRUB2` ( Lưu ý để chỉnh sửa cấu hình của `GRUB2` cần sử dụng các câu lệnh cụ thế, bạn có thể tự tìm hiểu thêm) :

```bash
terminal_output console
if [ x$feature_timeout_style = xy ] ; then
set timeout_style=menu
set timeout=5
# Fallback normal timeout code in case the timeout_style feature is
# unavailable.
else
set timeout=5
fi
### END /etc/grub.d/00_header ###
BEGIN /etc/grub.d/10_linux ###
menuentry 'CentOS Linux (3.10.0-123.4.2.el7.x86_64) 7 (Core)' --class centos --class gnu-linux --class gnu --class os --unrestricted $menuentry_id_option 'gnulinux-3.10.0-123.el7.x86_64-advanced-fe0109f2-6f34-48ae-b51e-1f5fa78305b5' {
load_video
set gfxpayload=keep
insmod gzio
insmod part_msdos
insmod ext2
set root='hd0,msdos1'
```

## 4. Quá trình khởi động lõi Kernel

![BOOT%20PROCESS/Untitled%204.png](BOOT%20PROCESS/Untitled%204.png)

Lõi Kernel - "trái tim" của rất nhiều hệ thống Linux khác nhau - sau khi được giải nén và load từ `GRUB2` thì sẽ thực hiện mount phần dữ liệu `root` ra hard disk theo đường dẫn có trong `grub2.cnf`

Sau đó nó sẽ thực hiện chạy `/sbin/init` - Tiến trình chạy đầu tiên trong hệ thống ( có PID là 1 ). 

Kernel sử dụng 1 đường dẫn dữ liệu `root` tạm thời trên `initramfs` cho đến khi hoàn tất quá trình mount trên hard disk. 

## 5. Quá trình Init

Tại quá trình này, hệ thống sẽ thực hiện các runlevel. Việc này được cấu hình trong `/etc/iniab` . Quá trình này có 7 Level tuy nhiên tiến trình tiên tiến hơn và được sử dụng nhiều hơn hiện này là `systemd` đã có những sửa đổi. Các runlevel của `systemd` :

```bash
1. poweroff.target - Tien hanh dung qua trinh va tat he thong
2. rescue.target - Cung cap 1 he thong co ban va kem theo 1 rescue shell
3. multi-user.target - Cung cap tat ca cac service va kem theo 1 CLI de thuc hien lenh
4. graphical.target - Cung cap tat ca cac service va kem theo 1 giao dien GUI
5. reboot.target - Khoi dong lai he thong
```

### Như vậy chúng ta đã có cái nhìn tổng quan về quá trình bootup !

---

## Nguồn tham khảo

[An introduction to the Linux boot and startup processes](https://opensource.com/article/17/2/linux-boot-and-startup)

[Stages of Linux booting process - explanation, step by step tutorial](https://www.crybit.com/linux-boot-process/)

[The Linux Booting Process - 6 Steps Described in Detail](https://www.freecodecamp.org/news/the-linux-booting-process-6-steps-described-in-detail/)

[6 Stages of Linux Boot Process (Startup Sequence)](https://www.thegeekstuff.com/2011/02/linux-boot-process/)

[Linux Boot Process](https://www.youtube.com/watch?v=ZtVpz5VWjAs)

[Understanding the Linux Boot Process - CompTIA Linux+, LPIC-1](https://www.youtube.com/watch?v=mHB0Z-HUauo)

[Linux boot Process tutorial, Linux boot process explained in detail | Linux Tutorial #35](https://www.youtube.com/watch?v=KdBctuRQxUo)

[Boot process in Linux](https://www.youtube.com/watch?v=RgLMBXg5b9I)