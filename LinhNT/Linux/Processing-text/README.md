## Processing text
___
Để phục vụ cho việc làm part 1
#### 1. Cut -  Removes sections from each line of files.
> In ra các phần đã được lựa chọn từ mỗi dòng đẩy tới **standard output**. 

**NOTE** : Default ***seperrator*** là 1 **Tab**.


Giả sử, ở đaya t có một file **test.txt** gồm 3 cột :
```
col_1 col_2 col_3   
one two three   
four five six   
seven eight nine   
ten eleven twelve

```

Trong ví dụ dưới đây, **cut** sẽ trả về cột số 2

Tiếp theo, **cut** sẽ trả về cột 1 và 3.
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/cut-return-col.png)

**NOTE**: **cut** có nhiều options khác đi kèm (sử dụng **man cut** để check theem), ở đây ta sẽ thử thêm một vài ví dụ.
+ **-d** -delimiter=D : sử dụng D thay vì Tab
+ **-c** -character=LIST: lựa chọn những characters này.
 
Chúng ta tạo một file **ipAddress.txt** gồm nội dung sau:
```

192.168.1.1/24
```

Hiển thị subnet mask, và địa chỉ network:

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/cut-delimiter.png)


Tiếp tục, chúng ta sẽ tạo mới **fileOne.txt**:
```
0123456789 
ABCDEFGHIJ
```

Sau đây, chúng ta sẽ thực hiện lần lượt **lấy kí tự thứ nhất**, **lấy các kí tự từ 1 đến 3** và **lấy kí tự thứ 5 trở đi đến hết**. Câu lệnh và kết quả được show dưới đây :
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/cut-c-ch.png)

#### 2. Paste - merge lines of files
> Merge và write các dòng tương ứng **sequentially** từ mỗi FILE, được phân cách bởi **Tab** tới **standard output**.

**NOTE** : giải quyết nhược điểm của **>>**, ở đây chúng ta có thể merge 1 cách tuần tự các dòng thuộc các files khác nhau [Xem-thêm](https://www.justpassion.net/tech/programming/bash-shell/lenh-paste-trong-linux.html)

Sau đây, để demo ta sẽ sử dụng 2 file sau : 

**file_one.txt**
```
01 Washington 
02 Sydney 
03 Warsaw 
04 Amsterdam 
05 Berlin

```

**file_two.txt**
```
01 USA 
02 Australia 
03 Poland 
04 Netherlands 
05 Germany

```

Command-lines đã sử dụng và kết quả thu được khi apply **-d**, **-s** và default.
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/paste-commands.png)


Ví dụ bên dưới sẽ lấy input từ **ls** và paste thành 3 cột, với phân cách là "-"
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/paste-multiple-columns.png)


#### Join - join lines of two files on a common field.
![](https://blogd.net/linux/cach-dung-lenh-sort-uniq-paste-join-split/img/lenh-join.png)

> Để kết hợp các file mà không lặp lại dữ liệu với các trường chung.

Ta tiếp tục sử dụng 2 files trong ví dụ về **paste**
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/join-s.png)

Phía trên là một ví dụ đơn giản. Bây giờ chúng ta thử thay đổi 1 chút **file_two.txt** thành :
```
05 Germany 
04 Netherlands 
03 Poland 
02 Australia 
01 USA
```
và ta thu được kết quả : 
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/join-bugs.png)

Chúng ta có thể thấy rằng **05 Germany Berlin** được trả về. `Phần này em nghĩ là khi join file_two.txt vào file_one.txt, thì các dòng của file_one.txt sẽ map với từng dòng của file_two.txt. Nếu tồn tại một dòng thuộc file_one có trường chung với trường thuộc dòng này của file_two.txt nó sẽ trả về kết quả. Và nếu 2 dòng này không thuộc cùng vị trí hàng --> return error.`

**TIP** : trước khi **join** các file, chúng ta cần **sort** để chúng tuân thủ theo một thứ tự chung.


#### Sort – sort lines of text files
> Sắp xếp tất cả các dòng thuộc text files theo thứ tự nhất định. Rồi put đến **standard output**.

Chúng ta sẽ tạo file **sortTest.txt** để demo :
```
1
10
11
12
2
3
Amsterdam
Berlin
Sydney
Warsaw
Washington
```

Đầu tiên, ta thực hiện sắp xếp file và được ouptut : 
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/sortSimple.png)

Chúng ta có thể thấy rằng mới chỉ có các chữ cái được sắp xếp. Để sắp xếp các số ta sử dụng một số options sau :
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/sortOptions.png)

Một số options hữu ích :

```
-d, --dictionary-order, consider only blanks and alphanumeric characters
-f, --ignore-case, fold lower case to upper case characters
-i, --ignore-nonprinting, consider only printable characters
-n, --numeric-sort, compare according to string numerical value
-r, --reverse, reverse the result of comparisons
```

#### uniq
> Dùng để loại bỏ các dòng liene tiếp trùng lặp nhau trong 1 tệp văn bản.

