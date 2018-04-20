<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
<style>
#svnPermission_show .tabs-header{
	background: none;
}
#svnPermission_show .permissionShowList{
	padding: 2px 0px 0px 10px;
	line-height: 24px;
	font-size: 14px;
}
#svnPermission_show .permissionShowList:HOVER{
	background: #EAF2FF;
}
#svnPermission_show .permissionShowList.selected{
	background: #FFE48D;
}
#svnPermission_show .permissionShowUserContext{
	width: 1070px;
}
#svnPermission_show .permissionShowGroupContext{
	width: 1070px;
}
#svnPermission_show .permissionShowRepositoryDirContext{
	width: 1070px;
}
</style>
<script type="text/javascript">
//嵌入用户展示页面
$("#svnPermission_show").find(".permissionShowUserContext").load("${pageContext.request.contextPath}/pages/highspeed/svnpermission/svnPermission_user_view.jsp");
//嵌入组展示页面
$("#svnPermission_show").find(".permissionShowGroupContext").load("${pageContext.request.contextPath}/pages/highspeed/svnpermission/svnPermission_group_view.jsp");
//嵌入库目录展示页面
$("#svnPermission_show").find(".permissionShowRepositoryDirContext").load("${pageContext.request.contextPath}/pages/highspeed/svnpermission/svnPermission_repositoryDir_view.jsp");
var isFirstLoad = true;
var isLoadedUserShow = false;
var isLoadedGroupShow = false;
var isLoadedRepositoryDirectoryShow = false;
//切换一览维度
$("#svnPermission_show").find("#svnPermission_show_tabs").tabs({
    onSelect:function(title){
        switch(title){
        case "用户":
        	if(isLoadedUserShow){
        		return;
        	}
        	isLoadedUserShow = true;
        	if(isFirstLoad){
        		return;
        	}
        	searchUserShow();
        	break;
        case "组":
        	if(isLoadedGroupShow){
        		return;
        	}
        	isLoadedGroupShow = true;
        	searchGroupShow();
        	break;
        case "库":
        	if(isLoadedRepositoryDirectoryShow){
        		return;
        	}
        	isLoadedRepositoryDirectoryShow = true;
        	repositoryDirShowModifyCss();
        	searchRepositoryDirShow();
        	break;
        default :
        	top.messageAlert(false,"加载失败","没有发现标签页"+title);
        }
    }
});

//选择配置库类型，重新渲染当前维度页面
function selectedRepositoryAfterModifyHtml(record){
	var title = $("#svnPermission_show").find("#svnPermission_show_tabs").tabs("getSelected").panel("options").title;
	var respType = record.value;
	switch(title){
    case "用户":
    	//用户为全局用户，不区分库类型。所以不会根据配置库类型而变化
    	isLoadedGroupShow = false;
    	isLoadedRepositoryDirectoryShow = false;
   		searchUserShow();
   		isFirstLoad = false;
    	break;
    case "组":
    	isLoadedUserShow = false;
    	isLoadedRepositoryDirectoryShow = false;
    	searchGroupShow(respType);
    	break;
    case "库":
    	isLoadedUserShow = false;
    	isLoadedGroupShow = false;
    	repositoryDirShowModifyCss(respType);
    	searchRepositoryDirShow(respType);
    	break;
    default :
    	top.messageAlert(false,"加载失败","没有发现标签页"+title);
    }
}

document.onkeydown = function(e){ 
    var ev = document.all ? window.event : e;
    if(ev.keyCode==13) {
    	var title = $("#svnPermission_show").find("#svnPermission_show_tabs").tabs("getSelected").panel("options").title;
    	var respType = $("#svnPermission_show").find("#respType").combobox('getValue');
    	switch(title){
    	case "用户":
       		searchUserShow();
        	break;
        case "组":
        	searchGroupShow(respType);
        	break;
        case "库":
        	repositoryDirShowModifyCss(respType);
        	searchRepositoryDirShow(respType);
        	break;
        default :
        	top.messageAlert(false,"加载失败","没有发现标签页"+title);
        }
		return;
	}
};

function searchUserShow(){
	var userNameLikeValue = $("#svnPermission_show").find(".permissionShowUser [name='userNameLike']").val();
	top.ajaxData({
		url : "${pageContext.request.contextPath}/main/svn/showLikeUser",
		data : {
			userNameLike:userNameLikeValue
		},
		success : function(obj) {
			var data = eval("(" + obj + ")");
			if (data.success) {
				//清除之前的页面渲染数据
				$("#svnPermission_show").find(".permissionShowUser .permissionShowUserGroupList").html("");
				$("#svnPermission_show").find(".permissionShowUser .permissionShowUserDirList").html("");
				$("#svnPermission_show").find(".permissionShowUser .permissionShowUserList").html(data.data);
			}else{
				top.messageAlert(false,"加载失败",data.msg);
			}
		}
	});
}

