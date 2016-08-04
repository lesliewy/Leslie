#! /bin/bash

USAGE(){
   cat << ENDOFUSAGE
   Usage:   `basename $0` [-h] [-d] [-r]
            `basename $0`  -h              :shutdown tomcat
            `basename $0`  -d              :shutdown tomcat and delete war
            `basename $0`  -r              :restart tomcat, redeploy war
ENDOFUSAGE
}

# kill tomcat
shutdown(){
   tomcatid=`ps -ef|grep tomcat|awk '{if ($3 == 1) print $2}'`
   if [ -n "$tomcatid" ]; then
      printf "kill tomcat id: $tomcatid\n"
      kill $tomcatid
   fi
   printf "tomcat is killed\n"
}	

#delete war
deletewar(){
   /bin/rm -rf /opt/tomcat/apache-tomcat-7.0.26/webapps/stanalyse*
   printf "war is deleted\n"
}

#start tomcat
startup(){
   /opt/tomcat/apache-tomcat-7.0.26/bin/startup.sh > /dev/null
   startstr="startup tomcat."
   printf "$startstr"
   while true
   do
      printf "."
      newtomcatid=`ps -ef|grep tomcat|awk '{if ($3 == 1) print $2}'`
      if [ -n "$newtomcatid" ]; then
         printf "\ntomcat id: %s\n" "$newtomcatid"
         break;
      fi 
   done
}

#redeploy
redeploy(){
   cd /home/leslie/MyProject/StockAnalyse/stanalyse
   mvn clean install -Dmaven.test.skip=true
   printf "\n\ninstall jar complete\n"

   cd ../stanalyseweb/
   mvn tomcat:redeploy

   printf "\ndeploy complete\n"
}

EX_USAGE=64;
EX_OK=0;

[ "$#" -eq 0 ] && USAGE && exit $EX_USAGE
while getopts "hdr" option;do
   case "$option" in
      "h") shutdown 
           exit $EX_OK
          ;;
      "d") shutdown 
	   deletewar
	   exit $EX_OK
	  ;;
      "r") shutdown
	   deletewar
	   startup
	   redeploy
	   exit $EX_OK
	  ;; 
       *) echo "no this option"
	  USAGE
	  exit $EX_USAGE
          ;;
   esac
done

