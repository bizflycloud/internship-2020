# Kiểm tra dung lượng disk

> Chủ yếu sử dụng thông qua 2 lệnh như `df` và `du`

## Lệnh `df`

- Sử dụng để làm gì ?

    Để kiểm tra dung lượng bộ nhớ khả dụng tại hệ thống Linux đang sử dụng hiện tại

- Cách sử dụng như thế nào ?

    Tại cửa sổ terminal nhâp `df -h` và sẽ nhận được một bảng output với các cột như tên file , kích cỡ, sử dụng bao nhiêu , còn bao nhiêu , phần trăm sử dụng, được mount ở đâu )

## Lệnh `du`

- Sử dụng để làm gì?

    Để xem mức sử dụng bộ nhớ của các file trong thư mực hiện tại

- Cách sử dụng như thế nào ?

    Tại cửa sổ terminal, nhập lệnh `du -h` tại đây sẽ hiện ra 2 cột với cột 1 là kích thước sử dụng , cột 2 là tên đường dẫn file.)
    Ngoài ra có thể thêm option `-s` để hiện kích thước tổng cho mỗi đường dẫn

- Tài liệu tham khảo

    [https://www.geeksforgeeks.org/du-command-linux-examples/](https://www.geeksforgeeks.org/du-command-linux-examples/)