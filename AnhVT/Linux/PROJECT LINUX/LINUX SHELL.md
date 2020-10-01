# LINUX SHELL

![LINUX%20SHELL/Untitled.png](LINUX%20SHELL/Untitled.png)

## 1. Giới thiệu cơ bản

Ngày nay có rất nhiều phiên bản OS ( hệ điều hành ) hoạt động dựa trên lõi Kernel, 1 số ví dụ tiêu biểu như: MacOS, Ubuntu, Debian, .... Vậy câu hỏi đặt ra là: khi chúng ta thực thi các câu lệnh thì thực sự điều gì đang diễn ra ở bên trong lõi hệ điều hành.

Câu trả lời đơn giản nhất chính là : Chúng ta đang thực hiện việc trao đổi dữ liệu với Shell để giao tiếp với lõi `Kernel` để thực hiện các nhu cầu của người dùng.

---

## 2. Lõi `Kernel` :

Về cơ bản Kernel là phần hạt nhân của hệ thống được phát triển bởi Linus Torvalds. Nó quản lý các việc sau:

1. Quản lý File
2. Quản lý bộ nhớ
3. Quản lý thiết bị
4. Quản lý vào / ra ( I/O)
5. Quản lý tiến trình

Thông qua các dữ liệu bên trên ta hoàn toàn có thể thấy, lõi `kernel` là 1 thành phần vô cùng quan trọng trong cấu trúc của Linux. Nó chính là " trái tim " của hệ điều hành. Ngoài ra Linux còn bao gồm các thành phần khác như : công cụ và tiện ích GNU, các script quản lý và cài đặt khác nhau.

( script là 1 tập hợp các câu lệnh được gộp lại với nhau nhằm thực hiện 1 mục đích với độ tiện ích cao hơn việc gõ lệnh thủ công)

---

## 3. Shell :

`Shell` tuy không phải là một thành phần nhân của hệ thống tuy nhiên nó lại sử dụng nhân hệ thống để xử lý các yêu cầu khác nhau từ người dùng. `Shell` thu thập dữ liệu từ người dùng thông qua cửa sổ `Terminal` ( Trên Ubuntu ) và dịch dữ liệu đó giúp cho lõi `Kernel` hiểu được và xử lý yêu cầu một cách linh hoạt.  Shell có thể ở hai dạng : Command Line Shell và Graphic Shell.

![LINUX%20SHELL/Untitled%201.png](LINUX%20SHELL/Untitled%201.png)

### 3.1 Shell Prompt :

Ký hiệu `$` hay còn gọi là *command prompt* được cấp bởi `Shell` . Khi có *command prompt* xuất hiện đồng nghĩa với việc bạn có thể giao tiếp với `Shell` thông qua các câu lệnh khác nhau. Mỗi loại Shell sẽ có 1 loại ký hiệu khác nhau chứ không hề giống nhau.

`Shell` sẽ thực hiện đọc lệnh của người dùng sau phím **Enter** .

Ví dụ:

```bash
$ ls -al | grep mysql # 
```

### 3.2 Các loại Shell cơ bản

![LINUX%20SHELL/Untitled%202.png](LINUX%20SHELL/Untitled%202.png)

**Có 2 loại shell phổ biến nhất đó chính là** :

1. Bash Shell ( Bourne Again Shell ):
    - Đây là loại shell được cài đặt mặc định trên hầu hết các hệ thống sử dụng nhân Kernel hiện nay.
    - Nó cung cấp một số ưu điểm sau:
        - Khả năng lưu trữ lịch sử câu lệnh không giới hạn
        - Kiểm soát các Jobs ( các tiến trình )
        - ...
2. Tcsh/Csh Shell 
    - Đây là loại `shell` được phát triển dựa trên ngôn ngữ C
        - Ưu điểm :
            - Cú pháp khá giống với ngôn ngữ C.
            - Command-line Editor
            - Kiểm soát Jobs
            - ...
- Ngoài ra còn 1 số loại `Shell` khác như : KSH, ZSH, Fish, ...

---

## 4. Shell script :

![LINUX%20SHELL/Untitled%203.png](LINUX%20SHELL/Untitled%203.png)

Đôi khi có 1 công việc ( task ) mà người sử dụng cần làm hằng ngày như backup log hay in ra các thông số của hệ thống,... Các task đó thường không chỉ là vài dòng lệnh đơn giản mà là sự kết hợp của rất nhiều câu lệnh khác nhau. Nếu phải thực hiện thủ công mỗi giờ , mỗi ngày thì thực sự vô cùng kém hiệu quả. Giải pháp được đưa ra đó chính là tạo `Shell script` . Ý tưởng cốt lõi đó chính là việc kết hợp các câu lệnh với nhau vào 1 file script. Và khi cần sử dụng, thì ta chỉ cần thực thi script thì vẫn thực hiện được công việc mà tốn ít công sức và thời gian hơn rất nhiều.

