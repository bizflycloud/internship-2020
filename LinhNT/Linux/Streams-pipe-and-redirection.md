## Standard IO streams, pipe and redirection
___
#### 1. Pipe
> **Pipe** (kí hiệu: `|`)như tên gọi của nó **cái ống** - để chuyển dòng dữ liệu (data stream) từ output của chương trình này tới input của chương trình khác.

**Ví dụ**
+ Liệt kê file và thư mục chứa từ **ryu** hoặc **mininet**
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Images-streams-pipe-direction/pipe.PNG)

Trong đó :
+ **ls ~** : liệt kê các thư mục, các file trong /home/user

+ Kiểm tra các process **mysql** hoặc **python** có đang chạy hay không.
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Images-streams-pipe-direction/pipe2.PNG)

Trong đó : **ps aux**
+ **a** : in ra tất cả các ***proceses*** từ tất cả các user
+ **u** : in ra cột user hoặc owner trong output
+ **x** : in ra các proceses đã không được chạy từ terminal trước đó.

#### 2. Redirection
> **Redirection** dùng để điều hướng data stream giữa 1 chương trình và 1 file (!= **pipe** là 2 chương trình)

**Các kí hiệu của Redirection**
- `>` : xuất **STDOUT** vào file (**overwrite**)
- `>>` : xuất **STDOUT** vào file (**append**)
- `<` : đọc **STDIN** từ file
- `2>` : xuất **STDERR** vào file

**Ví dụ**
+ Ouput của command **ls -al** được chuyển tiếp vào file **text.txt** (nếu text.txt đã tồn tại, dữ liệu ban đầu có thể bị ghi đè).
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Images-streams-pipe-direction/ghiOutput.PNG)

+ Để tránh bị ghi đè dữ liệu, chúng ta có thể dùng **>>** operator

**File text.txt ban đầu** 

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Images-streams-pipe-direction/originalFile.PNG)

**File text.txt sau khi append dữ liệu**

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Images-streams-pipe-direction/afterAppendingFile.PNG)

+ **cat < text.txt** : lấy dữ liệu từ **text.txt** như là input và hiển thị nội dung.
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Images-streams-pipe-direction/stdinFile.PNG)

Sử dụng theo câu lệnh ở hình phía trên sẽ giúp ta đính kèm file **text.txt** vào email với email subject là **input redirection**
+ **Error re-direction** : trong quá trình chạy shell scripts hoặc command-lines bất kì, chúng ta không muốn những error messages xuất hiện làm ảnh hưởng việc quan sát output.
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Images-streams-pipe-direction/stderr.PNG)

Theo hình trên, ta đã thực hiện **find** để tìm kiếm trong thư mục hiện tại **.** cùng các file có tên bắt đầu bằng **my** và sau đó redirect các errors vào **error.log** file. Sau đó, chúng ta sử dụng **cat error.log** để kiểm tra nội dung bên trong.

#### 3. File (FD)
Trong Linux/Unix, các file thông thường, thư mục hay thậm chí là các devices cũng là file. Mỗi file được chỉ định một số được gọi là **File descriptor (FD)**.
Ví dụ : Màn hình của chúng ta cũng có 1 FD, khi một chương trình được chạy thì output của nó gửi tới FD của màn hình. Do đó, output của chương trình sẽ hiển thị trên màn hình của chúng ta.


**Các loại data stream**
- **STDIN (0)**: standard input
- **STDOUT (1)**: standard ouput
- **STDERR (2)**: standard error

#### 4. Error redirection
> Bất cứ khi nào chúng ta chạy 1 chương trình/command trên terminal, 3 files **standard input**, **standard output**, **standard error** luôn luôn được mở.

![](https://www.guru99.com/images/Streams.png)

Mặc định, **error stream** được hiển thị trên màn hình. **Error redirection** chuyển các errors tới 1 file hơn là tới màn hình (Ví dụ khi khởi chạy shell scripts,chúng ta không muốn các error messages hiển thị lên màn hình và ảnh hưởng đến output đầu ra của chúng ta).

#### Filters
> **Filters** trong command-line có chức năng nhận đầu vào dữ liệu (STDIN), xử lí và xuất kết quả đầu ra (STDOUT)

|Tên |Chức năng|
|---|---|
|head | In ra n dòng đầu tiên |
|tail |In ra n dòng dữ liệu từ dưới lên|
|sort |Sắp xếp dữ liệu |
|nl | Hiển thị dòng dữ liệu kèm số thứ tự của dòng | 
| cut| Cắt dữ liệu | 
| sed | Tìm kiếm và thay thế dữ liệu | 
| uniq| Bỏ dòng trùng lặp (các dòng này phải kề nhau) |
| tac | Hiển thị dữ liệu từ dưới lên, ngược lại so với cat|


## References
[Linux-redirection](https://www.guru99.com/linux-redirection.html#:~:text=Redirection%20is%20a%20feature%20in,stdout)%20device%20is%20the%20screen.)

[Filters](https://viblo.asia/p/linux-tips-su-dung-piping-redirection-filters-trong-command-line-maGK7LYBZj2)

[Example](https://www.javatpoint.com/linux-input-redirection)

