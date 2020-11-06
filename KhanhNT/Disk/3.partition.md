# Partition trong Linux
## 1.Hard drives
- Là thiết bị lưu trữ dữ liệu, ví dụ như trong Linux là `dev/sda`

## 2. Partition
- **Partition** là phân vùng nhỏ (Phân vùng Logic) được chia ra từ `Hard drives` 
- Mỗi `Hard drives` có `4 partition`, trong đó **partition** bao gồm 3 loại là **Primary partition** ,**Extended partition** và **Logical Partition**
- **Primary partition**
  + Phân vùng chính có thể được dùng để boot hệ điều hành
- **Extended partition**
  + Là vùng dữ liệu còn lại khi ta phân chia ra các **Primary partition**
  + **Extended partition** chứa các **Logical Partition** trong đó. Mỗi ổ đĩa chỉ có thể chứa 1 **Extended partition**
  + **Logical partition**: Là các phân vùng nhỏ trong **extended partition**, thường được dùng để chứa dữ liệu.

## 3. MBR và GPT
  - Thông tin về các **Partition** của ỏ cứng sẽ được lưu trữ trên **MBR (Master Boot record)** hoặc **GPT(GUID Partition table)**
  - Đây là 2 chuẩn cấu hình và quản lí các Partition trên ổ cứng
  - Thông tin được lưu trữ trên đây bao gồm vị trí và dung lượng của các **Partition**

### 3.1 MBR (Master Boot Record)
  - `512 byte` đầu tiên của thiết bị lưu trữ
  - Nó chứa hệ thống nạp khởi động và **partition table** của ổ cứng.
  - Hỗ trợ ổ cứng tối đa **2TB**
  - Hỗ trợ tối đa `4 phân vùng/1 ổ đĩa` (3 Primary + 1 Extended)

### 3.2 GPT (GUID Partition table)
  - Là chuẩn mới thay thế cho **MBR**.
  - Kết hợp với **UEFI**-đang thay thế **BIOS** trên nhiều mainboard
  - Hỗ trợ ổ cứng tối đa `1ZB (=1 tỉ TB)`
  - Hỗ trợ tối đã `128 phân vùng/1 ổ đĩa (128 primary)`
  - Chỉ hỗ trợ các máy tính dùng chuẩn **UEFI**

__Docs__
- https://github.com/khanhnt99/thuctapsinh/blob/master/CuongNQ/Basic%20Linux/24_Partition.md