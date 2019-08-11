
# 将 rm 转为 mv;  /bin/rm 仍然为系统的rm命令;
function myrm(){
  timestamp=`date +%Y%m%d%H%M%S`
  for file in $@; do
    [ -d $file -o -f $file ] && mv $file /var/trash/$file.$timestamp 
  done	
}

# 加载func
#. ~/.myfunc1

# 解决gvim启动报:GVIM: Unable to create Ubuntu Menu Proxy: Timeout was reached
function gvim () { (/usr/bin/gvim -f "$@" &) }

# 设置PS1
#export PS1='\[\e]0;\u@\h: \W\a\]${debian_chroot:+($debian_chroot)}\u@\h \t:\W\$'
# 必须包含在\[ \]中，否则超长命令不会折行.
export PS1="\[\e[32m\]\u\[\e[0m\]\[\e[33m\]@\[\e[0m\]\[\e[34m\]\h\[\e[0m\][\[\e[36m\]\W\[\e[0m\]] \[\e[31m\]\t\[\e[0m\]\$ "

SHORTCUT_HOME=/home/leslie/myprojects/GitHub/Leslie/Shortcut
set -o vi
alias cds='cd $SHORTCUT_HOME'
alias cd1='cd ~/myprojects/'
alias cd6='cd /usr/MyInterest'
#alias cd7='cd /opt/Software'
alias cd7='cd /home/leslie/Software'
#alias cd8='cd /home/leslie/Dropbox/Leslie'
alias cd8='cd /home/leslie/Work/Leslie'
alias cd9='cd ~/Work'
#alias rm=myrm;
# 列出当前目录下所有文件的绝对路径.
alias lsp='ls | sed "s:^:`pwd`/:g"'

#export JAVA_HOME=/opt/jdk/oracle/jdk1.6.0_45
export JAVA_HOME=/opt/jdk/oracle/jdk1.7.0_45
#export JAVA_HOME=/opt/jdk/oracle/jdk1.8.0_112

MAVEN_HOME=/opt/apache-maven-3.1.0
ANT_HOME=/opt/Software/ProgrammingSoftware/Apache/apache-ant-1.9.2
#ANDROID_SDK_HOME=/opt/android-sdk-linux
ANDROID_SDK_HOME=/home/leslie/Android/Sdk
#NUTCH_HOME=/opt/apache-nutch-1.8
NUTCH_HOME=/opt/apache-nutch-2.2.1
HBASE_HOME=/opt/hbase-0.90.4
GROOVY_HOME=/opt/groovy-2.4.3
RUBY_HOME=/usr/local/ruby-2.3.1
#NODE_HOME=/opt/node-v4.4.3-linux-x64
NODE_HOME=/opt/nodejs/n/versions/node/7.2.1
PYTHON_HOME=/opt/python3.5
SOLR_HOME=/opt/solr-5.3.0
NGINX_HOME=/opt/nginx
ZOOKEEPER_HOME=/opt/zookeeper-3.3.6

#export CLASSPATH=~/.vim/autoload:
export PATH=/sbin/:$SHORTCUT_HOME:$JAVA_HOME/bin:$MAVEN_HOME/bin:/opt/bc3/bin/:$ANT_HOME/bin:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$NUTCH_HOME/runtime/local/bin:$HBASE_HOME/bin:$HOME/Android/bin:$GROOVY_HOME/bin:$RUBY_HOME/bin:$NODE_HOME/bin:/usr/local/bin:$SOLR_HOME/bin:$NGINX_HOME/sbin:$ZOOKEEPER_HOME/bin:$PATH

# export DISPLAY=localhost:1.0

export R_HOME=/usr/lib/R

# rjava 中会使用 java.library.path.  这里设置的LD_LIBRARY_PATH在jvm启动时会读取, 追加到 java.library.path后面. 也可以在 jvm的启动参数中设置.
# 指定的是 libjvm.so的路径, rJava.so 中需要用到. ldd rJava/libs/rJava.so 来查看.
#export LD_LIBRARY_PATH=/usr/lib/R/site-library/rJava/jri/:/usr/local/lib/:$JAVA_HOME/jre/lib/amd64/server/
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server/

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
