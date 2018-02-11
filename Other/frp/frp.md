* 配置:  https://github.com/fatedier/frp/blob/master/README_zh.md
frpc.ini
[common]
server_addr = ngrok.lktoken.com
server_port = 9001
privilege_token = happyNoNG

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 20101


* 登录
  ssh -oPort=20101 leslie@ngrok.lktoken.com
  ssh -oPort=20102 pi@ngrok.lktoken.com

