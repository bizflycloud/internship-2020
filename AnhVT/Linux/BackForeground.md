# Background Foreground

## Background & Foreground

- Giới thiệu
    - Background
        - Là 1 dạng cho phép ứng dụng chạy ở dạng nền
        - đặc biệt khi đang chạy các tiến trình có thời gian thực thi lâu
    - Foreground
        - Các ứng dụng đang thực thi trên cửa sổ terminal
- Ứng dụng
    - Cách xem toàn bộ các tiến trình background đang chạy ?
        - Sử dụng qua syntax`jobs`
    - Cách chuyển 1 tiến trình sang foreground để tiếp tục công việc ?
        - sử dụng `fg <số tiến trình trong background>`
    - Cách chuyển 1 tiến trình sang background ngay khi khởi chạy ?
        - Có thể sử dụng syntax sau để cho tiến trình vào background ngay khi khởi chạy:

            `<command> &`
           
           
           ->Ý nghĩa: Chuyển 1 lệnh vào trong Background ( giả sử câu lệnh đang chạy có thời gian thực thi lâu ) khi mà user muốn thực hiện tiếp 1 lệnh khác.

    - Nếu muốn chuyển từ 1 tiến trình hiện tại sang 1 tiến trình khác thì sử dụng syntax nào ?
        - Có thể sử dụng phím tắt `ctrl + z`
