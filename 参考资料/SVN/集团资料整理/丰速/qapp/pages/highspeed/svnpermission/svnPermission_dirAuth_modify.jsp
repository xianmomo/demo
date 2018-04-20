<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<style>
		.permissionEditRepositoryGroupContext .permissionEditRepositoryGroupList{
			height:180px;
			overflow: scroll;
			border: 1px solid #B7D2FF;
		}
		.permissionEditRepositoryUserContext .permissionEditRepositoryUserList{
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
		当前库目录    ${tbSvnResp.respName }:${tbSvnDir.dirPath}
	</div>
	<div style="text-align: center; padding: 5px">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-save'" onclick="svnPermissionDirAuthModifyFormSubmit()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			data-options="iconCls:'icon-cancel'" onclick="svnPermissionDirAuthModifyFormClear()">取消</a>
	</div>
	<div class="permissionEditRepositoryGroupContext">
		<div alt="库下组数据编辑" class="permissionEditRepositoryGroupList">
			<c:forEach items="${groupPermissionList }" var="groupPermission">
				<div class="permissionShowList">
					<div class="groupName">${groupPermission.group_name }</div>
					<div class="auth">
						<input type="radio" value="rw" <c:if test="${groupPermission.auth eq 'rw' }"> checked="checked" </c:if> name="permission_${groupPermission.id }_${groupPermission.auth }">读写
						<input type="radio" value="r" <c:if test="${groupPermission.auth eq 'r' }"> checked="checked" </c:if> name="permission_${groupPermission.id }_${groupPermission.auth }">只读
						<input type="radio" value="" name="permission_${groupPermission.id }_${groupPermission.auth }">移除
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="permissionEditRepositoryUserContext">
		<div alt="库下用户数据编辑" class="permissionEditRepositoryUserList">
			<c:forEach items="${userPermissionList }" var="userPermission">
				<div class="permissionShowList">
					<div class="userName">${userPermission.user_alias }(${userPermission.user_name })</div>
					<div class="auth">
						<input type="radio" value="rw" <c:if test="${userPermission.auth eq 'rw' }"> checked="checked" </c:if> name="permission_${userPermission.id }_${userPermission.auth }_${userPermission.date_num }_${userPermission.user_id }">读写
						<input type="radio" value="r" <c:if test="${userPermission.auth eq 'r' }"> checked="checked" </c:if> name="permission_${userPermission.id }_${userPermission.auth }_${userPermission.date_num }_${userPermission.user_id }">只读
						<input type="radio" value="" name="permission_${userPermission.id }_${userPermission.auth }_${userPermission.date_num }_${userPermission.user_id }">移除
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<script type="text/javascript">
		function svnPermissionDirAuthModifyFormClear() {
			$("#"+$("#dialogId").val()).dialog("destroy");
		}
		function svnPermissionDirAuthModifyFormSubmit(){
			var groupPermissionObj = $(".permissionEditRepositoryGroupContext").find(":input").serialize();
			var userPermissionObj = $(".permissionEditRepositoryUserContext").find(":input").serialize();
			top.ajaxData({
				url : '${pageContext.request.contextPath}/main/svn/updateSvnPermissionDirAuth',
				data : {
					dirId : "${tbSvnDir.dirId}",
					groupPermission : groupPermissionObj,
					userPermission : userPermissionObj
				},
				success : function(obj) {
					var data = eval("(" + obj + ")");
					if (data.success) {
						top.messageAlert(true,"提交成功","");
						svnPermissionDirAuthModifyFormClear();
						var currentTreeNode = $("#svnPermission_show").find("#svnPermission_show_tree").tree('getSelected');
						showRepositoryDirPermission(currentTreeNode.id);
					}
				}
			});
		}
	</script>
</body>
</html>