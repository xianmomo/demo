<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div style="padding: 10px 10px 0px 10px">
		<form class="custom-form" id="sysResAdd_form">
			<div style="display: none;">
				<input type="hidden" name="resId" value="${sysRes.resId }" />
			</div>
			<label-title>上级资源:</label-title>
			<label-value> 
				<select class="easyui-combobox" name="parentId">
					<option <c:if test="${sysRes.parentId eq 999999 }">selected="selected"</c:if> value="999999">无</option>
					<c:forEach items="${sysResList }" var="sysResTemp">
						<option <c:if test="${sysRes.parentId eq sysResTemp.resId}">selected="selected"</c:if> value="${sysResTemp.resId }">${sysResTemp.resName }</option>
					</c:forEach>
				</select> 
			</label-value>
			<label-title>资源名称:</label-title>
			<label-value> 
				<input class="easyui-textbox" name="resName" value="${sysRes.resName }" /> 
			</label-value>
			<label-title>资源路径:</label-title>
			<label-value> 
				<input class="easyui-textbox" multiline="true" style="height: 80px;" name="resPath" value="${sysRes.resPath }" /> 
			</label-value>
			<label-title>资源类型:</label-title>
			<label-value> 
				<input <c:if test="${sysRes.resType eq '0' }">checked="checked"</c:if> type="radio" name="resType" value="0" /> <span>菜单</span> 
				<input <c:if test="${sysRes.resType eq '1' }">checked="checked"</c:if> type="radio"	name="resType" value="1" /> <span>按钮</span>
			</label-value>
			<label-title>资源状态:</label-title>
			<label-value> 
				<input <c:if test="${sysRes.resStatu eq '0' }">checked="checked"</c:if> type="radio" name="resStatu" value="0"/> <span>正常</span> 
				<input <c:if test="${sysRes.resStatu eq '1' }">checked="checked"</c:if> type="radio" name="resStatu" value="1"/> <span>禁用</span> 
			</label-value>
			<label-title>备注:</label-title>
			<label-value> 
				<input class="easyui-textbox" multiline="true" style="height: 60px;" name="remark" value="${sysRes.remark }"/> 
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
						top.messageAlert(true, "提交成功", "");
						clearForm();
						top.refreshTab("资源管理");
					} else {
						top.messageAlert(false, "提交失败", data.msg);
					}
				}
			});
		}
	</script>
</body>
</html>