# Advanced knowledge of Git
___
### 1. Basic command-lines
\- Giả sử, chúng ta có một số files, folders muốn push lên github và đã tạo sẵn một repo ở trên đó.

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/folder.png)

+ ***git init***: tạo **local repo** 

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/init.png)

Và kết quả, chúng ta được **local repo** `.git`

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/folder_git.png)

+ ***git add .***: toàn bộ files, folders vào **staging area**, sãn sàng đánh dấu để commit. 

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/add.png)

+ ***git status*** : Check status of files and folders (tracked hoặc untracked)

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/status_2.png)

+ ***git commit -m "messages"***: Adds taged changes to local repo.

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/commit.png)


+ ***git remote add origin URL***: git cần biết **tag** và **URL** để push tới online services (github, gitlab).

+ ***git push -u origin master***: push to repository in the github

+ ***git pull***: sync local working and Github.

\- Khi chúng ta có thêm một ính năng mới. Chúng ta sẽ không push trực tiếp chúng tới **master** mà sẽ tạo **branch mới**. Sau đó, team sẽ **review** và **merger** chúng lại.

![](https://camo.githubusercontent.com/d5f8439d7af79a4eec8e0f297d6e2aee2aa6d300/68747470733a2f2f676974626f6f6b646f776e2e736974652f696d672f6769745f6272616e63685f6d657267652e706e67)

+ ***git branch*** : tạo một branch mới

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/branch.png) 

+ ***git checkout*** : Chuyển đổi branch

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/check-out.png)

**NOTE** : chúng ta cũng có thể gộp 2 bước **branch** và **checkout** này lại bằng cách sử dụng

```
git checkout -b test-pull-request
```

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/pull-request.png)

+ ***git merge*** : merges các branches lại với nhau

![](https://github.com/viendanbac/Learning-git-Github-from-scratch/raw/master/Images/merge.png)

### 2. Advanced command-lines
\- Trước khi tìm hiểu một số câu lệnh thường xuyên được sử dụng như : `git revert`, `git reset`,... trước hết chúng ta cần hiểu khái niệm `HEAD` trong git.

> HEAD is a reference to the last commit in the currently checked-out branch.

+ `HEAD` or `HEAD~1` : tham chiếu tới 1 commit trước đó.
+ `HEAD~10` : tham chiếu tới 10 commit trước đó.

**Usage** 

+ `git reset HEAD~3` : **uncommit** your last 3 commits - ***without removing the changes***. 
+ `git reset --hard HEAD~3` : **uncommit** your 3 last commits and ***remove your working directory changes***. 

OR, chúng ta có thể tìm kiếm **commit-id** (Commit mà chúng ta muốn back trở lại )trong `git log`. Sau đó, sử dụng

```
git reset --hard <sha1-commit-id>
```

Nếu chúng ta đã push lên github trước đó, vậy thì cần push lại bằng cách: 
```
git push origin HEAD --force
```

Trong trường hợp, chúng ta chưa push data lên github or git lab thì có thể sử dụng `git rebasse -i` để xóa các commit đó bằng cách thực hiện command-lines sau : 

```
git rebase -i HEAD~N
```

Sau đó, chúng ta thực hiện edit các parameters trong đó : 

```
pick 2231360 some old commit
pick ee2adc2 Adds new feature
# Rebase 2cf755d..ee2adc2 onto 2cf755d (9 commands)
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
# d, drop = remove commit
```

**NOTE** : Different between `git reabse` and `git reset`

> They are completely different. git-reset works with refs, on your working directory and the index, without touching any commit objects (or other objects). git-rebase on the other hand is used to rewrite previously made commit objects. ( [src](https://stackoverflow.com/questions/11225293/what-is-the-difference-between-git-reset-vs-git-rebase#:~:text=2%20Answers&text=They%20are%20completely%20different.,rewrite%20previously%20made%20commit%20objects.) )

### References
+ [HEAD](https://stackoverflow.com/questions/2529971/what-is-the-head-in-git)
+ [git rebase](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase)

