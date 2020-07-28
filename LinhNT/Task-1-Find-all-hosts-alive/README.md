### Task
Viết 1 file bash input là 1 cidr bất kỳ, yêu cầu tìm ra các host alive trong dải mạng đấy và OS của chúng.
ex: 
~> bash run.sh 192.168.1.0/22
Host 192.168.1.2 alive and using linux
Host 192.168.1.27 alive and using Windows
Done.
Total run in 73 sec

### Cons 
1. Chưa đọc được input bao gồm cả subnet mask
2. Hiện tại chỉ đọc được 2 OSs là: Linux, Window, others : "unknown"
3. Để chạy được dải mạng tương ứng vẫn phải config bằng tay trong **script.sh**.
### Reference
https://www.cyberciti.biz/faq/mapping-lan-with-linux-unix-ping-command/

https://blog.opensistemas.com/how-to-find-alive-hosts-in-our-network/

https://nmap.org/book/osdetect-usage.html

https://www.cyberciti.biz/tips/simple-linux-and-unix-system-monitoring-with-ping-command-and-scripts.html

https://vinasupport.com/cach-su-dung-lenh-grep-trong-linux/

https://www.reddit.com/r/linuxadmin/comments/3olh4k/bash_increment_first_octet_by_1/
