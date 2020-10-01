# TRAFFIC CONTROL

![TRAFFIC%20CONTROL/Untitled.png](TRAFFIC%20CONTROL/Untitled.png)

Sau quá trình sử dụng Linux 1 thời gian, người sử dụng đã có thể làm quen với các lệnh cơ bản như:  ip rule, ip route , .... Tuy nhiên, ít người lại biết đến được sự tồn tại của lệnh `tc` . Lệnh này sẽ cho phép điều khiển độ trễ, packet loss và băng thông của các giao diện mạng. 

Traffic control hay điều khiển lưu lượng là 1 tập các cách sắp xếp và quy tắc đối với các gói tin nhận và gửi đi trên các router. Điều này bao gồm việc như: chấp nhận hay không chấp nhận gói tin và tại tốc độ là bao nhiêu, trễ bao nhiêu; giảm tốc độ mạng, băng thông của 1 nguời sử dụng, ... Điều này cung cấp 1 lợi ích vô cùng lớn trong 1 hệ thống lớn khi mà nhiều dịch vụ trên cùng 1 hệ thống hoạt động.

Giả sử trong cùng 1 hệ thống hoạt động Web Server và Mail Server → Web Server sẽ cần 1 đường truyền băng thông lớn hơn so với Mail Server. Nếu sử dụng `tc` để chia lượng băng thông phù hợp với mỗi loại dịch vụ thì sẽ tận dụng được tối đa được đường truyền và khả năng phục vụ hệ thống 

⇒ Gia tăng QoS - Điều rất quan trọng trong thời đại hiện nay.

`tc` có thể cung cấp nhiều tiện ích khác nhau cho nguời sử dụng nhưng cùng với đó sẽ là những mặt nhược điểm đi cùng nó. Traffic Control là 1 khái niệm vô cùng rộng trong mạng vậy nên ở bài này chúng ta sẽ tập trung tìm hiểu về thành phẩn cơ bản, cơ chế  điều khiển băng thông trên các giao diện mạng và các ưu nhược điểm khi sử dụng phương pháp này.

# 1. Các thành phần cơ bản

Các thành phần cơ bản của Traffic Control bao gồm các phần tử sau:

1. **Shaping**:
    - Thực hiện làm delay ( gián đoạn ) các gói tin để có thể nhận được tốc độ mong muốn
    - Shaping là cách thức để điều khiển các gói tin trước khi gói tin được chuyển tới output queue ( hàng đợi ra ). Đây là phương thức được sư dụng nhiều nhất khi có nhu cầu giới hạn băng thông
    - Shaper sẽ giới hạn tốc độ đầu ra tại 1 giá trị xác định và không để vượt ngưỡng này

        → Có khả năng điều khiển độ trễ của gói tin 

    - Hoạt động dựa trên cơ chế Token Bucket
2. **Scheduling**
    - Thực hiện sắp xếp các gói tin cho đầu ra
    - Scheduling sẽ thực hiện việc sắp xếp gói tin ở giữa đầu vào và đầu ra
    - 1 Số các cách sắp xếp phổ biến : FIFO , SFQ, ESFQ, RR , ...
3. **Classifying**
    - Thực hiện sắp xếp gói tin theo loại hay kiểu gói tin
    - Là cách thức chuyển các gói tin theo các đầu ra khác nhau dựa theo loại gói tin
    - Có thể kết hợp cùng Policy để phân loại gói tin
4. **Policy**
    - Thực hiện đo lường và giới hạn trong 1 queue ( hàng đợi ) xác định
    - Policy sẽ đảm bảo các phần tử trong hệ thống sẽ không vượt quá ngưỡng cho phép đã được đặt xác định trước
    - Policy sẽ có các hành động khác nhau trong các trường hợp khác nhau: đạt ngưỡng, dưới ngưỡng hay trên ngưỡng
    - Mặc dù nó cũng hoạt động dựa trên cơ chế Token Bucket tuy nhiên lại không điều khiển được độ trễ giống như như *Shaping*
5. **Dropping** 
    - Thực hiện loại bỏ 1 Flow, gói tin hay 1 classification
6. **Marking**
    - Thực hiện cài DSCP trên packet và được các router khác trên mạng sử dụng

# 2. Thực hiện điều chỉnh băng thông

![TRAFFIC%20CONTROL/Untitled%201.png](TRAFFIC%20CONTROL/Untitled%201.png)

Trước khi thực hiện ta cần show các rule đang áp dụng trên dev:

```bash
tc qdisc show dev ens33
```

Kết quả nhận được có dạng:

```bash
tc qdisc show dev enp3s0 
qdisc fq_codel 0: root refcnt 2 limit 10240p flows 1024 quantum 1514 target 5.0ms interval 100.0ms memory_limit 32Mb ecn
```

Add rule giới hạn băng thông:

```bash
tc qdisc add dev enp3s0 root tbf rate 1mbit burst 32kb latency 400ms
```

Kết quả nhận được có dạng:

```bash
tc qdisc show dev enp3s0 
qdisc tbf 8001: root refcnt 2 rate 1Mbit burst 32Kb lat 400.0ms
```

Del rule trên giao diện mạng:

```bash
tc qdisc del root dev enp3s0
```

# 3. Ưu nhược điểm

![TRAFFIC%20CONTROL/Untitled%202.png](TRAFFIC%20CONTROL/Untitled%202.png)

**Ưu điểm :**

- Cung cấp khả năng kiểm soát đường truyền tối ưu nhất
- Nâng cao QoS
- Khả năng tuỳ biến theo nhu cầu

**Nhược điểm**

- Nâng cao độ phức tạp
- Khó khăn khi khắc phục lỗi
- Yêu cầu độ tính toán cao trên router hoặc server sử dụng `tc`
- Việc mở rộng thêm băng thông là phương pháp đơn giản hơn