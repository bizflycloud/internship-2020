# Tìm hiểu về tool TCPDUMP
## 1. Giới thiệu
- `TCPdump` là công cụ cung cấp khả năng phân tích mạng. 

## 2. Cách sử dụng
### 2.1 HTTPs traffic
- `tcpdump -nnSX port 443`
```
khanhnt@khanhnt-Inspiron-3521:~$ sudo tcpdump -nnSX port 443
[sudo] password for khanhnt: 
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on wlp2s0, link-type EN10MB (Ethernet), capture size 262144 bytes
21:19:50.632964 IP 192.168.1.28.36988 > 151.101.76.176.443: Flags [.], ack 865203282, win 501, options [nop,nop,TS val 2820733070 ecr 3294092417], length 0
	0x0000:  4500 0034 40ad 4000 4006 543d c0a8 011c  E..4@.@.@.T=....
	0x0010:  9765 4cb0 907c 01bb 366e 13bc 3391 f452  .eL..|..6n..3..R
	0x0020:  8010 01f5 891f 0000 0101 080a a820 f88e  ................
	0x0030:  c457 dc81                                .W..
21:19:50.633035 IP6 2402:800:61ca:aff1:dc9:aefe:375b:e948.51694 > 2606:4700::6810:457d.443: Flags [.], ack 1736253261, win 2789, length 0
	0x0000:  600b 4c37 0014 0640 2402 0800 61ca aff1  `.L7...@$...a...
	0x0010:  0dc9 aefe 375b e948 2606 4700 0000 0000  ....7[.H&.G.....
	0x0020:  0000 0000 6810 457d c9ee 01bb 4fe8 4e61  ....h.E}....O.Na
	0x0030:  677d 1f4d 5010 0ae5 7e74 0000            g}.MP...~t..
21:19:50.658821 IP6 2606:4700::6810:457d.443 > 2402:800:61ca:aff1:dc9:aefe:375b:e948.51694: Flags [.], ack 1340624482, win 69, length 0
	0x0000:  6002 312d 0014 0639 2606 4700 0000 0000  `.1-...9&.G.....
	0x0010:  0000 0000 6810 457d 2402 0800 61ca aff1  ....h.E}$...a...
	0x0020:  0dc9 aefe 375b e948 01bb c9ee 677d 1f4d  ....7[.H....g}.M
	0x0030:  4fe8 4e62 5010 0045 8913 0000            O.NbP..E....
21:19:50.659649 IP 151.101.76.176.443 > 192.168.1.28.36988: Flags [.], ack 913183677, win 133, options [nop,nop,TS val 3294137472 ecr 2820372683], length 0
```