## Bonding
___
> **Bonding** là công nghệ giúp tăng BW + reduntdancy bằng cách kết hợp 2 hay nhiều network interfaces thành **1 logical interface**. 

### Kịch bản
Ta tạo một kịch bản gồm 4 hosts như theo hình dưới đây.Còn h2 như một switch.  Chúng ra sẽ **bond** 2 interfaces của h1 thành 1 logical interface. Chúng ta sẽ đánh giá hiệu năng của 2 phần, khi có **bonding** và khi **không bonding**.

##### Kịch bản 1: Không thực hiện bonding
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/bonding-s1.jpg) 

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/results-1-bonding.PNG)

##### Kịch bản 2: Thực hiện bonding 
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/bonding-s2.jpg)

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Network/Switch/LABs/Bonding-EtherChannel/results-2-bonding.PNG)

Ta thấy, BW trong kịch bản 2 tăng hơn rõ rệt so với kịch bản 1 không thực hiện bonding

### Linux bridge
![](https://static.thegeekstuff.com/wp-content/uploads/2017/06/brctl-bridge.png)
Khi chúng ta có nhiều interfaces ở servers và các networks ethernets - chúng ta muốn kết hợp chúng thành 1 logical interface duy nhất thì chúng ta có thể sử dụng **brctl** để tạo và control **ethernet bridge**.
+ **brctl add new_bridge** :  Tạo một **ethernet bridge** 
+ **brctl addif bridgeName devices** : Thêm một interface to bridge - lúc này interface như một port của bridge. 
## References
[](https://www.thegeekstuff.com/2017/06/brctl-bridge/)

[](http://csie.nqu.edu.tw/smallko/sdn/mininet-link-aggregate.htm)
