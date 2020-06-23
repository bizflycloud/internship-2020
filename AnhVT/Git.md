# Cơ bản về Git


## Git là gì và dùng để làm gì ?

- Git là một phẩn mềm kiểm soát phiên bản

- Bạn có thể thay đổi, hoàn tác về các giai đoạn trước.

- Có nhiều các trang web khác nhau dựa trên Git như: GitHub, GitLab,...

Vậy chúng ta có thể thấy Git là 1 ứng dụng vô cùng hữu dụng trong việc quản lí dự án hiện nay của các công ty công nghệ . Trong bài viết này mình sẽ hướng dẫn các bạn cách cài đặt và sử dụng git trên hệ điều hành ubuntu 18.04LTS

## 1. Cài đạt Git như thé nào ?

Git cung cấp cho chúng ta nhiều cách để cài đặt nhưng ở bài này mình sẽ hướng dẫn các bài cài đặt git thông qua cửa sổ Terminal quen thuộc.

Đầu tiên, sử dụng các công cụ quản lý gói apt để cập nhật chỉ mục gói nội bộ của bạn. Với bản cập nhật hoàn tất, bạn có thể tải xuống và cài đặt Git:

> sudo apt update

> sudo apt-get install git

Sau khi cài đặt git xong chúng ta  sẽ đến với bước tiếp theo đó chính là config ( tinh chỉnh git)

 > git config --global user.name "user_name"

 > git config --global user.email "email_id"
  
 Với username và email_id là username và email trên github.comm

Tiếp đó chúng ta sẽ đến với bước tạo 1 Repo trong máy

- B1: Truy cập vào https://github.com/new và đặt tên mới cho repo của mình và một vài tùy chỉnh khác mà github có thể đề nghị cho bạn ( public/private, description)
 
- B2: Bật cửa sổ Terminal trên Ubuntu và nhập các lệnh sau

> git init

Nếu thành công sẽ hiển thị trạng thái ví dụ như: Initialized empty Git repository in /home/.git/

Bước này sẽ tạo trên máy tính của chúng ta 1 reposit
 
- Sau đó chúng ta sẽ kiếm tra lại xem trên máy đã có 1 repo hay chưa thông qua lệnh:

>git status

 - Nếu đã thực hiện được bước 1 sẽ có thông báo như sau : On branch master // No commits yet

Vậy là chúng ta đã tạo được repo trên ubuntu đang sử dụng 

## 2. Các lệnh Git cơ bản

 - Lệnh:
 
 `git init`
 
 Như đã biết ở trên thì chúng ta sử dụng lệnh này để tạo 1 repo ở máy đang sử dụng.

- Lệnh: 

`git clone`
 
 Lệnh này sẽ giúp chúng ta copy bất kì repo trên internet về máy tính đang sử dụng 

- Lệnh:

`git pull`

 Lệnh này sẽ giúp chúng ta tải xuống 1 repo tại 1 remote về máy tính của mình và update các thông tin trong repo đó.
 
 -Lệnh:
 
 `git add`
 
 Lệnh này giúp chúng ta lưu thay đổi chúng ta vừa tạo ra vào trạng thái chờ ( stagin arena )
 
- Lệnh:

`git commit`

Câu lệnh này sẽ giúp chúng ta lưu thay đổi tại local repo ( trên máy tính đang sử dụng)

- Lệnh: 

`git push`

Sau khi lưu thay đổi tại local repo thì câu lệnh này sẽ giúp chúng ta tải những thay đổi tại local repo(trên máy tính) lên remote repo(trên internet)

- Lệnh: 

`git log`
 
Trong một vài trường hợp muốn xem log của git thì đây chính là lệnh chúng ta cần sử dụng

## 3. Các bước thực hiện khi upload file lên remote repo

Trong một vài trường hợp sau khi sử dụng lệnh `git pull` hoặc `git clone` để lấy dữ liệu từ trên remote repo xuống máy tính của chúng ta. Sau khi chỉnh sửa xong các file thì đây là các bước giúp các bạn tải các file ( đã có sự thay đổi ) lên remote repo: 

`git add *Filename`

chuyển file sang staging arena

`git push`

Tải lên dữ liệu vào remote repo

`git commit -m "comment` 
- lưu ý việc comment là quan trọng, việc này sẽ giúp chúng ta theo dõi được sự thay đổi của các lần commit

`git status / git log`

Sau khi hoàn thành các bước trên bạn nên kiểm tra lại sự thay đổi bằng `git status` hoặc `git log` ( nơi mà git sẽ thường xuyên update trạng thái của các sự thay đổi )



## 4.Tạo 1 nhánh ( Branch )

Trong rất nhiều trường hợp và cũng như trong thực tế, việc quản lí dự án là vô cùng quan trọng và không thể cho phép ai cũng có thể chỉnh sửa trực tiếp lên nhánh master ( nhánh chính của dự án ). Sau đây là cách chúng ta có thể tự tạo một nhánh để có thể tạo ra một nhánh ( branch ) để test một vài tính năng trước khi đồng nhất ( merge ) vào dự án chính thuộc nhánh master:

`git checkout -b "*name of branch"`

đây là lệnh giúp bạn tạo một nhánh ( branch ) riêng trong remote repo của mình.


## 5.Xóa 1 nhánh
Tại máy tính của mình nếu bạn muốn xóa 1 nhánh thì có thể sử dụng lệnh sau
>Local: 

`git branch -d *branch_name`

- Còn đối với remote repo thì có thể sử dụng lệnh sau để xóa 1 branch:

`git push origin --delete *branch_name`

