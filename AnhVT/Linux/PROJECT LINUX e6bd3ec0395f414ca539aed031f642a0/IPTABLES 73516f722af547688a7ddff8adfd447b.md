# IPTABLES

![IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled.png](IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled.png)

## 1. Giới thiệu

Khái niệm `Iptables` hiện nay xuất hiện khá phổ biến trên các hệ điều hành sử dụng lõi Kernel như Debian, Ubuntu, CentOS,... Về cơ bản, `Iptable` là một tường lửa ( firewall ) cho phép các gói tin có thể thông qua hoặc không → Giúp bảo vệ hệ thống của bạn 1 cách an toàn hơn cho các server chứa các thông tin cá nhân ( private information ). Về cách thức vận hành thì `Iptables` khá phức tập, nhưng để sử dụng nó thì không quá khó. Thông qua một vài ví dụ thì người sử dụng hoàn toàn có thể thành thạo kĩ năng giúp bảo vệ máy tính của bạn.

## 2. Khái niệm `iptables`

![IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%201.png](IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%201.png)

`Iptables` là một firewall có thể cài đặt trên các hệ thống OS sử dụng lõi Kernel. Nó là 1 giao diện CLI để người sử dụng tương tác với `Packet Filtering` trong framework `Network Filtering`  ( Netfilter Hooks) của lõi Kernel.  Ở đây chúng ta cần lưu ý rằng `Iptables` sẽ nằm ở ngoài nhân hệ thống, khi được sử dụng, `Iptables` sẽ thực hiện giao tiếp với dữ liệu của người dùng sau đó chuyển dữ liệu này cho `Netfilter` nằm trong nhân xử lý bằng các thao tác nhanh gọn. 

### 2.1 Ý tưởng cốt lõi của `Iptables` ( Core concepts)

![IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%202.png](IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%202.png)

Đầu tiên chúng ta cần làm quen với các khái niệm (Terminology )cơ bản của `Iptables` như :

Chain, Tables và Target bởi vì đây là 3 thứ cốt lõi làm nên ý tưởng ( concept ) của `Iptables` . Việc hiểu về khái niệm và cách tương tác giữa chúng sẽ chúng ta hiểu hơn về `Iptables` mà không cần phải ghi nhớ quá nhiều cũng như hỗ trợ chúng ta trong quá trình debug sau này.

### 2.1.1 Table

Khái niệm `table` trong `Iptables` được định nghĩa như sau : Nó là 1 bảng chứa các quy tắc ( rules ) được sắp xếp từ trên xuống dưới. Khi nhận được gói tin ( package ) , thì package sẽ được so sánh với các quy tắc, nếu thỏa mãn thì sẽ chuyển xuống các rule bên dưới. Sau khi thỏa mãn toàn bộ các rule thì sẽ được chuyển tiếp sang 1 `table` khác để xử lý nếu cần. 

Có tổng cộng 5 loại `table` trong đó có 3 loại ( `filter` , `nat` , `mangle`) được sử dụng thường xuyên và 2 (`raw` , `security` ) loại được sử dụng ít hơn: 

1. `filter` : Đây là loại `table` được sử dụng thường xuyên nhân bởi đây chính là `table` quyết định xem liệu gói tin sẽ được thực thi hành động gì ( nhận, hủy, chuyển tiếp ).
2. `nat` : Đúng như cái tên của nó ( Network address translation ), nó được sử dụng mỗi khi gói tin tạo 1 kết nối mới và cùng với đó quyết định xem có hay không sự thay đổi địa chỉ địa chỉ nguồn, đích ( source , destination host ) và cách thay đổi địa chỉ đó của gói tin.
3. `mangle` : Đây là `table` được sử dụng để thay đổi tiêu đề của gói tin ( như mục TTL , ... ) 
4. `raw` : `table` này được sử dụng để theo dõi kết nối của gói tin ( connection tracking ) . Cơ chế này được cung cấp bởi `netfilter` , cho phép `Iptables` nhận biết các gói tin như các kết nối liên tục ( ongoing connection ), phiên (session ) thay vì như một luồng dữ liệu không liên kết, rời rạc ( unrelated, discrete stream ).
5. `security` : Có một số phiên bản Kernel hỗ trợ `table` này. Nó được dùng bởi SE Linux để thiết lập các chính sách bảo mật. Việc này diễn ra trên từng gói tin và từng kết nối một.

