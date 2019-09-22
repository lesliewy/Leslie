#! /bin/bash
# 解决微信文章无法保存图片的问题.
# a, 公众号文章用浏览器打开，右击，存储;  此时并不会下载公众号里的图片;
# b, 保存完后，执行该脚本;
# c, 浏览器打开新生成的html，再次右击，存储; 就可以将公众号里的图片下载到本地了.


IFS=$'\n'
# MacOS中 使用 -depth参数.
for file in `find $1 -maxdepth 1 -name "*.html"`; do
   suffix=${file:(-8)}
   if [ $suffix = "old.html" ]; then
      # rm $file
      continue
   fi
   sed  -e 's/data-src/src/g' -e 's/crossorigin="anonymous"//g'  -i.old.html "$file"
done

