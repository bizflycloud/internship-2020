# SSH

## Giới thiệu

- SSH sử dụng để làm gì ?
    - Truyền file , kết nối , thực hiện lệnh từ xa
- Tại sao cần sử dụng SSH thay cho Telnet ?
    - Do SSH cung cấp nhiều dịch vụ và bảo mật hơn

## Cách cài đặt

- Cách cài đặt ?

## Ứng dụng

- Lệnh `ssh-keygen` và `ssh-copy-id`sử dụng dụng để ?
    - Sử dụng để tạo 1 cặp key kết nối ssh giữa 2 máy
    - Có 3 loại phổ biến :
        1. ecdsa 
        2. rsa (lâu đời nhất )
        3. ed25519 ( mới nhất )
    - Cách chỉ định tên file key ?
        - `ssh-keygen -f ~/test_host_ed25519_key -t ecdsa -b 521`
            - sau -f là tên file
    - Cách copy public SSH key pub sang sever?
        - Sử dụng `ssh-copy-id *đường dẫn tới key ten_host@ip_host`
        - Bằng cách sử này thì khi ssh tới sever sẽ không cần file login. Sever sẽ cho ssh trực tiếp. Quá trình được kiểm tra thường xuyên qua việc trao đổi key
- Lệnh `ssh-agent` và `ssh-add` sử dụng để ?
    - Agent có quyền kết nối trực tiếp lên các sever
    - Khi sử dụng `ssh-agent` sẽ trực tiếp lấy các key mà bạn cung cấp cho agent để kết nối tới sever( giúp bỏ qua bước nhập pass )
    - Mặc định `ssh-add` không cần các option đằng sau, chế độ mặc định sẽ cung cấp tất cả các key của client lên sever
    - Nếu muốn chỉ up 1 số key lên agent sử dụng lệnh sau: `ssh-add *đường dẫn tới file`
- Phân biệt public key và private key ?
    - Pub-key cung cấp cho bạn quyền truy cập vào sever nhưng để ssh đến được sever cần phải dùng private key
- Khi ngắt kết nối ssh tới sever thì có còn lưu key của client không ?
    - Không
- Trình bày về phương  thức truyền `scp` ?
    - Phương thức truyền file thông qua phương thức ssh
    - Copy từ máy client sang host: `scp *file host:*path`
        - Với path là đường dẫn muốn copy sang
    - Copy từ host sang client: `scp host:*file path`
    - Copy cây thư mục: thêm option `scp -r host:dir`
- Trình bày về khái niệm passphrase ?
    - Passphrase là gì ?
        - Về cơ bản thì passphrase tương tự như password.
        - Nhưng nếu password dùng để xác minh truy cập thì passphrase lại là 1 phương thức mã hóa các file key với ssh
    - tạo passphrase như thế nào ?
        - `ssh-keygen -p -f /dir/to/key`