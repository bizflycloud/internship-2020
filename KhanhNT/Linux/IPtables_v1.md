# IPTABLES
## Khái niệm cơ bản:
- Các dữ liệu được gửi đi trong các gói tin được định dạng qua internet.
- Linux kernel cung cấp giao diện để lọc cả các gói tin đã đi vào và ra sử dụng 1 bảng bộ lọc gói tin.
- Có thể lập nhiều bảng khác nhau.
- Mỗi bảng có thể chứa nhiều chuỗi, mỗi chuỗi là 1 bộ quy tắc. 

## 1. Iptables là gì: 
- Iptable là ứng dụng tường lửa dựa trên lọc gói, miễn phí và có sẵn trên Linux.
- Gồm 2 phần:
 - Netfilter trong nhân Linux.
 - Iptables ngoài nhân Linux.
- Iptable **giao tiếp với người dùng** sau đó đẩy các rule của người dùng vào cho Netfilter xử lí.
- Netfilter lọc các gói dữ liệu ở mức IP (làm trực tiếp trong nhân nên nhanh và không làm giảm tốc độ hệ thống).

## 2. Cơ chế và thành phần:

- Cơ chế lọc gói tin của IPtables dựa trên 3 thành phần cơ bản:
 - **Table**.
 - ** Chain**.
 - **Target**.
- Table là bảng xử lí các gói tin theo những cách cụ thể. Mặc định là filter table, ngoài ra thêm được các bảng khác nữa.
- Mỗi bảng sẽ gắn thêm các **chain**. Việc gắn thêm **chain** sẽ cho phép xứ lí gói tin ở các giai đoạn khác nhau.
- Tạo rule cụ thể, ví dụ gói tin đến từ port, ip sau đó chỉ định hành động (Target) sẽ áp dụng.
- Khi 1 gói tin đến hoặc 1 gói tin đi Iptable sẽ so sánh với từng rule trong 1 chain.
- Khi 1 gói tin giống với rule trong 1 chain, Iptable sẽ thực hiện hành động ứng với rule đó.
- Nếu không khớp với bất kì rule nào. Iptable sẽ áp dụng `default policy`- cho phép gói tin.

### 2.1 Table

#### Filter table
- Lọc gói dữ liệu. Quyết định gói tin có đến được địa chỉ đích hay không.
- Gồm 3 quy tắc:
 - Forward chain: lọc gói khi đến các server khác.
 - Input chain: lọc gói khi vào trong server.
 - Output chain: Lọc gói khi ra khỏi server.
![](https://www.hostinger.com/tutorials/wp-content/uploads/sites/2/2017/06/iptabes-tutorial-input-forward-output.jpg?x46510)
- Quá trình bắt gói tin:
 - Khi gói tin đến gói tin có các bộ tham số như: địa chỉ nguồn, địa chỉ đích, port nguồn, port đích, TTL, TOS, giao thức.
 - Bộ lọc sẽ dựa vào các tham số trên của gói tin để bắt gói tin và áp dụng phương pháp xử lí với nó.

VD: `Bộ lọc bắt các gói tin kiểu tcp thì tất cả các gói tin kiểu tcp sẽ bị iptables giữ lại và áp dụng các phương pháp xử lí, ngoài ra còn có thể kết hợp các điều kiện lại với nhau như gói tin dạng tcp có địa chỉ port đích nguồn.`

#### Mangle table
- Chịu trách nhiệm thay đổi các bits trong TCP Header TOS(type of service), TTL(time to live), và MARK.

#### NAT table
- Cho phép các gói tin đến các host khác nhau trong mạng NAT table bằng cách thay đổi IP nguồn và IP đích của gói tin.

- NAT (network address translation)
 - NAT là quá trình chuyển đổi các port nguồn, đích, địa chỉ nguồn, địa chỉ đích của 1 gói tin.
 - Tác dụng: trong mạng internet thực tế nat sử dụng chuyển đổi địa chỉ ip private thành ip publish. Giấu địa chỉ thật của 1 hệ thống server qua đó giảm thiểu được tấn công nhằm vào hệ thống server.


#### Raw table

- 1 gói tin có thể thuộc 1 kết nối mới hoặc là 1 kết nối đã tồn tại. Table raw cho phép làm việc với gói tin trước khi Kernel kiểm tra trang thái gói tin. 

### 2.2 Chain
- Mỗi table được tạo với 1 số chain nhất định.  
- Chain cho phép lọc gói tin tại các thời điểm khác nhau.  

#### Bảng NAT
- 3 chain được xây dựng 
 - Chain PREROUTING: 
    - Dùng để thay đổi địa chỉ đích của gói tin, target được sử dụng là DNAT (destination NAT)
 - Chain POSTROUTING:
    - Thay đổi địa chỉ nguồn của gói tin, target sử dụng là SNAT (source NAT) 

#### Bảng Filter
- Chain INPUT: 
 - Dùng để lọc các gói tin đầu vào, các gói tin bắt buộc phải đi qua để có thể được xử lí
- Chain OUTPUT:
 - Dùng để lọc các gói tin đầu ra. Sau khi gói tin được xử lí phải đi qua chain output để được ra ngoài.
- Chain FORWARD:
 - Chuyển các gói tin qua lại giữa các card mạng với nhau.
- Các target có thể được sử dụng là: ACCEPT, DROP.

#### Bảng Mangle
- Bao gồm tất cả các chain được xây dựng sẵn
 - PREROUTING
 - POSTROUTING
 - INPUT
 - OUTPUT
 - FORWARD

![](https://techvccloud.mediacdn.vn/2018/1/Done-0108-Iptables-ph%E1%BA%A7n-1-Google-Docs.png)

### 2.3 TARGET:
- Các hành động áp dụng cho các gói tin.
 - ACCEPT: chấp nhận gói tin, cho phép gói tin đi vào hệ thống.
 - DROP: Loại bỏ gói tin, không có gói tin trả lời, hay hệ thống không tồn tại.
 - REJECT: Loại bỏ gói tin nhưng có trả lời table gói tin khác.
 - LOG: chấp nhận gói tin nhưng sẽ ghi lại log
- Gói tin sẽ đi qua tất cả các RULE chứ không dừng lại khi đã đúng với 1 rule đặt ra.

## 3. Quá trình xử lí gói tin:
- Đầu tiên gói tin từ mạng A vào hệ thống firewall sẽ phải đi qua bảng Mangle với chain là PREROUTING (mục đích tha đổi 1 số thông tin của gói trước khi quyết định dẫn đường).
- Sau đó gói tin đến bảng NAT với chain PREROUTING (địa chỉ đích của gói có thể bị thay đổi hoặc không), qua bộ routing và quyết định xem gói tin đó thuộc firewall hay không:
  - TH1: 
      - Gói tin đó của firewall: gói tin sẽ đi qua bảng mangle và đến bản filter với chain là INPUT.
      - Tại đây gói tin được áp dụng rule và ứng với mỗi rule sẽ áp dụng target. 
      - Sau đó gói tin đến bảng NAT với chain OUTPUT.
 - TH2:
    -  Gói tin không phải của firewall sẽ được đưa đến bảng mangle với chain FORWARD đến bảng filter với chain FORWARD. 

