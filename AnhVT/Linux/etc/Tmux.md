# Tmux ( Terminal Multiplexer)

- Tmux là gì ?
    - Viết tắt cho Terminal Multiplexer ( bộ ghép kênh)
    - Cho phép
        - chuyển qua lại giữa các chương tình ( trong terminal )
        - tách chương trình ra 1 terminal riêng ( không làm tắt chương trình )
- Tính năng ?
    - Tạo session: `tmux`
    - Tạo 1 session khacs: `tmux new -s name`
    - Attach session :
        - Với cửa số đầu `tmux` : sử dụng `tmux a`
        - Với các cửa sổ tiếp theo: sử dụng `tmux a -t name`
    - Hiển thị danh sách cửa số terminal: `tmux ls`
    - Tắt 1 terminal: `tmux kill-session name`
- Prefix đối với Tmux ?
    - Sử dụng `Ctrl + b < command >`, sau đây là danh sách các command hay được sử dungj:
        - `c` : tạo 1 cửa sổ mới
        - `,` : Rename cửa sổ terminal mới
        - `p` hoặc `n` : sử dụng để chuyển đổi giữa các cửa sổ terminal khác nhau ( next / previous)
        - `w` : liệt kê các danh sách window
        - `%` : Tách cửa số terminal hiện tại theo chiều dọc
        - `: split-windows`  : Tách cửa số terminal hiện tại theo chiều ngang
            - hoặc có thể sử dụng: `"`
        - Tắt pane: `x`
        - Tắt cửa số Terminal: `&`
    - Link tài liệu tham khảo

        > [https://gist.github.com/henrik/1967800](https://gist.github.com/henrik/1967800)

        > [https://viblo.asia/p/gioi-thieu-co-ban-ve-tmux-zoZVRgLEMmg5](https://viblo.asia/p/gioi-thieu-co-ban-ve-tmux-zoZVRgLEMmg5)