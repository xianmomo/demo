<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div style="padding: 10px 10px 0px 10px">
		<div style="text-align: center; padding: 5px">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-save'" onclick="tbSvnRespModifyFormSubmit()">保存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'" onclick="tbSvnRespModifyFormClear()">取消</a>
		</div>
		<form class="custom-form" id="tbSvnRespModify_form">
			<input type="hidden" name="respId" value="${tbSvnResp.respId }" />
			<label-title>库名称:</label-title>
			<label-value> 
				<input class="easyui-textbox" name="respName" value="${tbSvnResp.respName }"/> 
			</label-value>
		</form>
	</div>
	<script type="text/javascript">
		function tbSvnRespModifyFormClear() {
			$("#"+$("#dialogId").val()).dialog("destroy");
		}
		function tbSvnRespModifyFormSubmit(){
			top.ajaxSubmitForm({
				formId : "tbSvnRespModify_form",
				url : "${pageContext.request.contextPath }/main/svn/updateTbSvnResp",
				success : function(data) {
					if (data.success) {
						top.messageAlert(true,"提交成功","");
						tbSvnRespModifyFormClear();
						searchRepositoryDirShow();
					} else {
						top.messageAlert(false,"提交失败",data.msg);
					}
				}
			});
		}
	</script>
</body>
</html>