### 命令
* `git` 查看git commands
* `git add -help`: 查看git add 使用说明.
  `git help add`:  更加详细的说明.
* `git remote add origin https://github.com/lesliewy/helloworld.git`  

* `git push origin readme-edits`: 报错:  src refspec readme-edits does not match any.
  `git show-ref`:  查看 ref, 如果没有使用  git push orgin HEAD:readme-edits
* 不需要到.git 所在的父目录执行操作，只要是git所管理的目录都可以执行操作，例如 `git commit`, `git push` 等。

* `git reset --hard` 丢弃刚做的操作

* **上传Work/LESLIE的过程**
  `git config --global user.name ""`
  `git config --global user.email ""`
  `git init`
  `git add <directory or file>`: 添加要让git管理的目录、文件.
  `git add -A`: 添加所有目录和文件.
  `git commit -m "first commit"`
  `git remote add origin https://github.com/lesliewy/Leslie.git`: 添加远程库
  `git push -u origin master`: push到远程库, 第一次使用时必须加 -u origin 这个是将已经commit的push到github, 不是当前目录下所有.

* `git branch 161017`
  `git checkout 161017`
  `git checkout -b 161017`: 等价于上面的两条.
      **注意**: git checkout -b 161017 是在当前分支基础上创建分支.  如果当前分支存在未commit的内容, 新创建的分支commit掉之后，父分支上的内容就没有了.
      且新创建的分支在`git branch -d 161017`前需要merge, 否则使用 `git branch -D 161017`
  `git push origin 161017`: 将161017分之push到github, 就不需要在github上新建了.
  ·git branch -a: 查看本地和远程的所有分支.
  `git branch -d creditcloud170509225740`: 删除本地分支.


* **关于branch description**
  `git branch --edit-description 161017`: 给161017分支写说明. 
  `git config branch.161017.description`: 查看161017分支的说明. 这些说明只是在本地，不会push到github上.
  `Shortcut/branches.sh`: 将branch名和描述放在一起.

* **git clone**
  git clone <版本库的网址> <本地目录名>: 默认将版本库名称设置为origin.
  `git clone -o jQuery https://github.com/jquery/jquery.git`: 将版本库名称设置为 jQeury. git remote查看.

* **git add**
   git add -p: 选择某部分的修改添加到index, 而不是整个文件提交到版本库.

* **git pull**
  git pull <远程主机名> <远程分支名>:<本地分支名>: 取回远程主机某个分支的更新，再与本地的指定分支合并。它的完整格式稍稍有点复杂。
  `git pull origin next:master`: 取回origin主机的next分支，与本地的master分支合并
  `git pull origin next`: 远程分支是与当前分支合并，则冒号后面的部分可以省略. 取回origin/next分支，再与当前分支合并. 
     > 等价于:
     >    $ git fetch origin
     >    $ git merge origin/next

  `git pull origin 161017`: 获取远程(url是origin，可以通过git remote -v 查看)分支名是161017至本地.
  `git pull origin`:  当前分支与远程分支存在追踪关系，git pull就可以省略远程分支名。
   > git branch -vv（两个v），就能够看到本地分支跟踪的远程分支.

  `git pull`: 当前分支只有一个追踪分支，连远程主机名都可以省略

* **git push**
  git push <远程主机名> <本地分支名>:<远程分支名>
  `git push origin master`: 如果省略远程分支名，则表示将本地分支推送与之存在"追踪关系"的远程分支（通常两者同名），如果该远程分支不存在，则会被新建.将本地的master分支推送到origin主机的master分支。如果后者不存在，则会被新建.
  `git push origin :master`: 如果省略本地分支名，则表示删除指定的远程分支，因为这等同于推送一个空的本地分支到远程分支.
     > 等价于: git push origin --delete master
  `git push origin`: 如果当前分支与远程分支之间存在追踪关系，则本地分支和远程分支都可以省略.  将当前分支推送到origin主机的对应分支
  `git push`: 如果当前分支只有一个追踪分支，那么主机名都可以省略.
  `git push -u origin master`: 将本地的master分支推送到origin主机，同时指定origin为默认主机，后面就可以不加任何参数使用git push了.
  `git push --all origin`: 将所有本地分支都推送到origin主机.

* **git remote**
  git remote show <主机名>
  git remote add <主机名> <网址>
  git remote rm <主机名>
  git remote rename <原主机名> <新主机名>

* **落后/超前版本**
  git status:   查看working tree 超前/落后远程版本库的次数.  **注意：git 有一点延迟，如果长期没有使用本地git, git status 第一次执行可能不准，等几分钟
                . 也可以直接git fetch 获取log等信息.  就可以git log origin/master看到别人的提交了.
                Changes to be committed:   对应已经暂存的，但未提交的. （绿色)
                Changes not staged for commit: 对应未暂存的. (红色)
  git status -s : 查看working tree与本地版本库的差异文件.
  git log --stat master: 查看本地master分支的提交信息.
  git log --stat: 同上.
  git log --stat origin/master: 查看远程版本库的提交信息.

