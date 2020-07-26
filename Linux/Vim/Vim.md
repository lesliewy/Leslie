   /home/leslie/Work/Linux/Vim/vim73doc  使用这里的帮助文档.

builtin function: 在:help  eval.txt中.

vim -p filenames:   tab标签打开文件;  :tabnew filename 新增一个文件;   :tabn 下一个tab标签, 同gt;   :tabp 上一个tab标签，同gT;

0,基本概念
   vi 打开一个文件后的状态: 一般模式
   i,a后转入的模式        : 编辑模式
   :1,5s/from/to/         : 命令模式
 1,vi中选中的一块整体移动
   先设置shiftwidth,即将要移动的距离：set sw=1;然后ctrl+v(如果没有快捷键的话),此时即可以选中要选的矩形块，>:右移shiftwidth;<:左移shiftwidth;

 2,参数设置
    :set nowrap , set wrap   : 设置是否折行显示。
    :set fileencoding        : 查看fileencoding,如果与 set encoding的结果不一致，vi会转为encoding, 有可能会出现 conversion error 的错误信息.需要将fileencoding                              设置为encoding的值，一般为 set fileencoding=utf-8
                               参看 linux/software/linux&software.txt中vim部分关于vim编码的工作方式部分.
   : set ic                : ignorecase,   set ic smartcase : 如果有一个大写就是精确查找. 全小写是模糊查找.
    :sh                      : 修改了该文件，但是没有保存,进入console界面，使用exit，返回vi界面.
    ctrl + +                 : 放大字号.
    ctrl + -                 : 缩小字号.

 3,查找替换
    :1,5s/from/to/        :将第1－5行中的from 改为to,每行只匹配第一个找到的from
    :1,5s/from/to/g       :同上，但匹配所有的from。
    :%s/from/to/g         :替换所有行的from   如果不加"%",则默认只是当前行  
    :%s/<tr//gn: 只显示匹配的字符串个数, 不实际替换.  关键是最后的n.  
   : %s/\n/\n/g           : 这里要注意，第一个\n表示<NL>(换行), 第二个表示<Nul>（空字符, 表示为^@), 可以参看:help CR-used-for-NL.     直接搜索换行可以仍然用 /\n
   : %s/\n/^M/g          :  这里是将换行替换成换行了， 第二个汗行是^M(Ctrl-v  Ctrl-M).
    fx                    :在当前行中向后查找字母x, ";"表示下一个,","表示上一个
    Fx                    :在当前行中向前查找字母x, ";"表示下一个,","表示上一个
    \Wstatus\W            :查找模式下，精确查找status. \w:number + alphabet     \W: 除去数字、_ 和字母外的所有，包括空格、tab、汉字.但是不包括换行.用<status>
                           可以包括换行,可以匹配行末是status的情况,在vim中查找时用/\<status\>
   /abc/2   /abc/-2    /abc/e    /abc/e+2  :    查找到后，光标的位置.
   /\(abc\)*      /\(abc\)\+     /abc\(abc\)\?   /\(abc\)\{2,5}      /\(abc\)\{2}   :   把abc作为一个整体, "*" 前面不需要"\" ;  "{"前需要"\", "}"前不需要"\"
   /abc\|def   /[a-f0-9]     :   和"*"一样, "["前不需要"\"
   /abc\&ab:  此行表示查找abc中的ab，而不是既包括abc又包括ab的行.     /^".*\&leslie: 查找以"开头的所有行中的leslie, 即前一个当中的后一个.
   /\d  /\D  /\a   /\s   /\S  \w
   /abc\n\s*abc  : 匹配换行, abc\n, 下一行开头是空白符abc.        /abc\_s*abc   : 同前一个，但是\n不是必须的.
   
    :grep root *.txt      : 类似于在命令行中执行,会显示出当前所有以txt为扩展名文件中包含root的行. 只作为显示，不能跳到该文件.
    :vimgrep root *.txt   : 在vim7.3中即使没有打开全部的txt文件,使用:cn可以跳转到该文件. :n 是在当前文件中下一处.
    :argdo %s/root/leslie/e 对当前buffers中的所有文件进行查找替换.
