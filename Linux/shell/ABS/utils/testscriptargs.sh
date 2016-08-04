#! /bin/sh      
# do not comment in sha bang,it's wrong if you run the script like:   ./testscriptargs.sh aaa

E_WRONG_ARGS=85
script_parameters="-a -h -m -z"
Number_of_expected_args=2
if [ $# -ne $Number_of_expected_args ]; then
   echo "Usage: `basename $0` $script_parameters"
   exit E_WRONG_ARGS;
fi
exit;
