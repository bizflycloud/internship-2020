# Sử dụng Crontab để thực hiện các task tự động

## Syntax crontab -e

- Mẫu nhập: `m h dom mon dow command`
```
Giải thích:

m - phút

h - giờ

dom - ngày của tháng

mon - tháng 

dow - số ngày trong tuần ( chạy từ 1 đến 6 - tương ứng với thứ 2 đến thứ 7 )

command - lệnh cần thực hiện

``` 

- Ví dụ: 0 5 * * 1 tar zvf /home/usr/backup /home 

> Lệnh này sẽ backup các dữ liệu ở /home 

