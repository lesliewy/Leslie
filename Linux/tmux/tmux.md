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
  `Ctrl + b + z`: 多个pane时，最大化当前pane;  再按一次，恢复;  

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

  * 有些命令在tmux下无法使用  
    pbcopy/pbpaste
