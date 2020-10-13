# Standard Input & Standard Output
## 1. Chuyển hướng trong Linux
- Luồng dữ liệu input/output:
  + `Standard input (stdin)` là `Keyboard`
  + `Standard output (stdout)` là `monitor`
  + `Standarad error (stderr)` là `monitor`
- Thay vì nhập xuất thông tin từ các thiết bị keyboard, monitor theo chuẩn thì ta sẽ chuyển hướng nhập xuất đó bằng tệp tin hoặc tiến trình khác.
- 3 luồng dữ liệu chuyển hướng:
   + `input`
   + `output`
   + `error redirections`

## 2. Output Redirection
- Sử dụng kí tự `>` hoặc `1>` chuyển hướng cho output.
- Thay vì ghi ra màn hình, output có thể ghi vào tập tin hoặc truyền cho process khác xử lí tiếp.
- Dấu `>` hoặc `1>` khi ghi tệp sẽ tạo ra tệp mới, nếu tệp đã tồn tại thì ghi đè lên tập tin đó.
- Nếu không muốn ghi đè lên tệp cũ, ta sử dụng kí tự `>>` hoặc `1>>`

```
corgi@ubuntu:~$ echo "hello" > test.txt
corgi@ubuntu:~$ cat test.txt 
hello

```

## 3. Input Redirection
- Dữ liệu truyền vào để process xử lí, có thể dữ liệu nhập từ bàn phím, tập tin hay output của process khác.
- Sử dụng `<` để chuyển hướng input

## 4. Error Redirection
- Thay vì xuất thông tin lỗi ra màn hình, chuyển hướng lỗi giúp xuất thông tin lỗi ra tệp tin.
- Sử dụng lệnh `2>` hoặc `2>>`.

## 5. File Descriptos
- Là 1 biến số nguyên dương tham chiếu đến 1 nguồn input/output cụ thể:
  + 0 là `stdin`
  + 1 là `stdout`
  + 2 là `stderr`
- Dấu `>&` để redirect input/output bằng File descriptors


