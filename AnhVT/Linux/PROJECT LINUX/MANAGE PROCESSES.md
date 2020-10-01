# MANAGE PROCESSES

![MANAGE%20PROCESSES/Untitled.png](MANAGE%20PROCESSES/Untitled.png)

Trong quá trình sử dụng Linux, chắc chắn không ít lần chúng ta sẽ gặp trường hợp tiến trình ( process ) bị treo do nhiều lí do khác nhau từ chủ quan đến khách quan. Các hệ điều hành Linux thông thường sẽ cung cấp cho người sử dụng các câu lệnh hữu ích để giám sát, quản lý, điều khiển các tiến trình cả ở foreground lẫn background trên hệ điều hành. Dưới đây chúng ta sẽ tìm hiểu 1 số phương thức đơn giản cũng như hiệu quả nhất.

Trước khi đi đến việc quản lý tiến trình thì chúng ta cần tìm hiểu các loại tiến trình trước

## 1. Daemon trong Linux:

`Daemon` là các ứng dụng chạy nền khi hệ thống khởi động và hoạt động như 1 dịch vụ ( service ) và không bị tắt đi. Chúng thuộc về `systemd` nhưng cũng có thể được điều khiển thông qua 1 số tiến tình `init`

![MANAGE%20PROCESSES/Untitled%201.png](MANAGE%20PROCESSES/Untitled%201.png)

---

## 2. Tiến hành chạy process

Cần lưu ý 1 trình ứng dụng có thể chạy nhiều process khác nhau. Process được chia làm 2 loại đó chính là `Foreground` và `Background` :

1. `Foreground` : Tiến trình được chạy trực tiếp trên màn hình và cần có INPUT
2. `Background` : Tiến trình được chạy nền và thường không cần có INPUT
- Để tiến hành thực thi ứng dụng ở `Foreground` thì người sử dụng có thể kích hoạt ứng dụng ở giao diện GUI hay ở trong Terminal

    ![MANAGE%20PROCESSES/Untitled%202.png](MANAGE%20PROCESSES/Untitled%202.png)

- Để chạy ứng dụng dưới dạng ứng dụng nền ta có thể sử dụng:

    ![MANAGE%20PROCESSES/Untitled%203.png](MANAGE%20PROCESSES/Untitled%203.png)

    Ngoài ra ta có thể sử dụng lệnh `fg` để đưa tiến trình lên `Foreground` :

    ![MANAGE%20PROCESSES/Untitled%204.png](MANAGE%20PROCESSES/Untitled%204.png)

---

Vậy là chúng ta đã có cái nhìn cơ bản về Process. Sau đây chúng ta sẽ đến với phần kiểm soát và quản lý các Process 1 cách hiệu quả.

## 1. Sử dụng lệnh `top` :

Câu lệnh này cho phép chúng ta xem được các tiến trình đang hoạt động ( active process). Nhược điểm của top đó chính là nó không xem được các tiến trình chạy nền :

![MANAGE%20PROCESSES/Untitled%205.png](MANAGE%20PROCESSES/Untitled%205.png)

## 2. Sử dụng lệnh `htop`

Đây là phiên bản cải tiến hơn của `top` cho phép bạn sử dụng các phím mũi tên để điều khiển, cùng với đó có giao diện dễ nhìn hơn. Tuy nhiên `htop` không có sẵn trên các hệ điều hành và cần phải cài đặt thông qua:

```bash
sudo apt-get install htop
```

![MANAGE%20PROCESSES/Untitled%206.png](MANAGE%20PROCESSES/Untitled%206.png)

## 3. Sử dụng lệnh `ps`

Được viết tắt cho 'Process Status' tương đương với 'Task Manager' ở trên window. Cơ bản lệnh này giống với top nhưng hiển thị dữ liệu có sự khác biệt. Lệnh này sẽ liệt kê các tiến trình đang hoạt động ra OUTPUT của cửa sổ Terminal . Cú pháp : `ps - a`

![MANAGE%20PROCESSES/Untitled%207.png](MANAGE%20PROCESSES/Untitled%207.png)

## 4. Sử dụng lệnh `kill`  và `pkill` để tắt tiến trình

![MANAGE%20PROCESSES/Untitled%208.png](MANAGE%20PROCESSES/Untitled%208.png)

Đây là câu lệnh đơn giản nhất để tắt tiến trình trên cửa sổ Terminal. Dưới đây là bảng tín hiệu người sử dụng có thể gửi đến process

![MANAGE%20PROCESSES/Untitled%209.png](MANAGE%20PROCESSES/Untitled%209.png)

Các loại tín hiệu được sử dụng nhiều nhất đó chính là: 9(Ctrl + C ), 2, 3(Ctrl + D ),15,20. Cú pháp của lệnh:

```bash
kill -signal number -processId
#Vi du
kill -9 1354
```

Đối với `pkill` thì cú pháp như sau

```bash
pkill -f -processname
# 1 so option cua pkill co the tham khao qua pkill -l
```

**Vậy là chúng ta đã có nhìn cơ bản về tiến trình cũng như cách để quản lý tiến trình, 1 số mở rộng khác có thể tham khảo trong quá trình sử dụng!**

## Nguồn tham khảo

[All You Need To Know About Processes in Linux [Comprehensive Guide]](https://www.tecmint.com/linux-process-management/)

[How to Manage Processes from the Linux Terminal: 10 Commands You Need to Know](https://www.howtogeek.com/107217/how-to-manage-processes-from-the-linux-terminal-10-commands-you-need-to-know/)

[Linux/Unix Process Management: ps, kill, top, df, free, nice Commands](https://www.guru99.com/managing-processes-in-linux.html)