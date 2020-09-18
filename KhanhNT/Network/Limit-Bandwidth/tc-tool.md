# Limit bandwidth Linux
## 1. Giới thiệu về TC
- **TC** là công cụ quản lí băng thông trên nền tảng Linux.
- Trên mỗi thiết bị có cơ chế hàng đợi, `cơ chế hàng đợi` quyết định `cách xử lí gói tin`. Nó sử dụng `bộ lọc` để `phân các gói tin vào các lớp`, các `gói tin trong 1 lớp có thể được phân vào các lớp nhỏ hơn` là con của lớp này. Các gói tin trong `1 lớp` được `xử lí như nhau`, các gói tin `khác lớp` được `xử lí khác nhau` tùy vào mức độ `ưu tiên`.  

## 2. Thành phần TC
### 2.1 Qdiscs: 
- Cơ chế hàng đợi quyết định cách xử lí, điều khiển gói tin.
- Các cơ chế được hỗ trợ trong Linux
  + Class Based Quêu (CBQ)
  + Token Bucket Flow (TBF)
  + First in First out (FIFO)
  + Asynchronous Transfer Mode (ATM)
  + Random Early Detection (RED)
  + Generalized RED (GRED)
  + DiffServ Marked (DS_MARK)

### 2.2 Filter
- Dùng cơ chế hàng đợi để gán các gói tin tới được lớp của nó. 
- Bộ lọc sử dụng các tinh năng khác nhau của gói tin như địa chỉ nguồn, địa chỉ đích, port và byte ToS trong phần đầu của IP Header để phân lớp.

### 2.3 Class
- Dùng cơ chế hàng đợi để lưu trữ gói tin, mỗi loại gói tin sau khi được `filter` sẽ được phân vào 1 `class` được định nghĩa trước.
- Mỗi `Class` có 1 hàng đợi và xử lí riêng, 1 hàng đợi có thể được chia sẻ cho nhiều lớp.
- Có 2 dạng `class` là `qdiscs classful` và `qdiscs classless`. 
   + `qdiscs classful` cho phép tạo nhiều `qdiscs` trong class.
   + `qdiscs classless` không cho phép tạo nhiều `qdiscs` trong class.


