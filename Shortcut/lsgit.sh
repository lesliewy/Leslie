#! /bin/bash
# 用于列出所有git 的status.
# 新增repo时，需要处理 repoNames paths ommitedDirs
################################################################################################################################
# set -x
set -e

# BEGIN 颜色
STYLE=1   # 取值 0 1 2 3 4 5 6 7
FG=32     # 取值 30 31 32 33 34 35 36 37
BG=40     # 取值 40 41 42 43 44 45 46 47
# END

# repo名字需与路径对应
repoNames=("Leslie" 
           "OkParse" 
           "StockAnalyse" 
           "R"
           "MyWeb"
           "Python"
           "mysolr"
          )
paths=("/home/leslie/Work/Leslie"
       "/home/leslie/MyProject/OkParse"
       "/home/leslie/MyProject/StockAnalyse"
       "/home/leslie/MyProject/R"
       "/home/leslie/MyProject/MyWeb"
       "/home/leslie/MyProject/Python"
       "/home/leslie/MyProject/mysolr"
      )

# 忽略的目录, 有些没有加入git管理.利用关联数组实现.
# ${!animals[@]}: 所有的key
# ${animals[@]}: 所有的value
declare -A ommitedDirs
ommitedDirs=([${repoNames[0]}]="----"
             [${repoNames[1]}]="backup/|charts/|html/|parse/target/|"
             [${repoNames[2]}]="backup/|gen/|history/|html/|stanalyse/stanalyselog/|stanalyse/target/|stanalyseweb/target/|"
             [${repoNames[3]}]="shinyAppLog/|.gitignore|"
             [${repoNames[4]}]="angular-basic/app/bower_components/|angular-basic/node_modules/|"
             [${repoNames[5]}]="Backup/|"
             [${repoNames[6]}]="SolrMongoImporter/.classpath|SolrMongoImporter/.project|SolrMongoImporter/bin/|SolrMongoImporter/build/"
            )

numOfRepos=${#repoNames[*]}
for ((index=0; index < numOfRepos; index++));do
   name=${repoNames[$index]}
   path=${paths[$index]}
   ommit=${ommitedDirs[$name]}
   cd "$path"
   echo -e "\033[${STYLE};${FG};${BG}m""$name" "$path" "\033[0m"
   output=$(git status -s)
   # 换行处理，git status 得到的是一行 这里将ommit作为最后一个分段传给awk, 如果ommit中包含了该目录，就跳过不处理.
   a="$output $ommit"
   echo $a | awk '{
                   for(i=1; i < NF; i+=2){
                      if(match($NF, $(i+1)) > 0){
                         continue;
                      }
                      printf("%s  %s\n", $i, $(i+1))}
                  }'
   echo ""
done