Qua phần trên thì chúng ta đã có cái nhìn khá tổng quan về khái niệm đầu tiên của `Iptables` . Sau đây chúng ta sẽ tìm hiểu cách các `table` này kết nối với nhau như thế nào.

### 2.1.2 Chain

![IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%203.png](IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%203.png)

`Chain` có thể được xem xét như các điểm checkpoint trên đường truyền của gói tin. Tại mỗi điểm thì gói tin sẽ được thực hiện đánh giá ( evalutated ). Thông qua việc đánh giá đó thì sẽ quyết định đường đi tiếp theo của gói tin.

Có 5 `Chain` cơ bản đó chính là: `PRE-ROUTING` , `INPUT`, `FORWARD` , `OUTPUT` và `POST-ROUTING`. Các `Chain` này hoạt động dựa trên các hook của `Netfilter Hooks` . Các `Chain` khác nhau thì sẽ sử dụng các `table` khác nhau. Hoạt động của các `Chain` có thể được hiểu đơn giản qua hình bên dưới :

![IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%204.png](IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%204.png)

**2.1.2.1** `PRE-ROUTING` :

Bao gồm các `table` sau: 

- `raw` : Thực hiện connection tracking đối với gói tin, kiểm tra xem nó là gói tin mới hay là gói tin tiếp của các gói tin trước đó
- `nat` : Thực hiện chỉnh sửa gói tin khi nó đến với giao diện mạng
- `mangle` : Thực hiện thay đổi các thông số tại tiêu đề của gói tin ( nếu cần )

**2.1.2.2** `INPUT` :

Bao gồm các `table` sau :

- `mangle` : Thực hiện thay đổi các thông số tại tiêu đề của gói tin ( nếu cần )
- `filter` : Xử lý gói tin được định hướng tới local socket

**2.1.2.3** `FORWARD` :

Bao gồm các `table` sau :

- `mangle` : Thực hiện thay đổi các thông số tại tiêu đề của gói tin ( nếu cần )
- `filter` : Xử lý gói tin được định hướng để chuyển tiếp ( forward)

**2.1.2.4** `OUTPUT` :

Bao gồm các `table` sau :

- `raw` : Thực hiện connection tracking đối với gói tin
- `mangle` : Thực hiện thay đổi các thông số tại tiêu đề của gói tin ( nếu cần )
- `nat` : Thực hiện chỉnh sửa gói tin trước khi định hướng (routing) ra ngoài
- `filter` : Xử lý gói tin được tạo trong hệ thống để ra ngoài

**2.1.2.5** `POST-ROUTING`

Bao gồm các `table` sau :

- `mangle` : Thực hiện thay đổi các thông số tại tiêu đề của gói tin ( nếu cần )
- `nat` : Thực hiện chỉnh sửa gói tin trước khi nó được chuyển ra ngoài

`Chain` là một khái niệm vô cùng quan trọng giúp ta hiểu được cách các gói tin được đánh giá. Sau khi được đánh giá cụ thể thì nó sẽ được gán cho các `Targets` để thực hiện hành vi yêu cầu.

## 3. Target :

`Target` là một hành động sẽ được trigger ngay sau khi các tiêu chí được thỏa mãn . `Target` được chia làm 2 loại:

- Terminating Target : Loại `Target` này sẽ lập tức hủy việc đánh giá gói tin . Tùy thuộc vào thiết lập mà nó sẽ `Drop` `Reject` hay `ACCEPT`
- Non-terminating Target : Loại `Target` sẽ thực thi hành động nhưng vẫn sẽ tiếp tục các hành vi đánh giá.

