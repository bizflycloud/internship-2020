# HAProxy
## 1. Tổng quan
- **HAProxy** `High Availability Proxy` là công cụ mã nguồn mở cho giải pháp cân bằng tải TCP/HTTP.
- **HAProxy** có thể chạy trên môi trường Linux.
- Công dụng:
  + Cải thiện hiệu năng
  + Tăng độ tin cậy 

bằng cách phân phối lưu lượng tải trên nhiều máy chủ. 

## 2. Cách thức hoạt động
- Xử lí các incoming connections
- Định kì check các trạng thái của server (health checks)
- Trao đổi thông tin với các HAProxy nodes khác

### Health Check
- **HAProxy** sử dụng `health check` để phát hiện backend server nào sẵn sàng xử lí request.
- Tránh việc loại bỏ thủ công 1 `backend server` không sẵn sàng.
- `health check` thiết lập kết nối TCP tới server để kiểm tra `backend server` có sẵn sàng xử lí request.
- Nếu `health check` không thể kết nối tới server, nó sẽ tự động loại bỏ server. Các traffic sẽ không được forward tới server cho đến khi nó được `health check`.

## 3. Các thuật toán cân bằng tải
- `Weighted roundrobin`: Mỗi máy chủ được đánh giá bằng 1 số nguyên (default = 1). 1 server có khả năng xử lí lớn hơn được đánh số lớn hơn và nhận được số request lớn hơn. 
- `roundrobin`: Các request sẽ chuyển đến server theo lượt 1:1(default cho HAProxy).
- `least connections`: Chuyển đến server có ít kết nối đến nó nhất.
- `least response time`: dựa trên thời gian đáp ứng của mỗi server. Thuật toán chọn server có thời gian đáp ứng nhanh nhất (xác định bởi khoảng thời gian giữa thời điểm gửi 1 gói tin đến server và thời điểm nhận gói tin trả lời)
- `IP hash`: Các request được chuyển đến server bằng các hash của IP người dùng.

## 4. Các thuật ngữ trong HAProxy
### 4.1 Access Control List (ACL)
- Sử dụng để kiểm tra 1 số điều kiện và thực hiện hành động tiếp theo dựa trên kết quả kiểm tra.

### 4.2 Backend
- **Backend** là tập các server nhận các request đã được điều tiết (HAProxy điều tiết các request tới các backend).
- Các Backend thường được định nghĩa trong mục `backend` khi cấu hình HAProxy.
- 2 Cấu hình thường được định nghĩa trong mục `Backend`:
  + Thuật toán cân bằng tải (Round Robin, Least Connection, IP hash)
  + Danh sách các Server, Port (Nhận, xử lí request)
- Backend có thể chứa 1 hoặc nhiều server.

### 4.3 Frontend
- **Frontend** định nghĩa cách các request điều tiết tới Backend.
- Cấu hình Frontend định nghĩa trong mục `frontend` khi cấu hình HAProxy.
  + Các IP và Port.
  + Các ACL.
  + Backend nhận, xử lí request.

__Tài liệu tham khảo:__

- https://github.com/hocchudong/ghichep-nginx/blob/master/docs/nginx-loadbalncing.md
- https://github.com/lacoski/haproxy-note
- https://github.com/meditechopen/meditech-thuctap/blob/master/ThaoNV/HAProxy%20%2B%20KeepAlive/docs/intro.md
- https://github.com/hocchudong/ghichep-haproxy/blob/master/docs/ha-overview.md
