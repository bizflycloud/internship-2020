### Shell
___
>  **shell** cung cấp một interface giữa người dùng và OS
![](https://techvccloud.mediacdn.vn/thumb_w/650/2018/11/19/shellscripting-1542594064464172154102.png)
#### Ứng dụng 
Shell cung cấp một môi trường dành cho người dùng để có thể **tùy chỉnh từ các file khởi tạo**
- Tìm các đường dẫn đến các lệnh
- Set quyền mặc định trên các file mới
- Giá trị biến mà các chương trình khác sử dụng

#### Phân loại
###### 1. sh
> Nhỏ gọn + tốc độ nhưng thiếu interactive features (history, xử lí toán học, logic...)
Đường dẫn: **/bin/sh**  và **/sbin/sh**

```python
addition(){
   sum=$(($1+$2))
   return $sum
}
read -p "Enter a number: " int1
read -p "Enter a number: " int2
result=`expr $int1 $int2`
echo "The result is : $result"
```
![](https://upload.wikimedia.org/wikipedia/commons/b/bf/Version_7_UNIX_SIMH_PDP11_Kernels_Shell.png)

###### 2. C shell (csh)
> Có tính năng tương tác: alias, history, tính toán số học,... Không được sử dụng nhiều trong Linux.
Đường dẫn: **/bin/csh**

```python
#!/bin/csh
set i = 2
set j = 1
while ( $j <= 10 )
   echo '2 **' $j = $i
   @ i *= 2
   @ j++
end
````

###### 3. Korn shell (ksh)
> Kế thừa và mở rộng từ **csh** và **sh**. Bao gồm các tình năng lập trình tiện lợi, xử lí chuỗi và nhanh hơn C shell. Chạy được các script viết cho Bourne shell.
Đường dẫn: **/bin/ksh**

```python
integer even=0 odd=0 count
for ((count=0; count < 100; count++))
do    if    ((RANDOM%2==0))
      then  even=even+1
      else  odd=odd+1
      fi
done
print even=$even odd=$odd
```
###### 4. bash
> Tương thích với sh và kết hợp các tính năng hữu ích của **ksh** và **csh**. Có thể **recall lệnh** từ các mũi tên.
Đường dẫn: **/bin/bash**
```python
valid=true
count=1
while [ $valid ]
do
echo $count
if [ $count -eq 5 ];
then
break
fi
((count++))
done
```
### Time 
**time** command in Linux is used to **determine** the **duration of execution of a command or a script**
+ **real time**: the total execution time
+ + **user CPU time**: The CPU time used by your process
+ + **system CPU time** : The CPu time used by the system on behalf of your process
#### References
[Measure-time](
https://geek-university.com/linux/measure-time-of-program-execution/)
### Exercise 1 / Page. 50
1. D
2. B