Một `Shell script` tốt thì nên bao gồm các dòng comment thông qua `#` . Việc comments có tác dụng về lâu dài nếu sau này cần sử dụng lại hoặc cần hướng dẫn cho người sử dụng mới. 

**Ưu điểm** :

- Tiết kiệm thời gian
- Tiện ích
- Tận dụng tối đa khả năng của `shell`

**Nhược điểm**

- Tốc độ xử lý đôi khi có thể bị ảnh hưởng
- Không phù hợp với các task lớn và phức tạp
- Cung cấp các cấu trúc câu lệnh không phong phú, đa dạng như các ngôn ngữ khác

---

## 5. Các lệnh cơ bản làm việc với Shell :

Trên hệ điều hành Linux, có 1 số các thao tác, lệnh khác nhau mà chúng ta thường hay sử dụng như : cd,mv,cp, ... Ví dụ :

*Để xem thư mục đang làm việc hiện tại: sử dụng lệnh `pwd`*

```bash
$ pwd
$ /home/user/root
```

*Để chuyển thư mục làm việc hiện tại: sử dụng lệnh `cd`* 

```bash
$ pwd
$ /home/user/root
$ cd /home/user/user_test
$ pwd 
$ /home/user/user_test
```

Ngoài ra còn vô số các lệnh khác nhau, trong quá trình sử dụng shell người sử dụng có thể tìm hiểu thêm.

Cùng với đó trên `Shell` còn cung cấp các tổ hợp phím phục vụ các mục đích khau nhau như :

- `Ctrl + R` : Tìm kiếm lệnh đã từng thực thi
- `Ctrl + G` : Thoát chế độ tìm kiếm lệnh quay trở lại Shell
- `Ctrl + S` và `Ctrl + Q` : Thực hiện dừng / tiếp tục input flow.

---

## 6. Shell enviroment:

Mỗi khi người sử dụng giao tiếp với server thông qua 1 `Shell session` , có rất nhiều các mẩu thông tin, các biến khác nhau được `shell` nén lại để quyết định hành vi và giúp nó truy cập vào các nguồn dữ liệu khác nhau. Các biến này được tạo khi người sử dụng đăng nhập vào hệ thống, được tạo mặc định hoặc có thể được người dùng đặt.

Một cách để `shell` có thể giám sát các biến này là đặt nó vào trong một môi trường ( enviroments ). Enviroment chính là một vùng mà `shell` tạo ra mỗi khi có 1 phiên sử dụng để lưu lại các biến. Tuy nhiên có thể các biến này sẽ không giống nhau trong mọi lần đăng nhập.

*Biến môi trường* về mặt kĩ thuật thì khá giống với biến bình thường. Thông thường bạn sẽ không làm việc trực tiếp với các biến môi trường. Điều này chỉ thực sự hữu dụng khi bạn muốn thay dổi 1 vài cấu hình mặc định cung cấp bởi shell. Biến môi trường là các biến được định nghĩa cho phiên đang nhặp `shell` hiện tại và được kế thừa bởi các tiến trình con.

*Biến shell* là các biến tồn tại duy nhất trong phiên mà nó được tạo. Nó thường được sử dụng để giám sát các biến có thời gian tồn tại ngắn

**Cách để xem Enviroments Variables** : `env` hoặc `printenv` 

**Cách để xem Shell Variables** : `set`

Các biến môi trường thường được sử dụng: shell,pwd,user,home,...

Các biến Shell hay được sử dụng: bash_version, bash_versinfo, IFS, ....

---

## Script Tham khảo

Dưới dây cung cấp 1 Shell script có độ phức tạp trung bình để phát hiện các máy đang hoạt động trong LAN và hệ thống OS của máy đó ( đã kèm theo chú thích ) :

[tuananh2508/LinuxVcc](https://github.com/tuananh2508/LinuxVcc/tree/master/Linux/Bash_Script)

Ngoài ra bạn có thể tham khảo vô số các loại script khác nhau tùy vào mục đích sử dụng của Project của bạn !

---

## Tài liệu tham khảo :

[Giới thiệu về Linux Shell và Shell Script](https://viblo.asia/p/gioi-thieu-ve-linux-shell-va-shell-script-aWj53LweK6m)

[Unix / Linux - What is Shells?](https://www.tutorialspoint.com/unix/unix-what-is-shell.htm)

[Learning the shell - Lesson 1: What is the shell?](http://linuxcommand.org/lc3_lts0010.php)

[5 Most Frequently Used Open Source Shells for Linux](https://www.tecmint.com/different-types-of-linux-shells/)

[How To Read and Set Environmental and Shell Variables on a Linux VPS | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-read-and-set-environmental-and-shell-variables-on-a-linux-vps#how-the-environment-and-environmental-variables-work)

[What are environment variables in Bash?](https://opensource.com/article/19/8/what-are-environment-variables)