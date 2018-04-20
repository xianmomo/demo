<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<style>
table {
	margin: 0px auto;
}

table .labelTd {
	width: 160px;
	text-align: right;
	font-size: 16px;
	line-height: 24px;
}

table .inputTd {
	padding-left: 2px;
	width: 300px;
	text-align: left;
	font-size: 14px;
	line-height: 24px;
}

table .inputTd select {
	width: 140px;
}

.button-center {
	margin-top:5px;
	text-align: center;
}
</style>
	<form id="tbModulFileAdd">
		<table>
			<tbody>
				<tr>
					<td class="panel-body labelTd">模板类型:</td>
					<td class="panel-body panel-body-noleft inputTd">
						<select class="easyui-combobox" id="modulType">
							<option value="IT003">IT003</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="panel-body labelTd">模板附件:</td>
					<td class="panel-body panel-body-noleft inputTd">
						<label id="tbModulFile_fileList"></label>
						<a href='javascript:void("#")' onclick="tbModulFile_uploadFile();"
							class="easyui-linkbutton">上传</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<script type="text/javascript">
		function tbModulFile_uploadFile() {
			$(this)
					.customUpload(
							{
								id : 'tbModulUploadFile',
								title : '选择文件',
								width : 300,
								height : 400,
								uploadParams : {
									uploader : '${pageContext.request.contextPath}/main/bus/modulFile/upload',
									auto : false,
									multi : true,
									fileTypeExts : '*.xls;*.xlsx',
									buttonText : '模板上传',
									callBack : function(file, data) {
										var dataObj = eval("(" + data + ")");
										if (dataObj.success) {
											top.showUploadHtml(
													"tbModulFile_fileList",
													dataObj,true);
										} else {
											$.messager.alert("系统提示", file.name
													+ ":" + dataObj.msg);
										}

									}
								}
							});
		}
	</script>
</body>
</html>