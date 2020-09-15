# So sánh thin và thick provisoning


## 1. Khác nhau trong chiếm tài nguyên lưu trữ:
- Có 3 cách định dạng phân vùng lưu trữ cho VM:
 + __Thin Provisioning__
 + __Thick Provisioned Lazy Zeroe__
 + __Thick Provisioned Eager Zeroed__

![](https://gocit.vn/wp-content/uploads/2018/10/thick-provisioning.png)

## 2. Phân biệt:
- Giả sử ta tạo VM 100GB, thì `thick` sẽ chiếm dụng 100GB của server. Còn `thin` sẽ chỉ chiếm dung lượng mà nó lưu trữ. 

![](https://gocit.vn/wp-content/uploads/2018/10/thin-provisioning.png)

- Hiệu suất: 
  + `Thick Provisioned Eager Zeroed` sẽ chiếm hiệu suất tốt nhất.
  + Tiếp theo là `Thick Provisioned Lazy Zeroe`.
  + Cuối cùng là `Thin Provisioned`.

