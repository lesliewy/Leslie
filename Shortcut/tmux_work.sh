#!/bin/bash
# 启动两个session: work(10个window), interest(6个window)
#set -x

create_session(){
   session_name=$1
   num_of_window=$2
   # session 不存在情况下创建
   $cmd has -t $session_name 2>/dev/null
   existed=$?
   if [ $existed == 0 ]; then
      echo "session: $session_name 已存在"
      exit 1
   fi
   if [ $existed != 0 ]; then
       #new session, window name is "window0"
   #    $cmd new -s $work_session -d -n window0
       $cmd new -s $session_name -d 
   
       # 默认是有一个的, i 从1开始.
       for ((i=1; i <= $num_of_window - 1; i++))
       do
            if [ $session_name == "work" ]; then
               # $cmd neww -n $winName -t $work_session -d
               $cmd neww -t $session_name -d
               [ $i -ge 3 -a $i -le 4 ] && $cmd rename-window -t $i "git"
               [ $i -ge 5 -a $i -le 9 ] && $cmd rename-window -t $i "remote"
            fi
            if [ $session_name == "interest" ]; then
               [ $i -eq 4 ] && $cmd neww -t $session_name -c "/Users/leslie/Work/Favorite" -n "Favorite" -d && continue
               [ $i -eq 5 ] && $cmd neww -t $session_name -c "/Users/leslie/MyProjects/GitHub/Leslie" -n "Leslie" -d && continue
               # $cmd rename-window -t $i "Leslie"
               $cmd neww -t $session_name -d
            fi
   
           #split window ""
   #        $cmd splitw -v -p 50 -t $winName
   #        $cmd splitw -h -p 50 -t $winName
   #        $cmd selectp -t 0
   #        $cmd splitw -h -p 50 -t $winName
   #        $cmd selectp -t 0
      done
   fi
}

cmd=$(which tmux) 

if [ -z $cmd ]; then
    echo "You need to install tmux."
    exit 1
fi

# 这里数字代表总共有多少window
create_session work 10
create_session interest 6

#默认进入work
$cmd att -t work
#$cmd selectw -t work

exit 0

# 关闭：
#tmux kill-session -t work
