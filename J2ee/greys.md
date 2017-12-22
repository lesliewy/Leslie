* **安装**
  解压后执行 ./install-local.sh   不需要联网

  ./greys.sh pid

* **help**
  help 查看命令说明.
  help sc: 查看某个命令说明.

* **sc**
  sc -dE .*IntentScoreIndServiceImpl: class 详细信息.
  sc -d cn.fraudmetrix.creditcloud.tigris.biz.service.impl.IntentScoreIndServiceImpl: 基本等于上面.

* **sm**
  sm -d *PreLoanApplyService apply:  查看PreLoanApplyService中的apply()信息.
  sm -E .*IntentScoreIndImpl
  sm -dE .*IntentScoreIndImpl:  所有方法详情. 也可以: sm -d cn.fraudmetrix.creditcloud.tigris.api.impl.IntentScoreIndImpl

* **watch**
  watch -b cn.fraudmetrix.creditcloud.tigris.api.impl.IntentScoreIndImpl queryMultiInd params[0]: 监控queryMultiInd 的参数0(第一个参数), 可以改成params[1]
  watch -b cn.fraudmetrix.creditcloud.tigris.api.impl.IntentScoreIndImpl queryMultiInd params[0] -x 1:  -x表示输出的层级,会同时输出参数类型, 但是如果是json的话，最好别加-x 1, 不会展示json内的字段值, 如果是json 需要 -x 2, 或者不加 -x

  watch -b cn.fraudmetrix.creditcloud.tigris.biz.service.impl.MonitorPartnerServiceImpl getPartner params[0]+params[1]+params[2]:   监控多个参数， + 前后不要有空格.  不过输出不好看: zhaoyaotestcasefalse

  watch -f cn.fraudmetrix.creditcloud.tigris.biz.service.impl.IntentScoreIndServiceImpl queryMultiInd returnObj: 获取方法的返回值, 注意这里不能使用 -b

* **trace**
  trace cn.fraudmetrix.creditcloud.tigris.api.impl.IntentScoreIndImpl queryMultiInd: queryMultiInd 方法内部每个方法的执行时间.
     [5, 0ms]:  到目前总共执行时间5ms, 当前方法执行时间0ms
     [7, 1ms]:  到目前总共执行时间7ms, 当前方法执行时间1ms
     [67,60ms]: 到目前总共执行时间67ms, 当前方法执行时间60ms

* **tt**
  tt -t -n 3 cn.fraudmetrix.creditcloud.tigris.api.impl.IntentScoreIndImpl queryMultiInd: 记录3次调用
  tt -i 1001:  每一次调用的详细信息. 包含堆栈信息.  堆栈信息也可以: stack 
  tt -i 1001 -x 3:  可以带上层级的参数.
  cn.fraudmetrix.creditcloud.tigris.api.impl.IntentScoreIndImpl queryMultiInd 来监控.

* shutdown quit
  shutdown: 关闭greys server + quit console
  quit:  quit console,   quit后可以直接  greys.sh 进入已连接的greys server.

* 可以监控private static 等
