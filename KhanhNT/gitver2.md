# Branch: 

+ Phân nhánh và ghi lại luồng lịch sử, branch bị phân nhánh sẽ không ảnh hưởng đến các branch khác

+ Có thể tiến hành nhiều thay đổi đồng thời trong cùng 1 repo

### Branch tích hợp (Integration branch)

+ Thường là branch master

#### Branch chủ đề (Topic branch)

+ Khi tiến hành cùng lúc những công viêc liên quan đến nhiều topic thì các branch topic được tạo ra

### Chuyển đổi Branch:

+ Chuyển đổi branch ta dùng checkout

Nội dung của lần commit cuối cùng trong branch chuyển đến sẽ được mở trong work tree

Commit tiến hành sau khi checkout thì sẽ được thêm vào branch sau khi chuyển đến

git checkout <ten branch>

### Head:
+ Tên hiển thị phần đầu của branch đang sử dụng hiện tại. Default là hiển thị phần đầu branch master

+ Di chuyển HEAD thì branch đang sử dụng cũng thay đổi

### Stash:

+ Khi file có thêm hay nd thay đổi vẫn chưa commit vẫn còn lưu lại Index và Work free mà thực hiện 
checkout đến branch khác thì nội dung đó sẽ di chuyển từ branch đầu đến branch chuyển đến

+ Stash là khi vực ghi lại tạm thời nội dung thay đổi của file. Những thay đổi trong commit vẫn có thể lưu lại tạm thời

### Fetching:

+ Tiến hành lấy lịch sử mới nhất của remote repo cập nhật branch phía dưới của máy local

+ commit đã lấy sẽ được đưa vào như nhánh không tên. Branch checkout bằng FETCH_HEAD

+ Không cập nhật dữ liệu của working. Bất cứ thay đổi trên remote server không ảnh hưởng đến tập tin, thư mục local.

### Commit:

- Chỉnh sửa commit trước đó: 
 commit --amend

- Hủy bỏ commit trước đó: git revert
quay tro lai commit vua moi tao

- Loại bo commit: reset
