# OSI và TCP/IP

Việc tìm hiểu về 2 mô hình lý thuyết và thực tế là OSI và TCP/IP sẽ giúp chúng ta có cái nhìn cơ bản về cách hệ thống mạng hoạt động và từ đó có thể áp dụng 2 mô hình này để xử lý khi gặp lỗi. Cùng với đó so sánh để thấy được sự khá tương đồng giữa 2 mô hình mạng này

![OSI%20TCP%20IP/Untitled.png](OSI%20TCP%20IP/Untitled.png)

## 1. Mô hình OSI ( Open System Interconnection )

Đây là 1 mô hình hệ thống mạng mang tính lý thuyết cao. Tuy không có tính áp dụng thực tế cao nhưng bù lại đó là khả năng phân tích kĩ, phân tách nhiệm vụ của từng tiến trình từ đó giúp người học sẽ hiểu hơn về quá trình các gói tin được tạo ra và hợp lại như thế nào trong hệ thống mạng. 

⇒ Cung cấp cái nhìn cơ bản về hệ thống mạng hiện nay 

![OSI%20TCP%20IP/Untitled%201.png](OSI%20TCP%20IP/Untitled%201.png)

Sau đây chúng ta sẽ đi qua các chức năng của các lớp, việc phân tích sẽ được thực hiện từ lớp trên cùng xuống dưới ( Giả sử trong trường hợp chúng ta gửi gói tin đi . Với bên thu quá trình này sẽ là ngược lại ) :

### 7. Application ( Lớp ứng dụng )

![OSI%20TCP%20IP/Untitled%202.png](OSI%20TCP%20IP/Untitled%202.png)

Đây là lớp hoạt động gần với người sử dụng nhất. Một số ứng dụng như Web hoặc Mail dựa trên lớp ứng dụng này để giao tiếp dữ liệu. Không nên nhầm lẫn ứng dụng của người sử dụng không thuộc vào lớp này → Nó chỉ có nhiệm vụ thực hiện các giao thức và điều khiển dữ liệu để chương trình thể hiện dữ liệu với người dùng.

### 6. Presentation ( Lớp trình diễn )

![OSI%20TCP%20IP/Untitled%203.png](OSI%20TCP%20IP/Untitled%203.png)

Nhiệm vụ chính của lớp này là việc " phiên dịch " dữ liệu từ lớp ứng dụng xuống. Lớp này có thể thực hiện " phiên dịch " lại dữ liệu, mã hóa và  nén dữ liệu lại.

Đôi khi trong hệ thống, sẽ có trường hợp 2 máy tính sẽ sử dụng 2 cách thức mã hóa khác nhau 

→ Lớp trình diễn đảm bảo dữ liệu để lớp ứng dụng bên thu có thể đọc được 

Cùng với đó, đôi khi có 1 số giao thức như HTTPS sẽ yêu cầu thông tin được mã hóa trước khi truyền đi → Lớp 6 sẽ là lớp thực hiện nhiệm vụ mã hóa nếu cần

Cuối cùng, Lớp trình diễn sẽ thực hiện việc nén dữ liệu trước khi chuyển xuống lớp dưới 

→ Cải thiện tốc độ và hiệu năng

### 5. Session ( Lớp phiên )

![OSI%20TCP%20IP/Untitled%204.png](OSI%20TCP%20IP/Untitled%204.png)

Trong hệ thống Internet toàn cầu, việc một Server có thể nhận được hàng trăm thậm chí hàng nghìn kết nối là hoàn toàn có thể. Lớp phiên sẽ đảm bảo rằng mỗi dữ liệu truyền đi sẽ có 1 phiên phân biệt với các người dùng khác và sẽ thống báo lúc mở đầu và kết thúc của 1 phiên. Bạn có thể hiểu tại giai đoạn này dữ liệu sẽ được đánh dấu ( tag ) trước khi chuyển xuoogs

### 4. Transport ( Lớp vận chuyển )

![OSI%20TCP%20IP/Untitled%205.png](OSI%20TCP%20IP/Untitled%205.png)

Hai giao thức vô cùng nổi tiếng trên lớp này đó chính là TCP và UDP. Tuy còn rất nhiều các giao thức khác nhưng cơ bản đều xây dựng trên 2 giao thức này. Lớp này sẽ làm việc chủ yếu với các port và sẽ chia nhỏ dữ liệu thành các phần gọi là segment. Lớp này tại bên phía thu sẽ có nhiệm vụ lắp ghép các phần segment hoàn chỉnh ( theo thứ tự ( sequence ) ) trước khi chuyển lên lớp trên.

Tại lớp này có 2 cơ chế là : Kiểm soát luồng và Kiểm soát lỗi . 

1. Kiểm soát luồng : Thực hiện cơ chế đồng bộ tốc độ truyền dữ liệu trước khi truyền → Đảm bảo tốc độ thu nhận giữa 2 bên 
2. Kiểm soát lỗi : Thực hiện cơ chế yêu cầu truyền lại nếu phần dữ liệu thu được bị mất hoặc bị lỗi

### 3.  Network ( Lớp mạng )

![OSI%20TCP%20IP/Untitled%206.png](OSI%20TCP%20IP/Untitled%206.png)

Tại đây, thứ quan trọng nhất đó là địa chỉ IP của bên đích và nguồn → đảm bảo việc truyền dúng dữ liệu đúng địa chỉ. Tiếp đó, các segment lại được chia nhỏ làm các các packet và được gán địa chỉ IP đích/nguồn để truyền đi. Lớp mạng cũng sẽ tìm đường đi tối ưu thông qua các thuật toán khác nhau ( OSPF , EGIRG , BGP , ... ) 

