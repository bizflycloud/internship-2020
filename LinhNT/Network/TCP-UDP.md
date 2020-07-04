## TCP và UDP
___
| TCP | UDP |
|:---:|:---:|
|connection-oriented : trước khi trao đổi dữ liệu cần phải thành lập kết nối| connectionless |
| reliable and in-order | unriliable and any order |
| Có **cơ chế flow control** (đảm bảo sender không làm overwhelming receiver bằng việc gửi quá nhiều packets ), error control | None |
| *Flow control*: ví dụ : **window sliding**(cho phép mở rộng - thu hẹp window size trong trường hợp mạng không có congestion và có congestion) | None |
| Khi có congestion: TCP sử dụng các thuật toán để giải quyết (TCP Reno, Vegas, SACK,..) |None|
| TCP chậm hơn UDP vì nó cần thành lập, giải phóng kết nối - kiểm tra lỗi - đảm bảo không bị mất gói trong quá trình truyền | UDP nhanh hơn TCP | 
| Dùng trong transfer file (FTP), mail (SMTP), WWW (HTTP, HTTPS),..  | Dùng trong các ứng dụng livestream, VoIP |
| **Stateful** protocol | **Stateless** protocol | 

## 3-way handshake TCP
___
![](https://www.gatevidyalay.com/wp-content/uploads/2018/09/TCP-Header-Format.png)

Như trình bày phía trên, TCP là giao thức ***connection-oriented*** - yêu cầu kết nối trước khi truyền dữ liệu. Thêm vào đó, TCP cũng cung cấp cơ chế đánh số gói tin (***sequence numbers*** - 32 bits field) và cơ chế báo nhận (***ACK*** - 32 bits field).
Sau đây, ta sẽ đi tìm hiểu kĩ hơn về vấn đề thiết lập kết nối trong TCP hay còn gọi là **3-way handshake**.

**Kịch bản** :Host A muốn download một webpage từ gateway server -->  thành lập kết nối giữa một host và một gateway server.
###### 1. Step 1
![](http://www.firewall.cx/images/stories/tcp-analysis-section-2-6.gif)

Host A gửi một packet tới gateway server. Trong đó gói tin này gồm **SYN flag** + **ISN(Initial sequence number)** do OS của host A tạo ra  bằng *1293906975*. Hiện tại host A đang khởi tạo kết nối và chưa nhận được reply từ phía server nên **ACK=0**
###### 2. Step 2
![](http://www.firewall.cx/images/stories/tcp-analysis-section-2-7.gif)

Lúc này phía gateway server đã nhận được gói tin của host A. Để xác nhận việc này, gateway server đã phản hồi với gói tin có **SYN, ACK flag**. **ACK** =  1293906976 xác nhận rằng server đã nhận được gói tin **SN (sequence number)** = 1293906975 và mong muốn gói tin tiếp theo host A gửi sẽ có **SN** = 1293906976. Và server cũng có **ISN** của riêng nó  = 3455719727
###### 3. Step 3
![](http://www.firewall.cx/images/stories/tcp-analysis-section-2-8.gif)

Lúc này host A đã nhận được reply bên phía host B và nó sẽ thực hiện gửi một gói tin khác để hoàn thành việc kết nối. Gói tin này chứa **SYN flag**, và có SN = 1293906976 (giá trị SN mà gateway server mong muốn host A gửi được nói ở bước 2). Cùng với đó, **ACK** = 3455719728 để xác nhận với server là host A đã nhận được gói tin trước với SN = 3455719727, nó mong muốn gói tin tiếp theo server gửi sẽ có SN = 3455719728

> Lúc này, ***một kết nối được thành lập giữa host A và gateway server*** - 3 way handshake được hoàn thành. 

###### 4. Step 4 (host A request a webpage to gateway server)
![](http://www.firewall.cx/images/stories/tcp-analysis-section-2-9.gif)

Lúc này, host A khởi tạo một gói tin gửi đến server để request trang web mà nó muốn.
**NOTE** : ta có thể thất **SEQ**, **ACK** không thay đổi là vì với những gói tin chỉ có **ACK flag** với mục đích xác thực đã nhận được gói tin trước thì **SEQ không thay đổi**.

## Mở rộng Stateful và Stateless
| Stateful | Stateless |
|:---:|:---:|
| Yêu cầu server lưu trạng thái và thông tin của session | Không yêu cầu lưu thông tin các kết nối | 
| Khi client gửi request tới server nếu server không trả lời thì client sẽ resent | None |
| FTP, Telnet,... | UDP, DNS,.. | 

## References
[TCP-UDP](https://www.privateinternetaccess.com/blog/tcp-vs-udp-understanding-the-difference/#:~:text=TCP%20is%20a%20connection%2Doriented,a%20connection%20before%20sending%20data.)

[UDP-is-connectionless](https://www.quora.com/In-TCP-IP-UDP-is-connection-less-why#:~:text=User%20Datagram%20Protocol%20(UDP)%20is,require%20the%20overhead%20of%20TCP.&text=application%20as%20...-,User%20Datagram%20Protocol%20(UDP)%20is%20connectionless%20simply%20because%20not%20all,data%20over%20an%20IP%20network.)

[Stateful-Stateless](https://www.geeksforgeeks.org/difference-between-stateless-and-stateful-protocol/)

[3-way-handshake-TCP](http://www.firewall.cx/networking-topics/protocols/tcp/134-tcp-seq-ack-numbers.html)
