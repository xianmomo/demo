#!/usr/bin/env python
#coding: utf-8
###安装说明：
########### pip install python-gitlab xlwt

import gitlab
import xlwt
import json
import sys
import datetime
import time

HOST = 'http://192.168.16.211:88/'
PRIVATE_TOKEN = 'DJ8MvgQns6_Hs7pzgHx8'
API_VERSION = 4


def gettime():
    return time.strftime('%Y-%m-%d_%H_%M_%S', time.localtime(time.time()))

#获取所有projects指定的内容
def get_projects_data():
	contens = []
	titles = ['project.id','project.name','project.description','project.default_branch','project.last_activity_at','project.created_at','project.creator_id','project.path_with_namespace','project.visibility','project.web_url','project.ssh_url_to_repo','project.http_url_to_repo', 'group.id','group.name']
	contens.append(titles)
	gl = gitlab.Gitlab(HOST, private_token=PRIVATE_TOKEN, api_version=API_VERSION)
	projects = gl.projects.list(all=True)
	for p in projects: #行
		contens.append([p.id, p.name, p.description, p.default_branch, p.last_activity_at, p.created_at, p.creator_id, p.path_with_namespace, p.visibility, p.web_url, p.ssh_url_to_repo, p.http_url_to_repo,p.namespace['id'], p.namespace['name']])
	return contens

#将projects的内容写到xls中
def write_pro_data_to_xls():
	pro_data = get_projects_data()
	book = xlwt.Workbook(encoding = 'utf-8')
	sheet = book.add_sheet(gettime())
	i = 0 #行
	for data in pro_data:
		j = 0	#列
		for d in data:
			print(i, j)
			sheet.write(i, j, label=d)
			j+=1
		i+=1
	today = time.strftime('%Y-%m-%d')
	book.save('%s.xls' %today)

#创建分支
def create_branch(project,branch_name,ref):
	branch = {'branch': branch_name,
			  'ref'	: ref
			}
	project.branches.create(branch)

#循环所有的projects中的branchs,如果其没有develop分支，将自动基于master分支创建develop分支
def check_branchs():
	gl = gitlab.Gitlab(HOST, private_token=PRIVATE_TOKEN, api_version=API_VERSION)
	projects = gl.projects.list(all=True)
	for pro in projects:
		branchs = pro.branches.list(all=True)
		if 'develop' not in branchs:
			print(u'Project:%s 未创建develop分支,现在将为其自动创建' %(pro))
			create_branch(pro,'develop','master')



#检查30天内未登录过的用户
def check_users():
	gl = gitlab.Gitlab(HOST, private_token=PRIVATE_TOKEN, api_version=API_VERSION)
	users = gl.users.list()
	for u in users:
		if u.last_sign_in_at == None:
			print(u'用户：%s 没有登录过系统' %u.name)
		else:
			d1 = datetime.datetime.strptime(u.last_sign_in_at[:10],"%Y-%m-%d")
			d2 = datetime.datetime.today()
			days = (d2 - d1).days
			if days >= 30:
				print(u'用户:%s 已经%d天没有登录过了' %(u.name,days))

#修改非管理员用户属性can create groups: True>False
def modify_user():
	gl = gitlab.Gitlab(HOST, private_token=PRIVATE_TOKEN, api_version=API_VERSION)
	users = gl.users.list()
	for u in users:
		if u.is_admin == True:
			u.can_create_group = True
		else:
			u.can_create_group = False
		u.save()

#write_pro_data_to_xls()
#check_branchs()
check_users()
#modify_user()

