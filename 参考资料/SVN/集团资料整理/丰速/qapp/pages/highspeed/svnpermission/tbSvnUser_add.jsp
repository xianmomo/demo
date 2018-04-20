<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div style="padding: 10px 10px 0px 10px">
		<div style="text-align: center; padding: 5px">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-save'" onclick="tbSvnUserAddFormSubmit()">保存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'" onclick="tbSvnUserAddFormClear()">取消</a>
		</div>
		<form class="custom-form" id="tbSvnUserAdd_form">
			<label-title>工号:</label-title>
			<label-value> 
				<input class="easyui-textbox" name="userName" />
			</label-value>
			<label-title>用户名:</label-title>
			<label-value>
				<input class="easyui-textbox" name="userAlias" />
			</label-value>
			<label-title>邮箱:</label-title>
			<label-value>
				<input class="easyui-textbox" name="userEmail"/> 
			</label-value>
			<label-title>顺丰科技人员:</label-title>
			<label-value> 
				<input class="easyui-combobox" id="userType" value="1"
					data-options="editable:false,valueField: 'value',textField: 'label',data:[
						{label:'是',value:0},{label:'否',value:1}
					]" />
			</label-value>
		</form>
	</div>
	<script type="text/javascript">
		function tbSvnUserAddFormClear() {
			$("#"+$("#dialogId").val()).dialog("destroy");
		}
		function tbSvnUserAddFormSubmit(){
			top.ajaxSubmitForm({
				formId : "tbSvnUserAdd_form",
				url : "${pageContext.request.contextPath }/main/svn/saveTbSvnUser",
				success : function(data) {
					if (data.success) {
						top.messageAlert(true,"提交成功","");
						tbSvnUserAddFormClear();
						searchUserShow();
					} else {
						top.messageAlert(false,"提交失败",data.msg);
					}
				}
			});
		}
	</script>
</body>
</html>