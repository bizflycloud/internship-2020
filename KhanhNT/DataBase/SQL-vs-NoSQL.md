# SQL vs NoSQL
## 1. Khác nhau cơ bản
- **SQL** viết tắt của `Structured Query language`.

|Tham số|SQL|NoSQL|
|-------|---|-----|
|Định nghĩa|Cơ sở dữ liệu **quan hệ** | Cơ sở dữ liệu **phân tán** |
|Type| Dựa trên `bảng`| Dựa trên tập hợp các cặp `key-value`,`document`, `graph databases` hoặc `wide-column`|
|Schema|Dữ liệu có `lược đồ `được `xác định trước` | `Lược đồ động` cho dữ liệu phi cấu trúc |
|Khả năng mở rộng| Mở rộng theo `chiều dọc` | Mở rộng theo `chiều ngang`|
|Môi trường| Phù hợp cho môi trường `truy vấn phức tạp` | Phù hợp cho kho lưu trữ `dữ liệu phân cấp `|
| Best choice| Khi cần hỗ trợ môi trường `truy vấn động` | Khi cần mở rộng quy mô `dựa trên nhiều thay đổi` |
| Ngôn ngữ Query| Structured query language| Không có|
| Tầm quan trọng | Hiệu lực dữ liệu là siêu quan trọng | Cần có dữ liệu nhanh hơn dữ liệu chính xác|
| Loại Lưu trữ | High Available Storage (SAN, RAID,...) | Commodity drives storage |
| Mô hình | ACID | BASE|
| Ví dụ | Postgres, MS-SQL| MongoDB, Redis, Cassandra|
| Nhược điểm | Phức tạp để bảo trì và không hiệu quả xử lí dữ liệu lớn | Dữ liệu cấu trúc ít, cơ sở dữ liệu không tin cậy | 
| Kết luận | Dự án yêu cầu dữ liệu rõ ràng xác định quan hệ logic| Dự án yêu cầu dữ liệu không liên quan, khó xác định |

## 2. Database Types
### SQL: 
- __table-based database__
- Cơ sở dữ liệu bảng được lưu thành hàng và cột cố  định.

### NoSQL:
- __Key-value database__: tạo thành các cặp key-value.
- __Document database__: Lưu trong JSON, BSON, XML document.
- __Wide-column database__: Lưu và nhóm các dữ liệu thành cột.
- __Graph database__: Tối ưu để lấy và tìm kiếm các kết nối giữa các phần tử dữ liệu.

![](https://phoenixnap.com/kb/wp-content/uploads/2020/08/database-types.jpg)

## 3. Schema
- `Database schema` là cấu trúc xác định `cách database được xây dựng`. Xác định cách data được `tổ chức` và `mối quan hệ giữa các data`.
- SQL: __Predefined__ 
- NoSQL: __dynamic__

## 4. Data Model (mô hình dữ liệu)
- `Data Model` cho thấy cấu trúc logic của dữ liệu.
- 2 loại :
  + Relational: SQL
  + Nonrelational: NoSQL

## 5. Ability to Scale
- Khả năng mở rộng data mà không mất hiệu suất.
- __SQL__:
  + `Vertical scalable`
  + Dữ liệu nằm trên 1 nút duy nhất, để mở rộng thì cần thêm tài nguyên phần cứng.

- __NoSQL__:
  + `Horizontally scable`
  + Mỗi node chỉ có 1 phần dữ liệu và có thể add thêm node vào hệ thống.

## 6. ACID vs BASE

![](https://phoenixnap.com/kb/wp-content/uploads/2020/08/acid-vs-base.png)

### SQL sử dụng mô hình ACID
- `ACID` là 1 tập hợp các thuộc tính mà 1 `transaction` thao tác với database phải đạt được nhằm bảo vệ tính toàn vẹn, hợp lệ, an toàn, bền vững dữ liệu ở database.
- **`A`tomicity**: khi các chuỗi lần lượt thao tác với database, nếu 1 `transaction` đang xử lí mà bị lỗi ở database thì toàn bộ các `transaction` sẽ bị hủy bỏ và rollback. Nếu thành công thì toàn bộ các `transaction` đều thành công.
- **`C`onsistency**(tính nhất quán): mọi dữ liệu phải đảm bảo tính hợp lệ khi cập nhật vào database. Nếu không hợp lệ thì translation sẽ bị `rollback`
- **`I`solation**(tính cô lập ): mọi thao tác cảu transaction đều phải cô lập.
- **`D`urability**(tính bền bỉ ): Khi 1 transaction update dữ liệu thành công, thì dữ liệu phải được đảm bảo vĩnh viễn. Ngay cả khi database bị crash, lỗi hay restart hệ thống thì dữ liệu database vẫn luôn ở trạng thái thay đổi mới nhất.

### NoSQL sử dụng mô hình BASE

- **`B`ase `A`vailability** (tính sẵn sàng ở mức cơ bản ): Dữ liệu có thể ở trạng thái thay đổi.

- **`S`oft state** (Trạng thái mềm ): Trạng thái cơ sở dữ liệu có thể được thay đổi theo thời gian.

- **`E`ventual consistency**  (Tính nhất quán )

## 7. USE CASES:
### SQL:
- Cần tính nhất quán dữ liệu và toàn vẹn dữ liệu 100% (ACID)
- Lấy dữ liệu 1 cách nhanh chóng
- Khi làm việc với các truy vấn phức tạp.
- Khi CSDL có ít sự thay đổi hoặc tăng lên.

### NoSQL:
- Khi cần dữ liệu thời gian thực.
- Khi dữ liệu không có cấu trúc cụ thể.
- Dữ liệu cần lược đồ linh hoạt 

## Các DB Engine của từng loại 
- SQL:
  + MySQL
  + Oracle 
  + PostgreSQL
  + SQLite

- NoSQL:
  + MongoDB
  + Cassandra
  + Redis

__Docs__

- https://viblo.asia/p/nhung-diem-khac-biet-giua-sql-va-nosql-gGJ59b4rKX2
- https://phoenixnap.com/kb/sql-vs-nosql







