<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div style="padding: 10px 10px 0px 10px">
		<div style="text-align: center; padding: 5px">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-save'" onclick="tbSvnGroupModifyFormSubmit()">保存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'" onclick="tbSvnGroupModifyFormClear()">取消</a>
		</div>
		<form class="custom-form" id="tbSvnGroupModify_form">
			<input type="hidden" name="groupId" value="${tbSvnGroup.groupId }"/>
			<label-title>组名称:</label-title>
			<label-value>
				<input class="easyui-textbox" name="groupName" value="${tbSvnGroup.groupName }"/> 
			</label-value>
			<label-title>组别名:</label-title>
			<label-value>
				<input class="easyui-textbox" name="groupAlias" value="${tbSvnGroup.groupAlias }"/> 
			</label-value>
			<label-title>组类型:</label-title>
			<label-value> 
				<input type="radio"	name="groupType" <c:if test="${tbSvnGroup.groupType eq '0'}">checked="checked"</c:if> value="0"/> <span>标准</span>
				<input type="radio"	name="groupType" <c:if test="${tbSvnGroup.groupType eq '1'}">checked="checked"</c:if> value="1"/> <span>非标准</span>
			</label-value>
		</form>
	</div>
	<script type="text/javascript">
		function tbSvnGroupModifyFormClear() {
			$("#"+$("#dialogId").val()).dialog("destroy");
		}
		function tbSvnGroupModifyFormSubmit(){
			top.ajaxSubmitForm({
				formId : "tbSvnGroupModify_form",
				url : "${pageContext.request.contextPath }/main/svn/updateTbSvnGroup",
				success : function(data) {
					if (data.success) {
						top.messageAlert(true,"提交成功","");
						tbSvnGroupModifyFormClear();
						searchGroupShow();
					} else {
						top.messageAlert(false,"提交失败",data.msg);
					}
				}
			});
		}
	</script>
</body>
</html>