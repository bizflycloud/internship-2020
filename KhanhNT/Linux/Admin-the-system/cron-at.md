# Cron-at
## Cron
### 1. Khái niệm 
- Là tiện ích giúp lập kế hoạch chạy dòng lệnh trên server để thực hiện 1 hoặc nhiều công việc dựa trên thời gian được lập sẵn.
- Cron là chương trình chạy ngầm mãi khi mà đã được khởi động lên
- Điều khiển bởi tệp `/etc/crontab`

```
corgi@ubuntu:~$ cat /etc/crontab 
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# m h dom mon dow user	command
17 *	* * *	root    cd / && run-parts --report /etc/cron.hourly
25 6	* * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6	* * 7	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6	1 * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )

```
## 2. Chạy 1 script tự động bằng CronTab

```
corgi@ubuntu:~$ service cron status
cron start/running, process 857
```
- Kiểm tra xem hiện tại có những Crontab nào:
  
```
corgi@ubuntu:~$ crontab -l
no crontab for corgi`
```

- Tạo Crontab
  + `crontab -e`

```
*     *     *     *     *     command to be executed
-     -     -     -     -
|     |     |     |     |
|     |     |     |     +----- day of week (0 - 6) (Sunday=0)
|     |     |     +------- month (1 - 12)
|     |     +--------- day of month (1 - 31)
|     +----------- hour (0 - 23)
+------------- min (0 - 59)
```

Ví dụ:
- Chạy vào phút thứ 30 mọi giờ mọi tháng mọi tuần

```
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
 30 * * * * /script/abc.sh
```
- Chạy vào chủ nhật hàng tuần

```
0 17 * * sun /script/abc.sh
```
- 8 tiếng chạy 1 lần

```
* /8 * * * /script/abc.sh
```
- Khởi động load lại cron
  + `etc/init.d/cron restart`
- Xóa file crontab
  + `crontab -r`
- `@hourly`: Chạy hang giờ vào phút thứ 0.
- `@daily`: Chạy hàng ngày vào 00:00.
- `@montly`: Chạy vào 00:00 ngày đầu mỗi tháng.
- `@yearly`: Chạy hàng năm vào 00:00 ngày đầu tiên mỗi năm.

## AT 
- Lệnh `at` thay thế cho bộ lập lịch `cron`.
- `at` cho phép lên lịch 1 lệnh để chạy 1 lần tại 1 thời điểm nhất định mà không cần sửa tệp cấu hình.

```
corgi@ubuntu:~$ service atd status
atd start/running, process 854
```

- Xem các công việc

```
corgi@ubuntu:~$ atq
1	Wed Sep  9 15:38:00 2020 a corgi
```

- Xóa 1 công việc
 
```
corgi@ubuntu:~$ atrm 1
Warning: deleting running job
corgi@ubuntu:~$ atq
corgi@ubuntu:~$ 
```

__Tài liệu tham khảo__
- https://vntalking.com/toan-tap-cach-su-dung-crontab-tren-server-linux.html
- https://hocvps.com/tong-quat-ve-crontab/
- https://blogd.net/linux/quan-ly-cron-tren-linux/
- https://quantrimang.com/cach-len-lich-cac-lenh-trong-linux-voi-at-162038
