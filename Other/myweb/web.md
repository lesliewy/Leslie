* npm init: 交互式生成package.json
* npm install -g express-generator:  安装可执行的 express,  npm 需要安装node.js. -g 表示全局的，在/opt/node-v4.4.3-linux-x64 目录下.
* npm install -g bower: 安装bower
* npm install -g grunt-cli: 安装grunt
* express -h:  查看命令行帮助.
* npm help install：  查看npm install 的帮助.
* npm start:  启动, pckage.json 里面的 scripts 值 .
* npm ls --depth 0: 和当前项目的package.json中package 一致. 也可以查看全局: npm ls -g --depth 0
* npm root: 查看安装路径   npm root -g
* npm view babel-loader@7.0.0: 查看包信息. repository.url, deps 等;  version 是当前查看包的版本.
* npm install babel-loader@7.1.2: 安装指定版本;
* npm install --save-dev babel-loader@^7:  指定版本范围, major version是7的最大的版本，这里是7.1.5
* npm adduser: 在本机添加npm user, 需要先注册，可以到官网注册
* npm publish: 发布当前package, 需要先 npm adduser
* npm pack: 打包当前目录, 会在当前目录生成tgz package.
* npm install ../parbat/parbat-1.0.2.tgz:  安装本地package.


* bower:  查看bower的命令说明.
* bower install angular --save: 将依赖写入bower.json
* bower install angular-sanitize#1.5.8 --save : 安装指定版本.
* bower uninstall angular: 将angualr模块删除，bower.json中的配置没有删除.
* bower uninstall angular-route --save:  将angualr模块删除，同时删除bower.json中的配置.
* bower search bootstrap-datepicker: 查找github上是否存在某包.

* npm install grunt --save-dev:  本地安装grunt, 使用grunt-cli时需要本地安装，全局安装的不行，会报错。

* 在app.js目录下，执行 node ./bin/www 来启动server. 默认端口3000   http://127.0.0.1:3000/
---------------------------

# 环境搭建
1. cd StockWeb;  express -e angular-basic:  生成express框架, 也就是nodejs相关的服务端配置.
cd angular-basic && npm install: 安装相关的依赖，根据package.json文件,并将依赖放在node_modules目录.

2. 创建Angularjs需要的目录及文件
目录：
D:\workspace\javascript\angular-basic>mkdir app
D:\workspace\javascript\angular-basic>mkdir app\scripts
D:\workspace\javascript\angular-basic>mkdir app\scripts\angular
D:\workspace\javascript\angular-basic>mkdir app\styles
D:\workspace\javascript\angular-basic>mkdir app\views
D:\workspace\javascript\angular-basic>mkdir app\views\component
D:\workspace\javascript\angular-basic>mkdir app\views\tpl
目录解释：
app目录: Angular项目的根目录
scripts目录: 存放Javascript脚本目录
scripts\angular目录: 存放Angular Javascript脚本目录
styles目录: 存放css的目录
views目录: 存放html的目录
views\component目录: 存放html的自定义组件目录
views\tpl目录: 存放html的目录 <br/>
文件:
D:\workspace\javascript\angular-basic>touch app\index.html
D:\workspace\javascript\angular-basic>touch app\scripts\angular\app.js
D:\workspace\javascript\angular-basic>touch app\scripts\angular\controllers.js
D:\workspace\javascript\angular-basic>touch app\styles\main.css
D:\workspace\javascript\angular-basic>touch app\views\tpl\welcome.html
D:\workspace\javascript\angular-basic>echo "aaaa" > app\index.htm
文件解释：
app\index.html: Angular项目的入口文件
styles\main.css: Angular项目的css文件
scripts\angular\app.js: Angular项目全局配置文件
scripts\angular\controllers.js: Angular项目全局控制器文件/li>
views\tpl\welcome.html: 欢迎页

3. 配置bower
通过bower来安装Angularjs和Bootstrap，以及其他依赖的前端库
新建.bowerrc  bower.json
bower install 来安装.

4. 配置Angularjs项目
修改index.html: 在入口文件，页面模板
修改welcome.html: 欢迎页
修改app.js: 全局配置
修改controller.js: 控制器

5. 增加Bootstrap
bower install bootstrap --save
bower install angular-bootstrap --save
修改index.html: 增加css, js的引用
修改welcome.html: 增加bootstrap的效果

## Alligator  
  * 使用 nw.js + React  
  * npm install --save-dev react：安装最近版本的react. 非全局安装，文件放在 alligator/node_modules 下。  



# bootstrap
* 文档: http://v4.bootcss.com/getting-started/introduction/
* bower list: 列出本地通过bower安装的包.
  bower search angular: 模糊查找和angular有关的包， 但是不包括angular-route
  bower search angular-route: 这个才会查找angular-route相关的包.

# Angularjs
* 官方下载angularjs, 
   > 1. 需要使用gulp, 全局和本地都要下载. npm install -g gulp    angularjs目录下: npm install gulp
   > 2. angular.js-1.5.8/docs目录下:  gulp
   
