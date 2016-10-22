### Command
* git 查看git commands
* git add -help: 查看git add 使用说明.
  git help add:  更加详细的说明.
* git remote add origin https://github.com/lesliewy/helloworld.git 
  git push origin master: 报错 can't connect.
  git config --global -l  : 查看有 http.proxy的设置, 去掉该设置:  git config --global --unset http.proxy 即可.
* git push origin readme-edits: 报错:  src refspec readme-edits does not match any.
  git show-ref:  查看 ref, 如果没有使用  git push orgin HEAD:readme-edits
* 不需要到.git 所在的父目录执行操作，只要是git所管理的目录都可以执行操作，例如 git commit, git push 等。
* git reset --hard 丢弃刚做的操作，例如 git rm
* **上传Work/LESLIE的过程**
  > git config --global user.name ""
  > git config --global user.email ""
  > 然后再
  > git init
  > git add <directory or file>: 添加要让git管理的目录、文件.
  > git add -A: 添加所有目录和文件.
  > git commit -m "first commit"
  > git remote add origin https://github.com/lesliewy/Leslie.git  添加远程库
  > git push -u origin master: push到远程库, 第一次使用时必须加 -u origin 这个是将已经commit的push到github, 不是当前目录下所有.

* git branch 161017
  git checkout 161017
  git checkout -b 161017: 等价于上面的两条.
  git push origin 161017: 将161017分之push到github, 就不需要在github上新建了.

* **关于branch description**
  > git branch --edit-description 161017: 给161017分支写说明. 
  > git config branch.161017.description: 查看161017分支的说明. 这些说明只是在本地，不会push到github上.
  > Shortcut/branches.sh: 将branch名和描述放在一起.

* git pull origin 161017: 获取远程(url是origin，可以通过git remote -v 查看)分支名是161017至本地.

* **本地分支与github上分支的比对**
  > git fetch origin: origin 是remote repository, 可以通过 git remote -v 查看. fetch 不会修改working dir 中文件. 该命令会fetch origin下的所有分支。 不可以 git fetch origin/161017
  > git difftool 161017 origin/master:  比对本地的161017分支与远程origin下面的master分支的区别.
  > git difftool 161017 origin/161017:  比对本地的161017分支与远程origin下面的161017分支的区别. git diff 是原生工具比对.
  > git difftool 161017: 比对working directory 和版本库里的161017分支, 会比对所有不同的文件.
  > git diff --stat 161017 origin/161017:  只列出文件列表，不比对内容. 文件列表大概如下:
  >> leslie@wy 17:30:43:script$git diff --stat old origin/old
  >> script/create_table.sql | 1 -
  >> script/test1            | 0
  >> script/useful.sql       | 1 +
  >> 3 files changed, 1 insertion(+), 1 deletion(-)
  >> script/test1 是本地有，远程没有的；  script/create_table.sql 本地添加了一行； script/useful.sql 本地删除了一行; 0代表没有该文件，其他数字代表行数(非行号)；

* git reset --hard HEAD:  将当前所在的分支重置成github上的. 即用github上的分支覆盖本地分支.

* 用Eclipse开发时，当前在哪个分支，Eclipse就显示哪个分支的内容。 
  git checkout 161017 执行后，需要在Eclipse里面Refresh下.

* git tag v0.1:  给最近的commit打标签.
  git tag -a v0.1 -m "修改完成": 给标签添加message.
  git push --follow-tags :  默认push不包含tags

* git show -q v0.1:  显示v0.1 tag, -q 是去掉diff


### 配置
* **使用meld作为diff工具**
  > git config --global diff.tool meld
  > git difftool Markdown/readme.md

### 其他