Có 4 loại `Target` chính thường được hay sử dụng:

1. `ACCEPT` : Chấp nhận gói tin
2. `DROP` : Hủy gói tin nhưng không phản hồi lại
3. `REJECT` : Hủy gói tin và có phản hồi lại
4. `LOG` : Ghi lại log

## 4. Quá trình Connection Tracking :

Một gói tin trước khi vào hệ thống sẽ phải thông qua `Iptables` và được thực hiện connection tracking trước khi thực hiện các hành động tiếp theo. Đơn giản quá trình này là việc kiểm tra xem gói tin đó có thuộc về các gói đã nhận được trước đó hay là 1 gói tin hoàn toàn mới.  Sau đó quá trình này sẽ được gán 1 hay nhiều trạng thái( state ) sau:

- `NEW` : Một gói tin hoàn toàn không liên kết với bất kì gói tin đã nhận nào. Và gói tin này cũng không bị loại bỏ sau khi thông qua các quy tắc.
- `ESTABLISH` : Trạng thái sẽ được chuyển sang nếu nhận được phản hồi từ bên đối diện → kết nối được thiết lập giữa 2 bên ( Establish )
- `RELATED` : Trạng thái này xuất hiện nếu có 1 gói tin cụ thể không thuộc bất kì 1 dãy gói tin trước đó nhưng có liên quan tới 1 hoặc nhiều dãy các gói tin trước đó.
- `INVALID` : Xảy ra khi một gói tin không thuộc về bất kì 1 dãy gói tin nào và cũng không hợp lệ để mở một đường kết nối mới
- `UNTRACK` : Được thực hiện nếu ở `table raw` thiết lập `NOTRACK` để bỏ qua quá trình connection tracking

**Như vậy chúng ta đã hiểu cơ bản về ý tưởng hoạt động cũng như cách thức `Iptables` hoạt động**

Tiếp theo chúng ta  sẽ đến với một số ví dụ đơn giản để sử dụng `Iptables` 

## 5. Sử dụng `Iptables` trong 1 vài ví dụ cơ bản :

![IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%205.png](IPTABLES%2073516f722af547688a7ddff8adfd447b/Untitled%205.png)

Đầu tiên chúng ta cần thử liệt kê các quy tắc đang được áp dụng trên máy tính của bạn thông qua 

```bash
iptable -L
```

```bash
root@virtual-machine:/home/user# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
```

Ở đây chúng ta có thể thấy có 3 `Chain` chính đó là `INPUT` `FOWARD` và `OUTPUT` trong đó cơ chế mặc định của 3 `Chain` là `ACCEPT` ( chấp nhận gói tin)

**Các option cơ bản :**

