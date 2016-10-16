<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

> * 注: chrome展示时的格式要和文件格式匹配，否则中文乱码。chrome格式: Settings - Web Content - customize fonts 里设置.

# 兼容HTML

这是一个普通段落。

<table>
  <tr>
    <td>Foo</td>
  </tr>
</table>

这是另一个普通段落

# 特殊字符自动转换
&copy;
AT&T
4 < 5

# 区块元素
## 段落
aaa
bbb


ccc
  我的
  你的


## 标题
### 标题3
###### 标题6

##区块引用.
> 区块引用

> a  jijj
>>bb 引用内的引用
 cc 空行才能结束引用，这里还在二级引用中.

> 空行后还是引用，则上面的引用没有结束。

空行后跟其他非引用标识来结束引用

## 列表
不管有序列表、无序列表都要有空格.
* 无序列表1
+ 无序列表2
- 无序列表3

*没有空格不是列表.

1. 有序列表1

2. 有序列表2
3. 有序列表3

1. 有序列表1
1. 有序列表2
1. 有序列表3

22. 有序列表1
1.没有空格，不是列表
3.没有空格，不是列表

## 代码区块
缩进至少4个空格表示是一个代码区块, 注意前面要有一个空行, 最后不一定要有.

    dddd
     <  >  aaa
    4 < 5
    a  b
    bbb

     ccc
代码区块结束, 没有缩进的行, 不足4个空格.

## 分割线
aaa
****
bbb
* * *
ccc
- - - - 
ddd
* * *
eee
- - -
fff
- - - - -

# 区段元素
## 链接

行内式:
这是[假百度](www.baidu.com)
这是[真百度](http://www.baidu.com)
这是[带title的真百度](http://www.baidu.com "百度")

参考式:
这是[百度] [百度链接]

[百度链接]: http://www.baidu.com "百度"

## 强调
显然不能有空格，有空格变成列表了.
*强调1*
**强调2**
_还是强调1_
__还是强调2__

## 代码
这是`print("%s", "a")`, 输出a

## 图片
行内式:
这是![osgi](/home/leslie/Work/j2ee/Document/Struts/struts-2.3.4/docs/WW/osgi-plugin.data/struts-osgi.jpg "osgi")

参考式:
这是![leopard] [img1]

[img1]: /home/leslie/Work/j2ee/Document/Struts/struts-2.3.4/src/apps/showcase/src/main/webapp/tags/ui/images/leopard.jpg  "leopard"

# 其他
## 反斜线
反斜线后加特殊字符:
\\
\`
\*
\_
\{\}
\[\]
\(\)
\#
\+
\-
\.
\!

## 自动链接
百度的网址是<http://www.baidu.com>, 注意网址一定要加http://
我的邮箱地址是 <leslie_wangyang@163.com>

# 数学公式
生成数学公式1：
<img src="http://chart.googleapis.com/chart?cht=tx&chl=\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" style="border:none;">

生成数学公式2：
<img src="http://www.forkosh.com/mathtex.cgi? \Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}">

生成数学公式3:
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>
$$x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$$
\\(x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}\\)


