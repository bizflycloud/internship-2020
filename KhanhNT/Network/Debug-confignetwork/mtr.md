# mtr command
## 1. Giới thiệu:
- `mtr` là sự kết hợp `ping` và `tracepath`.
- `mtr` hoạt động bằng cách gửi các gói tin ICMP bằng cách tăng giá trị TTL để tìm tuyến đường giữa nguồn và đích.

## 2. Các command 

![](https://i.ibb.co/nCYCwGy/Screenshot-from-2020-09-20-21-20-14.png)

trong đó:

```
Loss%: Hiển thị % số gói bị mất tại mỗi bước nhảy
Last: độ trễ của gói tin cuối cùng được gửi
AVG: Độ trễ trung bình của tất cả các gói
Best: Hiển thị thời gian quay vòng tốt nhất cho gói tin đến máy chủ lưu trữ này (RTT ngắn nhất)
Wrst: Hiển thị thời gian quay vòng tệ nhất cho mỗi gói tin đến máy chủ lưu trữ (RTT dài nhất)


```

- `mtr -c [n] [domain_name]`
  + với n là số gói tin muốn gửi
- `mtr -f [n] [domain_name]`
  + với f là thời gian sống của gói tin

