

var isUserSelf=false;
var flag=0;
var isLogin=false;
if(!isUserSelf) 
{
     
        if(document.getElementById('tag_bar_title')!=null && document.getElementById('tag_bar_left')!=null)
        {
         document.getElementById('tag_bar_title').innerHTML='��ϵ����';
         document.getElementById('tag_bar_left').innerHTML="<a href='http://message.hexun.com/Send.aspx?id=4048425' target='_blank' title='����˽��'>����˽��</a> | <a style ='cursor:hand' href='http://hexun.com/4048425/messageboard.html' >����������</a> | <a href='http://i.hexun.com/gift/gift_index.aspx?userid=4048425' target='_blank'>��С����</a> | <a  href='http://i.hexun.com/focus/myfocusList.aspx?userid=4048425' target='_blank'>��ע����</a> | <a href='http://message.hexun.com/FriendsAdd.aspx?friend=4048425' target='_blank'>��Ϊ����</a> | <a href='http://i.hexun.com/myhome.html?id=4048425' target='_blank'>����Ta�ļ�</a> | <a href='http://t.hexun.com/4048425/default.html' target='_blank'>����Ta��΢��</a>";
        }
}

 if(document.getElementById("SelfTab_Login") !=null)
 {
     var login="";
     if(flag==1)
     {
        if (isLogin)
	    { 				
						
				login+="<a href='http://i.hexun.com/myhome.html' target=_blank>�����ҵļ�</a> | <a href='http://t.hexun.com/' target='_blank'>ȥ�ҵ�΢��</a> | <a  href='http://utility.tool.hexun.com/quit.aspx?gourl="+document.location.href+"'>�ǳ�</a> | ";
		}
		else
		{
				login+="<a href='javascript:GotoLogin()'>��¼</a> | <a href='http://reg.hexun.com' target='_blank'>ע��</a> | ";
		}
     }
     else
     {
        if (isLogin)
	    { 				
						
			login+="<a href='http://i.hexun.com/myhome.html' target=_blank>�����ҵļ�</a> | <a href='http://t.hexun.com/' target='_blank'>ȥ�ҵ�΢��</a> | <a  href='http://utility.tool.hexun.com/quit.aspx?gourl="+document.location.href+"'>�ǳ�</a> | ";
		}
		else
		{
			login+="<a href='javascript:GotoLogin()'>��¼</a> | <a href='http://reg.hexun.com' target='_blank'>ע��</a> | ";
		}
     }
     document.getElementById("SelfTab_Login").innerHTML=login;
 }

 function GotoLogin()
 {
    document.location.href='http://reg.hexun.com/login.aspx?gourl='+escape(window.document.location);
 }  
