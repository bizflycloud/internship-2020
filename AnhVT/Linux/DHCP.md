# DHCP - VPN - DNS Sever

## DHCP

- Giới thiệu
    - DHCP là gì ? cung cấp được cho thiết bị những gì
        - DHCP là giao thức tự động cung cấp địa chỉ tên miền
        - Cung cấp các mặt khác như DNS Sever, Default Gateway,..
- Cách thức hoạt động và cách cài đặt ?
    - Trình bày đặc điểm và cách thức hoạt động của DHCP diễn ra như thế nào khi  cung cấp 1 địa chỉ ip cho thiết bị?
        - Hoạt động đơn giản, khi PC hay 1 thiết bị yêu cầu thì giao thức này sẽ cung cấp 1 địa chỉ ip khả dụng.
        - Đối với một mạng nhỏ thì Router có thể đóng vai trò như 1 máy chủ DHCP nhưng với các mạng lớn thì cần 1 thiết bị riêng biệt
        - Các bước
            1. DHCP Request : Thiết bị gửi yêu cầu nhận tới máy chủ
            2. DHCP Offer : Nhận được địa chỉ IP offer từ máy chủ DHCP
            3. DHCP Request : Gửi lại yêu cầu chấp nhận lấy IP hay không từ thiết bị
            4. DHCP Ack : Mảy chủ DHCP sẽ gửi lại bản tin DHCP Ackknowledge
    - Cách cài đặt nhận DHCP ?
        - truy cập `/etc/network/interfaces`
        - thực hiện chỉnh sửa file theo

            ```bash
            auto eth0
            iface eth0 inet dhcp
            ```

            - 
- Ứng dụng
    - Các ứng dụng của DHCP trong thời địa hiện nay ?
        - Ứng dụng hầu hết trong các mạng LAN hiện nay do sự tiện dùng, tiết kiệm thời gian, cũng như khả năng tự động hóa.

## VPN

- Giới thiệu
    - VPN là gì và phương thức hoạt động của VPN ?
        - VPN  ( Virtual Personal Network ) là hình thức kết nối từ một máy tính sang 1 mạng ảo để kết nối sang internet. Thiết bị sử dụng VPN hoạt động dựa trên quy tắc coi như nó thuộc cùng mạng LAN với VPN
        - Khi kết nối mạng tới 1 trang web,etc thì thiết bị gửi yêu cầu tới VPN và VPN sẽ chuyển tiếp yêu cầu tới đích
        - Nâng cao bảo mật khi kết nối tới các Wifi-hotspot
        - Truy cập sang các trang web bị chặn do đã đổi ip sang 1 vùng địa lí khác
- Cách cài đặt
    - Cài đặt các dịch vụ VPN từ các nhà cung cấp khác nhau
- Ứng dụng
    - Các ứng dụng hiện tại của VPN dựa tren nhu cầu của người sử dụng ?
        - Truy cập vào dữ liệu các trang web bị chăn
        - Truy cập máy khác từ xa
        - Bảo vệ dữ liệu cá nhân từ các ISP

    ## Set IP tĩnh, gateway, DNS Sever

    - Khi muốn tiến hành set địa chỉ ip tĩnh cho máy, ta cần thực hiện những thao tác nào ?
        - truy cập  đường dẫn `/etc/network/interfaces` thực hiện chỉnh sửa file theo nội dung:

            ```bash
            iface eth0 inet static
            ip add x.x.x.x
            subnet y.y.y.y
            gateway z.z.z.z
            ```

    - Thực hiện thay đổi DNS trên CLI ?
        - Tiến hành truy cập đường dẫn `/etc` và chỉnh sửa file `resolve.conf` với nội dung như sau

            ```bash
            namesever x.x.x.x
            namesever y.y.y.y
            ```

            - Với x và y là địa chỉ phân giải tên miền
    - Thực hiện thay đổi Default gateway thông qua CLI ?
        - Sử dụng lệnh `route add default gateway *ip` với ip là địa chỉ bạn muốn đặt làm default gateway cho thiết bị.

    - Tài liệu tham khảo

        [https://thuonghieuweb.com/oldversion/huong-dan-cau-hinh-card-mang-cho-ubuntu.html](https://thuonghieuweb.com/oldversion/huong-dan-cau-hinh-card-mang-cho-ubuntu.html)