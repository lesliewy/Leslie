#! /bin/bash
# 不能在tmux 内执行nohup
nohup mysqld > /dev/null &
