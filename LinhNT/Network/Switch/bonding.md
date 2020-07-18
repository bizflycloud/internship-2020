## Bonding
___
> **Bonding** là công nghệ giúp tăng BW + reduntdancy bằng cách kết hợp 2 hay nhiều network interfaces thành **1 logical interface**. 

> **Bonding** giúp ***tăng BW*** và khả năng ***redundancy***. Nếu 1 NIC (network interface card có vấn đề, sự cố thì kết nối vẫn sẽ không bị hảnh hưởng bới **the other slave NICs** vẫn active).

##### Các mode bonding
Hành vi của **the bonded interfaces** phụ thuộc vào các mode chúng ta lựa chọn
+ **Mode 0 (balance-rr)**(balance-round robin mode) : Các packets được truyền và nhận một cách tuần tự thông qua mỗi interface. Mode này cung cấp chức năng **load balancing**.
+ **Mode 1 (active-backup)**: Mode này chỉ có 1 interface được set active, các interface còn lại ở trạng thái backup. Nếu the active interface bị down thì 1 trong số các backup interface sẽ thay thế nó. `The media access control (MAC) address of the bond interface in mode 1 is visible on only one port (the network adapter), which prevents confusion for the switch.` (phần này em chưa hiểu rõ ạ). Mode 1 cung cấp cơ chế chịu lỗi (**fault tolerance**).
+ **Mode 2 (balance-xor)**: XOR(src mac,dst mac) điều này đảm bảo **the slave interface** ở 2 phía src và dst là tương ứng. Mode 2 cung cấp khả năng chịu lỗi(**fault tolerance**) và **load balancing**.
+ **Mode 3 (broadcast)**: Tất cả các kết nối được gửi tới tất cả **slave interfaces**. Mode 3 cung cấp khả năng chịu lỗi (**fault tolerance**).
+ **Mode 4 (802.3ad)**: Mode này tạo **aggregation groups** - thiết lập chung BW, duplex,.. Mode 4 sử dụng tất cả interfaces trong 1 active aggregation group. Ví dụ, chúng ta có thể tổng hợp 3 ports 1Gb thành 1 port 3Gb. Mode 4 cung cấp cơ chế **fault tolerance** và **load balancing**.
+ **Mode 5 (balance-tlb)**: Mode 5 đảm bảo việc phân phổi lưu lượng được thiết lập theo BW của mỗi interface. Mode 5 cung cấp cơ chế **fault tolerance** và **load balancing**.
+ **Mode 6 (balance-alb)**: Mode 6 hoạt động trong môi trường x86. Các gói tin nhận được load balanced thông qua điều phối của ARP. Mode 6 cung cấp cơ chế **fault tolerance** và **load balancing**.

