#! /bin/bash

# 全局变量
STANALYSE_DIR="/home/leslie/MyProject/StockAnalyse/";
OKPARSE_DIR="/home/leslie/MyProject/OkParse/";

USAGE(){
   cat << ENDOFUSAGE
   Usage:   `basename $0` [-h] [-s] [-d] [-r] [-w]  okparse|stanalyse 
            `basename $0`  -h               :shutdown tomcat
            `basename $0`  -s               :shutdown tomcat, startup tomcat
            `basename $0`  -d              :shutdown tomcat and delete war
            `basename $0`  -r              :restart tomcat, redeploy war
            `basename $0`  -w              :restart tomcat, redeploy war only
ENDOFUSAGE
}

getTomcatId(){
   tomcatId=`ps -ef|grep tomcat|awk '{if ($4 != 0) print $2}'`
#   return $tomcatId;
   echo $tomcatId
}

# kill tomcat
shutdown(){
   tomcatId=`getTomcatId`;
   if [ -n "$tomcatId" ]; then
      printf "kill tomcat id: $tomcatId\n"
      kill $tomcatId
   fi
   printf "tomcat is killed\n"
}	

#delete war
deletewar(){
   warname="$1"
   if [ "$warname" == "stanalyse" ]; then 
      /bin/rm -rf /opt/tomcat/apache-tomcat-7.0.26/webapps/stanalyse*
   elif [ "$warname" == "okparse" ]; then
      /bin/rm -rf /opt/tomcat/apache-tomcat-7.0.26/webapps/okparse*
   fi
   printf "%s is deleted\n" "$warname"
}

#start tomcat
startup(){
   /opt/tomcat/apache-tomcat-7.0.26/bin/startup.sh > /dev/null
   startstr="startup tomcat."
   printf "%s" "$startstr"
   while true
   do
      printf "."
      newtomcatid=`getTomcatId`
      if [ -n "$newtomcatid" ]; then
         printf "\ntomcat id: %s\n" "$newtomcatid"
         break;
      fi 
   done
}

#redeploy
redeploy(){
   warname="$1"
   if [ "$warname" == "stanalyse" ]; then 
      cd $STANALYSE_DIR"stanalyse"
   elif [ "$warname" == "okparse" ]; then
      cd $OKPARSE_DIR"parse"
   fi

   mvn clean install -Dmaven.test.skip=true
   printf "\n\ninstall $warname jar complete\n"

   if [ "$warname" == "stanalyse" ]; then 
      cd ../stanalyseweb/
      mvn clean install -Dmaven.test.skip=true
      printf "\n\ninstall stanalyseweb war complete\n"
   elif [ "$warname" == "okparse" ]; then
      cd ../parse-web/
      mvn clean install -Dmaven.test.skip=true
      printf "\n\ninstall parseweb war complete\n"
   fi
#	mvn tomcat:undeploy
#  printf "\nundeploy $warname complete\n"
   mvn tomcat:redeploy

   printf "\ndeploy $warname complete\n"
}

redeployWar(){
   warname="$1";
#	tomcatId=$?;    # 这种方式接收不到，不知道为什么.
   tomcatId=`getTomcatId`;
	if [ -z "$tomcatId" -o $tomcatId -eq 0 ];then
	   startup;
	else
	   printf "\ntomcat id: $tomcatId\n"
	fi

   if [ "$warname" == "stanalyse" ]; then 
      cd $STANALYSE_DIR"stanalyseweb/"
      mvn clean install -Dmaven.test.skip=true
      printf "\n\ninstall stanalyseweb war complete\n"
   elif [ "$warname" == "okparse" ]; then
      cd $OKPARSE_DIR"parse-web/"
      mvn clean install -Dmaven.test.skip=true
      printf "\n\ninstall parseweb war complete\n"
   fi
	mvn tomcat:undeploy
   printf "\nundeploy $warname complete\n"
   mvn tomcat:redeploy

   printf "\ndeploy $warname complete\n"
}

EX_USAGE=64;
EX_OK=0;

[ "$#" -eq 0 ] && USAGE && exit $EX_USAGE

warname=$2;
[[ "$warname" != "okparse" && "$warname" != "stanalyse" ]] && echo "warname is false, return now..." && USAGE && exit $EX_USAGE;

while getopts "hsdrw" option;do
   case "$option" in
      "h") shutdown 
           exit $EX_OK
          ;;
      "s") shutdown
	   startup
           exit $EX_OK
          ;;
      "d") shutdown 
	   deletewar $warname 
	   exit $EX_OK
	  ;;
      "r") shutdown
	   deletewar $warname
	   startup
	   redeploy  $warname
	   exit $EX_OK
		;;
      "w") redeployWar $warname
	   exit $EX_OK
	   ;; 
       *) echo "no this option"
	  USAGE
	  exit $EX_USAGE
          ;;
   esac
done

