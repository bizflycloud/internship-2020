# DHCP - VPN - DNS Sever

## DHCP

- Giới thiệu
    - DHCP là gì ? cung cấp được cho thiết bị những gì
        - DHCP là giao thức tự động cung cấp địa chỉ IP
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
        - Thực hiện lệnh `ip a` để xác định cổng ethernet đang kết nối tới máy (enp0s3, enp3s0 ,.. ):
            - 
        - Truy câp đường dẫn `/etc/netplan` sau đó tiến hành chỉnh sửa file `01-network-manager-all.yaml` như sau:

        ```bash
        *tên card mạng :
        	dhcp4: no
        	addresses: [x.x.x.x]
        	gateway: [y.y.y.y]
        	nameserver:
        		address: [z.z.z.z,m.m.m.m]
        ```

        Sau khi thực hiện lưu file. Tiếp tục thực hiện lệnh `sudo netplan apply` để thực hiện cập nhật ip tĩnh.

    - Tài liệu tham khảo

        [https://linuxconfig.org/how-to-configure-static-ip-address-on-ubuntu-18-04-bionic-beaver-linux](https://linuxconfig.org/how-to-configure-static-ip-address-on-ubuntu-18-04-bionic-beaver-linux)
