<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#svnPermission_show .permissionShowRepositoryDir .permissionShowRepositoryDirList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:400px;
	overflow:scroll;
	height: 400px;
}
#svnPermission_show .permissionShowRepositoryDir .permissionShowDirectoryGroupList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:260px;
	overflow:scroll;
	height: 400px;
}
#svnPermission_show .permissionShowRepositoryDir .permissionShowDirectoryUserList{
	float:left;
	border: 1px solid #B7D2FF;
	border-bottom-width:0px;
	border-left-width:0px;
	width:400px;
	overflow:scroll;
	height: 400px;
}

#svnPermission_show .permissionShowRepositoryDir .permissionShowList div.groupname-tooltip{
	vertical-align:middle;
	display:inline-block;
	width:200px;
	color: blue;
	cursor:pointer;
}
#svnPermission_show .permissionShowRepositoryDir .permissionShowList div.userName{
	vertical-align:middle;
	display:inline-block;
	width:180px;
}
#svnPermission_show .permissionShowRepositoryDir .permissionShowList div.auth{
	vertical-align:middle;
	display:inline-block;
	text-align:center;
	width:20px;
	color: red;
}
#svnPermission_show .permissionShowRepositoryDir .permissionShowList div.validTime{
	vertical-align:middle;
	display:inline-block;
	text-align:center;
	width:160px;
}
</style>
<script type="text/javascript">
//点击库目录维度tab页后，根据所选配置库，动态调整按钮及筛选框
function repositoryDirShowModifyCss(repositoryType){
	if(typeof repositoryType == "undefined"){
		repositoryType = $("#svnPermission_show").find("#respType").combobox("getValue");
	}
	switch(repositoryType){
	case "0":
		$("#svnPermission_show").find("#addMenu_svnPermission_show_resp").linkbutton("disable");
		$("#svnPermission_show").find("#editMenu_svnPermission_show_resp").linkbutton("disable");
		$("#svnPermission_show").find("#repositoryNameLike").textbox("disable");
		$("#svnPermission_show").find("#directoryNameLike").textbox("enable");
		break;
	default:
		$("#svnPermission_show").find("#addMenu_svnPermission_show_resp").linkbutton("enable");
		$("#svnPermission_show").find("#editMenu_svnPermission_show_resp").linkbutton("enable");
		$("#svnPermission_show").find("#repositoryNameLike").textbox("enable");
		$("#svnPermission_show").find("#directoryNameLike").textbox("disable");
	}
}

function searchRepositoryDirShow(repositoryType){
	if(typeof repositoryType == "undefined"){
		repositoryType = $("#svnPermission_show").find("#respType").combobox("getValue");
	}
	var repositoryNameLikeValue = $("#svnPermission_show").find(".permissionShowRepositoryDir [name='repositoryNameLike']").val();
	var directoryNameLikeValue = $("#svnPermission_show").find(".permissionShowRepositoryDir [name='directoryNameLike']").val();
	$("#svnPermission_show").find(".permissionShowRepositoryDir .permissionShowDirectoryGroupList").html("");
	$("#svnPermission_show").find(".permissionShowRepositoryDir .permissionShowDirectoryUserList").html("");
	//加载库查看时的库目录树
	var remoteUrl = "${pageContext.request.contextPath}/main/svn/showTreeRepositoryDir";
	remoteUrl = remoteUrl+"?id=0&repositoryType="+repositoryType+"&repositoryNameLike="+repositoryNameLikeValue+"&directoryNameLike="+directoryNameLikeValue;
	$("#svnPermission_show").find("#svnPermission_show_tree").tree({
		url:remoteUrl,
		lines:true,
		loadFilter:top.convertTree,
		formatter:function(node){
			return "<lable class=\"custom-tooltip\" title=\""+node.text+"\">"+node.text+"</lable>";
		},
		onLoadSuccess:function(node, data){
			$("#svnPermission_show #svnPermission_show_tree .custom-tooltip").tooltip();
		},
		onSelect:function(node){
			showRepositoryDirPermission(node.id);
		}
	});
}

function showRepositoryDirPermission(dirId){
	if(typeof dirId == "undefined" || dirId == ""){
		top.messageAlert(false,"业务操作失败","请选择要查看的库目录");
		return;
	}
	top.ajaxData({
		url : "${pageContext.request.contextPath}/main/svn/showRepositoryDirPermissionList",
		data : {
			dirId:dirId
		},
		success : function(obj) {
			var data = eval("(" + obj + ")");
			if (data.success) {
				$("#svnPermission_show").find(".permissionShowRepositoryDir .permissionShowDirectoryGroupList").html(data.directoryGroupData);
				$("#svnPermission_show").find(".permissionShowRepositoryDir .permissionShowDirectoryUserList").html(data.directoryUserData);
				$("#svnPermission_show").find(".permissionShowRepositoryDir .permissionShowList .custom-tooltip").tooltip();
			}else{
				top.messageAlert(false,"加载失败",data.msg);
			}
		}
	});
}

