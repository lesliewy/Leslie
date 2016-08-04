#! /bin/bash
#  no  TMOUT

TIMER_INTERRUPT=14
TIMELIMIT=3

PrintAnswer(){
   if [ "$answer" = TIMEOUT ]; then
      echo $answer
   else 
      echo "Your favourite veggie is $answer"
      kill $!                                       # kill jobs
   fi
}

TimerOn(){
   sleep $TIMELIMIT && kill -s 14 $$ &              # 3s后,发送信号.
}

Int14Vector(){
   answer="TIMEOUT"
   PrintAnswer
   exit $TIMER_INTERRUPT
}

trap Int14Vector $TIMER_INTERRUPT                   # trap 是buildin comand help trap   , 相当于添加一个监听、handler.                

echo "What is your favourite vegetable"
TimerOn
read answer
PrintAnswer
