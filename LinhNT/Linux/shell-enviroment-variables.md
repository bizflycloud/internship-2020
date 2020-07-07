## Understanding shell enviroment variables
___
**Tổng hợp kiến thức về shell trong lần tìm hiểu trước**
+ **Shell** là trình thông dịch của hệ điều hàn, cho phép **người dùng** tương tác trực tiếp cùng hệ điều hành bằng cách gõ từng lệnh ở chế độ dòng lệnh.
+ Shell gồm có 2 loại chính : **$** Bourne shell (sh, ksh, bash, sh) và **%** C shell (csh, tcsh)

#### 1. Shell script
> **Shell script** là tập hợp các câu lệnh được ***thực thi nối tiếp nhau***

```python
#!/bin/bash
Hello="HELLO, "
Hello1=$(printf "%s %s" "$Hello" "$(whoami)" "!")
Day="Today: "
Day1=$(printf "%s %s" "$Day" "$(date)")
echo $Hello1
echo $Day1
```
+ **#!/bin/bash** : thông báo cho hệ thống rằng chuẩn bị có shell chạy bằng dòng lệnh
+ Thiết lập quyền thực thi cho shell **chmod +x 7-7-2020.sh**
!()[]
+ Chạy script: **bash 7-7-2020.sh**, **sh 7-7-2020.sh**, **./7-7-2020.sh**
![]()
**NOTE** 
+ **bash script.sh** : bỏ qua **!#**, vì **bash** được chỉ định như 1 chương trình để chạy **script.sh**
+ **./script.sh** : đọc **!#** để xác định chương trình để chạy script.sh và cần được ** cấp quyền**. 

#### 2. Biến trong shell
**Đặt tên**
+ Tên biến chỉ gồm chữ cái: a-z, A-Z, 0-9, "_"
+ Tên biến không được bắt đầu bằng số
```
Name="LinhNT"
```
**Sử dụng**
```
Name="LinhNT"
echo $Name
```
**Biến read-only**
![]()
**Xóa giá trị của biến**
![]()
**Các loại biến**
+ Biến hệ thống : tạo ra, quản lí bởi hệ thống và được viết hoa.
![]()
+ Biến do người dùng tự định nghĩa: tạo và định nghĩa bởi người dùng.
**Mảng**
Có 2 cách khai báo mảng: 
*Input* 
```
#!/bin/bash
NAME[0]="Zara"
NAME[1]="Qadir"
NAME[2]="Mahnaz"
NAME[3]="Ayan"
NAME[4]="Daisy"
echo "First Index: ${NAME[0]}"
echo "Second Index: ${NAME[1]}"
echo "First Method: ${NAME[*]}"
echo "Second Method: ${NAME[@]}"
```
![]()
hoặc
```
#!/bin/bash
NAME=(a b c d e)
echo "First Index: ${NAME[0]}"
echo "Second Index: ${NAME[1]}"
echo "First Method: ${NAME[*]}"
echo "Second Method: ${NAME[@]}"
```
![]()
+ Để sử dụng một giá trị trong màng: **${array_name[index]}**
+ Để in ra toàn bộ mảng: **{array_name[*]}** hoặc **{array_name[@]}**

**Các phép toán số học**
*Input*
```
!#/bin/bash

a=10
b=3
cong=$(($a + $b))
tru=$(($a - $b))
nhan=$(($a * $b))
chia=$(($a / $b))
layDu=$(($a % $b))

ganGiaTri=$b

echo $cong
echo $tru
echo $nhan
echo $chia
echo $layDu
echo $ganGiaTri
```

**Cấu trúc rẽ nhánh**
*Input* : conditions.sh
```
read -p "Nhap mot so > 20: " n
if [ $n -gt 20 ];
then
        echo "$n lon hon 20"
elif [ $n == 20 ];
then 
        echo "$n bang 20"
else 
        echo "ban nhap so nho hon 20"
fi
```
OR
```
read -p "Nhap mot so > 20: " n
if test $n -gt 20
then
        echo "$n lon hon 20"
else 
        echo "ban nhap so nho hon 20"
fi
```
*Output*

**Cấu trúc lặp**
```
#!/bin/bash
a=0
while [ $a -lt 10 ]
do
        echo $a
        if [ $a -eq 5 ];
        then 
                break
        fi
        a=$((a+1))
        sleep 1
done
```
OR
```
#!/bin/bash
a=0

until [ $a -gt 10 ] 
do
        echo $a
        a=$((a+1))
        sleep 1
done
```

*Output*
![]()

## References
[Shell-script](https://viblo.asia/p/lam-quen-voi-shell-script-ZabG9zYzvzY6#_cau-truc-re-nhanh-14)
[All-about-shell](https://www.tutorialspoint.com/unix/unix-loop-control.htm)



