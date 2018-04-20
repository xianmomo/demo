
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#svnPermission_show .permissionShowGroup .permissionShowGroupList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:200px;
	overflow:scroll;
	height: 400px;
}

#svnPermission_show .permissionShowGroup .permissionShowChildGroupList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:130px;
	overflow:scroll;
	height: 400px;
}
#svnPermission_show .permissionShowGroup .permissionShowGroupUserList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:330px;
	overflow:scroll;
	height: 400px;
}
#svnPermission_show .permissionShowGroup .permissionShowGroupDirList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:400px;
	overflow:scroll;
	height: 400px;
}

#svnPermission_show .permissionShowGroup .permissionShowList div.groupname-tooltip{
	vertical-align:middle;
	display:inline-block;
	width:100px;
	color: blue;
	cursor:pointer;
}
#svnPermission_show .permissionShowGroup .permissionShowList div.dirpath-tooltip{
	vertical-align:middle;
	display:inline-block;
	width:350px;
}
#svnPermission_show .permissionShowGroup .permissionShowList div.userName{
	vertical-align:middle;
	display:inline-block;
	width:130px;
}
#svnPermission_show .permissionShowGroup .permissionShowList div.auth{
	vertical-align:middle;
	display:inline-block;
	text-align:center;
	width:20px;
	color: red;
}
#svnPermission_show .permissionShowGroup .permissionShowList div.validTime{
	vertical-align:middle;
	display:inline-block;
	text-align:center;
	width:160px;
}
</style>
<script type="text/javascript">
function searchGroupShow(repositoryType){
	var groupNameLikeValue = $("#svnPermission_show").find(".permissionShowGroup [name='groupNameLike']").val();
	if(typeof repositoryType == "undefined"){
		repositoryType = $("#svnPermission_show").find("#respType").combobox("getValue");
	}
	top.ajaxData({
		url : "${pageContext.request.contextPath}/main/svn/showLikeGroup",
		data : {
			groupNameLike:groupNameLikeValue,
			repositoryType:repositoryType
		},
		success : function(obj) {
			var data = eval("(" + obj + ")");
			if (data.success) {
				//清除之前的页面渲染数据
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowChildGroupList").html("");
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowGroupUserList").html("");
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowGroupDirList").html("");
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowGroupList").html(data.data);
			}else{
				top.messageAlert(false,"加载失败",data.msg);
			}
		}
	});
}

function searchGroupPermission(obj){
	var title = $("#svnPermission_show").find("#svnPermission_show_tabs").tabs("getSelected").panel("options").title;
	if(title != "组"){
		$("#svnPermission_show").find("#svnPermission_show_tabs").tabs("select", "组");
	}
	var repositoryType = $("#svnPermission_show").find("#respType").combobox('getValue');
	top.ajaxData({
		url : "${pageContext.request.contextPath}/main/svn/showLikeGroup",
		data : {
			groupNameLike:"",
			repositoryType:repositoryType
		},
		success : function(result) {
			var data = eval("(" + result + ")");
			if (data.success) {
				//清除之前的页面渲染数据
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowChildGroupList").html("");
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowGroupUserList").html("");
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowGroupDirList").html("");
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowGroupList").html(data.data);
				var searchGroupId = $(obj).data("group-id");
				var searchGroup = $("#svnPermission_show").find(".permissionShowGroupList .permissionShowList[data-group-id='"+searchGroupId+"']");
				selectedGroupModifyCss(searchGroup);
				showGroupPermission(searchGroup);
			}else{
				top.messageAlert(false,"加载失败",data.msg);
			}
		}
	});
}

function selectedGroupModifyCss(obj){
	$("#svnPermission_show").find(".permissionShowGroup .permissionShowList.selected").each(function(){
		$(this).removeClass("selected");
	});
	var scrollTop = $(obj).parent().scrollTop()+$(obj).offset().top-$(obj).parent().offset().top;
	$("#svnPermission_show").find(".permissionShowGroupList").animate({scrollTop: scrollTop});
	$(obj).addClass("selected");
}

function showGroupPermission(){
	var groupId = $("#svnPermission_show").find(".permissionShowGroup .permissionShowList.selected").data("group-id");
	if(typeof groupId == "undefined" || groupId == ""){
		top.messageAlert(false,"业务操作失败","请选择要查看的组");
		return;
	}
	top.ajaxData({
		url : "${pageContext.request.contextPath}/main/svn/showGroupPermissionList",
		data : {
			groupId:groupId
		},
		success : function(obj) {
			var data = eval("(" + obj + ")");
			if (data.success) {
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowChildGroupList").html(data.childGroupData);
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowGroupDirList").html(data.groupDirData);
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowGroupUserList").html(data.groupUserData);
				$("#svnPermission_show").find(".permissionShowGroup .permissionShowList .custom-tooltip").tooltip();
			}else{
				top.messageAlert(false,"加载失败",data.msg);
			}
		}
	});
}

function addMenu_svnPermission_show_group(){
	top.openDialog({
		id : 'addTbGroup',
	    title: '新增SVN组',
	    width: 350,
	    height: 220,
	    href: '${pageContext.request.contextPath}/main/svn/tbSvnGroupAdd'
	});
}

function editMenu_svnPermission_show_group(){
	var groupId = $("#svnPermission_show").find(".permissionShowGroup .permissionShowList.selected").data("group-id");
	if(typeof groupId == "undefined" || groupId == ""){
		top.messageAlert(false,"业务操作失败","请选择要编辑的组");
		return;
	}
	top.openDialog({
		id : 'modifyTbGroup',
	    title: '编辑SVN组',
	    width: 350,
	    height: 220,
	    href: '${pageContext.request.contextPath}/main/svn/tbSvnGroupModify?groupId='+groupId
	});
}

function addMenu_svnPermission_show_group_auth(){
	var groupId = $("#svnPermission_show").find(".permissionShowGroup .permissionShowList.selected").data("group-id");
	if(typeof groupId == "undefined" || groupId == ""){
		top.messageAlert(false,"业务操作失败","请选择要新增的权限组");
		return;
	}
	top.openDialog({
		id : 'permissionShowAddTbGroupAuth',
	    title: '新增SVN组权限',
	    width: 600,
	    height: 520,
	    href: '${pageContext.request.contextPath}/main/svn/tbSvnGroupAddAuth?groupId='+groupId
	});
}

function editMenu_svnPermission_show_group_auth(){
	var groupId = $("#svnPermission_show").find(".permissionShowGroup .permissionShowList.selected").data("group-id");
	if(typeof groupId == "undefined" || groupId == ""){
		top.messageAlert(false,"业务操作失败","请选择要编辑的组");
		return;
	}
	top.openDialog({
		id : 'permissionShowEditTbGroupAuth',
	    title: '编辑SVN组权限',
	    width: 600,
	    height: 520,
	    href: '${pageContext.request.contextPath}/main/svn/tbSvnGroupModifyAuth?groupId='+groupId
	});
}
</script>
<div alt="组数据展示" class="permissionShowGroupList"></div>
<div alt="子组数据展示" class="permissionShowChildGroupList"></div>
<div alt="组用户数据展示" class="permissionShowGroupUserList"></div>
<div alt="组目录数据展示" class="permissionShowGroupDirList"></div>