//document.domain = "hexun.com";
var isChildSend=false;
var isTraceError=false;

try{
	typeof(top.isChildSend)
}catch(e){
	isTraceError=true;
}

if(!isTraceError){
	if(typeof(top.isChildSend)=="undefined" || !top.isChildSend){
	if(typeof(top.isChildSend)!="undefined"){
		top.isChildSend=true;
	}
		
	var fTrackIsLoaded;
	if (typeof(fTrackIsLoaded)=="undefined"){
			
		var calc_d=new Date();
		var calc_l=escape(document.location.href);
		var calc_r=escape(document.referrer);
		var isiframed='0';
		var sflag="1";
		
		articleid="";
		articleS=calc_l.indexOf(".html");
		if( articleS!=-1 )
		{
			tempArr=calc_l.split('/');
			tempStr=tempArr[tempArr.length-1];
			index=tempStr.indexOf(".html");
			articleid=tempStr.substr(0,index);
			if(parseInt(articleid)!=articleid || eval("'"+parseInt(articleid)+"'.length")!=articleid.length){
				var flag = articleid.indexOf("_");
				if(flag>0){
					articleid = articleid.substr(0,articleid.indexOf("_"));
				}else{
					articleid = articleid.substr(0,articleid.indexOf("-"));
				}
			}
		}

		
		
		function readCookie(name){
			var cookieValue="";
			var search=name+"=";
			if(document.cookie.length>0){
				offset=document.cookie.indexOf(search);
				if(offset!=-1){
					offset+=search.length;
					end=document.cookie.indexOf(";",offset);
					if(end==-1)
					end=document.cookie.length;
					cookieValue=unescape(document.cookie.substring(offset,end))
				}
			}
			return cookieValue;
		}
		if (calc_l.toLowerCase().indexOf("hexun.com")==-1){
			sflag="2";
		}else{
			if(readCookie('HexunTrack')==""){
				isiframed='2';
				sflag="2";
			}
		}
		
		if (sflag=="1"){
			if(window!=top.window){
				isiframed='1';
				try{
					if(readCookie('HexunTrack')==""){
						isiframed='2';
						sflag="2";
					}
				}catch(e){
					sflag="2";
				}
			}
		}

		if(calc_l.indexOf("guba.hexun.com")>=0)
		{
                    if(calc_l.indexOf("%2C")>=0)
	            {
        	    calc_l=calc_l.replace(/%2C/g,",");
                    }

		    var articleA=calc_l.indexOf(".com/d/");
		    if(articleA != -1)
                    {
                    var articleAA=calc_l.indexOf(",guba");
                    articleid = calc_l.substring(articleA+7,articleAA);
                    }else
                    {
                    var articleB=calc_l.indexOf(",p");
                    var articleBB=calc_l.indexOf(",guba,");
    
                     if(articleB != -1)
                     {        
                     articleid = calc_l.substring(articleBB+6,articleB);
                     }
                     else
                     {
                     var articleBBB=calc_l.indexOf(".html");
                     articleid = calc_l.substring(articleBB+6,articleBBB);
                     }
                    }
            
                    if(articleid.indexOf(",img2")>=0)
                    {
        	    articleid=articleid.substring(0,articleid.indexOf(",img2"));
      	            }
                    if(articleid>0)
                    {
                     var v = articleid;
                     while(v.length < 10)
                     {
                     v = "0" + v;
                     }
                     articleid = "1"+v;
		    }
		}
		
		if(calc_l.indexOf("t.hexun.com")>=0)
		{
		    articleid=calc_l.substring(calc_l.lastIndexOf("/")+1,calc_l.lastIndexOf("_"));
		    articleid="200"+articleid;
		}
		
		if(calc_l.indexOf("mymoney.hexun.com/broadcast")>=0)
		{
		    articleid=0;	
		}
		
		if (sflag=="1"){
			if(typeof(_title_for_track_)=='undefined'){
				document.write("<iframe src='http://count.utrack.hexun.com/Default.aspx?site="+calc_l+"&time="+calc_d.getTime()+"&id="+articleid+"&rsite="+calc_r+"' height=0 frameborder=0></iframe>");
			}else{
				document.write("<iframe src='http://count.utrack.hexun.com/Default.aspx?site="+calc_l+"&time="+calc_d.getTime()+"&id="+articleid+"&rsite="+calc_r+"&title="+title+"' height=0 frameborder=0></iframe>");
			}
		}else{
			if(typeof(_title_for_track_)=='undefined'){
				document.write("<iframe src='http://count.utrack.hexun.com/Default.aspx?calc_l="+calc_l+"&time="+calc_d.getTime()+"&id="+articleid+"&calc_r="+calc_r+"&isiframed="+isiframed+"&sflag="+sflag+"' height=0 frameborder=0 width=0></iframe>");
			}else{
				document.write("<iframe src='http://count.utrack.hexun.com/Default.aspx?calc_l="+calc_l+"&time="+calc_d.getTime()+"&id="+articleid+"&calc_r="+calc_r+"&title="+escape(_title_for_track_)+"&isiframed="+isiframed+"&sflag="+sflag+"' height=0 frameborder=0></iframe>");
			}
		}
		fTrackIsLoaded=true;
		}
	}
}