**NOTE** : **uniq** yêu cầu các dòng trùng lặp phải liên tiếp nhau nên chúng ta thường phải sử dụng **sort** trước --> sau đó redirect output tới **uniq**.

Chúng ta sẽ tạo ra 2 files để thực hiện demo :

**uniq1.txt**
```
apple
child
delay
hand
delay
hand
nice
apple
nice
rain
rain
safari
child
safari
```
**uniq2.txt**

```
apple
child
nice
nice
child
apple
delay
apple
delay
hand
apple
hand
nice
```

Đầu tiên, ta thực hiện xóa các mục trùng lặp khỏi nhiều tệp cùng một lúc và đếm số lượng mỗi mục trùng lặp
![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/Processing-text/Images-cut-paste-join-sort/uniq-sort.png)

#### Split 
> **split** dử dụng để chia hoặc tách một tệp thành các phân đoạn có **kích thước bằng nhau** để xem và thao tác dễ dàng hơn và thường được sử dụng với các tệp tương đối lớn.

![](https://blogd.net/linux/cach-dung-lenh-sort-uniq-paste-join-split/img/lenh-split.png)

#### wc - word count
> **wc** thường được sử dụng để tìm kiếm thông tin về số lượng dòng, số lượng từ, byte hoặc số lượng kí tự của 1 file hoặc 1 biến có nội dung.

Chúng ta tạo 1 file **wcTest.txt** để thực hiện demo :
```
Red Hat
CentOS
Fedora
Debian
Scientific Linux
OpenSuse
Ubuntu
Xubuntu
Linux Mint
Pearl Linux
Slackware
Mandriva
```
Đầu tiên, sử dụng cơ bản mà không có parameters đi kèm thì kết quả sẽ hiển thị với 3 cột lần lượt : **số lượng dòng**, **số lượng từ** và **số lượng byte**.

Tiếp theo, ta thực hiện đếm số lượng dòng, số lượng từ, đếm số lượng bytes, kí tự (thường **-c** = **-m**, do 1 kí tự có kích thước 1 byte). Và cuối cùng ta cho hiển thị dòng text có độ dài lớn nhất là bao nhiêu (số lượng bytes).



#### Cat - concatenate
> **cat** sử dụng chủ yếu để hiển thị nội dung của file / tập tin.

###### Tạo file rỗng mới
Chúng ta kết hợp với **stdout** và toán tử **>** để tạo ra một tập tin có nội dung rỗng hăọc là xóa hoàn toàn nội dung đang có trong file.
```
# cat > empty_file.txt
```
Lệnh này tương đương với **touch** trên Linux
```
# touch empty_file.txt
```

![](https://www.tecmint.com/wp-content/uploads/2016/04/Create-New-File-using-Cat-Command.gif)

###### Hiển thị nội dung với `more` hoặc `less`
> Trong trường hợp file nội dung của chúng ta dài đến hàng ngàn, hàng triệu thì thật khó để có thể hiển thị và đọc được nội dung vì **terminal** có giới hạn buffer nhất định. Do đó, chúng ta cần kết hợp sử dụng với **more** hoặc **less**

```
cat test.txt | more
cat test.txt | less
```

###### Hiển thị số dòng của file
```
cat -n FILE

# cat -n /etc/passwd
1 root:x:0:0:root:/root:/bin/bash
2 bin:x:1:1:bin:/bin:/sbin/nologin
3 daemon:x:2:2:daemon:/sbin:/sbin/nologin
4 adm:x:3:4:adm:/var/adm:/sbin/nologin
```

![](https://www.tecmint.com/wp-content/uploads/2016/04/Add-Numbers-to-Lines-in-File.gif)

###### Copy và thêm nội dung của file
Sử dụng **stdout** cùng với **>** hoặc **>>** để copy hoặc thêm nội dung src_file tới dst_file. Và nội dung có trước đó trong dst_file sẽ bị ghi đè (trong trường hợp sử dụng **>**)
```
cat src_file > dst_file
cat src_file >> dst_file
```

#### tac
> **tac** như có tác dụng hiển thị tương tự như **cat** nhưng theo thứ tự ngược lại. 

![](https://www.tecmint.com/wp-content/uploads/2016/04/Print-Content-File-in-Reverse-Order.gif)

> Một trong những parameter quan trọng nhất của **tac** đó là **-s** (phân tách nội dùng của file dựa vào một string hoặc keyword)

![](https://www.tecmint.com/wp-content/uploads/2016/04/Remove-Matching-String-in-File.gif)

#### head và tail
> **head** và **tail** sử dụng để hiển thị 10 dòng đầu hoặc cuối của bất kì file nào tới **stdout**

Để chỉ định số dòng x muốn hiển thị chúng ta có thể sử dụng option **-n**.
```
# tail -n fileName
```
## References
https://emarcel.com/cutpastejoin/

https://blogd.net/linux/cac-vi-du-ve-lenh-sort-tren-linux/

https://www.howtoforge.com/tutorial/linux-join-command/

https://www.tecmint.com/learn-linux-cat-command-and-tac-command/







