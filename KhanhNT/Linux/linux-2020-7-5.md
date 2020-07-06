# Manager process:
## ps
==========================================================================
PID: process ID

PPID: parent process ID: ID của process mà khởi động process này

TTY: loại terminal

STIME: thời gian khởi động tiến trình

ps <option>

ps -a

ps -f: toàn bộ danh sách được format

ps -af

ps -e: hiện tất cả các process

ps -r: hiện cacsc process đang chạy

ps aux: process đang chạy ngay bây giờ

ps -f -u username: hiện các process theo user

ps -f -pid id: hiển thị tất cả các process dựa trên process id

ps -C command/name: lọc process dựa trên tên process

ps -u USERNAME --forest

ps -af | grep " ": chuyển kết quả sang grep

ps -o pid,unmae,pcpu,pmem,comm: các tùy chọn đầu ra

ps -e --sort=-pcpu -o pid,pcpu,comm (sắp xếp theo 
tiền tố - giảm dần, cộng tăng dần)

ps -p PID -L : hiển thị các thread trong tiến trình

=====================================================================

## top:
=====================================================================
Quản trị cpu, ram, I/O

Thời gian hoạt động hiện tại

Thời gian uptime

User đang login

Load average: thời gian CPU load trung bình (1/5/15p)

Tasks: Tổng số tiến trình

us: CPU được dùng cho tiến trình user

sy: CPU được dùng cho tiến trình hệ thống

ni: CPU dùng cho cấu hình các giá trị

id: CPU đang ở trạng thái nghỉ

wa: CPU trạng thái chờ I/O

hi: CPU sử dụng cho phần cứng khi bị gián đoạn

si: CPU dùng cho phần mềm khi bị gián đoạn

st: CPU ảo chờ CPU thật chạy các tiến trình


Mem: thông tin RAM 

total: dung lượng ram, used: được sử dụng, free

Thông số tiến trình: 

PID: mã của tiến trình

USER: user đang thực hiện tiến trình

PR: độ ưu tiên của tiến trình

NI: giá trị nice value của tiến trình

+ Với nice value từ -20 đến 19: giá trị càng thấp độ ưu tiên càng ca. >19 thì lúc nào có thể thì sẽ chạy

+ Giá trị mặc định là 0

VIRT: dung lượng Ram ảo thực hiện cho 1 tiến trình

RES: dung lượng Ram chạy thực 1 tiến trình

SHR: dung lượng Ram share cho tiến trình

S S: trạng thaí tiến trình đang hoạt động

%CPU: CPU sử dụng cho tiến trình

%MEM: bộ nhớ sử dụng cho tiến trình

TIME: thời gian thực hiện 1 tiến trình

## FOREGROUND AND BACKGROUND PROCESS

### FOREGROUND: 
+ Mặc định mọi tiến trình lúc bắt đầu chạy là foreground process

+ jobs: liệt kê những tiến trình đang chạy

+ Thêm & cuối nếu muốn tiến trình chạy background thay vì foreground

+ fg <job number>: đưa tiến trình background trở thành foreground

+ Ctrl + Z: đưa tiến trình foreground trở thành background

============================================================================

## Kill process

+ Tìm ID tiến trình đang chạy: 

ps aux | grep process name

kill <process ID>

kill -9 <process ID>

+Hiển thị các signal của kill

kill -l

kill -9 <process ID> <process ID> <process ID>
