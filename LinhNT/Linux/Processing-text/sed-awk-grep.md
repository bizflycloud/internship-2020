## Grep, awk and sed
___
#### 1. grep (global regular expression print)
> **grep** sẽ tìm kiếm và in ra dòng ở trong file ***match*** với **string** cần tìm kiếm.

###### Cách hoạt động

Bắt đầu từ dòng đầu tiên trong file, **grep** sẽ copy dòng đó vào trong buffer. Sau đó, so sánh với **input string** --> Nếu **match**, dòng đó sẽ được in ra ngoài màn hình. Quá trình diễn ra lặp lại cho đến hết dòng trong file.

Để thực hiện demo, ta tạo file **grep.txt** có nội dung :
```
boot
book
booze
machine
boots
bungie
bark
aardvark
broken$tuff
robots
```

Chúng ta sẽ kết hợp **grep** với một số parameters đơn giản :

+ **-n**  : Những dòng được **match** được đính kèm thêm số dòng của nó trong file để có thể quan sát, theo dõi dễ dàng.
+ **-vn** : switch kết quả theo hướng ngược lại với **-n**, những dòng **không match** sẽ được đánh số dòng(tương ứng với vị trí trong file) và in ra màn hình.
+ **-c** : chỉ hiển thị số dòng **match**.
+ **-l** : chỉ hiển thị tên của files mà bên trong nó có các lines match với input. Phù hợp cho việc **tìm kiếm thông qua multiple files**.
+ **-i** : **ignore case**. Khi tìm kiếm xử lí upper case và lower case tương tự như nhau.

![]()


**NOTE** : Để tìm kiếm **a specical character**. Chúng ta cần thêm `\` phía trước kí tự đặc biệt, nếu không trình thông dịch sẽ hiểu nhầm nó là 1 **regexp**

#### 2. awk (A text pattern scanning and processing language)
> **awk** thường được sử dụng cho việc tìm kiếm và xử kí text. Nó tìm kiếm 1 hoặc nhiều files để kiểm tra xem có dòng nào **match** với các **pattern** hay không. Sau đó, nó thực hiện những **action** tương ứng.

**Một số đặc điểm**

+ **awk** xem 1 file text như một bảng dữ liệu bao gồm các records và các fields.
+ Tương tự nnư các ngôn ngữ lập trình phổ biến, **awk** cũng có các khái niệm như var, conditions, loops.
+ Cũng có những toán tử số học và toán tử thao tác chuỗi.

**Cú pháp**
```
awk '/search pattern 1/ {Actions}
     /search pattern2/ {Actions}' file
```

**Cách hoạt động**

+ **awk** đọc từng đọc và xử lí từng dòng với input file.
+ Với từng dòng, nó so sánh với **pattern**. Nếu **match**, **action** tương ứng sẽ được thực hiện and vice versa.
+  Trong câu lệnh trên, either **pattern** or **action** là các optionals. Nhưng không được thiếu cả 2.
+  Nếu **pattern** không được đưa thì **action** được thực hiện lần lượt với các dòng trong file.
+  Còn nếu, **action** không được đưa ra thì các dòng **match** với **pattern** sẽ được in ra màn hình.


**NOTE** : 

+ Mỗi capwj **patterns và actions** tương ứng của nó được phân cách nhau **by newline**.
+ Mỗi câu lệnh trong **action** nên được phân cách bởi `;`

Sau đây, chúng ta sẽ tạo file **employee.txt** để thực hiện một số demo : 
```
100  Thomas  Manager    Sales       $5,000
200  Jason   Developer  Technology  $5,500
300  Sanjay  Sysadmin   Technology  $7,000
400  Nisha   Manager    Marketing   $9,500
500  Randy   DBA        Technology  $6,000
```

Trong hình dưới đây, chúng ta thực hiện lần lượt **default behavior**, in ra từng dòng matches với patttern và chỉ in ra những fields nhất định

![]()

Trong đó :
+ Giả sử, trong 1 line có 4 từ thì **awk** sẽ phân chia nó bởi dấu cách và chứa trong các biến **$n** (n = 1, 2,...). Chú ý, **$0** đại diện cho toàn bộ dòng.
+ **NF** là một biến **built-in**, đại đienẹ cho tổng số fields trong một record. Như trong ví dụ trên, NF = 5


###### Initialization và final action
> **awk** có hai patterns quan trọng được chỉ định bởi các keywords **BEGIN** và **END**.

```
Syntax: 

BEGIN { Actions}
{ACTION} # Action for everyline in a file
END { Actions }

# is for comments in Awk
```

+ **actions** được chỉ định trong **BEGIN** sẽ được ***chạy trước*** khi bắt đầu đọc các dòng trong file.
+ **actions** được chỉ định trong **END** sẽ được ***chạy sau*** khi hoàn thành việc đọc và xử lí các dòng của file.

![]()

Tiếp theo, chúng ta sẽ thực hiện thêm một số ví dụ: liệt kê những nhân viên có id > 200, những người thuộc phòng ban **Technology**, và đếm số người thuộc phòng ban Technology.

![]()

**NOTE**
+ `~` operator là để sử dụng cho việc so sánh giữa một field cùng với regexp. Nếu kết quả khớp, dòng dữ liệu sẽ được in ra màn hình.

#### seq
> **seq** cho phép in một chuỗi các số. Nhược điểm, **seq** chỉ dùng để in số, không in được các kí tự và không in được chiều ngược lại.

**Chúng ta có một số ví dụ :**

In dãy số liền kề từ 1 đến 3
```
# seq 1 3
1
2
3
```

In các số cách nhau 2 đơn vị
```
# seq 0 2 6
0 
2
4
6
```

**NOTE** : Một cấu trúc khác cũng rất thuận lợi đó là sử dụng cấu trúc `{..}`.
+ Đây là cấu trúc thực thi chứ không phải là một câu lệnh.
+ In được cả số, chữ hoa và thường
+ Cho phép in ngược chiều
+ Hạn chế : không in cách số được.

Sau đây, chúng ta sẽ xem một số ví dụ : 

In các số từ 1 đến 3 và vice versa ( tương tự với chữ cái )
```
# echo {1..3}
1
2
3
```

```
# echo {3..1}
3
2
1
```

Dùng với vòng for hoặc tạo folders hoặc files
```
# for i in {1..10}; do echo $i; done
```

```
# mkdir -p test/{1..3}
# Tạo ra thư mục parent là **test** và các thư mục con 1, 2 được tạo bên trong
```

## References
https://www.users.york.ac.uk/~mijp1/teaching/2nd_year_Comp_Lab/guides/grep_awk_sed.pdf

https://www.thegeekstuff.com/2010/01/awk-introduction-tutorial-7-awk-print-examples/

https://cuongquach.com/bash-shell-in-chu-cai-hay-so-lien-ke.html
