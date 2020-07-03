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
