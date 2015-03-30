while read HOST
do  ping $HOST  if [ "$?" -ne "0" ]; then   echo $HOST >> failed_host.$$  fi done < hostfile if [ -s "failed_host.$$"];then  cat failed_host.$$ | mailx -s failed server list aditi.khullar@gmail.com fi
