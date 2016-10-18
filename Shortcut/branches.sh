#! /bin/bash
# .bash_profile
# list git branches with their descriptions
branch=""
branches=`git branch --list`
while read -r branch; do
   clean_branch_name=${branch//\*\ /}
   description=`git config branch.$clean_branch_name.description`
   printf "%-15s %s\n" "$branch"  "$description"
   #if [ 
   #printf "\033[44;37;5m %-15s \033[0m %s\n" "$branch"  "$description"
   # echo -e "\033[44;37;5m ME \033[0m"  颜色.
done  <<< "$branches"


# printf "\033[44;37;5m %-15s\033[0m %s"  "abc" "$description"
