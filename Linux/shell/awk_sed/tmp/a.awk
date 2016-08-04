{
   a[1,"a"]="m";
   a[1,"b"]="n";
   a[1,"c"]="p";
#   if (("1","a") in a){
#      print a[1,"a"];
   for ( k in a){
      split(k,idx,SUBSEP);
      print idx[1],idx[2],a[idx[1],idx[2]],a[k],a[k];
   }
   if (idx[1]==1){
      print a["1"SUBSEP"c"] "OK"
   
   }
   print "====" a[1 SUBSEP "*"]
}
