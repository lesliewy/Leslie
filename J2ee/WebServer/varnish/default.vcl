# This is a basic VCL configuration file for varnish.  See the vcl(7)
# man page for details on VCL syntax and semantics.
# 
# Default backend definition.  Set this to point to your content
# server.
# 被代理的服务器; 此时访问 http://localhost:8070/myphptest/index1.html 相当于访问 127.0.0.1/8085/myphptest/index1.html;  其中 8070是varnish 的监听端口;  
 backend default {
     .host = "127.0.0.1";
     .port = "8085";
 }
# 
# Below is a commented-out copy of the default VCL logic.  If you
# redefine any of these subroutines, the built-in logic will be
# appended to your code.
# vcl_recv: 在反向服务器接收到浏览器请求时调用;
# sub vcl_recv {
#     if (req.restarts == 0) {
# 	if (req.http.x-forwarded-for) {
# 	    set req.http.X-Forwarded-For =
# 		req.http.X-Forwarded-For + ", " + client.ip;
# 	} else {
# 	    set req.http.X-Forwarded-For = client.ip;
# 	}
#     }
#     if (req.request != "GET" &&
#       req.request != "HEAD" &&
#       req.request != "PUT" &&
#       req.request != "POST" &&
#       req.request != "TRACE" &&
#       req.request != "OPTIONS" &&
#       req.request != "DELETE") {
#         /* Non-RFC2616 or CONNECT which is weird. */
#         return (pipe);
#     }
#     if (req.request != "GET" && req.request != "HEAD") {
#         /* We only deal with GET and HEAD by default */
#         (pass) 表示不检查缓存，直接发往后端服务器;
#         return (pass);
#     }
#     if (req.http.Authorization || req.http.Cookie) {
#         /* Not cacheable by default */
#         return (pass);
#     }
#     (lookup) 表示检查缓存,后续可能执行vcl_hit 或者 vcl_miss;
      # 支持负载均衡时使用; load 是定义的负载均衡器;
#     set req.backend=load;      
#     return (lookup);
# }
# 
# sub vcl_pipe {
#     # Note that only the first request to the backend will have
#     # X-Forwarded-For set.  If you use X-Forwarded-For and want to
#     # have it set for all requests, make sure to have:
#     # set bereq.http.connection = "close";
#     # here.  It is not set by default as it might break some broken web
#     # applications, like IIS with NTLM authentication.
#     return (pipe);
# }
# 
# sub vcl_pass {
#     return (pass);
# }
# 
# sub vcl_hash {
#     hash_data(req.url);
#     if (req.http.host) {
#         hash_data(req.http.host);
#     } else {
#         hash_data(server.ip);
#     }
#     return (hash);
# }
# 
# sub vcl_hit {
#     return (deliver);
# }
# 
# sub vcl_miss {
#     return (fetch);
# }
# 
# vcl_fetch: 在反向服务器接收到后端服务器的内容时调用;
# sub vcl_fetch {
      # ttl表示缓存有效期;
#     if (beresp.ttl <= 0s ||
#         beresp.http.Set-Cookie ||
#         beresp.http.Vary == "*") {
# 		/*
# 		 * Mark as "Hit-For-Pass" for the next 2 minutes
# 		 */
# 		set beresp.ttl = 120 s;
# 		return (hit_for_pass);
#     }
#     (deliver)表示将缓存写入缓存区;
#     return (deliver);
# }
# 
# sub vcl_deliver {
#     return (deliver);
# }
# 
# sub vcl_error {
#     set obj.http.Content-Type = "text/html; charset=utf-8";
#     set obj.http.Retry-After = "5";
#     synthetic {"
# <?xml version="1.0" encoding="utf-8"?>
# <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
#  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
# <html>
#   <head>
#     <title>"} + obj.status + " " + obj.response + {"</title>
#   </head>
#   <body>
#     <h1>Error "} + obj.status + " " + obj.response + {"</h1>
#     <p>"} + obj.response + {"</p>
#     <h3>Guru Meditation:</h3>
#     <p>XID: "} + req.xid + {"</p>
#     <hr>
#     <p>Varnish cache server</p>
#   </body>
# </html>
# "};
#     return (deliver);
# }
# 
# sub vcl_init {
# 	return (ok);
# }
# 
# sub vcl_fini {
# 	return (ok);
# }

# 实现负载均衡;
# backend 用来定义后端服务器;
backend web01 {  
       .host = "192.168.10.244";  
       .port = "80";  
       # probe 定义健康探测, 只有返回200才是正常的;
       .probe = {  
               .url = "/probe.html";  
               .interval = 5s;  
               .timeout = 1 s;  
               .window = 5;  
               .threshold = 3;  
       }  
}  
backend web02 {  
       .host = "192.168.10.243";  
       .port = "80";  
       .probe = {  
               .url = "/probe.html";  
               .interval = 5s;  
               .timeout = 1 s;  
               .window = 5;  
               .threshold = 3;  
       }  
}  
backend web03 {  
       .host = "192.168.10.242";  
       .port = "80";  
       .probe = {  
               .url = "/probe.html";  
               .interval = 5s;  
               .timeout = 1 s;  
               .window = 5;  
               .threshold = 3;  
       }  
}  
# director 定义负载均衡器名称为load; 并使用 RR 调度;
# 还要修改 vcl_recv, 添加负载均衡器;
director load round-robin {  
       {  
               .backend = web01;  
       }  
       {  
               .backend = web02;  
       }  
       {  
               .backend = web03;  
       }  
}
