#!/usr/bin/env bash

if [ -z $1 ] ; then  # Kiểm tra nếu input rỗng
    echo "Please enter Network Address and Subnet Mask" #Hướng dẫn nhập
    echo "Input form A.B.C.D/E"
    exit 1 
fi #kết thúc trong trường hợp k có input

#Ví dụ : 192.168.10.128/27
base=${1%/*}        # Kết quả nhận được 192.168.10.0
masksize=${1#*/}    #Kết quả nhận được 24
                    # https://devhints.io/bash
[ $masksize -lt 8 ] && { echo "Max range is /8."; exit 1;} 
#Do 8 bit đầu tiên sử dụng làm net-id
#Và do các / như /6 /7 ,... thường sử dụng để làm các mục đích khác như nghiên cứu etc,... 
mask=$(( 0xFFFFFFFF << (32 - $masksize) )) #Đẩy bit 0 vào từ phải sang trái . Mặc định 32 bit 1

IFS=. read a b c d <<< $base # đọc từ base vào các biến a b c d

ip=$(( ($b << 16) + ($c << 8) + $d )) # thực hiện việc đẩy các bit vào . 8 bit 1 lượt

ipstart=$(( $ip & $mask )) #Tiến hành & với mask để tìm ra địa chỉ id bắt đầu. Host ID toàn 0
ipend=$(( ($ipstart | ~$mask ) & 0x7FFFFFFF )) # Khi phần host ID chạy hết là 111111

seq $ipstart $ipend | while read i; do # Vòng lặp  
# Phần bên dưới tiến hành đọc biến a ( do phần net ID không thay đổi nên đọc trực tiếp). 
# Tiến hành so sánh 8 bit sau phần a
# Tiếp tục thực hiện phép so sánh với 8 bit tiếp và tiếp
# Việc này để thực hiện đọc từ nhị phân sang hệ Decimal
# Thực hiện grep ttl từ lệnh ping 1 lần đợi 1s
# lệnh grep -o tiến hành in ra phần match
    ttlstr=$(ping -c1 -w1  $a.$(( ($i & 0xFF0000) >> 16 )).$(( ($i & 0xFF00) >> 8 )).$(( $i & 0x00FF )) | grep -o 'ttl=[0-9][0-9]*') || { 
        #Nếu không tiến hành ping được thì mặc định in ra 
        printf "%s is Offline\n" "$a.$(( ($i & 0xFF0000) >> 16 )).$(( ($i & 0xFF00) >> 8 )).$(( $i & 0x00FF ))"
        continue; 
    }
    #Nếu có thì ... 
    ttl="${ttlstr#*=}"     # lấy giá trị từ bên trên đặt vào biến ttl      
    #in ra kết quả nếu có ttl 
    #thực hiện phép so sánh AND nhị phân với 16 bit >> tiếp theo là 8 bit tiếp và tiếp.
    printf "%s is Online, ttl=%d\n" "$a.$(( ($i & 0xFF0000) >> 16 )).$(( ($i & 0xFF00) >> 8 )).$(( $i & 0x00FF ))" "$ttl"
    if [ $ttl -eq 64 ] # vòng điều kiện
            then
                echo "Operating is Linux"
            elif [ $ttl -eq 128 ]
            then
                echo "Operating is Windows"
            else
                echo "Operating is IOS"
                fi

done
