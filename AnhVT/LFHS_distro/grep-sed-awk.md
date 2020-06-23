# grep - Tìm kiếm

- Lệnh: `grep *x *file` 

tìm kiếm x trong file

- Lệnh: `grep -v *x *file` 

tìm kiếm các dòng không có kí tự x

- Lệnh: `grep -i *x *file` 

tìm kiếm không phân biệt hoa thường 

- Lệnh: `grep -n *x *file` 

hiện số dòng có xuất hiện x

- Lệnh: `grep -c *x *file` 

hiện số lần xuất hiện của x

- Lệnh: `grep -e *x -e *y *file` 

tìm kiếm nhiều từ khác nhau

- Lệnh: `grep -l *x *file1` *file2 

hiển thị các file có chứa x

- Lệnh:  `grep -w *x *file` 

tìm chính xác từ i.e nếu không có -w thì khi tìm no thì nothing cũng sẽ đc hiển thị

-------------------------------------------------------------
# sed - Tìm kiếm và thay thê từ


- Lệnh: `sed 's/*x/*y/' *file`  

thay thế x đầu tiên với y có thể thêm /g vào cuối nếu muốn thay thế tất cả 

- Lệnh: `sed 's/*x/*y/Ng' *file` 

thay thế các từ x từ vị trí thứ n đến cuối

- Lệnh: `sed 's/*x/*y/N" *file` 

thay thế n vị trí

- Lệnh: `sed '/^$d' *file` 

xóa các vị trí dấu cách " "

- Lệnh: `sed 's/*x//g' *file` 

xóa các dòng xuất hiện x

- Lệnh: `sed '*x' | sed '*y' <=> sed '*x,*y'` 
 
--------------------------------------------------------------
# awk 

## Lệnh awk dùng để làm gì ?

Awk là 1 dạng ngôn ngữ script được sử dụng để thao tác dữ liệu và tạo báo cáo.
Awk chủ yếu được sử dụng để quét và xử lý các pattern

## Các chức năng chính:

- quét các dòng

- Tách các dòng input thành các fields khác nhau

- Thao tác các lệnh khác nhau với các dòng tim thấy

## Các option với awk

*Syntax: awk options 'selection _criteria {action }' input-file > output-file 

- Theo mặc định thì lệnh `awk '{print}' vim.md` sẽ in ra các dòng thuộc file 

> tất cả các dòng sẽ được in ra 

- In các dòng với pattern được nhập vào `$ awk '/vim/ {print}' vim.md`

> Các dòng có pattern 'vim' sẽ được in ra output






--------------------------------------------------------------


