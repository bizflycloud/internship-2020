# LAB Policy Routing

## 1. Mục đích bài LAB

![](https://i.ibb.co/12M6NFY/Screenshot-from-2020-09-26-11-07-32.png)

- Từ Router-Test ping được tới Linux-Router qua 2 interface khác nhau.
- Vì Linux mặc định chỉ hiểu 1 defaut gateway duy nhất => Giải pháp là route lại đường đi của các subnet này qua các gateway tương ứng bằng các `rule table`.

## 2. Cấu hình
### **B1**: Đặt interface như hình vẽ 

- Linux-Router

![](https://i.ibb.co/M8tVKgP/Screenshot-from-2020-09-26-11-24-08.png)

- ISP1

![](https://i.ibb.co/nrVLKny/Screenshot-from-2020-09-26-11-26-54.png)

- ISP2

![](https://i.ibb.co/yFQTDXk/Screenshot-from-2020-09-26-11-28-40.png)

- Router-Test

![](https://i.ibb.co/yFQTDXk/Screenshot-from-2020-09-26-11-28-40.png)

### B2: Trên ISP1 và ISP2 cấu hình forward gói tin đi qua

![](https://i.ibb.co/cbnm7tq/Screenshot-from-2020-09-26-11-32-21.png)

### B3: Định tuyến cho Router-Test

- `ip route add 203.203.203.0/24 via 203.203.205.3 dev ens3`
- `ip route add 203.203.204.0/24 via 203.203.206.3 dev ens4`

### B4: Định tuyến cho Linux-Router

- `ip route add 203.203.204.0/24 dev ens4 src 203.203.204.2 table ens4`
- `ip route add default via 203.203.204.3 dev ens4 table ens4`

![](https://i.ibb.co/kMWsRnB/Screenshot-from-2020-09-26-12-22-20.png)

- `ip route add from 203.203.204.2/24 table ens4`

- Kiểm tra ping thông cả 2 đường.

![](https://i.ibb.co/S0J7hyk/Screenshot-from-2020-09-26-12-28-17.png)
