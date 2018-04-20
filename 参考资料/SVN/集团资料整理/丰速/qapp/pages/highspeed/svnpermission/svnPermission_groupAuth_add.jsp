<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div alt="头部描述" style="padding: 5px 0px 5px 5px;color: green;font-size: 16px;font-weight: bold;">
		当前组信息    ${tbSvnGroup.groupName }
	</div>
	<div style="text-align: center; padding: 5px">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-save'" onclick="svnPermissionGroupAuthAddFormSubmit()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-cancel'" onclick="svnPermissionGroupAuthAddFormClear()">取消</a>
	</div>
	<div class="permissionShowChildGroupContext">
		<div alt="库下组数据展示" class="permissionShowChildGroupList">
			<select multiple="multiple" class="demoChildGroupList">
			<c:forEach items="${parentGroupList }" var="parentGroup">
				<option value="${parentGroup.group_id }">${parentGroup.group_name }</option>
			</c:forEach>
			</select>
		</div>
	</div>
	<div class="permissionShowGroupUserContext">
		<div alt="库下用户数据展示" class="permissionShowGroupUserList">
			<select multiple="multiple" class="demoGroupUserList">
			<c:forEach items="${userList }" var="groupUser">
				<option data-date-num="${groupUser.date_num }" value="${groupUser.user_id }">${groupUser.user_alias }(${groupUser.user_name })</option>
			</c:forEach>
			</select>
		</div>
	</div>
	<script type="text/javascript">
		demoRepositoryGroup = $(".permissionShowChildGroupContext").find(".demoChildGroupList").bootstrapDualListbox({
			nonSelectedListLabel: '未选择组',
			selectedListLabel: '已选择组',
			preserveSelectionOnMove: 'moved',
			moveOnSelect: false
		});
		
		demoRepositoryUser = $(".permissionShowGroupUserContext").find(".demoGroupUserList").bootstrapDualListbox({
			nonSelectedListLabel: '未选择用户',
			selectedListLabel: '已选择用户',
			preserveSelectionOnMove: 'moved',
			moveOnSelect: false
		});
		
		function svnPermissionGroupAuthAddFormClear() {
			$("#"+$("#dialogId").val()).dialog("destroy");
		}
		function svnPermissionGroupAuthAddFormSubmit(){
			var selectChildGroupObj = $(".permissionShowChildGroupContext").find(".demoChildGroupList").find("option:selected");
			var selectGroupUserObj = $(".permissionShowGroupUserContext").find(".demoGroupUserList").find("option:selected");
			var groupArray = [];
			selectChildGroupObj.each(function(){
				groupArray.push($(this).val());
			});
			var userArray = [];
			selectGroupUserObj.each(function(){
				var userObj = {};
				userObj.userId = $(this).val();
				userObj.dateNum = $(this).data("date-num");
				userArray.push(userObj);
			});
			top.ajaxData({
				url : '${pageContext.request.contextPath}/main/svn/saveSvnPermissionGroupAuth',
				data : {
					groupId : "${tbSvnGroup.groupId}",
					childGroup:JSON.stringify(groupArray),
					groupUser:JSON.stringify(userArray)
				},
				success : function(obj) {
					var data = eval("(" + obj + ")");
					if (data.success) {
						top.messageAlert(true,"提交成功","");
						svnPermissionGroupAuthAddFormClear();
						showGroupPermission();
					}
				}
			});
		}
	</script>
</body>
</html>