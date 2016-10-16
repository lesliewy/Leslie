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

### 配置
* 使用meld作为diff工具:
  git config --global diff.tool meld
  git difftool Markdown/readme.md
  
* 上传Work/LESLIE的过程:
    git config --global user.name ""
    git config --global user.email ""
    然后再
     git init
     git commit -m "first commit"

     git remote add origin https://github.com/lesliewy/Leslie.git
     git push -u origin master   # 这个是将已经commit的push到github, 不是当前目录下所有.

### 其他
