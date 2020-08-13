# Version Control System
___
## Mục lục
- [1. Concept](#1)
- [2. History and distinguish VCSs](#2)
	- [2.1. Local Version Control System](#2.1)
	- [2.2. Contralized Version Control System](#2.2)
	- [2.3. Distributed Version Control System](#2.3)
- [3. Git](#3)
	- [3.1. Diffirences between git and github](#3.1)
	- [3.2. Git Overview](#3.2)
		- [a. The working tree](#3.2.1)
		- [b. Staging area (index)](#3.2.2)
		- [c. Local repository](#3.2.3)
		- [d. Branching and merging](#3.2.4)
		- [e. Data assurance](#3.2.5)
	- [3.3. Workflow of git](#3.3)
		- [a. Subversion Style](#a)
		- [b. Intergation Manager](#b)
- [4. References](#4)

<a name="1"></a>
### 1. Concept
\- Hệ thống chứ tất cả những thay đổi source code.

\- Hỗ trỡ nhiều người làm việc cùng một thời điểm

\- Theo dõi tiến độ, ai push, modify những thay đổi trong code.

\- Cho phép chuyển đổi code về version cũ hơn, không lo lắng mất code.

<a name="2"></a>
### 2. History and distinguish VCSs
<a name="2.1"></a>
##### 2.1. Local Version Control System 
\- Đầu tiên, local VCS ra đời chứa 1 database đơn giản lưu trữ mọi thay đổi theo các versions. 

![](https://viblo.asia/uploads/611c2af8-2b1b-4070-a7a1-0675b3ef80e1.png)

\- Nhược điểm : vẫn chưa giải quyết được bài toán nhiều người có thể làm việc cùng nhau. Muốn gộp codes cần cop USB, gửi file,... 

<a name="2.2"></a>
##### 2.2. Contralized Version Control System
\- Kế tiếp, Centralized VCS được ra đời như là : CVS, Subversion,..

\- Mô hình này gồm có 1 server và chứa tất cả các files theo từng version kèm theo các guest hosts có thể truy cập và thay đổi trên Central VCS server.

![](https://camo.githubusercontent.com/ff9e44b849b6e73dad3b5c0fdfe774582f551fde/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f313430302f312a47676147637768354c323436596355354e56444135412e706e67)

\- Nhược điểm
+ Nếu Central VCS server gặp sự cố, các thành viên trong team không thể kết nối được với nhau.
+ Nếu hard disk của Central VCS server bị hỏng chưa kịp backup có thể data sẽ bị mất hết.

<a name="2.3"></a>
##### 2.3. Distributed Version Control System
\- Trong DVCS, mỗi thành viên tham gia project đều có 1 local repository (clone). Mỗi người đều có thể tạo các branch, commit code, tại local của mình mà không ảnh hưởng đển Central repository.

![](https://camo.githubusercontent.com/e4ba71ad19e53f5e72eac875fb27d97141fc98ad/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f313430302f312a4345796944755f6d513575394e4930467232705364412e706e67)

<a name="3"></a>
### 3. Git
<a name="3.1"></a>
##### 3.1. Diffirences between git and github
Trước khi tìm hiểu về `git` ta sẽ thực hiện so sánh cùng với `github` bởi vì đây là các khái niệm rất dễ nhầm lẫn.

| Git | Github |
|---|---|
|`git` là một `công cụ` distributed version control - dùng để quản lí lịch sử , hỗ trợ việc phát triển source code của project |`github` là một `platform` |
| `git` là công cụ được install `locally` trên máy tính của chúng ta |`github` là một `online service` - chứa code được đẩy lên từ computer đang running git|

**NOTE** 

![](https://i.stack.imgur.com/ijR3Q.png)

<a name="3.2"></a>
##### 3.2. Git Overview
<a name="3.2.1"></a>
###### a. The working tree
\- Khu vực làm việc và chứa tất cả các file - được biết đến là **untracked area** of git.

\- Khi thực hiện những thay đổi files trong working tree, git sẽ nhận ra nó bị thay đổi nhưng git cũng không save lại nên dữ liệu ở đây không cẩn thận vẫn có thể bị mất.


![](https://miro.medium.com/max/637/1*g-r4SeerMdhPafYQmkesKw.jpeg)

<a name="3.2.2"></a>
###### b. [Staging area (Index)](https://softwareengineering.stackexchange.com/questions/119782/what-does-stage-mean-in-git)

\- `git` bắt đầu **tracking** và **saving** những thay đổi trong files. Và những thay đổi này được thể hiện trong `.git` floder. 

\- Đây là nơi trung gian để **stage** 1 file trước khi thực hiện **commit**.

![](https://miro.medium.com/max/700/1*fww66vqqxnCpsquDucGYOw.png)

\- Mỗi tập tin trong git được quản lí dựa trên 3 trạng thái : **committed**, **modified** và **staged**. 
+ `Staged` : đánh dấu  current version của tập tin vào cở sở dữ liệu
+ `Modified` đã thực hiện thay đổi tập tin nhưng chưa **add** vào staging area cũng như **commit**.
+ `Committed` : Dữ liệu đã được **commit** từ staging area tới local repo - dữ liệu được lưu trữ một cách an toàn

<a name="3.2.3"></a>
###### c. Local repository
\- **Local repo** là những folders, files trong thư mục **.git**

<a name="3.2.4"></a>
###### d. Branching and merging
\- `Repository` : là một kho chứa toàn bộ project bồm gồm : source code, change history của từng file, người thay đổi.
+ **Remote repository** : Kho này là public cho các members trong team.
+ **Local repository** :  Kho này đặt tại local của mỗi cá nhân.

![](https://kevintshoemaker.github.io/StatsChats/GIT1.png)

\- `Branch` : là một nhánh của repository - đảm nhiệm một chức năng nhất định mà khi thêm sửa, xóa code không ảnh hưởng đến phần còn lại của repo.
+ **master** là branch chứa code version tốt nhất của project. Sau khi các branch đã được test bằng cách `merge` vào branch `dev` thì sau đó ta `merge` code từ `dev` vào branch `master`.

<a name="3.2.5"></a>
###### e. Data Assurance
\- Mọi thứ trong git được `hash` trước khi được lưu trữ và được tham chiếu tới bẵng mã hash đó.

\- Cơ chế git sử dụng cho mã hash này là **SHA-1** - chuỗi được tạo thành vởi 40 kí tự ( 0- 9 và a - f).

<a name="3.3"></a>
##### 3.3. Workflow of git
\- Chúng ta có 2 `workflow` làm việc với git thông dụng nhất : 

<a name="a"></a>
###### a. Subversion-Style
\- Đầu tiên, developer cần **clone** shared repository từ github, gitlab,.. về.

\- Sau đó, thực hiện **add**, **commit** rồi **push** lên shared repository
+ Mỗi commit đính kèm một message chú thích nhiệm vụ hay thay đổi vừa tạo.
+ Mỗi commit sẽ **lưu lại trạng thái dưới local**.
+ Để cho cả team có thể nhìn thấy sự thay đổi đó cần **push** tới server (github, gitlab)

**NOTE** : Trước khi push lên server bạn cần chắc chăn local repo của mình đã **up to date**. Vì git không cho phép **push** lên server khi trong local repo chưa cập nhật những thay đổi trong khoảng thời gian trước đó.

![](https://viblo.asia/uploads/5d2f12f7-6ba7-48f5-a503-4660eec3dab0.png)

<a name="b"></a>
###### b. Intergation Manager
\- Đầu tiên, chúng ta **fork repo** về your personal repository.

\- Tiếp theo, **clone** forked repo về local computer.

\- Tiếp tục modify, add, commit and push tới forked repo.

\- Tạo **pull request** , để người maintainer review và merge code mới vào.

![](https://viblo.asia/uploads/9aca83cb-d1e3-40ca-8247-386b05ce7cd3.png)

<a name="4"></a>
### References
+ https://viblo.asia/p/git-hoc-nghiem-tuc-mot-lan-phan-1-OeVKBo6JZkW#_5-git---about-4
