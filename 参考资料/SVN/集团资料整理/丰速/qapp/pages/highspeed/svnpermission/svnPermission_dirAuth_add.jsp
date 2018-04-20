<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div alt="头部描述" style="padding: 5px 0px 5px 5px;color: green;font-size: 16px;font-weight: bold;">
		当前库目录    ${tbSvnResp.respName }:${tbSvnDir.dirPath}
	</div>
	<div style="text-align: center; padding: 5px">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-save'" onclick="svnPermissionDirAuthAddFormSubmit()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-cancel'" onclick="svnPermissionDirAuthAddFormClear()">取消</a>
	</div>
	<div class="permissionShowRepositoryGroupContext">
		<div alt="库下组数据展示" class="permissionShowRepositoryGroupList">
			<select multiple="multiple" class="demoRepositoryGroupList">
			<c:forEach items="${resultAllNotPermissionGroupList }" var="notPermissionGroup">
				<option title=右键点击切换权限类型 value="${notPermissionGroup.group_id }">${notPermissionGroup.group_name }</option>
			</c:forEach>
			</select>
		</div>
	</div>
	<div class="permissionShowRepositoryUserContext">
		<div alt="库下用户数据展示" class="permissionShowRepositoryUserList">
			<select multiple="multiple" class="demoRepositoryUserList">
			<c:forEach items="${resultAllNotPermissionUserList }" var="notPermissionUser">
				<option title="右键点击切换权限类型" data-date-num="${notPermissionUser.date_num }" data-user-name="${notPermissionUser.user_name }" value="${notPermissionUser.user_id }">${notPermissionUser.user_alias }(${notPermissionUser.user_name })</option>
			</c:forEach>
			</select>
		</div>
	</div>
	<script type="text/javascript">
		demoRepositoryGroup = $(".permissionShowRepositoryGroupContext").find(".demoRepositoryGroupList").bootstrapDualListbox({
			nonSelectedListLabel: '未选择组',
			selectedListLabel: '已选择组',
			preserveSelectionOnMove: 'moved',
			moveOnSelect: false,
			selectedItemContextMenu:function(showSelectedItem,hideSelectedItem){
				if(!$(hideSelectedItem).data("permission")){
					$(hideSelectedItem).data("permission","r");
				}
				if($(hideSelectedItem).data("permission") == "r"){
					$(hideSelectedItem).data("permission","rw");
				}else{
					$(hideSelectedItem).data("permission","r");
				}
				$(showSelectedItem).text($(hideSelectedItem).text()+" 权限类型："+$(hideSelectedItem).data("permission"));
			},
			selectedItemInitText:function(showSelectedItem,hideSelectedItem){
				if(!$(hideSelectedItem).data("permission")){
					$(hideSelectedItem).data("permission","r");
				}
				$(showSelectedItem).text($(hideSelectedItem).text()+" 权限类型："+$(hideSelectedItem).data("permission"));
			}
		});
		demoRepositoryUser = $(".permissionShowRepositoryUserContext").find(".demoRepositoryUserList").bootstrapDualListbox({
			nonSelectedListLabel: '未选择用户',
			selectedListLabel: '已选择用户',
			preserveSelectionOnMove: 'moved',
			moveOnSelect: false,
			selectedItemContextMenu:function(showSelectedItem,hideSelectedItem){
				if(!$(hideSelectedItem).data("permission")){
					$(hideSelectedItem).data("permission","r");
				}
				if($(hideSelectedItem).data("permission") == "r"){
					$(hideSelectedItem).data("permission","rw");
				}else{
					$(hideSelectedItem).data("permission","r");
				}
				$(showSelectedItem).text($(hideSelectedItem).text()+" 权限类型："+$(hideSelectedItem).data("permission"));
			},
			selectedItemInitText:function(showSelectedItem,hideSelectedItem){
				if(!$(hideSelectedItem).data("permission")){
					$(hideSelectedItem).data("permission","r");
				}
				$(showSelectedItem).text($(hideSelectedItem).text()+" 权限类型："+$(hideSelectedItem).data("permission"));
			}
		});
		
		function svnPermissionDirAuthAddFormClear() {
			$("#"+$("#dialogId").val()).dialog("destroy");
		}
		function svnPermissionDirAuthAddFormSubmit(){
			var selectGroupObj = $(".permissionShowRepositoryGroupContext").find(".demoRepositoryGroupList").find("option:selected");
			var selectUserObj = $(".permissionShowRepositoryUserContext").find(".demoRepositoryUserList").find("option:selected");
			var groupArray = [];
			selectGroupObj.each(function(){
				var groupObj = {};
				groupObj.groupId = $(this).val();
				groupObj.permission = $(this).data("permission");
				groupArray.push(groupObj);
			});
			var userArray = [];
			selectUserObj.each(function(){
				var userObj = {};
				userObj.userId = $(this).val();
				userObj.permission = $(this).data("permission");
				userObj.dateNum = $(this).data("date-num");
				userArray.push(userObj);
			});
			top.ajaxData({
				url : '${pageContext.request.contextPath}/main/svn/saveSvnPermissionDirAuth',
				data : {
					dirId : "${tbSvnDir.dirId}",
					groupPermission:JSON.stringify(groupArray),
					userPermission:JSON.stringify(userArray)
				},
				success : function(obj) {
					var data = eval("(" + obj + ")");
					if (data.success) {
						top.messageAlert(true,"提交成功","");
						svnPermissionDirAuthAddFormClear();
						var currentTreeNode = $("#svnPermission_show").find("#svnPermission_show_tree").tree('getSelected');
						showRepositoryDirPermission(currentTreeNode.id);
					}
				}
			});
		}
	</script>
</body>
</html>