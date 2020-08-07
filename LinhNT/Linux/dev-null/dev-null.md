### /dev/null
> Đây là một file đặc biệt hay còn được gọi là **null device** (blackhole) bởi vì nó sẽ **discards** bất cứ cái gì được ghi tới nó và chỉ **return EOF** khi được đọc.

Ví dụ khi chúng ta thử viết một đoạn text nhỏ tới nó cùng với **>**

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/dev-null/Images-dev-null/dev-null.PNG)

Trong đó: 
+ `$?`: là một biến đặc biệt, chứa **exit status** của command trước nó. Nó sẽ bị ghi đè bất cứ khi nào chúng ta chạy 1 command mới. **0** được return chỉ ra rằng câu lệnh trước đó đã được chạy thành công. Những số **lớn hơn** chỉ 1 **error code** 

Như trong phần **data-stream, pipe and redirection** chúng ta đã đề cập, khi chạy một script chúng ta không muốn error làm ảnh hưởng trong quá trình quan sát output. Để làm được điều đó, chúng ta chỉ cần put chúng **/dev/null** 

Chúng ta hãy thử xem 1 ví dụ sau: 

![](https://github.com/linhnt31/internship-2020/blob/linhnt-baocao-t1/LinhNT/Linux/dev-null/Images-dev-null/dev-null-tricks.PNG)

+ `>/dev/null`: redirect tất cả các **standard output** sang **/dev/null**. Nó cũng tương đương với các viết **1>/dev/null**
+ `2>&1` : redirect tất cả các **standard error** tới sang **standard ouput**. Nhưng thời điểm này, **standard ouput** đang trỏ tới **/dev/null** nên **standard ouput** lúc này sẽ redirect sang **/dev/null**.

> Tóm lại, câu lệnh trên sẽ không in ra màn hình tất cả các output hoặc error mà đẩy vào /dev/null.

### References
[Explain-detailly-dev-null](https://blog.cloud365.vn/shell/bash-shel-danh-cho-nguoi-moi-bat-dau-p2/)

[dev-null](https://medium.com/@codenameyau/step-by-step-breakdown-of-dev-null-a0f516f53158)

