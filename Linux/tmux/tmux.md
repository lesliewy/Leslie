* `tmux ls`: 列出sessions.
  `tmux new -s daily`:  创建一个名字叫daily的session.
  `tmux new -d -s project`: 创建一个session, 但是不进入. 后台创建.
  `tmux a -t session-name`:  进入指定的session.
  `tmux kill-session -t daily`: 删除session

  `Ctrl + b + c`: 进入session后，创建window
  `Ctrl + b + s`: 进入session选择页面.
  `Ctrl + b + ,`: 修改窗口名字.
  `Ctrl + b + d`: detach from session, 随后可以tmux a  -t 来重新进入.
  `Ctrl + b + [`: 进入copy mode, 这是可以使用鼠标滚动屏幕. 设置了vi,也可以使用vi命令滚动.  q 退出该模式.
  `Ctrl + b + ?`: 快捷键帮助

  `Ctrl + b + x`: 删除当前pane
  `Ctrl + b + &`: 删除当前window

* 配置文件在 ~/.tmux.conf

* 在shell中打开tmux session, 关闭shell软件后，该session仍在，tmux a -t 可以重新进入.