#!/bin/bash
# 启动两个session: work(10个window), interest(6个window)

create_session(){
   session_name=$1
   num_of_window=$2
   # session 不存在情况下创建
   $cmd has -t $session_name
   existed=$?
   if [ $existed == 0 ]; then
      echo "session: $session_name 已存在"
      exit 1
   fi
   if [ $existed != 0 ]; then
       #new session, window name is "window0"
   #    $cmd new -s $work_session -d -n window0
       $cmd new -s $session_name -d 
   
       for ((i=0; i < $num_of_window - 1; i++))
       do
   #        $cmd neww -n $winName -t $work_session -d
            $cmd neww -t $session_name -d
   
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
create_session work 10
create_session interest 6

#默认进入work
$cmd att -t work
#$cmd selectw -t work

exit 0

# 关闭：
#tmux kill-session -t work