Vì trong phần lab ta sẽ sử dụng **mode 4 (802.3ad)** khi thực hiện bonding tại h1 nên chúng ta sẽ tìm hiểu kĩ hơn về **IEEE 802.3ad Link Aggregation Policy** và **LACP**.
###### 802.3ad Link aggregation và LACP
[](https://80f9b8fec919ac5ebc1a-384085a95109bffb325fe35cb6202ded.ssl.cf2.rackcdn.com/LAP-diagram-9bd552984ad697c18f50c166ca71c8928bd6447765f47de411ae212c53668b7c.png)
- **802.3ad Link aggregation** : cho phép chúng ta nhóm các physical ethernet interfaces tới **link layer interface** (LAG - link aggregation group)
- **LACP** : là một **cơ chế** để trao đổi thông tin các ports và hệ thống cho việc tạo và duy trì LAG. **LACP** xác định địa chỉ MAC của các ethernet links( có highest port priority) và chỉ định địa chỉ MAC đó tới LAG.

### Kịch bản
Ta tạo một kịch bản gồm 4 hosts như theo hình dưới đây.Còn h2 như một switch.  Chúng ra sẽ **bond** 2 interfaces của h1 thành 1 logical interface. Chúng ta sẽ đánh giá hiệu năng của 2 phần, khi có **bonding**, khi **không bonding** và trong khi **bonding** + down 1 đường.

#### Chuẩn bị
- Ta sử dụng mininet làm môi trường để xây dựng topo. Ở đây, em sử dụng đoạn code python để custom topo với 4 hosts, BW mỗi links giữa các hosts là 1Mb. Và phần cuối đoạn code, em thực hiện kết hợp và biểu diễn các ethernet interfaces tại h2 như 1 logical network interface được gọi là **mybr**.
**Thực hiện test băng thông**
- Theo hình vẽ topo sẽ trình bày ở phía dưới, h3 và h4 sẽ là client - h1 sẽ là server
- Ở đây, em sử dụng công cụ iperf để khởi tạo lưu lượng TCP và truyền **đồng thời** từ cả h3 và h4 (trên 2 port khác nhau) tới h1.

```python
from mininet.cli import CLI

from mininet.link import Link,TCLink,Intf

from mininet.net import Mininet

from mininet.node import RemoteController
 

if '__main__' == __name__:

  net = Mininet(link=TCLink)

  h1 = net.addHost('h1', mac='00:00:00:00:00:11')

  h2 = net.addHost('h2', mac='00:00:00:00:00:22')

  h3 = net.addHost('h3', mac='00:00:00:00:00:23')

  h4 = net.addHost('h4', mac='00:00:00:00:00:24')

  linkopts={'bw':1}

  net.addLink(h1, h2, cls=TCLink, **linkopts)

  net.addLink(h1, h2, cls=TCLink, **linkopts)

  net.addLink(h2, h3, cls=TCLink, **linkopts)

  net.addLink(h2, h4, cls=TCLink, **linkopts)

  net.build()

  h2.cmd("sudo ifconfig h2-eth0 0")

  h2.cmd("sudo ifconfig h2-eth1 0")

  h2.cmd("sudo ifconfig h2-eth2 0")

  h2.cmd("sudo ifconfig h2-eth3 0")

  h2.cmd("sudo brctl addbr mybr")

  h2.cmd("sudo brctl addif mybr h2-eth0")

  h2.cmd("sudo brctl addif mybr h2-eth1")

  h2.cmd("sudo brctl addif mybr h2-eth2")

  h2.cmd("sudo brctl addif mybr h2-eth3")

  h2.cmd("sudo ifconfig mybr up")

  CLI(net)

  net.stop()
```

##### Kịch bản 1: Không thực hiện bonding
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/bonding-s1.jpg) 

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/results-1-bonding.PNG)

##### Kịch bản 2: Thực hiện bonding 
Để thực hiện bonding tại h1, ta sử dụng script sau
```sh
echo "bonding mode=4 miimon=100" >> /etc/modules
modprobe bonding
ip link add bond0 type bond
ip link set bond0 address 00:00:00:11:22:33
ip link set h1-eth0 down
ip link set h1-eth1 down
ip link set h1-eth0 master bond0
ip link set h1-eth1 master bond0
ip addr add 10.0.0.1/8 dev bond0
ip addr del 10.0.0.1/8 dev h1-eth0
ip link set bond0 up
```

+ **miimon=100**: (ms) thời gian kiểm tra link failures ở mỗi đường link.
+ **modprobe bonding**: là câu lệnh để thêm module **bonding** từ kernel.

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/bonding-s2.jpg)

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/results-2-bonding.PNG)

**Kết quả đo lần 2**
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/new-results-3-bonding.PNG)

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/new-results-4-bonding.PNG)

Ta thấy, BW trong kịch bản 2 tăng hơn rõ rệt so với kịch bản 1 không thực hiện bonding

##### Kịch bản 3: Bonding + down 1 interface
Ta sẽ sử dụng ping với **-i x** (x nhỏ - ví dụ -i 0.2) để kiểm tra packet loss (thông qua việc thiếu sequence numbers, hoặc nhìn vào statistics) 
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/check-packet-loss-after-shutting-down-a-path.PNG)

### Linux bridge
![](https://static.thegeekstuff.com/wp-content/uploads/2017/06/brctl-bridge.png)

Khi chúng ta có nhiều interfaces ở servers và các networks ethernets - chúng ta muốn kết hợp chúng thành 1 logical interface duy nhất thì chúng ta có thể sử dụng **brctl** để tạo và control **ethernet bridge**.
+ **brctl add new_bridge** :  Tạo một **ethernet bridge** 
+ **brctl addif bridgeName devices** : Thêm một interface to bridge - lúc này interface như một port của bridge. 

## References
[Linux-bridge](https://www.thegeekstuff.com/2017/06/brctl-bridge/)

[Lab-bonding](http://csie.nqu.edu.tw/smallko/sdn/mininet-link-aggregate.htm)

[LACP-Bonding](https://developer.rackspace.com/blog/lacp-bonding-and-linux-configuration/)