### 2. Data Link ( Lớp liên kết dữ liệu )

![OSI%20TCP%20IP/Untitled%207.png](OSI%20TCP%20IP/Untitled%207.png)

Lớp này hoạt động tương đối giống với lớp mạng. Tuy nhiên, nó không làm việc với địa chỉ IP, mà làm việc với địa chỉ vật lý hay còn được gọi là MAC Address ( Mỗi máy tính sẽ có 1 địa chỉ này và không bị nhầm lẫn ) . 

→ Vấn đề : Nếu không làm việc với địa chỉ IP thì làm sao lớp này có thể truyền dữ liệu đúng địa chỉ 

⇒ Giải pháp đó chính là ARP ( Address Resolution Control ) 

### 1. Physical ( Lớp vật lý )

![OSI%20TCP%20IP/Untitled%208.png](OSI%20TCP%20IP/Untitled%208.png)

Các dữ liệu ở lớp trên sẽ được chuyển thành các bit 0 - 1 và được truyền trên các phương tiện trung gian như: cáp quang, cáp đồng, sóng radio, ... 

**Vậy là chúng ta đã tìm hiểu được về mô hình OSI cũng như chức năng của các lớp !**

---

## 2. Mô hình TCP/IP

![OSI%20TCP%20IP/Untitled%209.png](OSI%20TCP%20IP/Untitled%209.png)

Trên đây là mô hình tổng quan của TCP/IP, do 2 mô hình có tính tương đồng khá cao nên việc hiểu cách thức hoạt động của TCP/IP sẽ khá đơn giản :

 

### 4. Application ( Lớp ứng dụng )

Đây là lớp bao gồm 3 lớp tại OSI : Application - Presentation - Session. Có nhiệm vụ thực hiện nhận dữ liệu từ người dùng hoặc các ứng dụng để truyền đi. Các giao thức trên lơp này bao gồm: HTTP, HTTPS, SSH, DNS , ... 

### 3. Transport ( Lớp vận chuyển )

Lớp tương ứng với lớp này tại mô hình OSI là lớp 4. Có nhiệm vụ tương đối giống: Cung cấp cơ chế kiểm soát lỗi và truyền điểm - điểm. Hai giao thức thuộc lớp này : TCP ( Tranmisssion Control Protocol ) và UDP ( User Datagram Protocol ). Tùy vào từng trường hợp có thể chọn giao thức phù hợp với nhu cầu. 

### 2. Internet ( Lớp mạng )

Thực hiện làm việc với địa chỉ IP từ đó cung cấp khả năng truyền điểm - điểm trên mạng internet. Các gói tin được chia nhỏ làm các packet và được truyền đi ( Giống với lớp 3 tại mô hình OSI ). Cung cấp khả năng kết nối liên mạng giữa các hệ thống. Các giao thức chính : IP , ICMP , ARP , ...

### 1. Network Access ( Truy cập mạng )

Là sự kết hợp của 2 lớp Data Link và Physical. Chịu trách nhiệm cho việc kết nối và truyền dữ liệu giữa 2 hệ thống, cùng với đó xác lập giao thức truyền. Các giao thức chính : Token ring,PPP, IEEE, ...

**Qua việc phân tích trên, chúng ta đã có được cái nhìn tổng quan về mô hình TCP/IP.**

---

 

### Tại sao mô hình OSI không được áp dụng trong thực tế ?

- Do mô hình này quá lý tưởng hóa về hệ thống mạng

    → Yêu cầu chặt chẽ về mặt cấu trúc

- Có tốc độ không cao, chi phí áp dụng thực tiễn >> chi phí áp dụng với TCP/IP
- Có sự lặp lại về chức năng giữa các lớp
- Các lớp như Session và Presentation có ít chức năng khi áp dụng thực tiễn

---

## Nguồn tham khảo

[The OSI model explained: How to understand (and remember) the 7-layer network model](https://www.networkworld.com/article/3239677/the-osi-model-explained-how-to-understand-and-remember-the-7-layer-network-model.html)

[](https://www.cloudflare.com/learning/ddos/glossary/open-systems-interconnection-model-osi/)

[Layers of OSI Model - GeeksforGeeks](https://www.geeksforgeeks.org/layers-of-osi-model/)

[What is the OSI Model?](https://www.forcepoint.com/cyber-edu/osi-model)

[OSI Model: Layers, Characteristics, Functions - javatpoint](https://www.javatpoint.com/osi-model)

[Introduction to TCP/IP Reference Model | Studytonight](https://www.studytonight.com/computer-networks/tcp-ip-reference-model)

[What is TCP/IP and How Does it Work?](https://searchnetworking.techtarget.com/definition/TCP-IP)

[Computer Network TCP/IP model](https://beginnersbook.com/2019/04/computer-network-tcp-ip-model/)

[TCP/IP Protocol Architecture Model (System Administration Guide: IP Services)](https://docs.oracle.com/cd/E19683-01/806-4075/ipov-10/index.html)

[TCP/IP Protocol Architecture Model (System Administration Guide: IP Services)](https://docs.oracle.com/cd/E19683-01/806-4075/ipov-10/index.html)

[Advantages and Disadvantages of the OSI Model](https://www.tutorialspoint.com/Advantages-and-Disadvantages-of-the-OSI-Model)

[Stop Using the OSI Model](https://rule11.tech/stop-using-osi/)