* **本地分支与github上分支的比对**
  git diff：是查看working tree与index file的差别的。（git add后两者就同步）
  git diff --cached：or git diff --staged 是查看index file与commit的差别的。（git commit后两者就同步）
  git diff HEAD：是查看working tree和该分支最新版本的差别的。（你一定没有忘记，HEAD代表的是最近的一次commit的信息，即：git commit后working tree未做任何操作，那么两者就是同步的，没有差异信息）
  `git diff master origin/master share/src/main/java/cn/fraudmetrix/creditcloud/api/intf/PreLoan.java`: 比对本地版本库里的master分支(不是working tree), 和origin/master(远程分支)下指定文件的区别.  **有时候需要隔开revision and filename: git diff master origin/master -- biz/src/main/java/cn/fraudmetrix/creditcloud/biz/service/cache/CreditPartnerCache.java
  `git diff origin/master share/src/main/java/cn/fraudmetrix/creditcloud/api/intf/PreLoan.java`: 比对的是working tree和远程分支上的. 
  @@ -32,23 +32,23 @@:  表示从文件的第32行开始，左边包含23行，右边包含23行, 两边包含行数一致，说明是修改的； 如果不一致，说明新增/删除.

  `git fetch origin`: origin 是remote repository, 可以通过 git remote -v 查看. fetch 不会修改working dir 中文件. 该命令会fetch origin下的所有分支。 不可以 `git fetch origin/161017`
  `git difftool 161017 origin/master`:  比对本地的161017分支与远程origin下面的master分支的区别, 这里是所有不同的文件都会比对.
  `git difftool 161017 origin/161017`:  比对本地的161017分支与远程origin下面的161017分支的区别. git diff 是原生工具比对.
  `git difftool 161017`: 比对working directory 和版本库里的161017分支, 会比对所有不同的文件.
  `git diff --stat 161017 origin/161017`: 只列出文件列表，不比对内容. 文件列表大概如下:
  > leslie@wy 17:30:43:script$git diff --stat old origin/old
  > script/create_table.sql | 1 -
  > script/test1            | 0
  > script/useful.sql       | 1 +
  > 3 files changed, 1 insertion(+), 1 deletion(-)
 
  script/test1 是本地有，远程没有的；  script/create_table.sql 本地添加了一行； script/useful.sql 本地删除了一行; 0代表没有该文件，其他数字代表行数(非行号)；

* **git reset**
* `git reset --hard origin/master`: 将当前所在的分支重置成远程分支origin/master. 本地修改将丢失.
* 回退到某个tag的版本:
  > `git tag`: 查询tag
  > `git show -q <tag-name>`: 查找某个tag的commit id.
  > `git reset --hard 39debacd3375cf4430c502aa6a99ac8655cfddae`: 回退到该版本.

* 查看某文件的历史版本:
  `git log filename`:查看所有提交历史,获取sha-1值.
  `git show sha-1 filename`: 查看内容.

* 查看某次提交的文件列表.
  `git log --stat`: 找出commitid
  `git show --stat commitid`

* 用Eclipse开发时，当前在哪个分支，Eclipse就显示哪个分支的内容。 
  `git checkout 161017` 执行后，需要在Eclipse里面Refresh下.

* `git tag v0.1`: 给最近的commit打标签.
  `git tag -n3`: 显示tag及内容.
  `git tag -a v0.1 -m "修改完成"`: 给最近的commit打标签同时添加message.
  `git push --follow-tags` :  默认push不包含tags

* `git show -q v0.1`:  显示v0.1 tag, -q 是去掉diff

* `git rm -r --cached shinyAppLog`: 将shinyAppLog从版本库中移除，不需要git管理. 如果不加--cache,会删掉本地的文件.

* merge
  将161017分支merge到master分支:
  ~/MyProject/StockAnalyse> git checkout master
  ~/MyProject/StockAnalyse> git merge --no-ff 161017

* 状态
  第一个 ？ 主要表示staging area 和 repository 两个区域间的文件变化，一般会有两个字母来表示（A、M <绿色>）；A  表示此文件已经是在追踪文件，M 表示此文件已经在staging area区域修改，还没有提交到repository。
  第二个 ？ 主要表示working directory 和 staging area 两个区域间的文件变化，M <红色> 表示此文件已经working directory区域修改，还没有提交到staging area

* useful urls
  http://www.ruanyifeng.com/blog/2014/06/git_remote.html

### 配置
* `git config --list`: 查看配置信息.
* **使用meld作为diff工具**
  > `git config --global diff.tool meld`
  > `git difftool Markdown/readme.md`

* `git push origin master`: 报错 can't connect.
  `git config --global -l`: 查看有 http.proxy的设置, 去掉该设置:  `git config --global --unset http.proxy` 即可.

* .gitignore 忽略文件.
  # 用来注释.

### 其他
