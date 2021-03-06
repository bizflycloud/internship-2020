# Linux
## Understand shell environment variables
Cách chạy 1 file shell ( đuôi .sh): 

- bash hello.sh
- sh hello.sh

- ./hello.sh

Biến trong shell:
	
+ Không thể sử dụng các ký tự khác như !, *, hoặc - , bởi vì các ký tự này có ý nghĩa đặc biệt đối với shell.

+ Biến hệ thống: là chữ in hoa
	
+ Biến do người dùng đặt: chữ thường và phải bắt đầu bằng kí tự, không được bằng số
+ Không có giá trị khởi tạo thì bằng NULL
	
Variable_name=variable value
VD: VAR1=”khanh”
       VAR2=100

Để truy cập các giá trị được giữ trong một biến, đặt trước tên biến đó với ký hiệu ( $)

VD: NAME = “Khanh”
       echo $NAME
	
Không có dấu cách 2 bên toán tử = khi gán giá trị cho biến

	
Shell cung cấp một cách để đánh dấu các biến như read-only bằng cách sử dụng lệnh readonly. Sau khi một biến được đánh dấu read-only, giá trị của nó không thể thay đổi.

Xóa 1 biến trong linux: Xóa một biến nói cho shell để gỡ bỏ biến đó từ danh sách các biến mà nó theo dõi.

NAME = “Khanh”

unset NAME 

       echo $NAME

note: Không thể dùng unset xóa biến readonly
	
Xem toàn bộ biến môi trường: env
	
Các kí tự toán học
expr toántử 1 toánhạng toántử 2 
Các dấu ngoặc:
 
-	Tất cả các kí tự trong dấu ngoặc kép đều không có giá trị tính toán 

-	Dấu nháy ngược: yêu cầu thực hiện lệnh

Cấu trúc điều khiển trong shell script:
	
## GETTING HELP
 Sử dụng lệnh man để tra cứu

Các option của 1 số lệnh cơ bản: 

###	Lệnh ls: 

+ ls -l: Hiển thị thư mục và các file có trong thư mục hiện tại với nhiều thông tin hơn như các quyền read, write, excute

+ ls -a: Hiển thị các file có thư mục ẩn

+ ls *.txt: hiển thị các file có đuôi là txt

###	Lệnh cd:
cd / : di chuyển đến thư mục gốc của user hiện tại
cd ..: lùi về thu mục trước đó

###	Lệnh cat: 
cat filename.txt: hiển thị trong file
cat >filename.txt: xóa trong file và thêm dữ liệu mới vào file

###	Lệnh rm: 
rm : xóa thư mục trống

rm -rf: xóa thư mục là các file, thư mục con của nó.

## Using stream, Redirection, and Pipes
•	Stream 

Standard Input (stdin): có file desciptor là 0, trong hầu hết các trường hợp data đến từ keyboard của người dùng.

Standard Output (stdout): có file descriptor là 1, thể hiện trên màn hình dạng text-mode hoặc GUI.

Standard Error (stderr): có file descriptor là 2, thể hiện các thông tin quan trọng như lỗi ra màn hình như stdout, ta có thể tách biệt stderr ra 1 file riêng so với stdout để theo dõi.

•	Redirecting:

VD:   echo $LOGNAME >test.txt

       nano test.txt hiển thị ra khanhnt

Khi muốn chương trình nhận input từ file cho đến dòng tồn tại ký tự EOF (End of File), ta gõ lệnh:

            file_name<<EOF

•	Piping Date between programs
Pipe data được sử dụng trong trường hợp ta muốn lấy output của program1 đem làm input của program2. Cách sử dụng như sau:

$program 1 | program 2 | program 3


## Processing text
### cat, join, paste: 
#### cat (concatenate): 

cat <option> <ten file>

cat <path file>

cat <path file> <path file>:hiển thị nhiều nội dung file

cat >ten file.txt: tạo tập tin rỗng hay xóa tập tin có sẵn

cat -n <path file>: hiển thị số thứ tự của dòng

cat file1.txt > file2.txt

cat file1.txt >> file2.txt: lấy nd file 1 xuống cuối file 2

cat file | less

cat file | more

#### join

join file1 file2: gộp 2 file dưới dạng cột

#### paste:
-d: dấu phân cách thay vì tab

-s: nối dữ liệu theo chuỗi, theo chiều ngang

#### sort

Sắp xếp các thứ tự theo thứ tự tăng dần hay giảm dần, theo bảng mã ASCII.

sort <file>

sort -r <file>: sắp xếp theo thứ tự ngược lại

cat file1 file2 | sort
==================================

BEGIN {Actions}
{Action} # Action for every line in a file
END {Actions}

#### uniq:
Bỏ các dòng liên tiếp trong 1 văn bản trùng lặp.

uniq -c filename: đếm số lượng thư mục trùng lặp


#### head: 

Dùng để xem dòng đầu của tập tin (mặc định là 10 dòng đầu)
 

head <option> filename

-n : chọn số dòng đầu hiển thị (n là số dòng)

#### tail

Dùng để xem dòng đầu tệp tin

tail <option> filename

-n: số dòng muốn xem

-q: không in tiêu đề ra

-f: tiếp tục đọc cho đến khi Ctrl+C

#### wc:
 
Dùng để đếm từ, byte, hoặc dòng

wc <option> file 

-l: hiển thị số dòng

-c: hiển thị số lượng byte

-w: hiển thị số lượng từ

#### cut:

cut kí tự của tệp

cut -c a-b filename: lấy kí tự a đến b của file

#### grep:

grep <option> pattern <file>

-i: tìm kiếm không quan trọng chữ hoa hay chữ thường

-c: hiện số dòng khớp với mẫu tìm kiếm

-r: tìm theo kiểu đệ quy

-n: tìm dòng và tìm thông tin khớp với số dòng

-v: hiển thị dòng không khớp với mẫu cần tìm

grep query1 file | grep query2 file: tìm nhiều từ khóa khác nhau

grep -l wordsearch ./*

grep -e "chuoi" -e "chuoi" filename

#### sed: stream editor

sed <option> command <file>

Lệnh in: sử dụng -n và p // sed -n 'từ cần lọc/p' 
filename

In và thay thế: sed -n 's/từ bị thay thế/từ thay thế/p' filename

#### awk:

awk '/search pattern 1/ {actions}/search pattern 2/{actions}'file

awk '{print}' filename: in ra các dòng thuộc file

awk '/098/{print}' file1.txt: in ra các dòng có chứa xâu mẫu 098 trong file1.txt

## EDITOR FILE

vi: trình soạn thảo văn bản ở trong terminal

Cách mở: sudo vi <đường dẫn đến file cần chỉnh sửa>

Chế độ command: di chuyển con trỏ bằng phím mũi tên. 

Nhấn x xóa kí tự ngay trước con trỏ

v: copy

c: cut

p:paste

insert mode: chèn các kí tự mới vào (ở chế độ insert mode ấn phím i. Trở lại chế độ command ấn phim Esc)

Chế độ thoát: :wq lưu, :q thoát, :!q thoát không lưu

## Text-based window manager and terminal multiplexer
+ byobu

Shift+F1: mở help

F2: tạo tab mới

Crtl+F2: 2 tab theo chiều dọc

Shift+F2: 2 tab theo chiều ngang

F3, F4: di chuyển giữa các tab hoặc Alt+<-, Alt+->

Ctrl+F6: đóng cửa sổ hoặc 1 tab dùng

## Manager process:

ps <option>

PID: process ID

PPID: Process Parent ID: ID của process khởi động 

process này

Command: top, ps

