<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<style>
		.permissionEditChildGroupContext .permissionEditChildGroupList{
			height:180px;
			overflow: scroll;
			border: 1px solid #B7D2FF;
		}
		.permissionEditGroupUserContext .permissionEditGroupUserList{
			height:220px;
			overflow: scroll;
			border: 1px solid #B7D2FF;
		}
		.permissionShowList{
			padding: 2px 0px 0px 10px;
			line-height: 24px;
			font-size: 14px;
		}
		.permissionShowList:HOVER{
			background: #EAF2FF;
		}
		.permissionShowList.selected{
			background: #FFE48D;
		}
		.permissionShowList div.groupName{
			vertical-align:middle;
			display:inline-block;
			width:260px;
		}
		.permissionShowList div.userName{
			vertical-align:middle;
			display:inline-block;
			width:260px;
		}
		.permissionShowList div.auth{
			vertical-align:middle;
			display:inline-block;
			text-align:center;
			width:200px;
		}
	</style>
	<div alt="头部描述" style="padding: 5px 0px 5px 5px;color: green;font-size: 16px;font-weight: bold;">
		当前组信息    ${tbSvnGroup.groupName }
	</div>
	<div style="text-align: center; padding: 5px">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-save'" onclick="svnPermissionGroupAuthModifyFormSubmit()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-cancel'" onclick="svnPermissionGroupAuthModifyFormClear()">取消</a>
	</div>
	<div class="permissionEditChildGroupContext">
		<div alt="组下子组数据编辑" class="permissionEditChildGroupList">
			<c:forEach items="${childGroupList }" var="childGroup">
				<div class="permissionShowList">
					<div class="groupName">${childGroup.group_name }</div>
					<div class="auth">
						<input type="radio" value="${childGroup.group_id }" checked="checked" name="permission_${childGroup.group_id }">保留
						<input type="radio" value="" name="permission_${childGroup.group_id }">移除
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="permissionEditGroupUserContext">
		<div alt="组下用户数据编辑" class="permissionEditGroupUserList">
			<c:forEach items="${groupUserList }" var="groupUser">
				<div class="permissionShowList">
					<div class="userName">${groupUser.user_alias }(${groupUser.user_name })</div>
					<div class="auth">
						<input type="radio" value="${groupUser.user_id }" checked="checked" name="permission_${groupUser.id }_${groupUser.date_num }">保留
						<input type="radio" value="" name="permission_${groupUser.id }_${groupUser.date_num }">移除
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<script type="text/javascript">
		function svnPermissionGroupAuthModifyFormClear() {
			$("#"+$("#dialogId").val()).dialog("destroy");
		}
		function svnPermissionGroupAuthModifyFormSubmit(){
			var childGroupObj = $(".permissionEditChildGroupContext").find(":input").serialize();
			var groupUserObj = $(".permissionEditGroupUserContext").find(":input").serialize();
			debugger
			top.ajaxData({
				url : '${pageContext.request.contextPath}/main/svn/updateSvnPermissionGroupAuth',
				data : {
					groupId : "${tbSvnGroup.groupId}",
					childGroup : childGroupObj,
					groupUser : groupUserObj
				},
				success : function(obj) {
					var data = eval("(" + obj + ")");
					if (data.success) {
						top.messageAlert(true,"提交成功","");
						svnPermissionGroupAuthModifyFormClear();
						showGroupPermission();
					}
				}
			});
		}
	</script>
</body>
</html>