<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div style="padding: 10px 10px 0px 10px">
		<div style="text-align: center; padding: 5px">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-save'" onclick="tbSvnDirModifyFormSubmit()">保存</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="iconCls:'icon-cancel'" onclick="tbSvnDirModifyFormClear()">取消</a>
		</div>
		<form class="custom-form" id="tbSvnDirModify_form">
			<input type="hidden" name="dirId" value="${tbSvnDir.dirId }"/>
			<label-title>所属配置库:</label-title>
			<label-value> 
				${tbSvnResp.respName }
			</label-value>
			<label-title>所属上级目录:</label-title>
			<label-value>
				${parentDirPath eq ""?"/":parentDirPath }
				<input type="hidden" value="${parentDirPath }" name="parentDirPath" />
			</label-value>
			<label-title>文件夹名称:</label-title>
			<label-value>
				<input class="easyui-textbox" value="${folderName }" name="folderName"/> 
			</label-value>
			<label-title>目录类型:</label-title>
			<label-value> 
				<input type="radio"	name="dirType" <c:if test="${tbSvnDir.dirType eq '0'}">checked="checked"</c:if> value="0"/> <span>标准</span>
				<input type="radio"	name="dirType" <c:if test="${tbSvnDir.dirType eq '1'}">checked="checked"</c:if> value="1"/> <span>非标准</span>
			</label-value>
			<label-title>备注:</label-title>
			<label-value> 
				<input class="easyui-textbox" multiline="true" style="height: 60px;" value="${tbSvnDir.remark }" name="remark"/> 
			</label-value>
		</form>
	</div>
	<script type="text/javascript">
		function tbSvnDirModifyFormClear() {
			$("#"+$("#dialogId").val()).dialog("destroy");
		}
		function tbSvnDirModifyFormSubmit(){
			top.ajaxSubmitForm({
				formId : "tbSvnDirModify_form",
				url : "${pageContext.request.contextPath }/main/svn/modifyTbSvnDir",
				success : function(data) {
					if (data.success) {
						top.messageAlert(true,"提交成功","");
						tbSvnDirModifyFormClear();
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