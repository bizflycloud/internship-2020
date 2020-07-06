# Git
Là tên gọi hệ thống quản lí phiên bản phân tán (Distributed Version Control System)

# Repository (Repo):
Nơi chứa tất cả những thông tin cần thiết để duy trì và quản lí các sửa đổi và lịch sử của toàn bộ project

+ Object Store
+ Index

#### Thư mục trong sự quản lí của git đang đang thực hiện công viêc gọi là working tree.

 Giữa repo và working tree laf index. Index là nơi chuẩn bị cho viêc commit lên repo

- Remote repository: là repo chia sẻ nhiều người bố trí trên server chuyên dụng

- Local repository: là repo bố trí trên máy cá nhân

- Commit: các thao tác ghi lại việc thêm/thay đổi file hay thư mục vào repo gọi là commit

- git add: vào staging để cbi commit lên repo

- git commit -m "": commit lên repo sẵn sàng push lên 

- git clone <đường dẫn muốn clone về>

- git pull: trước khi commit pull về

- git push: push lên github

### Branch là nhánh của repository:

- Các nhánh sẽ độc lập với nhau và phát triển một tính năng hoặc làm 1 nhiệm vụ nào đó, không gây ảnh hưởng đến các nhánh khác.

- Khi các nhánh hợp nhất lại với nhau thì gọi là merge, thông thường, nhánh mặc định là master.

- Branch ở trên local repo thì gọi là local branch.

- Branch ở trên remote repo thì gọi là remote branch.

- Một branch trên local có thể liên kết với 1 hoặc nhiều branch trên remote hoặc không branch nào cả.
