# Tools for Locating Files
## 1. `find`
- `find [file/folder_name]`: tìm kiếm file/folder theo tên đầy đủ. 
- `find -name *`: tìm kiếm file theo tên không đầy đủ

```
corgi@corgi:~$ find -name G*
./GNS3
./.config/GNS3
```

- `find -name *.[phần mở rộng]`

```
corgi@corgi:~$ find -name *.docx
./CV Nguyễn Trần Khánh.docx
```

- `find /home -group corgi`: tìm file trong thư mục home có group là corgi
- `find -type f -name ".*"`: tìm file ẩn
- `find /home -user corgi`: tìm các file thuộc quyền sở hữu user corgi. 
- `find / -perm 644`: tìm file có permission 644.


## 2. `locate`
- `locate [option] Pattern...`

```
corgi@corgi:~$ locate GNS3 | tail
/usr/share/gns3/GNS3/Ui/ConfigurationPages/Page_PreferencesQemu.py
/usr/share/gns3/GNS3/Ui/ConfigurationPages/Page_PreferencesQemu.pyc
/usr/share/gns3/GNS3/Ui/ConfigurationPages/Page_PreferencesVirtualBox.py
/usr/share/gns3/GNS3/Ui/ConfigurationPages/Page_PreferencesVirtualBox.pyc
/usr/share/gns3/GNS3/Ui/ConfigurationPages/Page_Qemu.py
/usr/share/gns3/GNS3/Ui/ConfigurationPages/Page_Qemu.pyc
/usr/share/gns3/GNS3/Ui/ConfigurationPages/Page_VirtualBox.py
/usr/share/gns3/GNS3/Ui/ConfigurationPages/Page_VirtualBox.pyc
/usr/share/gns3/GNS3/Ui/ConfigurationPages/__init__.py
/usr/share/gns3/GNS3/Ui/ConfigurationPages/__init__.pyc
```

- `locate *.md`: Hiển thị file có đuôi .md

```
corgi@corgi:~$ locate -n 10 *.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/BACKERS.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/CHANGELOG.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/README.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/.github/ISSUE_TEMPLATE/bug_report.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/.github/ISSUE_TEMPLATE/feature_request.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/node_modules/applicationinsights/README.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/node_modules/braces/CHANGELOG.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/node_modules/braces/README.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/node_modules/fill-range/README.md
/home/corgi/.vscode/extensions/formulahendry.code-runner-0.11.0/node_modules/is-number/README.md
```
`-n 10: Chỉ hiển thị 10 kết quả`

- `locate -i [file_name]`: phân biệt chữ hoa và chữ thường.
- `locate -c [file_name]`: trả về số lượng file
- `locate -e [file_name]`: Hiển thị các file tại thời điểm `locate` được chạy. 

## 3. `whereis`
- `whereis` chương trình giúp ta tìm :
   + Đường dẫn vị trí file binary.
   + Đường dẫn vị trí source code.
   + Đường dẫn vị trí manual dành cho chương trình hay lệnh đó.

- `whereis [options] program/command`

```
corgi@corgi:~$ whereis date
date: /bin/date /usr/share/man/man1/date.1.gz
corgi@corgi:~$ whereis df
df: /bin/df /usr/share/man/man1/df.1.gz
```

- Các option
 + `-b`: tìm file binary 
```
corgi@corgi:~$ whereis -b date
date: /bin/date
```
 + `-m`: tìm file manual 
 + `-s`: tìm source code
 + `-B /path/dir`: tìm kiếm file binary ở thư mục được chỉ định.
 + `-M /path/dir`: tìm kiếm file manual ở thư mục được chỉ định.
 + `-S /path/dir`: tìm kiếm file source code ở thư mục được chỉ định.

## 4. `which`
- Tìm ra đường dẫn các file chương trình nằm trong các directory liệt kê ở biến môi trường `$PATH`. 

```
corgi@corgi:~$ echo $PATH
/home/corgi/bin:/home/corgi/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```
- which [-option][command]

```
corgi@corgi:~$ which cat
/bin/cat
corgi@corgi:~$ which ls gdb grep 
/bin/ls
/usr/bin/gdb
/bin/grep
```

## 5. So sánh `which` và `whereis`
- `whereis` liệt kê đường dẫn vị trí file binary, manual và source code còn `which` chỉ liệt kê đường dần file binary của chương trình lệnh.

```
corgi@corgi:~$ which cat
/bin/cat
corgi@corgi:~$ whereis cat
cat: /bin/cat /usr/share/man/man1/cat.1.gz
```

 

 