ggguG:  全部转为小写;    gggUG全部转为大写;  gu0: 光标所在处至行首转为；   gU$: 光标所在处至行尾转为大写;
guw,  gu5w: 单词转换；   guG:  所在处至最后    gu1G: 所在处至文章开始.

 4, 删除
    2dd                   : 删除当前开始往下2行(包括当前所在行)
    d$                    : 删除光标当前位置至该行末的所有字符.
    dG                    : 删除当前行至文件末尾.
    :10,500d              : 删除第10至第500行(包括第10行和第500行)。
    :%s/^\n//g            :删除所有空行        其中：  % 相当于 1,$   即所有文本。  s 为substitute缩写。
    :%s/^\n$//g           :有多行空行时，只保留一行
 5,多个文件编辑
    :n                    : 转到下一个文件
    :bn                   : buffers 中的下一个文件，可以循环，而:n不可以.
    :e#                   : 返回上一个文件,只能在两个文件中间切换
    :e filename           : 编辑名称为filename的文件.
    vi -o a.txt b.txt     : 可以分屏显示2个文件,ctrl w 切换,此方法可以解决两个文件之间用vi进行复制粘贴的问题.不加-o选项也是可以的.
    :split                : 将当前文件copy为上下两屏,使用ctrl +w切换
    :vsplit               : 将当前文件copy为左右两屏,使用ctrl +ww切换
    * 多个文件编辑时, :reg 中的所有的都是共享的,包括删除后使用p来粘贴删除(即在a文件中dw,可以在b文件中使用p来粘贴刚刚删除的).
 6,复制移动
    :28,31 mo 7           : 将28－31行移动到第7行的后面
    y$                    : 复制光标至行末的数据.p命令粘贴在当前光标之后
    cc                    : 剪切当前行.必须紧接着使用p命令.
                          : 复制文本的存放区域与删除文本的存放区域相同，并且会覆盖，所以不可以混合.
   "+y                ： 复制到系统剪切板
   "+p                ： 把系统粘贴板里的内容粘贴到vim
   :set paste      : 复制代码的时候会自动缩进，使用该命令后，就不会了.
 7, 光标移动
    gg                   : 转到文件的第一行,同 1G 命令.
    G                    : 转到文件的最后一行
 8, 使用缓冲区
    "a3yw                 : 一般模式下执行,将当前光标及其后面的3个word复制到a缓冲区，前面双引号是必须的. "b4yy  :将后面的4行复制到b缓冲区,a和b是独立的。
    "ap                  : 将a缓冲区中的内容粘贴.
                           如果是多个文件之间的复制粘贴，可以使用:ex filename,来转换，缓冲区中的内容不会失去.
 9, 使用标记.
    ma                    : 一般模式下使用。将此行做一个标记a,    使用 'a   来转到a标记的行.

 10, :! ls -lrt           : 使用 ! 可以执行linux shell 命令.
     :r!ls -lrt           : 将!后面命令执行的结果添加到光标所在行的下面.
     
 11, 折叠
     idea-vim中使用的方式:
    zR  – 打开所有折行； idea-vim 中打开所有方法
    zM  – 收起所有折行； idea-vim 中收起所有方法。以方法为单位，看左边的 + - 
    zo – 打开折叠的文本； idea-vim 中打开当前所在的方法; 
    zc – 收起折叠；      idea-vim 中折叠当前所在的方法.


 .vimrc  :  每次vi打开文件时都会执行.
     set fileencodings=utf-8   :   如果不设置，vim可能无法辨认文件类型，从而无法转换.
    set mouse=v  : 可以使用系统粘帖板内容. 在terminal中右键可以copy.
在vi的命令状态下 :
 :%!xxd ——将当前文本转换为16进制格式。
 :%!od ——将当前文本转换为16进制格式。
 :%!xxd -c 12——将当前文本转换为16进制格式,并每行显示12个字节。
:%!xxd -r ——将当前文件转换回文本格式。
不同于上面的 :!ls

** 格式化xml
First, highlight the XML you want to format.

Then, in normal mode, type ! xmllint --format -

Your command-line at the bottom will look like this:

:'<,'>!xmllint --format -

Then hit enter.
** 保存一个没有权限的已编辑文件:
w   !sudo tee %

** 多个窗口间移动:  ctrl + w + [hljk]

** 插件管理
Pathogen:   本来没有.vim目录的, 只有一个.vimrc  
安装pathogen, 建两个目录，下载pathogen.vim: mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
pathogen使用: http://www.cnblogs.com/litifeng/p/5597565.html

Vundle 安装: git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   然后在.vimrc 中添加： mac 中vundle begin    vundle end 中部分;
   :PluginInstall   安装.vimrc 中配置的插件;
   :PluginSearch plugin-name    搜索插件,可以交互式安装;  不需要再.vimrc中配置了.
   :PluginClean
   .vimrc 中有几种类型安装:
      Plugin 'user/plugin':   从Github进行安装
      Plugin 'plugin_name':   从http://vim-scripts.org/vim/scripts.html进行安装：
      Plugin 'git://git.another_repo.com/plugin':  从另一个git软件库进行安装
      Plugin 'file:///home/user/path/to/plugin': 从本地文件进行安装

* vim git 安装: https://vim.sourceforge.io/git.php
    可能报错需要安装: sudo apt-get install  libncurses5-dev

* vundle
  安装: git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  配置.vimrc

  :BundleInstall   安装（更新）插件 

  :BundleClean  卸载插件 

  :BundleList  显示所有插件 

  :BundleSearch 插件名称    查找插件 

  :BundleSearch! 插件名称   刷新插件（下面插件名称的）缓存 

   BundleClean!   清除插件缓存 a
   
** taglist
   使用vundle 安装:  PluginSearch taglist.vim
   help taglist.txt:   帮助文档;
   :Tlist   打开taglist， 前提是已经执行过 ctags -R

** WinManager
   :PluginSearch WinManager   来安装;
   可以用来管理自带的netrw  taglist  窗口;


问题:
  1, 写一个plugin, 可以根据文件类型(sed,awk,c,c++,java,vim)来添加不同格式的注释.
