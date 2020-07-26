## Standard IO streams, pipe and redirection
___
#### 1. Pipe
> **Pipe** (kí hiệu: `|`)như tên gọi của nó **cái ống** - để chuyển dòng dữ liệu (data stream) từ output của chương trình này tới input của chương trình khác.

**Ví dụ**
+ Liệt kê file và thư mục chứa từ **ryu** hoặc **mininet**
![]()

+ Kiểm tra các process **mysql** hoặc **python** có đang chạy hay không.
![]()


#### 2. Redirection
> **Redirection** dùng để điều hướng data stream giữa 1 chương trình và 1 file (!= **pipe** là 2 chương trình)

**Các kí hiệu của Redirection**
- `>` : xuất **STDOUT** vào file (**overwrite**)
- `>>` : xuất **STDOUT** vào file (**append**)
- `<` : đọc **STDIN** từ file
- `2>` : xuất **STDERR** vào file

**Ví dụ**
+ Ouput của command **ls -al** được chuyển tiếp vào file **text.txt** (nếu text.txt đã tồn tại, dữ liệu ban đầu có thể bị ghi đè).
![]()

+ Để tránh bị ghi đè dữ liệu, chúng ta có thể dùng **>>** operator

**File text.txt ban đầu** 
![]()

**File text.txt sau khi append dữ liệu**
![]()

+ **cat < text.txt** : lấy dữ liệu từ **text.txt** như là input và hiển thị nội dung.
![]()

Sử dụng theo câu lệnh ở hình phía trên sẽ giúp ta đính kèm file **text.txt** vào email với email subject là **input redirection**
+ **Error re-direction** : trong quá trình chạy shell scripts hoặc command-lines bất kì, chúng ta không muốn những error messages xuất hiện làm ảnh hưởng việc quan sát output.
![]()

Theo hình trên, ta đã thực hiện **find** để tìm kiếm trong thư mục hiện tại **.** cùng các file có tên bắt đầu bằng **my** và sau đó redirect các errors vào **error.log** file. Sau đó, chúng ta sử dụng **cat error.log** để kiểm tra nội dung bên trong.
#### 3. Data stream
> **A data stream** là một **stream of data** , đặc biệt là dữ liệu text, được pass từ 1 file, thiết bị, chương trình tới (chưa xong )

**Các loại data stream**
- **STDIN (0)**: standard input
- **STDOUT (1)**: standard ouput
- **STDERR (2)**: standard error


## References
[](https://www.guru99.com/linux-redirection.html#:~:text=Redirection%20is%20a%20feature%20in,stdout)%20device%20is%20the%20screen.)

[](https://viblo.asia/p/linux-tips-su-dung-piping-redirection-filters-trong-command-line-maGK7LYBZj2)

[Example](https://www.javatpoint.com/linux-input-redirection)

