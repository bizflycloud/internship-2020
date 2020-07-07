# Kill Proccess

- Khi muốn " Kill " một tiến trình. Ta có 2 lựa chọn, có thể sử dụng lệnh `jobs` hoặc `ps` để lấy id hoặc số thứ tự của tiến tình
    - Với lệnh `jobs` : Giả sử ta đã có sẵn một số các chương trình nào đó chạy ở background ( có thể chạy thông qua việc gán thêm `&` ở cuối tên process)
        - Ta có thể ngừng tiến trình thông qua lệnh sau: `kill %1` ( Syntax: `kill %x` với x là id của tiến trình muốn ngừng )
    - Với lệnh `ps` : Giả sử đã có sẵn một số chương trình đang chạy
        - Sau khi có được id của tiến trình muốn ngừng thông qua lệnh `ps` , ta tiến hành ngừng tiến trình thông qua lệnh : `kill -9 process id`
        - Ở đây có thể thấy ta sử dụng option 9 với ý nghĩa là SIGKILL, sau đây là một số các option hay được sử dụng mà ta có thể tham khảo :

            [Các option ](Kill%20Proccess/C%20c%20option%202866dd67d06341008a165157a39f500b.csv)
