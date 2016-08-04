function shareHexunAll(){
var db=document.getElementById("douban");
if(db!=null){
db.href='http://www.douban.com/recommend/?url='+encodeURIComponent(document.location.href)+'&title='+encodeURIComponent(document.title);
}
var qq=document.getElementById("qq");
if(qq!=null){
qq.href='http://v.t.qq.com/share/share.php?&appkey=19b6600725374fbcb5dc4774c96b7b5d&url='+encodeURIComponent(document.location.href)+'&title='+encodeURIComponent(document.title);
}
var rr=document.getElementById("renren");
if(rr!=null){
rr.href='http://share.renren.com/share/buttonshare.do?link='+encodeURIComponent(document.location.href)+'&title='+encodeURIComponent(document.title);
}
var kx=document.getElementById("kaixin");
if(kx!=null){
kx.href='http://www.kaixin001.com/repaste/share.php?rtitle='+escape(document.title)+'&rurl='+encodeURIComponent(document.location.href)+'&rcontent=';
}
var sohu=document.getElementById("sohu");
if(sohu!=null){
sohu.href='http://t.sohu.com/third/post.jsp?&url='+escape(window.location.href)+'&title='+escape(document.title);
}
var sina=document.getElementById("sina");
if(sina!=null){
sina.href='http://v.t.sina.com.cn/share/share.php?title='+encodeURIComponent(document.title)+'&url='+encodeURIComponent(location.href)+'&source=bookmark';
}

var db1=document.getElementById("douban1");
if(db1!=null){
db1.href='http://www.douban.com/recommend/?url='+encodeURIComponent(document.location.href)+'&title='+encodeURIComponent(document.title);
}
var qq1=document.getElementById("qq1");
if(qq1!=null){
qq1.href='http://v.t.qq.com/share/share.php?&appkey=19b6600725374fbcb5dc4774c96b7b5d&url='+encodeURIComponent(document.location.href)+'&title='+encodeURIComponent(document.title);
}
var rr1=document.getElementById("renren1");
if(rr1!=null){
rr1.href='http://share.renren.com/share/buttonshare.do?link='+encodeURIComponent(document.location.href)+'&title='+encodeURIComponent(document.title);
}
var kx1=document.getElementById("kaixin1");
if(kx1!=null){
kx1.href='http://www.kaixin001.com/repaste/share.php?rtitle='+escape(document.title)+'&rurl='+encodeURIComponent(document.location.href)+'&rcontent=';
}
var sohu1=document.getElementById("sohu1");
if(sohu1!=null){
sohu1.href='http://t.sohu.com/third/post.jsp?&url='+escape(window.location.href)+'&title='+escape(document.title);
}
var sina1=document.getElementById("sina1");
if(sina1!=null){
sina1.href='http://v.t.sina.com.cn/share/share.php?title='+encodeURIComponent(document.title)+'&url='+encodeURIComponent(location.href)+'&source=bookmark';
}
}
shareHexunAll();
if (document.getElementById('share'))
{
var btnList = document.getElementById('share').getElementsByTagName("a");
var btndiv = document.getElementById('share').getElementsByTagName("div");
for(var i=0;i<btnList.length;i++){
   (function(i){
btnList[i].onmouseover = function(){
btndiv[i].className='on'
}
btnList[i].onmouseout = function(){
btndiv[i].className=''
}
})(i)
}
}
if (document.getElementById('sharetop'))
{
var btnList1 = document.getElementById('sharetop').getElementsByTagName("a");
var btndiv1 = document.getElementById('sharetop').getElementsByTagName("div");
for(var i=0;i<btnList.length;i++){
   (function(i){
btnList1[i].onmouseover = function(){
btndiv1[i].className='on'
}
btnList1[i].onmouseout = function(){
btndiv1[i].className=''
}
})(i)
}
}