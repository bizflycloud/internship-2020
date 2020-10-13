# Load Balancer

## 1. Giới thiệu:

![](https://viblo.asia/uploads/9ef3bb43-3d54-49fa-90be-d464751e5b47.png)

- Trên là ảnh của 1 hạ tầng web không có Load Balancing.
  + Khi máy chủ web duy nhất này down, người dùng sẽ không thể truy cập vào trang web.
  + Nếu nhiều người dùng cố gắng truy cập vào máy chủ cùng lúc thì nó không thể xử lí tải, tải chậm hoặc không thể kết nối.

![](https://viblo.asia/uploads/65fad7fe-c1b6-4798-8bdd-94232331f8f8.png)

- Khắc phục bằng 1 `load balancer` và bổ sung 1 máy chủ web.
  + Các máy chủ sẽ cung cấp nội dung giống hệt nhau để có thể đáp ứng dù bất kể máy chủ nào.
  + Vì truy cập đến `Load Balencer` nên phản hồi sẽ chậm hơn.

## 2. Các loại giao thức `Load balencer` có thể xử lí:

- HTTP
- HTTPS
- TCP
- UDP

## 3. Các loại cân bằng tải
### 3.1 Không có cân bằng tải

![](https://raw.githubusercontent.com/lacoski/haproxy-note/master/images/img-tongquan-haproxy/pic1.png)

### 3.2 Layer 4 Load Balancing
- Chuyển traffic tới các server sử dụng `transport layer`.
- `Load balancing` theo cách này sẽ forward user traffic dựa trên `IP` và `Port` đến backend.

![](https://raw.githubusercontent.com/lacoski/haproxy-note/master/images/img-tongquan-haproxy/pic2.png)

- Tất cả các nội dung trong backend phải giống nhau và cả 2 server đều kết nối tới chung một database.

### 3.3 Layer 7 Load Balancing
- Sử dụng `Load Balancing` ở `layer 7` điều howngs `request` tới các backend khác nhau dựa trên nội dung cuả `request`.

![](https://raw.githubusercontent.com/lacoski/haproxy-note/master/images/img-tongquan-haproxy/pic3.png)

- Chế độ cho phép triển khai `nhiều web server dưới cùng 1 domain và port`.
- Cả 2 đều dùng chung 1 máy chủ database.
- Nếu `request` `/` thì chuyển tới `web-1-backend`.
- Nếu `request` `/about` thì chuyển tới `web-2-backend`.

## 3. Các thuật toán cân bằng tải
- Thuật toán cân bằng tải sử dụng để `xác định server trong 1 backend sẽ được chọn khi load balancing`
- `roundrobin`: các request sẽ chuyển đến server theo lượt.
- `leastconn`: chọn máy chủ đang có ít kết nối đến nhất (nên dùng cho những kết nối có session kéo dài`.
- `source`: các request chuyển đến server dựa trên `hash IP nguồn (ip người dùng)`

## 4. Các giải pháp `Load Balancing`
- HAProxy
- Linux Virtual Server (Layer 4 Load Balancer)
- Nginx (thường được kết hợp với HAProxy)

**Tài liệu tham khảo**
- https://github.com/hocchudong/ghichep-nginx/blob/master/docs/nginx-loadbalncing.md
- https://github.com/lacoski/haproxy-note
- https://www.haproxy.com/blog/load-balancing-affinity-persistence-sticky-sessions-what-you-need-to-know/
- https://viblo.asia/p/huong-dan-su-dung-haproxy-cho-load-balancing-ung-dung-4P856jp95Y3
- https://github.com/greatbn/Load-Balancing-using-HAProxy
- https://github.com/meditechopen/meditech-thuctap/blob/master/ThaoNV/HAProxy%20%2B%20KeepAlive/docs/intro.md




 