function modifyMenu_svnPermission_show(){
	top.ajaxData({
		url : "${pageContext.request.contextPath}/main/svn/updateAuthzConf",
		success : function(obj) {
			var data = eval("(" + obj + ")");
			if (data.success) {
				top.messageAlert(false,"配置文件已更新",data.msg);
			}else{
				top.messageAlert(false,"更新配置文件失败",data.msg);
			}
		}
	});
}
</script>
	<div id="svnPermission_show">
		<div alt="头部搜索" style="padding-top: 5px;">
			<form class="custom-query-form">
				<label-title>配置库类型:</label-title>
				<label-value>
					<input class="easyui-combobox" id="respType" value="1"
						data-options="editable:false,valueField: 'value',textField: 'label',onSelect: selectedRepositoryAfterModifyHtml,data:[
							{label:'产品库',value:'0'},{label:'系统库',value:'1'}
						]" />
				</label-value>
				<c:if test="${hasPermissionTodelRepository }">
				<a onclick="modifyMenu_svnPermission_show()" href='javascript:void("#")'
					class="easyui-linkbutton" data-options="iconCls:'icon-reload'">更新配置文件</a>
				</c:if>
			</form>
		</div>
		<div alt="tabs页展示" id="svnPermission_show_tabs" class="easyui-tabs" style="padding-top: 5px;">
			<div title="用户">
				<div class="permissionShowUser">
					<c:if test="${hasPermissionTodelRepository }">
					<div alt="用户维度头部按钮" style="padding-top: 5px;">
						<a onclick="addMenu_svnPermission_show_user()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增用户</a>
						<a onclick="deleteMenu_svnPermission_show_user()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除用户</a>
					</div>
					</c:if>
					<div alt="用户维度头部搜索" style="padding-top: 5px;">
						<form class="custom-query-form">
							<label-title>用户名:</label-title>
							<label-value>
								<input class="easyui-textbox" name="userNameLike" />
							</label-value>
							<label-search>
								<label onclick="searchUserShow();" class="easyui-linkbutton custom-search" data-options="iconCls:'icon-search'" style="width:80px">搜索</label>
							</label-search>
						</form>
					</div>
					<div alt="用户维度内容" class="permissionShowUserContext" style="padding-top: 5px;"></div>
				</div>
			</div>
			<div title="组">
				<div class="permissionShowGroup">
					<c:if test="${hasPermissionTodelRepository }">
					<div alt="组维度头部按钮" style="padding-top: 5px;">
						<a onclick="addMenu_svnPermission_show_group()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增组</a>
						<a onclick="editMenu_svnPermission_show_group()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑组</a>
						<a onclick="addMenu_svnPermission_show_group_auth()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加组权限</a>
						<a onclick="editMenu_svnPermission_show_group_auth()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑组权限</a>
					</div>
					</c:if>
					<div alt="组维度头部搜索" style="padding-top: 5px;">
						<form class="custom-query-form">
							<label-title>组名:</label-title>
							<label-value>
								<input class="easyui-textbox" name="groupNameLike" />
							</label-value>
							<label-search>
								<label onclick="searchGroupShow();" class="easyui-linkbutton custom-search" data-options="iconCls:'icon-search'" style="width:80px">搜索</label>
							</label-search>
						</form>
					</div>
					<div alt="组维度内容" class="permissionShowGroupContext" style="padding-top: 5px;"></div>
				</div>
			</div>
			<div title="库">
				<div class="permissionShowRepositoryDir">
					<c:if test="${hasPermissionTodelRepository }">
					<div alt="库目录维度头部按钮" style="padding-top: 5px;">
						<a onclick="addMenu_svnPermission_show_resp()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-add'" id="addMenu_svnPermission_show_resp">新建库</a>
						<a onclick="editMenu_svnPermission_show_resp()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-edit'" id="editMenu_svnPermission_show_resp">编辑库</a>
						<a onclick="addMenu_svnPermission_show_dir()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增目录</a>
						<a onclick="editMenu_svnPermission_show_dir()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑目录</a>
						<a onclick="addMenu_svnPermission_show_auth()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加权限</a>
						<a onclick="editMenu_svnPermission_show_auth()" href='javascript:void("#")'
							class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑权限</a>
					</div>
					</c:if>
					<div alt="库目录维度头部搜索" style="padding-top: 5px;">
						<form class="custom-query-form">
							<label-title>库名:</label-title>
							<label-value>
								<input class="easyui-textbox" id="repositoryNameLike" name="repositoryNameLike" />
							</label-value>
							<label-title>目录名:</label-title>
							<label-value>
								<input class="easyui-textbox" id="directoryNameLike" name="directoryNameLike" />
							</label-value>
							<label-search>
								<label onclick="searchRepositoryDirShow();" class="easyui-linkbutton custom-search" data-options="iconCls:'icon-search'" style="width:80px">搜索</label>
							</label-search>
						</form>
					</div>
					<div alt="库目录维度内容" class="permissionShowRepositoryDirContext" style="padding-top: 5px;"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>