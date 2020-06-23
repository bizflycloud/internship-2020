# Start Up Script Ubuntu 18.04LTS

## Cách 1: Dùng Crontab

- B1: Tại cửa sổ Terminal ( Ctrl + Alt + T), sử dụng lệnh `crontab -e `

- B2: sau đó thêm vào dòng lệnh như sau: `@reboot /path/to/script`

`Chú ý sử dụng abs path`

## Cách 2: Dùng systemd

- B1: Tạo Script

Đầu tiên chúng ta sẽ tạo 1 scipt ví dụ khi hệ thống start up

Tại cửa số Terminal nhập lệnh: `sudo nano /usr/local/sbin/my-startup.sh`

Sau đó tự tạo 1 scipt đơn giản 

Tiếp đến chúng ta sẽ cần phải cấp quyền để script có thể chạy được thông qua lệnh `sudo chmod +x /usr/local/sbin/my-startup.sh`

- B2: Tạo file systemd

Sử dụng câu lệnh: sudo nano /etc/systemd/system/my-startup.service

Sau đó sẽ xuất hiện 3 mục như 
> Unit , Service , Install 


Một số thuộc tính của file:

Unit : Description: My Sh Script - mô tả

```
Service: 

ExecStart: /usr/local/sbin/my-startup.sh - Nơi lưu script

Type=forking - Bật ở chế độ *nền* sau đó tự thoát và kết thúc sau khi thực thi thành công

PIDFile=/run/start.pid - Nơi systemd có thể tìm thấy file process id của tiến trình

ExecStartPre=/usr/local/proc1/bin/start -t -q -g 'daemon on; master_process on;' - chạy các lệnh của start mà ko cần khởi động nó 
với các option như -t ( kiểm tra cấu hình ) -g 'dae ... on' khởi đồng process start dưới chế độ nền ở dạng daemon( trước khi thực sự khởi động ) . 

ExecStart=/usr/local/proc1/bin/start -g 'daemon on; master_process on;' - khởi động start 

ExecReload=/usr/local/proc1/bin/start -g 'daemon on; master_process on;' -s reload - chạy lệnh này khi systemd reload 

ExecStop - thực thi lệnh này khi systemd stop với các option khác nhau


```

Install : WantedBy=multi-user.target - sử dụng bởi các user khác nhau 



- B3 : Bật Service

Có thể kiểm tra trước thông qua lệnh: `systemctl status my-starup.service`

Nếu thông báo hiện ra là Disable thì chúng ta sẽ bật Service thông qua lệnh: `sudo systemctl enable my-starup.service`

có thể kiểm tra lại 1 lần nữa thông qua lệnh `systemctl status my-starup.service`

Nếu đã thấy thay đổi thành Enabled là đã thành công !
