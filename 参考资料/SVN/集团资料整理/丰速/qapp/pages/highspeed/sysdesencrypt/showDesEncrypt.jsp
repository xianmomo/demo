<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div style="padding: 10px 60px 20px 60px;">
		<form id="ff" style="width:100%;">
			<table cellpadding="2">
				<tr>
					<td>字符串</td>
					<td>
						<input type="text" name="inputString" class="easyui-textbox" />
					</td>
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton"
							onclick="processString('0')">加密</a>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea rows="5" cols="80" name="resultString"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script>
		function processString(processType) {
			top.ajaxData({
				url : "${pageContext.request.contextPath}/main/sys/processString",
				data : {
					processType : processType,
					inputString : $("input[name='inputString']").val()
				},
				success : function(obj) {
					var obj = eval('(' + obj + ')');
					if (obj.success) {
						$("textarea[name='resultString']").val(obj.data);
					} else {
						$.messager.alert('系统提示', obj.msg);
					}
				}
			});
		}
	</script>
</body>
</html>