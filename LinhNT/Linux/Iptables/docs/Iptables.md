# Iptables và Netfilter Achitecture
___
## Mục lục
- [1.Concept](#1)
- [2.Netfilter hooks](#2)
- [3.Cơ chế và thành phần iptables](#3)
	- [3.1.Table](#3.1)
	- [3.2.Chain](#3.2)
	- [3.3. Target](#3.3)
- [4.Demo](#4)
	- [4.1.Đầu tiên, chúng ta thực hiện block outgoing tracffic tới domain bizflycloud.vn](#4.1)
    - [4.2.Tiếp theo, chúng ta sẽ thực hiện block các traffic đi qua port 443 (https) đến máy chủ](#4.2)
- [References](#References)

<a name="1"></a>
#### 1.Concept
> **iptables** là một ứng dụng firewall, miễn phí và có sẵn trên Linux.

> **iptables** chịu trách nhiệm giao tiếp với người dùng, rồi sau đó tương tác cùng với **packet filtering hooks**. **Kernel hooks** này được biết đến như là **netfilter framework**. 

![](https://blog.landhb.dev/static/img/trigger/design.c143882e3e84.PNG)

> **Netfilter** tiến hành xử lí các packets ở **IP layer**, và làm việc trực tiếp trong **kernel**, nhanh và không làm giảm tốc độ của hệ thống

> Các **kernel modules** được liên kết cùng với **iptables** để đăng kí ở các **hooks** theo thứ tự.
![](https://xerocrypt.files.wordpress.com/2013/08/iptables-and-netfilter.png)

<a name="2"></a>
#### 2.Netfilter hooks
Có 5 **netfileter hooks** và các packets sẽ **trigger** các hooks này dựa vào các yếu tố như : các packets là **incoming** hay **outgoing**,...
![](https://news.cloud365.vn/wp-content/uploads/2019/08/hook-and-chain.png) 

+ **NF_IP_PRE_ROUTING** : hook này được **trigger** bởi bất kì **incoming trafic** đến.  Và hook được xử lí trước khi có bất kì quyết định routing nào liên quan đến việc gửi packets.
+ **NF_IP_LOCAL_IN** : hook này được **trigger** sau khi **1 incoming packet** đã được định tuyến nếu packet này được dành riêng cho local.
+ **NF_IP_FORWARD** : hook này được **trigger** sau khi **1 incoming packet** đã được định tuyến nếu packety này được **forward** tới một host khác.
+ **NF_IP_LOCAL_OUT** : hook này được **trigger** bởi bất kì **outbound traffice** ngay khi nó vừa tới network stack.
+ **NF_IP_POST_ROUTING** : hook này được **trigger** bởi các **outgoing** hoặc **forwared** traffic ngay sau khi được định tuyến và truwocs khi đi đến dây.

**NOTE** 

**Kernel modules**  muốn **register** tới các hooks này cần phải cùng cấp 1 **priority number** để giúp xác định trình tự gọi khi hooks được trigger. Điều này giúp ích khi có multiple modules được kết nối tới các hooks. Lúc này, mỗi module sẽ được gọi theo thứ tự và lần lượt trả về các **decisions** tới **netfilter** sau khi được xử lí xong.

<a name="3"></a>
#### 3.Cơ chế và thành phần iptables
Cơ chế **filtering packets** được xây dựng dựa trên 3 thành phần cơ bản đó là : `table`, `chain`và `target`.

![](https://static.thegeekstuff.com/wp-content/uploads/2011/01/iptables-table-chain-rule-structure.png)

<a name="3.1"></a>
###### 3.1.Table
> **iptables** sử dụng `table` để define các ***rules*** cho các packets. Hiện nay chúng ta có 1 số loại table khác nhau: 

+ **filter table** : table này quyết định xem gói tin có được chuyển đến source address hay deny các packets đó. Table này được sử dụng phổ biến nhất.
+ **mangle table** : table này có khả năng chỉnh sửa phần overhead của gói tin như TTL, MTU, ToS,..
+ **nat table** : table này cho phép định tuyến các packets tới các hosts trên NAT networks băng cách thay đổi src và dst addresses của các packets.
+ **raw table** : 1 gói tin có thể thuộc một kết nối mới hoặc một kết nối đã tồn tại từ trước đó. Table này cho phép làm việc với packet trước khi kernel kiểm tra trạng thái packet.

<a name="3.2"></a>
###### 3.2.Chain
> Trong mỗi **table** của iptables, các **rules** được tổ chức thêm trong các **chain** riêng biệt. **Chains** cho phép lọc gói tin tại các thời điểm khác nhau (arrive or leave,... ) 

![](https://techvccloud.mediacdn.vn/2018/1/Done-0108-Iptables-ph%E1%BA%A7n-1-Google-Docs.png)

+ **PREROUTING chain** : các ***rules*** được apply khi packets vừa đến network interface. This chain có thể thuộc **nat**, **mangle** hoặc **raw** table.
+ **INPUT chain** : **rules** được apply tới packets khi packets trước khi được đưa tới **local process**. This chain có thể thuộc **filter** hoặc **mangle** table.
+ **OUTPUT chain** : **rules** được apply tới các packets khi chúng được xử lí bởi **local process**. This chain có thể thuộc **filter**, **raw**, **nat** hoặc **mangle** table.
+ **FORWARD chain** : **rules** được apply tới bất khi packets nào được routed thông qua **curent host**. This chain có thể thuộc **filter** và **mangle** tables.
+ **POSTROUTING chain** : **rules** được apply tới các packets khi chúng vừa rời khỏi net interface. This chain này thuộc **nat** hoặc **mangle** tables.

<a name="3.3"></a>
###### 3.3.Target
> **target** là các hành động (**rules**) áp dụng cho các packets. 

**Phân loaij**

\- **terminating** : Khi 1 packet được matched, `target` sẽ apply quyết định ngay lập tức. Nghĩa là lúc này, gói tin sẽ không match với bất kì rules nào khác nữa
+ **ACCEPT** : Chấp nhận gói tin, cho các gói tin đi vào hệ thống.
+ **DROP** : loại bỏ gói tin, không phản hồi gói tin.
+ **REJECT** : **iptables** reject các gói tin đó. Nó gửi **connection reset** packet với TCP, hoặc **destination host unreachable** packet với UDP và ICMP.

\- **non-terminating** : Khi gói tin đã match 1 rules nhưng vẫn tiếp tục được apply tiếp với các rules khác.
<a name="4"></a>
#### 4.Demo
Chúng ta sẽ thực hiện demo cùng với **filter table**. **Filter table** này có bộ 3 **chains** cần chú ý : 
+ **INPUT** : controls các packets tới máy chủ. Chúng ta có thể chặn hoặc cho phép kết nối dựa trên **port**, **protocols** hoặc **src ip**.
+ **FORWARD** : sử dụng để filter các packets tới máy chủ và các packets đó sẽ được forward đi nơi khác.
+ **OUTPUT** : được sử dụng để filter các packets đi ra máy chủ.

![](https://www.hostinger.com/tutorials/wp-content/uploads/sites/2/2017/06/iptabes-tutorial-input-forward-output.jpg?x46510)

<a name="4.1"></a>
###### 4.1.Đầu tiên, chúng ta thực hiện block outgoing tracffic tới domain bizflycloud.vn

![](https://github.com/linhnt31/internship-2020/raw/linhnt-baocao-t1/LinhNT/Linux/Iptables/Images/block-outgoing-traffic.png)

Trong đó : 
+ **-A OUTPUT** :  add các rules tới chain **OUTPUT** 
+ **-d** : destination. Tham số được chỉ định có thể là **Network name**, **host name**, **địa chỉ mạng cùng /mask**, hoặc một **plain IP address**.
+ **-s** : source. Việc chỉ định tham số tương tự như cách thực hiện thêm tham số của **-d**
+ **-j DROP** : target sẽ thực hiện khi packets được match với rule. Ở đây, loại bỏ và không phản hồi gói tin đi ra khỏi máy và đi tới bizflycloud.vn có ip là 123.31.11.119

Lúc này, chúng ta không thể truy cập vào trang web trên. Để có thể truy cập lại, chúng ra chỉ cần xóa rule đã được thêm vào trước đó trong chain **OUTPUT**.

```
# sudo iptables -L --line-number // Liệt kê các chains và rules trong nó, cùng với số thứ tự đi kèm

# sudo iptables -D OUTPUT pos_of_rule // Xóa rule khỏi chain là ta có thể truy cập lại bình thường.
```

<a name="4.2"></a>
###### 4.2.Tiếp theo, chúng ta sẽ thực hiện block các traffic đi qua port 443 (https) đến máy chủ

![](https://github.com/linhnt31/internship-2020/raw/linhnt-baocao-t1/LinhNT/Linux/Iptables/Images/block-port.png)


## References
+ [Deep-dive Iptables](https://www.booleanworld.com/depth-guide-iptables-linux-firewall/)

+ https://www.cyberciti.biz/faq/iptables-block-port/

+ https://www.digitalocean.com/community/tutorials/a-deep-dive-into-iptables-and-netfilter-architecture


+ https://www.frozentux.net/iptables-tutorial/iptables-tutorial.html