* 编译官方下载的AngularJS
   > 1. 先将 bower.json 中的closure-compiler 行修改成: "closure-compiler": "../build_need/google_closure_compiler/", 之前是google的url, 连接不上, 先单独下载好.
   > 2. npm install: 安装 package.json中的package.
   > 3. grunt package: 编译AngularJS

* Angular是前端框架, 没有服务端也可以。比如直接在html引入angular, 一样可以使用controller, 数据绑定。用浏览器打开html就可以测试效果。 但不可以使用angular-route， 因为这不是http协议，是file协议。

* Grunt+Bower+Requirejs+Angular : https://my.oschina.net/xianggao/blog/608779
  本地位置: /home/leslie/MyProject/AngularJS/my2
  这几个都是前端用到的，可以没有服务端，一般都是用node.js

* 带有服务端(Express 是nodejs框架之一)的环境搭建: 
  * express: 生成express 框架
  * npm install: 下载所需的dependencies. 此时已经可以启动服务端了. npm start即可. package.json中默认有start配置.
                  http://127.0.0.1:3000
  * 按照 Grunt+Bower+Requirejs+Angular 搭建. 
    npm init 不需要了, Express已经完成.
    npm install grunt --save-dev: 需要， grunt-cli 安装成全局的， 而grunt每个项目都需要单独安装.
    npm install grunt-cli -g: 可以不要.
    npm install grunt-init -g: 可以不要.
    git clone https://github.com/gruntjs/grunt-init-gruntfile.git ~/.grunt-init/gruntfile: 如果已经存在的话，可以不要
    grunt-init gruntfile: 需要，生成grunt配置Gruntfile.js
    npm install bower -g: 可以不要。
    bower init: 需要,生成bower配置. bower.json
  
* 执行grunt相关命令时，会从本地目录开始找Gruntfile.js，没有的话找父目录，所以是可以嵌套的.

* bower.json, package.json等文件中版本号的使用: https://github.com/npm/node-semver#ranges

# e2e测试
* jasmine: /home/leslie/MyProject/Other/jasmine
* WebDriverJS，Jasmine和Protractor
  * npm install selenium-webdriver
    npm install chromedriver: 测试程序中需要require('chromedriver'); 或者chromedriver在PATH路径里.
    npm install jasmine-node: jasmine测试框架
    写测试文件test.js
   node test.js,没有使用jasmine框架
   ./node_modules/jasmine-node/bin/jasmine-node test/test1.js: 使用了jasmine框架

# karma
* [karma 官网](http://karma-runner.github.io)
* [常用的前端自动化测试工具介绍 —— Karma（二）](https://www.jianshu.com/p/9ab441d6a1f4)

npm install --save-dev karma
npm install --save-dev karma-jasmine karma-chrome-launcher jasmine-core
npm install -g karma-cli: 全局安装,将命令路径(/usr/local/lib/node_modules/karma/bin/karma)添加到PATH中.
karma init: 交互式设置测试环境;
karma start: 执行karma测试;

# phantomjs
* 提供了js运行环境, 官网下载，添加到path, 直接phantomjs 命令进入;  也可以phantomjs a.js 来执行a.js.


# Node.js
* node.js 是服务端框架.
* node 命令进入node环境,  "global.module.paths" 查看查找module的路径.
* npm install npm@latest -g: 使用npm安装npm
  npm install -g n:  模块n用来管理node, 安装完node后需要修改PATH.
  n stable: 升级到最新稳定版.
  n v0.10.26: 升级到指定版本.

# Tomcat
http://127.0.0.1:8080/stanalyse/analyse/industryHotStocks?from=2016-01-01&to=2016-05-01&callback=a
http://123.57.50.82:8080/stanalyse/analyse/industryHotStocks?from=2016-01-01&to=2016-05-01&callback=a

http://123.57.50.82:3838/

# webpack
* 入门参考: http://www.cnblogs.com/xuehaoyue/p/6410095.html
  http://www.cnblogs.com/vajoy/p/4650467.html

# Vue
* [vue 官网](https://cn.vuejs.org/)
* [vue 教程](https://cn.vuejs.org/v2/guide/)
* [vue-cli 环境配置](http://vuejs-templates.github.io/webpack/)

# webpack + vue
* [从零开始搭建一个简单的基于webpack的vue开发环境](https://segmentfault.com/a/1190000012789253)

# TODO
* 初期可以用表格的方式，后期改成图
* 某时间段内概念、行业涨跌幅排名;
* 某时间段内某概念(某行业)内股票涨跌幅排名;
* 
* 模板1365: /home/leslie/Work/HTML/Template/moban1365
* 视差滚动
http://tnc.org.cn/
https://segmentfault.com/q/1010000000601024
http://www.cnblogs.com/e50000/p/5856064.html
* redis 缓存.  先不考虑， dashboard上的诗词数量可以写个简单的map存放.
* mysql 异步复制.
* 百度api  图片中获文字.
* 防止按钮重复点击: 包括诗词查询、股票查询.