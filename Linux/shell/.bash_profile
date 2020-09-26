
#if [ -f ~/.bashrc ]; then
#    . ~/.bashrc
#fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


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

set -o vi
SHORTCUT_HOME=/home/leslie/myprojects/GitHub/Leslie/Shortcut
alias cds='cd $SHORTCUT_HOME'
alias cd1='cd ~/myprojects/'
#alias cd6='cd /usr/MyInterest'
#alias cd7='cd /opt/Software'
alias cd7='cd /home/leslie/Software'
#alias cd8='cd /home/leslie/Dropbox/Leslie'
#alias cd8='cd /home/leslie/Work/Leslie'
alias cd9='cd ~/Work'
alias cdl='cd ~/myprojects/GitHub/Leslie'
#alias rm=myrm;
# 列出当前目录下所有文件的绝对路径.
alias lsp='ls -a| sed "s:^:`pwd`/:g"'

# JDK 设置
JAVA_HOME=/opt/jdk/jdk1.8.0_221
export JAVA_7_HOME=/opt/jdk/jdk1.7.0_80
export JAVA_8_HOME=/opt/jdk/jdk1.8.0_221
alias jdk7="export JAVA_HOME=$JAVA_7_HOME && source ~/.bash_profile"
alias jdk8="export JAVA_HOME=$JAVA_8_HOME && source ~/.bash_profile"

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

# 颜色配置
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

