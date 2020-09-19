# NGINX LOAD BALANCER

## *HTTP LOAD BALANCING*

![NGINX%20LOAD%20BALANCER%2079f187b3bd9c4d79aae7dff7550d8d70/Untitled.png](NGINX%20LOAD%20BALANCER/Untitled.png)

### Cấu hình

- Để cấu hình Nginx làm Load Balancer HTTP, đầu tiên cần phải liệt kê các server được sử dụng ở trong phần `upstream` ( thuộc mục http ) .

```bash
http {
    upstream backend {
        server backup1.com ;
        server backup2.com;
        server backup3.com backup;
    }
}
```

- Ở ví dụ trên, 2 server `[backup1.com](http://backup1.com)` và `[backup2.com](http://backup2.com)` sẽ được sử dụng chính đẻ cân bằng tải trong khi đó server `[backup3.com](http://backup3.com)` được sử dụng khi cả 2 server chính bị quá tải hay gặp lỗi trong quá trình vận hành
- Sau khi đã cấu hình liệt kê các server cần được sử dụng để cân bằng tải, bước tiếp theo cần sử dụng `proxy_pass` để chuyển tiếp yêu cầu nhận được :

```bash
server {
    location / {
        proxy_pass http://backend;
    }
}
```

### Các phương thức cân bằng tải

Mặc định Nginx cung cấp 3 phương thức chính để cân bằng tải :

1. Round Robin :

    ![NGINX%20LOAD%20BALANCER%2079f187b3bd9c4d79aae7dff7550d8d70/Untitled%201.png](NGINX%20LOAD%20BALANCER/Untitled%201.png)

    - Các yêu cầu được phân phối đồng đều trên các server theo thuật toán tuần tự. Phương thức này được chạy mặc định trong cấu hình

    ```bash
    upstream backend {
    	# Thuat toan Round Robin duoc chay mac dinh khong can cau hinh
       server backup1.com;
       server backup2.com;
    ```

2. Ít kết nối nhất ( Least Connection )

    ![NGINX%20LOAD%20BALANCER%2079f187b3bd9c4d79aae7dff7550d8d70/Untitled%202.png](NGINX%20LOAD%20BALANCER/Untitled%202.png)

    - Các yêu cầu được phân phối tới các server đang xử lý ít lưu lượng nhất

    ```bash
    upstream backend {
        least_conn; #Syntax
        server backup1.com;
        server backup2.com;
    }
    ```

3. Ip Hash

    ![NGINX%20LOAD%20BALANCER%2079f187b3bd9c4d79aae7dff7550d8d70/Untitled%203.png](NGINX%20LOAD%20BALANCER/Untitled%203.png)

    - Mỗi địa chỉ IP sẽ được chuyển tới 1 server cố định mà không thay đổi

    ```bash
    upstream backend {
        least_conn; #Syntax
        server backend1.example.com;
        server backend2.example.com;
    }
    ```

### Server Weights

- Mặc định Nginx sử dụng thuật toán Round Robin và chuyển các yêu cầu nhận được tới các server ( có xét tới server weight được đặt ):

```bash
upstream backend {
    server backup1.com weight=2;
    server backup2.com;
    server backup3.com backup;
}
```

- Ví dụ cứ nhận được 3 yêu cầu thì 2 yêu cầu được chuyển tới server 1 ( giá tị mặc định của server weight là 1 )

## TCP & UDP LOAD BALANCING

Nginx cũng có thể sử dụng để làm TCP & UDP Load Balance

Lưu ý : Khi cài đặt cần thêm option `--with-stream`

### Cấu hình reverse proxy cho Nginx :

Đầu tiên ta phải tiến hành config Nginx như 1 Reverse Proxy để có thế chuyển tiếp các yêu cầu UDP hay TCP từ clients đến các server khác nhau

Để thực hiện, ta cần mở file cấu hình của Nginx ( thường được chứa tại /etc/nginx ), tiến hành thêm các syntax như sau :

- Bước 1: Thêm `stream block` 

Lưu ý mục stream này được đặt ngoài `http{}` 

```bash
stream {
    # ...
}
```

- Bước 2: Thêm các `server block` trong `stream block`

```bash
stream {

    server {
        listen 12345; # Tcp la giao thuc mac dinh nen khong co syntax
        # ...
    }

    server {
        listen 53 udp; # Khi su dung UDP
        # ...
    }
    # ...
}
```

- Bước 3: Thêm `proxy pass` để chuyển tiếp yêu cầu tới các khối server khác nhau

```bash
stream {

    server {
        listen     12345;
        #Bản tin TCP sẽ được chuyển tới khối server stream_backend
        proxy_pass stream_backend;
    }

    server {
        listen     12346;
        #Bản tin TCP sẽ được chuyển tới 1 server nhất định thông qua port
        proxy_pass backend.example.com:12346;
    }

    server {
        listen     53 udp;
        #Bản tin UDP sẽ được chuyển tới khối server dns_server
        proxy_pass dns_servers;
    }
    # ...
}
```

### Cấu hình TCP & UDP Load balance

![NGINX%20LOAD%20BALANCER%2079f187b3bd9c4d79aae7dff7550d8d70/Untitled%204.png](NGINX%20LOAD%20BALANCER/Untitled%204.png)

Để cấu hình Nginx chuyển tiếp các yêu cầu, bản tin UDP & TCP, ta lần lượt thực hiện các bước sau

- Bước 1:

Khởi tạo 1 khối server để nhận các yêu cầu hay bản tin UDP & TCP được chuyển tiếp tới

Lưu ý: khi khởi tạo các server thì tên cần phải giống trong phần reverse proxy

```bash
stream {

    upstream stream_backend { #Khối server 1
        # ...
    }

    upstream dns_servers { #Khối server 2
        # ...
    }

    # ...
}
```

- Bước 2:

Thêm các server cùng địa chỉ IP, Port nhận của server, ở đây ta không cần định nghĩa giao thức TCP hay UDP do phần này đã được định nghĩa trong phần Reverse Proxy ( Giao thức đó sẽ được áp dụng cho toàn bộ các server:

```bash
stream {

    upstream stream_backend {
        server backend1.example.com:12345;
        server backend2.example.com:12345;
        server backend3.example.com:12346;
        # ...
    }

    upstream dns_servers {
        server 192.168.136.130:53;
        server 192.168.136.131:53;
        # ...
    }

    # ...
}
```

- Bước 3:

Nginx cung cấp cho nguời dùng các giao thức vòng lặp như: Round Robin, Least Connection ( ít kết nối nhất ) , Hash,...

```bash
upstream stream_backend {
    hash $remote_addr; #Sử dụng giao thức hash với user-key là địa chỉ IP client
    server backend1.example.com:12345;
    server backend2.example.com:12345;
    server backend3.example.com:12346;
}
```

Như vậy chúng ta đã hoàn thành xong phần cấu hình Nginx sử dụng để làm Load Balance cho HTTPS và TCP  & UDP

Tài liệu tham khảo

[NGINX Docs | Welcome to NGINX documentation](https://docs.nginx.com)

[Deep Dive to NGINX 💻](https://medium.com/@tirthankarkundu/deep-dive-to-nginx-264b8d440828)

[https://www.youtube.com/watch?v=lWjZSgXu5VU](https://www.youtube.com/watch?v=lWjZSgXu5VU)
