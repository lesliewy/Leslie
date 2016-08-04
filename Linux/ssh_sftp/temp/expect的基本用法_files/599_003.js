function spantodiv(id)
    {
        try
        {
            var str="";
	        var arradCom=eval("Arr_"+id);
	        if(arradCom.length==1)
	        {
	          str=arradCom[0][0];
	        }
	        if(arradCom.length>1)
	        {
	          var yms=Math.random()*(arradCom.length-1); 
                  var kms=Math.round(yms); 
                  str=arradCom[kms][0];
	        }
	        if(str!="")
	        {
                   if(document.getElementById("ADV_"+id))
                    {
	              document.getElementById("ADV_"+id).innerHTML=str;
	              document.getElementById("ADV_"+id).style.display="block";
	              if(typeof(pageType)!='undefined'&& pageType=="article")
	               {
		          document.getElementById("ADV_"+id).parentNode.style.display="block";
	               }
                    }
	        }
	    }
	    catch(e)
	    {}
    }
