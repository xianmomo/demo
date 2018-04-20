<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#svnPermission_show .permissionShowUser .permissionShowUserList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:220px;
	overflow:scroll;
	height: 400px;
}

#svnPermission_show .permissionShowUser .permissionShowUserGroupList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:390px;
	overflow:scroll;
	height: 400px;
}
#svnPermission_show .permissionShowUser .permissionShowUserDirList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:450px;
	overflow:scroll;
	height: 400px;
}
#svnPermission_show .permissionShowUser .permissionShowList div.groupname-tooltip{
	vertical-align:middle;
	display:inline-block;
	width:200px;
}
#svnPermission_show .permissionShowUser .permissionShowList div.dirpath-tooltip{
	vertical-align:middle;
	display:inline-block;
	width:240px;
}
#svnPermission_show .permissionShowUser .permissionShowList div.userName{
	vertical-align:middle;
	display:inline-block;
	width:180px;
}
#svnPermission_show .permissionShowUser .permissionShowList div.auth{
	vertical-align:middle;
	display:inline-block;
	text-align:center;
	width:20px;
	color: red;
}
#svnPermission_show .permissionShowUser .permissionShowList div.validTime{
	vertical-align:middle;
	display:inline-block;
	text-align:center;
	width:160px;
}
</style>
<script type="text/javascript">
function selectedUserModifyCss(obj){
	$("#svnPermission_show").find(".permissionShowUser .permissionShowList.selected").each(function(){
		$(this).removeClass("selected");
	});
	$(obj).addClass("selected");
}

function showUserPermission(){
	var repositoryType = $("#svnPermission_show").find("#respType").combobox("getValue");
	var userId = $("#svnPermission_show").find(".permissionShowUser .permissionShowList.selected").data("user-id");
	if(typeof userId == "undefined" || userId == ""){
		top.messageAlert(false,"业务操作失败","请选择要查看的用户");
		return;
	}
	top.ajaxData({
		url : "${pageContext.request.contextPath}/main/svn/showUserPermissionList",
		data : {
			userId:userId,
			repositoryType:repositoryType
		},
		success : function(obj) {
			var data = eval("(" + obj + ")");
			if (data.success) {
				$("#svnPermission_show").find(".permissionShowUser .permissionShowUserGroupList").html(data.userGroupData);
				$("#svnPermission_show").find(".permissionShowUser .permissionShowUserDirList").html(data.userDirData);
				$("#svnPermission_show").find(".permissionShowUser .permissionShowList .custom-tooltip").tooltip();
			}else{
				top.messageAlert(false,"加载失败",data.msg);
			}
		}
	});
}

function addMenu_svnPermission_show_user(){
	top.openDialog({
		id : 'permissionShowAddTbUser',
	    title: '新增SVN用户',
	    width: 350,
	    height: 220,
	    href: '${pageContext.request.contextPath}/main/svn/tbSvnUserAdd'
	});
}

function deleteMenu_svnPermission_show_user(){
	var userId = $("#svnPermission_show").find(".permissionShowUser .permissionShowList.selected").data("user-id");
	if(typeof userId == "undefined" || userId == ""){
		top.messageAlert(false,"业务操作失败","请选择要查看的用户");
		return;
	}
	$.messager.confirm("系统提示", "是否确认删除该用户？",function(result) {
		if (result) {
			top.ajaxData({
				url : '${pageContext.request.contextPath}/main/svn/deleteTbSvnUser',
				data : {
					userId : userId
				},
				success : function(obj) {
					var data = eval("(" + obj + ")");
					if (data.success) {
						searchUserShow();
					}else{
						top.messageAlert(false,"删除失败",data.msg);
					}
				}
			});
		}
	});
}
</script>
<div alt="用户数据展示" class="permissionShowUserList"></div>
<div alt="用户组数据展示" class="permissionShowUserGroupList"></div>
<div alt="用户目录数据展示" class="permissionShowUserDirList"></div>