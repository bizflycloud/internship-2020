# Git Basic

## 1 Install git on ubuntu

- Open Terminal and type in this command: sudo apt-get install git

- Config Github: type in these commands
 - git config --global user.name "user_name"
 - git config --global user.email "email_id"

- Creating a local repository
 - Use the following command : git init Mytest
 - If successfully you will get this noti : Initialized empty Git repository in /home/akshay/Mytest/.git/


## 2 Git Commands

- git init
 -Tao repo trong may
- git clone
 -Lay tu tren mang ve
- git pull
 -Dong bo tren mang ve
-git add / git add .
 -Sua source code
- git commit
 -Sua source code 
- git push
 -Dong bo tu may len mang
- git log
 -Lay log

## 3 Upload Files
>git add *Filename
>git push
>git commit -m "comment"
>git status / git log

## 4 Create a branch
>git checkout -b "*name of branch"
>git commit -m "comment"
>git push

## 5 Delete a branch
- Local:
>git branch -d *branch_name

- Remote
>git push origin --delete *branch_name