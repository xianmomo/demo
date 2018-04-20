#!/bin/bash
date

who=`whoami`
if [ "${who}" != "appdeploy" ];
then
   echo "the current user is ${who}, please run the scripts by appdeploy user!"
   exit 1
fi

if [ ! -f /home/appdeploy/backup.log ];
then
   touch /home/appdeploy/backup.log
fi

expireDay=60
logPath=/usr/local/apache/logs
apachPath=/usr/local/apache/bin/apachectl
configPath=/svndata/auth
confgName=authz.conf
logbackupPath=/app/svn/svnlogBackup
configBackupPath1=/app/svn/confBackup
configBackupPath2=${configPath}/confBackup

now=`date +%Y%m%d%H%M%s`
weeks=`date +%w`
day=`date +%d`

mkdir -p $logbackupPath $configBackupPath1 $configBackupPath2
find ${configBackupPath1} -mtime +${expireDay} |xargs -n 1000 rm -f
find ${configBackupPath2} -mtime +${expireDay} |xargs -n 1000 rm -f
cp ${configPath}/authz.conf ${configBackupPath1}/authz${now}.conf
cp ${configPath}/authz.conf ${configBackupPath2}/authz${now}.conf
if [ -d ${logPath} ];
then
   if [ "${weeks}" -eq "0" -a "${day}" -le "07" ];
   then
      echo "today is `date`,start to backup logs!"
      rm -fr ${logPath}/*.tar.gz
      cd ${logPath}/ && tar -zcvf  log${now}.tar.gz *
      mv ${logPath}/log*.tar.gz ${logbackupPath}/
      if [ "$?" -eq "0" ];
      then
         rm -fr ${logPath}/*.tar.gz
         echo "${apachPath} stop"
         ${apachPath} stop
         sleep 5
         cd ${logPath}/ && rm -fr *
         echo "${apachPath} start"
         ${apachPath} start
      else
         echo "backup svnlog error, not need restart httpd server!"
      fi
   fi
else
  echo "${logPath} is not exist!"
fi
