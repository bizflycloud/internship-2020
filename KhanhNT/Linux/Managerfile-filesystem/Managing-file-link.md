# Các lệnh quản lí file, thư mục và các option


## 1. `ls`
- `ls -a`: Hiển thị tất cả 2 thư mục mục tiêu (thư muc hiện tại) và thư mục cha.
- `ls -A`: lệnh hữu ích khi bạn sử dụng output của lệnh làm input cho 1 scipt khác.
- `ls -R`: Liệt kê tất cả các file bao gồm cả các thư mục phụ bên trong.
- `ls -al`: Liệt kê tất cả các file và thư mục với thông tin chi tiết như phân quyền, kích thước, chủ sở hữu,...
- `ls -t`: hiện các thư mục/file sắp xếp theo thời gian.
- `ls -S`: hiện các thu mục/file sắp xếp theo size
- `ls *.md`: Tìm các thư mục/file có đuôi `.md`

## 2. `cp`
- `cp` để sao chép file.
- `cp a.txt a.txt`: copy file a.txt và sao chép thành 1 file b.txt giống y hệt.
- `cp -v`
  + `cp -v a.txt b.txt c.txt d.txt e.txt lab/`
  + copy nhiều file vào thư mục lab/
- `cp home/a.txt home/internship-2020/b.txt`
  + Sao chép 1 file nằm ở thực mục này sang 1 thư mục khác. 
- `cp -av internship/ /home/corgi/`
   + Dùng option `-r`hoặc `-a` để copy thư mục trên hệ thống.
   + `-a`: bao gồm `-r` nhưng duy trì các thuộc tính file đang có
- `cp -n`: không được ghi đè nếu đã có filename cùng tên với file name định copy.
- `cp -f`: ép buộc copyfile ghi đè lên file đang tồn tại ở thư mục nếu nó cùng tên nguồn file copy.

## 3. `mv`
- `mv [path with old_name] [path with new name]`: đổi tên thư mục.
   + mv /root/test1.txt /root/test.txt
- `mv [old_path] [new_path]: di chuyển tập tin đến vị trí khác. (có thể đổi tên cùng lúc)
   + `mv root/test1.txt /etc/test.txt`

## 4. `rm`
- `rm [path]`: xóa tập tin
- `rm -f [path]`: xóa tập tin mà không cần hỏi
- `rm -rf [path]`: xóa thư mục
- `rmdir [path]`: xóa thư mục rỗng 

## 5. `touch`
- Lệnh dùng để tạo tập tin rỗng.
- `touch [file_name]`: tạo thư mục
- `touch -t [time] [file_name]`:Đặt ngày và thời gian của file.  

## 6. `ln`
- __Symbolic Link__: 
  + Chỉ 1 file tham chiếu đến file khác hoặc thư mục khác dưới dạng đường dẫn tương đối hoặc tuyệt đối.
  + Tạo nhiều Symbolic Link khác nhau vẫn trỏ về 1 file gốc.
- `ln` dùng để tạo __Symbolic Link` cho 1 file 
  + `ln -s [target file] [Symbolic filename]`
- `ln -s [Specific file/directory] [symlink name]
- Xóa __Symbolic Link__:
  + unlink [Symlink to remove]
  + rm [Symlink name]   
   



