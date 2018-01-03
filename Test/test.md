** ab
   Apache 的Http性能测试工具.
   ab -n 10 -c 10 "http://paycenter.gotrip8.com/querypay.aspx?Version=1.0&InputCharset=GBK&SignType=MD5": get方式
   ab -n 1 -c 1 -T 'application/x-www-form-urlencoded' -p post.dat "http://127.0.0.1:8089/ponia/query?a=123&b=456": post方式测试;  post.dat 里面是参数: c=202CB962AC59075B964B07152D234B70&      最后那个&需要，否则会解释成换行; url 中的"" 是必须的，否则无法解析& 后的参数; 