function addMenu_svnPermission_show_resp(){
	top.openDialog({
		id : 'permissionShowAddTbSvnRepository',
	    title: '新增SVN配置库',
	    width: 350,
	    height: 160,
	    href: '${pageContext.request.contextPath}/main/svn/tbSvnRespAdd'
	});
}

function editMenu_svnPermission_show_resp(){
	var currentTreeNode = $("#svnPermission_show").find("#svnPermission_show_tree").tree('getSelected');
	if(currentTreeNode == null){
		top.messageAlert(false,"业务操作失败","请选择要编辑的库");
		return;
	}
	//只有库节点才能编辑库名称
	if(currentTreeNode.id.substr(0,1) == "D"){
		top.messageAlert(false,"业务操作失败","只能编辑库");
		return;
	}
	top.openDialog({
		id : 'permissionShowModifyTbSvnRepository',
	    title: '编辑SVN配置库',
	    width: 350,
	    height: 160,
	    href: '${pageContext.request.contextPath}/main/svn/tbSvnRespModify?respId='+currentTreeNode.id
	});
}

function addMenu_svnPermission_show_dir(){
	var currentTreeNode = $("#svnPermission_show").find("#svnPermission_show_tree").tree('getSelected');
	if(currentTreeNode == null){
		top.messageAlert(false,"业务操作失败","请选择要新增的目录上级目录");
		return;
	}
	if(currentTreeNode.id.substr(0,1) == "R"){
		top.messageAlert(false,"业务操作失败","请选择配置库下的目录");
		return;
	}
	top.openDialog({
		id : 'permissionShowAddTbSvnDir',
	    title: '新增SVN目录',
	    width: 350,
	    height: 280,
	    href: '${pageContext.request.contextPath}/main/svn/tbSvnDirAdd?dirId='+currentTreeNode.id
	});
}

function editMenu_svnPermission_show_dir(){
	var currentTreeNode = $("#svnPermission_show").find("#svnPermission_show_tree").tree('getSelected');
	if(currentTreeNode == null){
		top.messageAlert(false,"业务操作失败","请选择要编辑的目录");
		return;
	}
	//只有目录才有dir_path属性
	if(currentTreeNode.id.substr(0,1) == "R" || currentTreeNode.dir_path == "/"){
		top.messageAlert(false,"业务操作失败","不能编辑库或者根目录");
		return;
	}
	top.openDialog({
		id : 'permissionShowModifyTbSvnDir',
	    title: '编辑SVN目录',
	    width: 350,
	    height: 280,
	    href: '${pageContext.request.contextPath}/main/svn/tbSvnDirModify?dirId='+currentTreeNode.id
	});
}

function addMenu_svnPermission_show_auth(){
	var currentTreeNode = $("#svnPermission_show").find("#svnPermission_show_tree").tree('getSelected');
	if(currentTreeNode == null){
		top.messageAlert(false,"业务操作失败","请选择要分配权限的目录");
		return;
	}
	if(currentTreeNode.id.substr(0,1) == "R"){
		top.messageAlert(false,"业务操作失败","请选择配置库下的目录");
		return;
	}
	top.openDialog({
		id : 'permissionShowAddAuth',
	    title: '添加SVN目录权限',
	    width: 680,
	    height: 520,
	    href: '${pageContext.request.contextPath}/main/svn/svnPermissionAuthAdd?dirId='+currentTreeNode.id
	});
}

function editMenu_svnPermission_show_auth(){
	var currentTreeNode = $("#svnPermission_show").find("#svnPermission_show_tree").tree('getSelected');
	if(currentTreeNode == null){
		top.messageAlert(false,"业务操作失败","请选择要分配权限的目录");
		return;
	}
	if(currentTreeNode.id.substr(0,1) == "R"){
		top.messageAlert(false,"业务操作失败","请选择配置库下的目录");
		return;
	}
	top.openDialog({
		id : 'permissionShowModifyAuth',
	    title: '编辑SVN目录权限',
	    width: 600,
	    height: 520,
	    href: '${pageContext.request.contextPath}/main/svn/svnPermissionAuthModify?dirId='+currentTreeNode.id
	});
}
</script>
<div alt="库目录数据展示" class="permissionShowRepositoryDirList">
	<ul id="svnPermission_show_tree"></ul>
</div>
<div alt="库目录组数据展示" class="permissionShowDirectoryGroupList"></div>
<div alt="库目录用户数据展示" class="permissionShowDirectoryUserList"></div>