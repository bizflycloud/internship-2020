# Check Ram, CPU, proccess

## Check Ram và CPU

- `top` ?
    - Chương trình mặc định để giám sát ram và CPU cũng như các thông số khác
    - Hiển thị các Process đang sử dụng tài nguyên của máy
- `htop` ?
    - Chức năng tương tự như `top` nhưng trực quan hơn
    - Hiển thị tất cả các process ( dù có hay không sử dụng tài nguyeeeen)
    - Có các shortcut gửi các signal đến cho tiến trình ( process) như kill, stop , start,...
    - Cài đặt htop: `sudo apt install htop`
- `ps` ?
    - Xem toàn bộ các tiến trình đang chạy `ps -e`
    - Xem toàn bộ tiến trình ( chạy / không chạy ): `ps aux`
    - Xem các tiến trình chạy dưới tên root: `ps -U root -u root`
- Tài liệu tham khảo
    - [https://www.tecmint.com/ps-command-examples-for-linux-process-monitoring/](https://www.tecmint.com/ps-command-examples-for-linux-process-monitoring/)
    - [https://blog.vu-review.com/htop-la-gi.html](https://blog.vu-review.com/htop-la-gi.html)