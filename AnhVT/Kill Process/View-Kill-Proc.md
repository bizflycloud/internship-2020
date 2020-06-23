# Xem danh sách các process đang hoạt động

- `ps aux` 

Lệnh này sẽ show các command đang hoạt động ra output

Tại đây sẽ hiện process cũng như các thông số của process như id, thời gian hoạt động, cpu, ...

- `pgrep *name` sẽ trả lại các id có từ khóa thỏa mãn

# Đóng các process 

- sử dụng `pgrep` để lấy các id của process cần đóng 

- khi kill proc sử dụng `kill -9 *procid` 

> option 9 không phải là số mà là signal command

- khi muốn kill all sử dụng  `killall *procname*` 

