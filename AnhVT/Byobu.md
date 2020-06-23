# Byobu

- Cài đặt như thế nào
    - Trên Ubuntu: sử dụng lệnh `sudo apt-get install byobu -y`

- Sử dụng để làm gì và như thế nào
    - Sử dụng khi ssh đến các sever khác nhau, cho phép đồng thời mở một hay nhiều terminal khác nhau, có thể tách tiến trình mà không làm tiến trinhf bị gián đoạn, gần tương tự như *Tmux(terminal multiplexer).*
    - Cách sử dụng cơ bản ?
        - Sử dụng tổ hợp `Shift F1` để vào cửa sổ help để xem toàn bộ các lệnh cơ bản
        - Các nút bind và tổ hợp hay sử dụng:
            - Đặt tên cửa số Terminal ( do khi sử dụng sẽ phải sử dụng khá nhiều cửa sổ terminal): sử dụng `F8`
            - Để tạo một cửa sổ terminal mới ta sử dụng phím `F2`
            - Để chia đôi cửa sổ terminal theo chiều ngang, sử dụng: `Shift + F2`
            - Để chia ngang cửa số terinal theo chiều dọc, sử dụng: `Ctrl+  F2`
            - Di chuyển giữa các cửa sổ terminal: `alt + <-` hoặc `alt + ->`
            - Di chuyển lên xuống trong cửa sổ terminal: đầu tiên ta sử dụng : `F7` sau đố sử dụng `up arrow key` hoăc `down arrow key` để lướt lên xuống ( alt : có thể sử dụng thêm cả `page up` và `page down`
            - Để tắt( Detach ) cửa số byobu và logout: sử dụng trực tiếp `F6`

            Các tổ hợp phím tắt trên hoàn toàn có thể tìm thấy trong phần Help của Byobu. Trên đây chỉ là các tổ hợp thường dùng nhất. Nếu có nhu cầu sử dụng nhiều bạn nên tham khảo trong mục Help ( Cách truy cập đã nói ở trên )