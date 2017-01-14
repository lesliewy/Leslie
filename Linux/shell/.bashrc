# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# 将 rm 转为 mv;  /bin/rm 仍然为系统的rm命令;
function myrm(){
  timestamp=`date +%Y%m%d%H%M%S`
  for file in $@; do
    [ -d $file -o -f $file ] && mv $file /var/trash/$file.$timestamp 
  done	
}

# 加载func
. ~/.myfunc1

# 解决gvim启动报:GVIM: Unable to create Ubuntu Menu Proxy: Timeout was reached
function gvim () { (/usr/bin/gvim -f "$@" &) }

# 设置PS1
export PS1='\[\e]0;\u@\h: \W\a\]${debian_chroot:+($debian_chroot)}\u@\h \t:\W\$'

SHORTCUT_HOME=/home/leslie/Work/Leslie/Shortcut
set -o vi
alias cds='cd $SHORTCUT_HOME'
alias cd1='cd ~/MyProject/'
alias cd6='cd /usr/MyInterest'
alias cd7='cd /opt/Software'
#alias cd8='cd /home/leslie/Dropbox/Leslie'
alias cd8='cd /home/leslie/Work/Leslie'
alias cd9='cd ~/Work'
alias rm=myrm;
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

#export CLASSPATH=~/.vim/autoload:
export PATH=/sbin/:$SHORTCUT_HOME:$JAVA_HOME/bin:$MAVEN_HOME/bin:/opt/bc3/bin/:$ANT_HOME/bin:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$NUTCH_HOME/runtime/local/bin:$HBASE_HOME/bin:$HOME/Android/bin:$GROOVY_HOME/bin:$RUBY_HOME/bin:$NODE_HOME/bin:/usr/local/bin:$SOLR_HOME/bin:$NGINX_HOME/sbin:$PATH

# export DISPLAY=localhost:1.0

export R_HOME=/usr/lib/R

# rjava 中会使用 java.library.path.  这里设置的LD_LIBRARY_PATH在jvm启动时会读取, 追加到 java.library.path后面. 也可以在 jvm的启动参数中设置.
# 指定的是 libjvm.so的路径, rJava.so 中需要用到. ldd rJava/libs/rJava.so 来查看.
#export LD_LIBRARY_PATH=/usr/lib/R/site-library/rJava/jri/:/usr/local/lib/:$JAVA_HOME/jre/lib/amd64/server/
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server/

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# test
