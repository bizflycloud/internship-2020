# Quản lí Users và Groups

- Tạo user như thế nào ?

    Sử dụng lệnh : `sudo adduser *user` với user là tên muốn tạo 

    Đặt password: `sudo passwd *user` sau đó sẽ nhận đuộc 1 output nhập passworrd của user mới

    → khi tạo 1 user thì đồng thời cũng tạo các tuy cập vào `/etc/passwd` `/etc/shadow` `/etc/gshadow` và `/etc/group`

- Cách để xóa 1 user ?

    B1: Sử dụng lệnh `sudo -i` hoặc `sudo su -`

    B2: Tiếp tục nhập lệnh `userdel *user`

- Thêm 1 user vào 1 group khác như thế nào ?
    - Sử dụng lệnh `usermod -a -G *group *user` ( ↔ thêm user vào group )
        - Lưu ý lệnh này chỉ thêm user vào group chứ k thay đổi group chính ( primary group) của user
    - Khi muốn thay đổi Group chính ( Primary Group) của user ta sử dụng lệnh sau
        - `sudo usermod -g *newgroup *user`
            - Ở đây có thể thấy ta sử dụng option `-g` thay vì `-G` ( g sẽ thay đổi Group chính còn G chỉ thêm vào group mới )
- Khi muốn thay đổi đường dẫn /home của 1 user?

    Sử dụng lệnh `sudo usermod --home *new_home_dir *user` 

- Tác dụng của  `/etc/passwd` - `/etc/group` - `/etc/sudoer` - `/etc/shadow`?
    1. `/etc/passwd`
        - Nơi lưu các thông tin login của các user trên hệ thống, thường lưu thành 7 trường riêng biệt, chia cách bởi dấu `:`

            ![Quan_li_user_group_image/Selection_003.png](Quan_li_user_group_image/Selection_003.png)

            1. username : tên của người dùng
            2. x : thể hiện user có sử dụng password được bảo vệ bởi `/etc/shadow`
            3. UID: id user
            4. GID: id group
            5. Comment: mô tả về user 
            6. Home directory: đường dẫn `/home`
            7. Default Shell : Loại shell sử dụng trên user

        2. `/etc/group`

        - Nơi lưu thông tin về các group đang sử dụng trên hệ thống

            ![Quan_li_user_group_image/Selection_004.png](Quan_li_user_group_image/Selection_004.png)

            1. Group name : tên Group 
            2. Group password: nếu có xuất hiện `x` thì group k sử dụng password
            3. GID: group id
            4. Group member: Các user thuộc vào group

        3. `/etc/sudoer`

        - Nơi chỉnh sửa lệnh `sudo` - một lệnh rất hay sử dụng khi dùng linux
        - Để chỉnh sửa, ta cần vào chế độ root trước tiên, sau đố sử dụng lệnh `visudo` để tiến hành chỉnh sửa, kết quả mà hình sẽ in ra một số output, sau đây là ý nghĩa của các dòng quan trọng nhất :

            > Defaults secure_path="/usr/sbin:/usr/bin:/sbin:/usr/local/bin"

            - ở đây thể hiện đường dẫn sẽ sử dụng cho `sudo`

            > root ALL=(ALL) ALL

            - Ở đây ta thấy sự xuất hiện của 3 từ ALL với 3 ý nghĩa khác nhau
                1. từ ALL đầu tiên thể hiện quy tắc này áp dụng với tất cả các user
                2. từ ALL thứ hai thể hiện mọi user ở cột 1 sẽ có quyền nhập lệnh với tư cách user khác
                3. từ All cuối cùng thể hiện rằng quy tắc này áp dụng với mọi lệnh

            > %admin ALL=(ALL) ALL

            - Ở đây thể hiện mọi user thuộc group admin đều có thể thực hiện quy tắc này

            4. `/etc/shadow`

            - Nơi lưu các thông tin về mật khẩu mã hóa của các user

- Phân biệt `sudo` và `su`
    1. Khi sử dụng `su` người dùng sẽ được yêu cầu nhập vào password của `root` ( ở lệnh này các biến môi trường được giữ nguyên )
        - Có 1 lệnh khác đó chính là `su -` ( ở lệnh này thì các biến môi trường cũ không còn được sử dụng )

    ⇒ việc để người dùng biết được password của `root` là vô cùng nguy hiểm với các nguy cơ tấn công khác nhau.

    ⇒ Nguy cơ tấn công ạng 

    ⇒ Giải quyết bằng cách sử dụng `sudo` 
    2. Khi sử dụng `sudo` người dùng sẽ được yêu cầu nhập vào password của user

    → cho phép user thực thi 1 lệnh với đặc quyền cao hơn và sẽ kết thúc sau khi thực thi.

    - So sánh `su` và `sudo`
        - Hành vi mặc định
            - Ở `sudo` thì cho phép sử dụng lệnh với đặc quyền root và kết thúc ngay sau đso
            - Còn với `su` sẽ tạo 1 shell mới, user có thể nhập vào bao nhiêu lệnh tùy thích
        - Ghi Log
            - Với `sudo` tên người sử dụng lệnh có thể trực tiếp theo dõi
            - Còn với `su` thì k thể theo dõi
- Tài liệu tham khảo

    [https://www.howtogeek.com/50787/add-a-user-to-a-group-or-second-group-on-linux/](https://www.howtogeek.com/50787/add-a-user-to-a-group-or-second-group-on-linux/)

    [https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/#how-to-create-a-new-user-in-linux](https://linuxize.com/post/how-to-create-users-in-linux-using-the-useradd-command/#how-to-create-a-new-user-in-linux)

    [https://www.tecmint.com/manage-users-and-groups-in-linux/](https://www.tecmint.com/manage-users-and-groups-in-linux/)

    [https://dangkyhosting.com/sudo-va-su-khac-nhau-nhu-the-nao.html](https://dangkyhosting.com/sudo-va-su-khac-nhau-nhu-the-nao.html)

    [https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/](https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/)