```bash
1. Chỉ định tên tables : -t
2. Chỉ định interface vào : -i
3. Chỉ dịnh hành động thực thi : -j
4. Chỉ định interface ra : -o
5. Chỉ định giao thức: `-p
6. Chỉ định cổng vào : --sport
7. Chỉ định cổng ra : --dport
```

**Các thao tác đối với iptables:**

```bash
1. Thêm rule (append) : -A
2. Xóa rule : -D
3. Chèn thêm rule : -I
4. Thay thế rule: -R
```

- **Đầu tiên chúng ta sẽ thử chặn ping tới port 80 của máy :**

```bash
root@virtual-machine:/home/user# iptables -A INPUT -p tcp --dport 80 -j REJECT
root@virtual-machine:/home/user# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
REJECT     tcp  --  anywhere             anywhere             tcp dpt:http reject-with icmp-port-unreachable

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
```

khi thực hiện lệnh này nếu 1 máy tính khác thực hiện lệnh ping tới port 80 sẽ nhận được két quả như sau :

```bash
SENT (0.0031s) TCP xxxxx:60460 > xxxxxx:80 S ttl=64 id=50654 iplen=40  seq=2331717045 win=1480 
RCVD (0.0032s) ICMP [xxxxxx > xxxxxxx Port 80 unreachable (type=3/code=3) ] IP [ttl=64 id=9976 iplen=68 ]
```

- **Tiếp theo chúng ta xét tới kết nối SSH**:

Đa số các kết nối hiện nay đều yêu cầu kết nối 2 chiều, ví dụ như SSH. Giả sử bạn cần chấp nhận kết nối của máy khác tới → Cần thêm 1 số quy tắc vào cả `INPUT` và `OUTPUT` . Nhưng nếu bạn chỉ muốn chấp nhận kết nối từ máy khác tới mà không chấp nhận kết nối SSH tới máy đó ? Đó là khi mà `state` ( như chúng ta đã đề cập ở bên trên ) thể hiện vai trò của nó

Giả sử chúng ta sẽ chấp nhận kết nối từ 1 server 123.30.234.1. Việc thực hiện update các quy tắc trong `Iptables` được thực hiện như sau:

```bash
iptables -A INPUT -p tcp -s 123.30.234.1 --dport ssh -m state --state NEW,ESTABLISH -j ACCEPT
```

→ Chúng ta sẽ chấp nhận các kết nối với giao thức tcp từ source 123.30.234.1 tới cổng port ssh ( port 22 ) nếu trạng thái ( state ) của kết nối đó là `NEW` `ESTABLISH` 

Vậy để chặn chiều ssh ngược lại chúng ta sẽ sử dụng

```bash
iptables -A OUTPUT -p tcp -d 123.30.234.1 --dport 22 -m state --state ESTABLISHED -j DROP
```

Server trong ngữ cảnh đang xét sẽ được phép trả lời và nhận gói tin từ host 123.30.234.1 → cho phép kết nối ssh giữa 2 host tuy nhiên chiều ngược lại sẽ không thực hiện được ! 

**Sau khi thực hiện các lệnh , để lưu lại thay đổi chúng ta sử dụng lệnh**: 

```bash
sudo /sbin/iptables-save
```

Sau đó kiểm tra lại bằng lệnh `Iptables -L` ( Lưu ý cần chạy với `root` hoặc thêm `sudo` ) 

**Để thực hiện xóa lệnh chúng ta thực hiện như sau**:

```bash
iptables -D [Table ] [ number ]
#Vi du
iptables -D INPUT 3
```

## **Chúc các bạn thành công**!!!

---

## Nguồn tham khảo :

[The Beginner's Guide to iptables, the Linux Firewall](https://www.howtogeek.com/177621/the-beginners-guide-to-iptables-the-linux-firewall/)

[Iptables Tutorial 1.2.2](https://www.frozentux.net/iptables-tutorial/iptables-tutorial.html)

[Tìm hiểu về Iptables (phần 1) - Techblog của VCCloud](https://bizflycloud.vn/tin-tuc/tim-hieu-ve-iptables-phan-1-660.htm)

[IPTABLES [PART-1] : "UNDERSTANDING THE CONCEPT"](https://www.youtube.com/watch?v=vbhr4csDeI4&t=130s)

[iptables: Tables and Chains](https://www.youtube.com/watch?v=jgH976ymdoQ)

[A Deep Dive into Iptables and Netfilter Architecture | DigitalOcean](https://www.digitalocean.com/community/tutorials/a-deep-dive-into-iptables-and-netfilter-architecture)

[Hướng dẫn sử dụng Iptables - Học VPS](https://hocvps.com/iptables/)

[Hướng dẫn Iptables toàn tập - Bảo mật máy chủ](https://thachpham.com/linux-webserver/iptables-linux-toan-tap.html)

[Iptables chuyên sâu](https://blogd.net/linux/iptables-chuyen-sau/)

[Iptables Tutorial 1.2.2](https://www.frozentux.net/iptables-tutorial/iptables-tutorial.html#MANGLETABLE)