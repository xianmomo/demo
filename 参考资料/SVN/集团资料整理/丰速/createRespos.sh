#!/bin/bash
reposName=$1
svn_workSpace="/app/SVN"
svnadminPath="/usr/local/subversion/bin/svnadmin"
hooksPath="/home/appdeploy/tools"
checkfileFlag=true
creatReposCommand="${svnadminPath} create --pre-1.6-compatible ${svn_workSpace}/${reposName}"
echo "提示： prepare to create repository:${reposName}, full path is:${svn_workSpace}/${reposName}"

if [ $# != 1 ];
then
 echo "错误： please input one args: repos name!"
 exit 1
fi

if [ -d ${svn_workSpace}/${reposName} ];
then
  echo "错误： folder ${svn_workSpace}/${reposName} is exist!"
  exit 1
fi

if [ -f ${svn_workSpace}/${reposName} ];
then
  echo "错误： file ${svn_workSpace}/${reposName} is exist!"
  exit 1
fi

if [ ! -f ${hooksPath}/pre-commit ];
then
  echo "错误： has no file:${hooksPath}/pre-commit, please check it!"
  checkfileFlag=false
fi

if [ ! -f ${hooksPath}/pre-revprop-change ];
then
  echo "错误： has no file:${hooksPath}/pre-revprop-change, please check it!"
  checkfileFlag=false
fi


if [ ! -f ${hooksPath}/svnserve.conf ];
then
  echo "错误： has no file:${hooksPath}/svnserve.conf, please check it!"
  checkfileFlag=false
fi

if [ $checkfileFlag != true ];
then
 exit 1
fi

echo "提示： step 1 start to exec shell command:${creatReposCommand}"
${creatReposCommand}
sleep 2

if [ $? -ne 0 ];
then
  echo "错误： ${creatReposCommand} command exec failed ,return $0"
  exit 1
fi

if [ ! -w ${svn_workSpace}/${reposName}/conf ];
then
  echo "错误： ${svn_workSpace}/${reposName}/conf has no Authorization to Write!"
  echo "错误： svnserve.conf file hasn't to replace, hooks file hasn't to copy!"
  exit 1
fi

echo "提示： step 2 start to replace svnserve.conf file!"
cp ${hooksPath}/svnserve.conf ${svn_workSpace}/${reposName}/conf/

if [ $? -ne 0 ];
then
  echo "错误： copy file:${hooksPath}/svnserve.conf to ${svn_workSpace}/${reposName}/conf/, return $0"
  echo "错误： svnserve.conf file hasn't to replace, hooks file hasn't to copyto!"
  exit 1
fi


echo "提示：        start to modify svnserve.conf file's realm value!"
sed -i "s/realm = */realm = ${reposName}/" ${svn_workSpace}/${reposName}/conf/svnserve.conf
if [ $? -ne 0 ];
then
  echo "WARRNING: modify svnserve.conf file's realm=${reposName} fail!"
fi


if [ ! -w ${svn_workSpace}/${reposName}/hooks ];
then
  echo "错误： ${svn_workSpace}/${reposName}/hooks has no Authorization to Write!"
  echo "错误： svnserve.conf file has replaced,but hooks file hasn't to copy!"
  exit 1
fi


echo "提示： step 3 start to copy hooks files!"
cp ${hooksPath}/pre-commit ${hooksPath}/pre-revprop-change ${svn_workSpace}/${reposName}/hooks/
chmod +x ${svn_workSpace}/${reposName}/hooks/pre-revprop-change
chmod +x ${svn_workSpace}/${reposName}/hooks/pre-commit

if [ $? -ne 0 ];
then
  echo "错误： cp ${hooksPath}/pre-commit ${hooksPath}/pre-revprop-change  to  ${svn_workSpace}/${reposName}/hooks/ fail, return $0"
  echo "错误： svnserve.conf file has replaced,but hooks file hasn't to copy!"
  exit 1
else
  echo "成功: create ${reposName} is successful and svnserve.conf repaced ok, hooks file copy ok!"
  exit 0
fi
