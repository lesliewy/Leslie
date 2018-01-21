** ab
   Apache 的Http性能测试工具.
   ab -n 10 -c 10 "http://paycenter.gotrip8.com/querypay.aspx?Version=1.0&InputCharset=GBK&SignType=MD5": get方式
   ab -n 1 -c 1 -T 'application/x-www-form-urlencoded' -p post.dat "http://127.0.0.1:8089/ponia/query?a=123&b=456": post方式测试;  post.dat 里面是参数: c=202CB962AC59075B964B07152D234B70&      最后那个&需要，否则会解释成换行; url 中的"" 是必须的，否则无法解析& 后的参数; 

** jmeter
   * jmeter 不要在命令行打开图形界面，在finder中打开.
   jmeter -n -t "兴趣雷达-API.jmx" -l report/01.csv -j log/01.log:   命令行方式.  使用gui创建jmx文件.  可以在图形界面的聚合报告中打开01.csv,查看结果.
