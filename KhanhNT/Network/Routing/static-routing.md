# Định tuyến tĩnh 
## 1. Khái niệm:
- Định tuyến là quá trình tìm đường đi cho các gói tin từ nguồn tới đích thông qua hệ thống mạng.

- Router dựa vào địa chỉ IP đích trong các gói tin và sử dụng bảng định tuyến để xác định đường đi cho chúng.

## 2. Định tuyến tĩnh:
- Định tuyến tĩnh là loại định tuyến mà trong đó router sử dụng các tuyến đường đi tĩnh để vận chuyển dữ liệu đi.
 
- Các tuyến đường đi tĩnh này được cấu hình thủ công vào các router.

## 3. Cấu hình:
**R(config)# ip route** <Destination-net> <subnet-mask> <Nexthop|Outport>

## 4. Default route:
- Nằm ở cuối bảng định tuyến, được sử dụng để gửi các gói tin đi trong trường hợp mạng đích không thấy bảng định tuyến.

**R(config)# ip route** 0.0.0.0 0.0.0.0 <Mang ngoai>

LAB

![](https://2.bp.blogspot.com/-DLwUDqMqx40/TrtDyotKKiI/AAAAAAAAAic/labGY4_8adE/s1600/4.11.jpg)


