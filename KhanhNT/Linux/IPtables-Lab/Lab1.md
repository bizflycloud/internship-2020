# LAB1 về Iptables

![](https://i.ibb.co/F56zDpR/Screenshot-from-2020-08-21-14-53-15.png)

## 1. Mục đích 
- Mặc đinh DROP INPUT
- Mặc định ACCEPT OUTPUT
- Mặc định DROP FORWARD
- ACCEPT Established Connection
- ACCEPT kết nối Ping 5 lần mỗi phút từ mạng LAN
- ACCPET kết nối SSH từ trong mạng LAN

## 2. Thực hiện trên con server
- DROP INPUT
 + `iptables -P INPUT DROP` (-P: --policy Câu lệnh nói với kernel để thiết lập target mặc định, hoặc policy của chain. Tất cả các gói tin không phù hợp với bất kỳ rule nào sẽ bị buộc phải sử dụng policy của chain. ) 
- ACCEPT OUTPUT
 + `iptables -P OUTPUT ACCEPT`
- DROP FORWARD
 + `iptables -P FORWARD DROP`
- ACCEPT Established Connection
  + `iptables -A INPUT -m state --state ESTABLISHED, RELATED -j ACCEPT`
  + -A: --append: thêm rule vào cuối của chain
  + -m: --match
  + **Explicit matches** kết hợp option `-m` 
  + State matches: yêu cầu chỉ thị `-m state` trạng thái kết nối.
  + **ESTABLISHED**: 1 kết nối được đăng kí trong kernel
  + **RELATED**: 1 kết nối mới được tạo bởi kết nối cũ, 1 established.
- ACCEPT kết nối ping 5 lần mỗi phút từ mạng LAN
  + `iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/m --limit-burst 5 -s 192.168.1.0/24 -d 192.168.1.2 -j ACCEPT`
  + **Limit match**: `--limit 5/minute --limit-burst 5`: chứa tối đã 5 token và sau mỗi 60/5s sẽ nạp thêm 1 token.

## 3. Explicit matches
- Là những kết hợp đặc biệt với option `-m`

### 3.3.1 Limit match
- Dựa trên token bucket filter
- Thùng chứa X token, mỗi request đến và được response làm thùng giảm đi 1 token, sau khi hết token request sẽ không được trả lời.
- `--limit 3/minute --limit-burst 5`: tối đã 5 token và sau mỗi 60/3=20s nạp thêm 1 token
- VD: `iptables -A INPUT -p icmp -s 192.168.1.0/24 -d 192.168.1.1 -m limit --limit 3/m --limit-burst 5 -j ACCEPT`

### 3.3.2 MAC match 
- Khớp packet dựa trên địa chỉ MAC nguồn
- Đi kèm option `-m mac`
- Dùng trong các chain **PREROUTING, FORWARD, INPUT**
- `iptables -A INPUT -m mac --mac-source 00:00:00:00:00:01`

### 3.3.3 Multiport match
- Chỉ định nhiều port hoặc dải ports
- `iptables -A INPUT -p tcp -m multiport --source-port 22,53,80.`
   + Tối đa 15 port 
- `iptables -A INPUT -p tcp -m multiport --destination-port 22,53,80.`
- `iptables -A INPUT -p tcp -m multiport --port 22,52,80`

### 3.3.4 State match
- Match state được sử dụng để kết hợp connection tracking code trong kernerl. State match truy cập vào trạng thái theo dõi kết nối từ contracking machine.
- `iptables -A INPUT -m state --state RELATED, ESTABLISHED`
- Có 4 trạng thái INVALID, ESTABLISHED, NEW và RELATED. 

**Tài liệu tham khảo: https://github.com/khanhnt99/thuctap012017/tree/master/XuanSon/Security/Iptables**
