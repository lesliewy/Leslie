## 命令 ##
  `tmux ls`: 列出sessions.  
  `tmux new -s daily`:  创建一个名字叫daily的session.  
  `tmux new -d -s project`: 创建一个session, 但是不进入. 后台创建.  
  `tmux a -t session-name`:  进入指定的session.  
  `tmux kill-session -t daily`: 删除session  
  `tmux list-commands`:  
  `tmux list-windows -t leslie`:  列出leslie session 下的所有window.  
  `Ctrl + b + c`: 进入session后，创建window  
  `Ctrl + b + s`: 进入session选择页面.  
  `Ctrl + b + L`: 回到上一个session  
  `Ctrl + b + ,`: 修改窗口名字.  
  `Ctrl + b + d`: detach from session, 随后可以tmux a  -t 来重新进入.  
  `Ctrl + b + [`: 进入copy mode, 这是可以使用鼠标滚动屏幕. 设置了vi,也可以使用vi命令滚动.  q 退出该模式.  
  `Ctrl + b + ?`: 快捷键帮助  
  `Ctrl + b + x`: 删除当前pane  
  `Ctrl + b + &`: 删除当前window  
  `Ctrl + b + |`: 将window划分为左右两个pane.
  `Ctrl + b + -`: 将window划分为上下两个pane.
  `Ctrl + b + j`: ijkl 进入不同的pane.
  `Ctrl + b + z`: 多个pane时，最大化当前pane;  再按一次，恢复;  
  `Ctrl + b + Ctrl h`: 调整pane的宽度. 同样可以Ctrl i, k, l
  `Ctrl + b + {`:  swap pane
  `Ctrl + b + q`: 多个pane时，显示各个pane的序号.
  `Ctrl + b + o`: 在各个pane间，按转序跳转。跳转的先后可能是Ctrl + b + q 所显示的顺序.
  `Ctrl + b + '`: 输入window index 来跳转. 0-9 不够用时使用这个.

## 配置 ##
  * 安装  
  [非root用户源码安装Tmux](https://www.jianshu.com/p/f7f24b4b2625)  

  * 配置文件在 ~/.tmux.conf  
    ctrl + b + :  进入命令模式:   source-file ~/.tmux.conf 生效 or tmux source .tmux.conf  

  * 在shell中打开tmux session, 关闭shell软件后，该session仍在，`tmux a -t` 可以重新进入.  

  * iterm2 , tmux copy-mode(prefix + [)下, 先空格, 再使用y直接复制内容到剪贴板:  
  To enable this:  
    > Go into iTerm2's preferences.  
    Go to the "General" tab.  
    Check "Applications in terminal may access clipboard"  
    In tmux, ensure set-clipboard is turned on:  
    $ tmux show-options -g -s set-clipboard  
    set-clipboard on  

## 杂项 ##
  * 插件管理  
    Tmux Plugin Manager  
    安装插件流程: 
    1, .tmux.conf 中添加插件， 类似set -g @plugin '...'这样的行
    2， 在终端中敲tmux启动tmux
    3， 在tmux环境中敲<prefix>+I来安装相应的插件（ls ~/.tmux/plugins/可以看到抓下来的插件）
        <prefix>就是tmux中前缀键  注意I是大写
    4, 如果要升级所有插件，敲<prefix> + U
    5, 如果要干掉某个插件，先从~/.tmux.conf中删掉对应的行，然后敲<prefix> + alt + u即可

  * 有些命令在tmux下无法使用  
    pbcopy/pbpaste
