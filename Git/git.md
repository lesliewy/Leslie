* 文档及文章  
  [Git远程操作详解](http://www.ruanyifeng.com/blog/2014/06/git_remote.html)  
  [如何在 Git 中重置、恢复，返回到以前的状态](https://mp.weixin.qq.com/s?__biz=MjM5NjQ4MjYwMQ==&mid=2664611824&idx=1&sn=67be8d6a42bc9badd29fbf49fd7df316&chksm=bdce84b68ab90da0efba8f00b48c35e585fedabf245ec15ecf6f493b861c572ce2742f50a94d&scene=0&key=8b90303c306774bb86651129359cc29a86248864b9eb831c2f811f5b0c4e58efcb70539c8a644ba51f2c1a2708ca4c5507cc2bb14c0e216c43b7b6d95ecd8c5cd770cf899dd0a40e46d179bd2114a27c&ascene=0&uin=MjQ0NDE5OTIxOQ%3D%3D&devicetype=iMac+MacBookAir7%2C2+OSX+OSX+10.12.5+build(16F73)&version=12020810&nettype=WIFI&lang=zh_CN&fontScale=100&pass_ticket=Q9xqv1Q2QFNWCPJc3WGmhoc%2BduaPx6ltaih1erXhBtN0%2FIz02WC6rQNKsy5qPc6I)  

### 常用命令 ###
  * 命令  
  `git` 查看git commands  
  `git add -help`: 查看git add 使用说明.  
  `git help add`:  更加详细的说明.  
  `git remote add origin https://github.com/lesliewy/helloworld.git`  
  `git push origin readme-edits`: 报错:  src refspec readme-edits does not match any.  
  `git show-ref`:  查看 ref, 如果没有使用  git push orgin HEAD:readme-edits  
  `git ls-files`: 查看版本库里的内容.

  * 上传Work/LESLIE的过程  
    ```
    git config --global user.name ""  
    git config --global user.email ""  
    git init  
    git add <directory or file>: 添加要让git管理的目录、文件.  
    git add -A: 添加所有目录和文件到 staging area.  
    git commit -m "first commit"  将staging area 内容提交到版本库, 即staging area 和 repository同步.  -a: 将所有修改的stage, 即woking tree 和 staging area 同步.  
    git remote add origin https://github.com/lesliewy/Leslie.git: 添加远程库  
    git push -u origin master: push到远程库, 第一次使用时必须加 -u origin 这个是将已经commit的push到github, 不是当前目录下所有.  

    git init
    git remote add origin git@gitlab.wy.cn:app/mygit-web.git
    git fetch
    git checkout -b mygit-web170707102248 origin/mygit-web170707102248
    ```

#### branch ####
  * 命令  
  `git branch 161017`  
  `git checkout 161017`  
  `git checkout -b 161017`: 等价于上面的两条.  
  **注意**: git checkout -b 161017 是在当前分支基础上创建分支.  如果当前分支存在未commit的内容, 新创建的分支commit掉之后，父分支上的内容就没有了.且新创建的分支在`git branch -d 161017`前需要merge, 否则使用 `git branch -D 161017`  
  `git checkout -b b3 master`: 基于master新建分支, 也可以修改成其他的.  
  `git push origin 161017`: 将161017分支push到github, 就不需要在github上新建了.  
  `git branch -va`: 查看本地和远程的所有分支.  
  `git branch -d mygit170509225740`: 删除本地分支.  如果该分支还没有merged, 会报错. git branch -D myweb170509225740强制删除.  
  `git branch --merged`: 当前HEAD为master分支时，查看已经合并到master的分支  
  `git branch --no-merged`: 未合并到当前HEAD的分支,  如果有分支没有合并到master, 这也是不可以git branch -d 来删除未合并到master分支的原因.  
  `git branch`: 只有当有至少一次commit 才会显示master分支, 刚git init , git add 之后不会显示任何分支.  
  `git branch -m oldbranchname newbranchname`: 本地分支重命名.  
  `git checkout -b myjava170612145119 origin/myjava170612145119`:  获取远程分支myjava170612145119, 本地会新建一个.  
  `git checkout master -- deploy/tomcat/conf/catalina.policy web/src/main/resources/spring/asgard/stark-asgard.xml`: 使用master分支上的两个文件替换本地的同名文件.  -- 后通常是 <path>, 为了避免 <path> 和 <branch>同名.

  * 关于branch description  
  `git branch --edit-description 161017`: 给161017分支写说明.  
  `git config branch.161017.description`: 查看161017分支的说明. 这些说明只是在本地，不会push到github上.  
  `Shortcut/branches.sh`: 将branch名和描述放在一起.  

#### clone ####
  * 命令  
  git clone <版本库的网址> <本地目录名>: 默认将版本库url别s名设置为origin. 没有<本地目录名> 将默认为版本库名称.  
  git clone <版本库的网址> <本地目录名>: 默认将版本库名称设置为origin; 如果版本库有多个分支，clone下来的是主分支.  
  git clone -o jQuery https://github.com/jquery/jquery.git jquery`: 将origin名称设置为 jQeury. git remote查看, 放到本地的jquery目录.  
  git clone -b b1 https://github.com/jquery/jquery.git`:  clone jquery的b1分支.  

  * clone 所有分支  
    ```
    git clone  https://git.coding.net/aiyongbao/tradepc.git      tradepc_zzgdapp`: 先clone master  
    git branch -r`: 显示远程分支;  
    git checkout dev5`: checkout 某个远程分支.  
    如果clone下来的是master, 此时git branch 只会有一个master,  git branch -r 查看远程分支, 再通过git checkout -b [远程分支名] 来获取其他的远程分支.

    git clone git@gitlab.wy.cn:app/billing.git`  
    git clone --depth 1 https://github.com/tensorflow/models`: 只clone最近一次commit, 如果项目太大，而又不关心commit 历史的可以使用.  
    ```

#### add ####
  * 命令  
    `git add -u`:  update, 将所有本地修改(删除)过的被跟踪文件更新到index.
    `git add -p`: 选择某部分的修改添加到index, 而不是整个文件提交到版本库.  

#### fetch ####
  * 命令  
    `git fetch origin`: origin 是remote repository的shortname, 可以通过 `git remote -v` 查看. fetch 不会修改working dir 中文件. 该命令会fetch origin下的所有分支。 不可以 `git fetch origin/161017`

#### pull ####
  * 命令  
  git pull <远程主机名> <远程分支名>:<本地分支名>: 取回远程主机某个分支的更新，再与本地的指定分支合并。它的完整格式稍稍有点复杂。  
  `git pull origin next:master`: 取回origin主机的next分支，与本地的master分支合并  
  `git pull origin next`: 远程分支是与当前分支合并，则冒号后面的部分可以省略. 取回origin/next分支，再与当前分支合并.   
  等价于:
  ```
   git fetch origin  
   git merge origin/next  
  ```
  `git pull origin 161017`: 获取远程(url是origin，可以通过git remote -v 查看)分支名是161017至本地.  
  `git pull origin`:  当前分支与远程分支存在追踪关系，git pull就可以省略远程分支名。 `git branch -vv`（两个v），就能够看到本地分支跟踪的远程分支.  
  `git pull`: 当前分支只有一个追踪分支，连远程主机名都可以省略  
  `git branch --set-upstream-to=origin/myweb-web170711153255 mygit-web170711153255`: 设置mygit-web170711153255分支的upstream, 这样就可以直接git pull, git push了.  
  `git branch --unset-upstream jdk-8u111-linux-x64`: unset upstream.  

#### push ####
  * 命令  
  git push <远程主机名> <本地分支名>:<远程分支名>  
  `git push origin master`: 如果省略远程分支名，则表示将本地分支推送与之存在"追踪关系"的远程分支（通常两者同名），如果该远程分支不存在，则会被新建.将本地的master分支推送到origin主机的master分支。如果后者不存在，则会被新建.  
  `git push origin --delete serverfix`: 通常用这个来删除远程分支, 不需要 origin/serverfix  
  `git push origin :master`: 如果省略本地分支名，则表示删除指定的远程分支，因为这等同于推送一个空的本地分支到远程分支.  等价于: `git push origin --delete master`  
  `git push origin`: 如果当前分支与远程分支之间存在追踪关系，则本地分支和远程分支都可以省略.  将当前分支推送到origin主机的对应分支  
  `git push`: 如果当前分支只有一个追踪分支，那么主机名都可以省略.  
  `git push -u origin master`: 将本地的master分支推送到origin主机，同时指定origin为默认主机，后面就可以不加任何参数使用git push了, 相当于 git push --set-upstream origin  
  `git push --all origin`: 将所有本地分支都推送到origin主机.  

#### remote ####
  * 命令  
  `git remote show origin`: 查看远程版本库情况.  
  `git remote add <主机名> <网址>`  
  `git remote rm <主机名>`  
  `git remote rename <原主机名> <新主机名>`  

#### checkout ####
  * 命令  
  git checkout [<commit>] [--] --path: 从暂存区检出, 和 reset 不同: reset的默认值是HEAD，一般用来重置暂存区(--hard 除外), 检出的默认值是暂存区, 主要是覆盖工作区.
  git checkout <branch>:  改变HEAD指针, 用来切换分支.


#### status ####
  * 命令  
  `git status`: 查看working tree 超前/落后远程版本库的次数.  **注意**：git 有一点延迟，如果长期没有使用本地git, `git status` 第一次执行可能不准，等几分钟. 也可以直接 `git fetch` 获取log等信息.  就可以 `git log origin/master` 看到别人的提交了.
  
  ```
   Changes to be committed:   对应已经暂存的，但未提交的. （绿色)  
   Changes not staged for commit: 对应未暂存的. (红色)  
   第一个 ？主要表示staging area 和 repository 两个区域间的文件变化，一般会有两个字母来表示（A、M <绿色>）   
   A 表示此文件已经是在追踪文件  
   M 表示此文件已经在staging area区域修改，还没有提交到repository。  
   第二个 ？ 主要表示working directory 和 staging area 两个区域间的文件变化  
   M <红色> 表示此文件已经working  directory区域修改，还没有提交到staging area  
   A_: 第一次加入追踪文件.  
   AM: 加入追踪文件，尚未提交时，有过修改.  
   _M: 已经在repository, 且修改过.  
  ```
  `git status -s`: 查看working tree与本地版本库的差异文件.  
  `git status -sb`: 带上分支名及ahead/behind  

#### commit ####
  * 命令  
  `git commit --amend`: 修改上一次的提交，将当前staging area 的内容添加到上一次的提交中. 如果上一次commit之后staging area没有变化，则相当于修改commit message.  
  `git commit -m "修改" -a`
  `git add a.file b.file`: 将a.file b.file 修改同步到staging area, 忘了提交a.file b.file 的内容.  
  `git commit --amend`:  重新打开上一次提交, 修改文件中多了a.file b.file,  提交时间仍是上一次的.  

#### log ####
  * 命令  
  `git log --stat master`: 查看本地master分支的提交信息.  
  `git log --stat`: 查看当前分支的log  
  `git log --stat origin/master`: 查看远程版本库的提交信息.  
  `git log --grep="mysql"`: 查找log的提交描述中包含所有 "mysql" 的.  
  `git log -p -1`: 最近一次提交的log, 同时显示diff  
  `git log master..b3`: 查看b3分支比master分支多出来的log  
  `git log b3..master`: 查看master分支比b3分支多出来的log.  
  `git log --left-right master...dev`:  不管哪边多出来的，都显示出来.  master使用"<": commit < ea57df14;  dev使用">": commit > 2420488  
  `git log --stat -- biz/src/main/java/cn/wy/mygit/myjava/biz/util/excel/FileUtil.java`: 查看提交历史, 该文件是被删除的文件,必须使用 --  
  `git log -S mysql`:  显示所有添加 或 删除 "mysql" 的log.  
  `git log --stat abc*`:  显示所有文件路径名中包含abc的commit.  abc不一定是文件名, 可以是路径中的目录名.
  参考: [git log 命令全解析，打log还能这么随心所欲！](https://www.cnblogs.com/bellkosmos/p/5923439.html) 

  * commit ranges  
  `git log master..experiment`: experiment分支上有，但是master上没有的commit. `git log experiment..master`  
  `git log origin/master..HEAD`: 当前分支上多出的commit, 即要push的commit.  
  `git log refA..refB`:  
  `git log refA refB ^refC`: refA、refB上均有，但是refC上没有.  
  `git log refA refB --not refC`: 等价于上面的.  
  `git log master...experiment`: master、experiment上各自有的但不是公共的commits.  
  `git log --left-right master...experiment`: 标识出哪些commit属于哪个分支.  例如:  
    < F: master 上有F;  
    > D: D在experiment上.  


#### diff ####
  * 命令  
  `git diff`: 是查看working tree与index file的差别的。（git add后两者就同步, 另外，将已经commit的文件回退到之前的版本，working tree 和index也相同）  
  `git diff --cached` or `git diff --staged` 是查看index file与commit的差别的。（git commit后两者就同步）  
  `git diff HEAD`：是查看working tree和该分支最新版本的差别的。（你一定没有忘记，HEAD代表的是最近的一次commit的信息，即：git commit后working tree未做任何操作，那么两者就是同步的，没有差异信息）  
  `git diff master origin/master share/src/main/java/cn/wy/mygit/api/intf/PreLoan.java`: 比对本地版本库里的master分支(不是working tree), 和origin/master(远程分支)下指定文件的区别. 有时候需要隔开revision and filename: `git diff master origin/master -- biz/src/main/java/cn/wy/mygit/biz/service/cache/CreditPartnerCache.java`  
  `git diff origin/master share/src/main/java/cn/wy/mygit/api/intf/PreLoan.java`: 比对的是working tree和远程分支上的. 
  @@ -32,23 +32,23 @@:  表示从文件的第32行开始，左边包含23行，右边包含23行, 两边包含行数一致，说明是修改的； 如果不一致，说明新增/删除.  
  `git diff HEAD HEAD~ web/src/main/webapp/htdocs/app-modules/creditmyjava/intentionScoreBatch.js`: 当前最新版和上一次提交的版本，显示本次修改的内容.  
  `git diff HEAD~ HEAD~2 web/src/main/webapp/htdocs/app-modules/creditmyjava/intentionScoreBatch.js`: 上一个版本和上上一个版本.  
  `git diff --stat origin/myjava170706211413`: 比对的是版本库和远程分支的区别， 注意是版本库.  
  `git diff --stat myjava170706211413 origin/myjava170706211413`:  比对的当前working tree 和远程版本库的区别.  

  * difftool  
  `git difftool 161017 origin/master`: 比对本地的161017分支与远程origin下面的master分支的区别, 这里是所有不同的文件都会比对.  
  `git difftool 161017 origin/161017`: 比对本地的161017分支与远程origin下面的161017分支的区别. git diff 是原生工具比对.  
  `git difftool 161017`: 比对working directory 和版本库里的161017分支, 会比对所有不同的文件.  
  `git difftool -d master`:  比对master分支和当前分支， 注意: 需要加-d, 目录比对。  
  `git diff --stat 161017 origin/161017`: 只列出文件列表，不比对内容. 文件列表大概如下:  
  ```
  > leslie@wy 17:30:43:script$git diff --stat old origin/old  
  > script/create_table.sql | 1 -  
  > script/test1            | 0  
  > script/useful.sql       | 1 +  
  > 3 files changed, 1 insertion(+), 1 deletion(-)  
  script/test1 是本地有，远程没有的；  script/create_table.sql 本地添加了一行； script/useful.sql 本地删除了一行; 0代表没有该文件，其他数字代表行数(非行号)  
  ```

#### reset ####
  > 主要用于本地仓库，如果已经push到远程，最好别用, 因为需要使用push -f 来强制update远程仓库。 如果在push -f 之前已经有人pull了，别人的仓库就会出现 ahead, 容易再次被别人push
  * commit level: 不带file path: 移动HEAD的指向.  
    `git reset --soft HEAD~`: 将HEAD移动到HEAD~, 即将repository回退至HEAD~, staging area 和 working tree仍然是HEAD.  
    `git reset --soft HEAD^`: 同上，对最近的提交不满意时，撤销最新的提交以便重新提交;  
    `git update-ref -d HEAD`: 撤销版本库的第一次commit, 第一次commit不能使用reset HEAD~ 这种方式.  
    `git reset --mixed HEAD~`: 将HEAD移动到HEAD~, 同时unstaged, 即将staging area回退到HEAD~, 即repo 和 staging area都回退到HEAD~   
    `git reset --hard HEAD~`: 将HEAD移动到HEAD~, 同时unstaged, update working tree, 即repo, staging area, working tree 都回退到 HEAD~, ** 慎重使用 hard，数据会丢失 **  
    `git reset HEAD~`: 即 `git reset --mixed HEAD~`   
    `git reset --hard`: 丢弃刚做的操作  
    `git reset --hard origin/master`: 将当前所在的分支重置成远程分支origin/master. 本地修改将丢失.  
    `git reset --hard origin/wy181130103117`: 远程分支覆盖, 如果从master分支切换到wy181130103117后，由于master分支已经提交了很多代码，git status 会出现 ahead 49, behind 53 这种情况,git pull 可能后出现冲突, 此时需要完全替换成 wy181130103117 的代码.  
    `git reset`: 等于 `git reset HEAD`, 是 `git add`的逆操作.  

  * file level: 带file path: 不移动HEAD，只改变 staging area, working tree.  
    `git reset file.txt`: 等价于 git reset --mixed HEAD file.txt, repo不变，将index中file.txt回退到HEAD(repo内容).  
    `git reset eb43bf8 file.txt`: 将index中file.txt回退到 eb43bf8.  
    `git reset HEAD file`:   unstaging staging area, 回到working area.  

#### blame ####
  * 命令  
  `git blame filename`: 查看每一行是哪个提交最后改动的.  

#### tag ###
  * 命令  
  `git tag v0.1`: 给最近的commit打lightweight标签, 不带标签信息.  
  `git tag -n3`: 显示tag及内容.  
  `git tag -a v0.1 -m "修改完成"`: 给最近的commit打annotated标签同时添加message  
  `git tag -a v0.1 -m "a" aaf9e2b2a7b`: 给某次commit打标签.  
  `git push --follow-tags`: 默认push不包含tags  
  `git checkout -b version2 v2.0.0`: 在tag处创建新分支, 不能checkout 一个tag.   
  `git show -q v0.1`:  显示v0.1 tag, -q 是去掉diff
  `git rm -r --cached shinyAppLog`: 将shinyAppLog从版本库中移除，不需要git管理. 如果不加--cache,会删掉本地的文件.
  
  * 回退到某个tag的版本  
  `git tag`: 查询tag  
  `git show -q <tag-name>`: 查找某个tag的commit id.  
  `git reset --hard 39debacd3375cf4430c502aa6a99ac8655cfddae`: 回退到该版本.  

#### stash ####
  * 命令  
  `git stash`: 将当前working tree修改存入栈.  
  `git stash list`: 列出栈中的内容.  
  `git stash pop`: 将栈顶的修改还原到working tree.  
  `git stash apply stash@{0}`: 指定位置还原到working tree, 不指定stash@{0}时，将最近的一次进度恢复，和pop不同，不会删除最近的进度.
  `git stash drop`: 将栈顶(stash@{0})的删除.  
  `git stash drop stash@{2}`: 删除指定位置的stash.  
  `git stash clear`: 清除所有存储的进度;
  `git stash save "message"`: stash同时添加说明.
  `git stash --keep-index`: 已经git add 到staging area的不做stash.  
  `git stash -u`: 即git stash --include-untracked, 同时也将untracked stash.  
  `git stash --all`: 将所有的都stash, 包括untracked files, ignored files.  

#### clean ####
  * 命令  
  `git clean -f`: 删除所有的untracked files, 默认的git clean 并不会删除:fatal: clean.requireForce defaults to true and neither -i, -n, nor -f given; refusing to clean  
  `git clean -f -d`: 删除所有的untracked files 和 directories, 以及tracked但是为空的目录.  
  `git clean -d -n`:  dry run, 列出要删除的，但不会执行.  
  `git clean -d -x -n`:  -x 包含ignored.  

#### fork ####
  * fork 的仓库和源仓库同步  
   `git remote add fork-from https://github.com/iluwatar/java-design-patterns.git`: remote 添加源仓库.
   `git fetch --all`: 同步remote 中所有repo;
   `git rebase fork-from/master`;   本地与源仓库同步; git status 可以看到已经比自己fork的远程repo 提前了.
   `git push origin master`:  将自己的远程repo 和 源repo 同步;
   

#### merge ####
  * conflicts  
  发生在对不同分支上同一文件的同一文本块以不同方式修改;  
  一般过程:  
    `git checkout master`  
    `git merge b3`:  执行后发生冲突.  
    `git mergetool`: 调用配置的diffmerge来解决.  
    `git merge --abort`:  如果此时想回退merge操作,可以abort.  
    `git add`: 添加到staging area, 标志已解决冲突, 也可以用 git commit -a: 一步完成.  
    `git commit`:  提交.  
    
  * rebase 时发生冲突  
    git rebase fork-from/dev_v1
    resolve conflicts
    git add .      不要commit
    git rebase --continue   再次与本地的冲突, 再次解决.  
    git rebase --skip   确定没有了, 就skip  

  * 直接合并  
    将会把所有的提交(包括log)合并在一起.  
    将161017分支merge到master分支:
    ~/MyProject/StockAnalyse> git checkout master
    ~/MyProject/StockAnalyse> git merge --no-ff 161017
  
  * 压合合并  
    将被合并分支的所有提交压合成一个提交.  
    将b3分支压合合并至master.  
    `git checkout master`  
    `git merge --squash b3`  
    `git status`: 未提交的是压合合并的内容.  
    `git commit -m "" -a`:  正常提交一次.  
  
  * 拣选合并  
    选择指定的commit来合并.  
    * 只选择一个来合并:  
      git checkout master  
      git cherry-pick <commitid>  
      
    * 选择多个来合并:  
      git checkout master  
      git cherry-pick -n <commitid>  
      git cherry-pick -n <commitid>  
      ...  
      git commit`:  不带 -m 参数.  
      
    * 使用idea 来进行cherry-pick.
       参考: [使用IDEA进行git cherry-pick](https://www.jianshu.com/p/b36fc61afb26)
       假设A分支需要cherry-pick B分支上的几个commit, 即代码在B分支上，需要合并到A分支.
       1, idea 切换到A分支.
       2, 打开version control 中的Log标签. branch 选择B分支, 找到需要并入A的commit;
       3, 选择commit, ctrl 多选
       4, 点击Log标题栏中的cherry-pick. 有几个commit, idea会弹出几个提交框，输入提交信息.
      
  * 选择另一个分支上的部分文件.
    不是一整个commit, 而是不同commit里的文件。
    1， 使用idea -> merge branches,  选择分支，勾选 no-commit(相当于 --no-commit 选项). 会将所有不同合并，但不会提交，A 或 M状态;
        git reset; 将所有cached的回退到本地;  
        git add -- {needed files}

### 配置 ###
  * `git config --list`: 查看配置信息.  默认是local, 项目级别, 相当于 git config --local --list  配置文件再 .git/config 
    git config --global --list:  用户级别配置, 优先级低于项目级别.  配置文件在 ~/.gitconfig
    git config --system --list:  系统级别配置，优先级低于用户级别， 配置文件再 /etc/gitconfig

  * 使用meld作为diff工具  
    `git config --global diff.tool meld`  
    `git difftool Markdown/readme.md`  
    `git diffall`: 比较working tree 和 index.  
    `git-diffall e73e7db9c0bdc40ea79c2ce6b498e4e3d4e858e4 cb3fcb5fc7502641db456ddda8889134ce381344`: 最初提交的文件比较.  

  * `git push origin master`: 报错 can't connect.  
    `git config --global -l`: 查看有 http.proxy的设置, 去掉该设置:  `git config --global --unset http.proxy` 即可.  

  * .gitignore 忽略文件.  
    "#" 用来注释.  
    ponia.properties: 忽略所有名称是 ponia.properties, 包括 conf/my/ponia.properties  
    /ponia.properties: 忽略根目录下的 ponia.properties, 不包括其他位置的  
    ponia.properties/:  忽略目录ponia.properties  

### 其他 ###
  *  不需要到.git 所在的父目录执行操作，只要是git所管理的目录都可以执行操作，例如 `git commit`, `git push` 等。  

  * ^ 与 ~  
  `git show HEAD^`:  当前HEAD的第一个parent  
  `git show HEAD^2`: 当前HEAD的第二个parent, 用于merged分支时, 一个commit有多个parent情况.  
  `git show HEAD~`:  当前HEAD的第一个parent  
  `git show HEAD~2`: 当前HEAD的第一个parent的第一个parent. 相当于 HEAD^^  

  * 回退某个文件  
  `git checkout -- api/pom.xml`: 放弃working tree的修改, 恢复版本库内容.  
  `git checkout .`: 放弃所有work tree的修改， 新增的文件仍然在本地;
  
  * 回退本地所有修改，包括新增  
    `git reset --hard`: 新增的文件会从worktree中删除，但是本地仍然存在;
    `git clean -df`: 删除多余的本地文件(前面是 ?)   `git clean -n`: 查看要删除的文件;

  * 查看某文件的历史版本  
  `git log filename`:查看所有提交历史,获取sha-1值.  
  `git show sha-1 filename`: 查看内容.  

  * 查看某次提交的文件列表  
  `git log --stat`: 找出commitid  
  `git show --stat commitid`  

  * 用Eclipse开发时，当前在哪个分支，Eclipse就显示哪个分支的内容。 `git checkout 161017` 执行后，需要在Eclipse里面Refresh下.

  * 从分支1(myjava170613152324)中删除代码， 形成两个分支. myjava170613152324先提测、上线。  
   备份:  备份整个目录。  
   代码全部删除后, git pull;   git checkout -b myjava170706200706:  myjava170706200706 分支后上线.  
   在新分支myjava170706200706 恢复删除: git revert commitid1 commitid2 commitid3  
   在新分支myjava170706200706 创建远程分支: git push --set-upstream origin myjava170706200706  
   通过以上方法，以后myjava170706200706分支合并其他分支时也不会出现问题。 注意: 只能revert删除代码的commitid!!!!  

  * 修改branch名称.
  `git branch -m oldname newname`:  修改本地branch  
  `git push origin --delete jdk1.8.0_112`:  删除远程分支.  
  `git push -u origin jdk-8u112-linux-x64`: push 最新分支.  
  `git branch --set-upstream-to=origin/jdk-8u112-linux-x64 jdk-8u112-linux-x64`: 重新设置upstream.  
  `git branch -vv`  `git branch -va` 来验证.  

  * jdk source 添加一个source  
  `git rm -r --cached jdk-8u111-linux-x64`: 删除master里的所有，确保为空.  
  `git checkout -b jdk-8u111-linux-x64` or `git checkout master; git checkout jdk-8u111-linux-x64`  
  `git rm -r *`: 好像用rm -rf 也不会把master分支里的删掉  
  `git commit -m "delete"`;  这样来删除新分支现有的;  
  `git ls-files`: 验证下新分支版本库没有内容.  
  将jdk里的src.zip解压到新分支;  
  `git add -A; git commit -m "add"`: 提交新的source.  
  编辑.gitignore, 忽略掉其他的.  
  `git push -u origin jdk1.8.0_112`:  push  

  * 撤销首次提交
  `git update-ref -d HEAD`, 不能用git reset HEAD~

  * 添加commit 模板
  git config --local commit.template /Users/leslie/MyProjects/GitHub/Leslie/Git/commit_template
