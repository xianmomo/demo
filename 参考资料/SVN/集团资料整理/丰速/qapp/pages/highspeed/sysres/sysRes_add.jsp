<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div style="padding: 10px 10px 0px 10px">
		<form class="custom-form" id="sysResAdd_form">
			<label-title>上级资源:</label-title>
			<label-value> 
				<select class="easyui-combobox" name="parentId">
					<option value="999999">无</option>
					<c:forEach items="${sysResList }" var="sysRes">
						<option value="${sysRes.resId }">${sysRes.resName }</option>
					</c:forEach>
				</select> 
			</label-value>
			<label-title>资源名称:</label-title>
			<label-value> 
				<input class="easyui-textbox" name="resName"/> 
			</label-value>
			<label-title>资源路径:</label-title>
			<label-value> 
				<input class="easyui-textbox" multiline="true" style="height: 80px;" name="resPath"/> 
			</label-value>
			<label-title>资源类型:</label-title>
			<label-value> 
				<input type="radio" name="resType" value="0"/> <span>菜单</span> 
				<input type="radio"	name="resType" checked="checked" value="1"/> <span>按钮</span>
			</label-value>
			<label-title>资源状态:</label-title>
			<label-value> 
				<input type="radio" name="resStatu" checked="checked" value="0"/> <span>正常</span> 
				<input type="radio" name="resStatu" value="1"/> <span>禁用</span> 
			</label-value>
			<label-title>备注:</label-title>
			<label-value> 
				<input class="easyui-textbox" multiline="true" style="height: 60px;" name="remark"/> 
			</label-value>
		</form>
		<div style="text-align: center; padding: 5px">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-save'" onclick="submitForm()">保存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'" onclick="clearForm()">取消</a>
		</div>
	</div>
	<script type="text/javascript">
		function clearForm() {
			$("#"+$("#dialogId").val()).dialog("destroy");
		}
		function submitForm(){
			top.ajaxSubmitForm({
				formId : "sysResAdd_form",
				url : "${pageContext.request.contextPath }/main/sys/sysResSave",
				success : function(data) {
					if (data.success) {
						top.messageAlert(true,"提交成功","");
						clearForm();
						top.refreshTab("资源管理");
					} else {
						top.messageAlert(false,"提交失败",data.msg);
					}
				}
			});
		}
	</script>
</body>
</html>