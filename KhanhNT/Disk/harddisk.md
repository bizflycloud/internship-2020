# Hard Disk Drives (HDD)
## Cấu trúc dữ liệu của đĩa

![](https://github.com/hocchudong/ghichep-disk/raw/master/images/disk2.jpg)

### 1. Track-Rãnh từ
- Là các vòng tròn đồng tâm trên mặt đĩa dùng để xác định các vùng lưu trữ dữ liệu riêng biệt trên mặt đĩa.
- Mặc định các `track` không cố định, chúng sẽ thay đổi vị trí khi được định dạng ở cấp thấp (Low format) nhằm tái cấu trúc cho phù hợp khi đĩa bị hư hỏng (bad block)
- Tập hợp các `track` cùng bán kính của mặt đĩa khác nhau để tạo thành các `trụ (cylinder)`, có `1024` cylinder (0-1023). Mỗi ổ cứng sẽ có nhiều `cylinder` vì có nhiều rãnh từ khác nhau.

### 2. Sector-Cung từ
- Mỗi `track` được chia thành các đường hướng tâm tạo thành các **sector**.
- **Sector** là đơn vị chứa dữ liệu nhỏ nhất, dung lượng 512 byte.
- Số **sector** trên các track từ phần rìa đĩa đến tâm đĩa là khác nhau, các ổ cứng đều chia ra 10 vùng, mỗi vùng có tỉ số `sector/track` bằng nhau.

### 3. Cluster-Liên cung
- Là đơn vị lưu trữ 1 hoặc nhiều **sector**.
- Khi dữ liệu được lưu vào ổ cứng, các dữ liệu được ghi vào hàng chục, hàng trăm cluster liền kề hoặc không liền kề nhau. Nếu không có cluster liền kề nhau, hệ điều hành sẽ tìm kiếm cluster còn trống ở gần và ghi tiếp dữ liệu lên đĩa.

__Docs__
- https://github.com/hocchudong/ghichep-disk/blob/master/C%E1%BA%A5u%20t%E1%BA%A1o%20%E1%BB%95%20%C4%91%C4%A9a%20v%C3%A0%20c%E1%BA%A5u%20tr%C3%BAc%20d%E1%BB%AF%20li%E1%BB%87u%20trong%20%E1%BB%95%20%C4%91%C4%A9a.md



