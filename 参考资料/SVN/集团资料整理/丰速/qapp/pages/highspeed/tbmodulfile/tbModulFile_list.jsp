<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<script type="text/javascript">
		$("#tbModulFile_datagrid")
				.datagrid(
						{
							url : '${pageContext.request.contextPath}/main/bus/queryModulFileData',
							columns : [ [ {
								field : 'modul_id',
								title : '模板Id',
								width : 80,
								halign : 'center',
								hidden : true
							}, {
								field : 'modul_name',
								title : '模板实际名',
								width : 160,
								halign : 'center'
							}, {
								field : 'modul_upload_name',
								title : '模板上传名',
								width : 180,
								halign : 'center',
								formatter : function(value,row){
									return '<a style="text-decoration:none;" href="${pageContext.request.contextPath}/main/bus/modulFile/download?fileId='
											+ row.modul_id + '" target="_blank">' + value + '</a>';
								}
							}, {
								field : 'modul_type',
								title : '模板类型',
								width : 80,
								halign : 'center',
								align : 'center'
							}, {
								field : 'create_time_str',
								title : '操作时间',
								width : 160,
								halign : 'center'
							} ] ],
							pagination : true,
							rownumbers : true
						});

		//查询数据
		function seachData() {
			$('#tbModulFile_datagrid').datagrid('load');
		}
		
		function uploadModulFile() {
			top.openDialog({
				id : 'tbModulFileAdd',
				title : '模板文件上传',
				width : 500,
				height : 200,
				href : '${pageContext.request.contextPath}/pages/highspeed/tbmodulfile/tbModulFile_add.jsp',
				isOk : {
					text : '保存',
					handler : function() {
						var modulId = $("input[name='tbModulFile_fileList_fileMsg']");
						if (typeof modulId == "undefined") {
							$.messager.alert('系统提示', '请先上传模板文件');
							return;
						}
						var modulIdArray = [];
						for(i=0;i<modulId.length;i++){
							modulIdArray.push(modulId[i].value);
						}
						$.ajax({
							url : _ctx
									+ "/main/bus/modulFile/update",
							async : false,
							data : {
								modulIds : modulIdArray.join(),
								modulType : $("#modulType").val()
							},
							success : function(obj) {
								var obj = eval('(' + obj + ')');
								if (!obj.success) {
									$.messager.alert('系统提示',
											obj.msg);
								} else {
									// 销毁弹窗
									$("#tbModulFileAdd").dialog("destroy");
									seachData();
								}
							}
						});
					}
				}

			});
		}
		
		function deleteModulFile(){
			//获取选中的行
			var selectRows = $('#tbModulFile_datagrid').datagrid('getSelections');
			if (selectRows == null) {
				$.messager.alert('系统提示', '请选择要执行的数据');
				return;
			}
			var modulIdArray = [];
			for(i=0;i<selectRows.length;i++){
				modulIdArray.push(selectRows[i].modul_id);
			}
			$.ajax({
				type : "POST",
				url : '${pageContext.request.contextPath}/main/bus/modulFile/delete',
				data : "fileId="+ modulIdArray.join(),
				success : function(obj) {
					var data = eval("(" + obj + ")");
					if (data.success) {
						seachData();
					}else{
						$.messager.alert('系统提示', data.msg);
					}
				}
			});
		}
	</script>

	<div style="padding: 5px 0;">
		<a onclick="uploadModulFile()" href='javascript:void("#")'
			class="easyui-linkbutton" data-options="">上传模板</a>
		<a onclick="deleteModulFile()" href='javascript:void("#")'
			class="easyui-linkbutton" data-options="">删除模板</a>
	</div>
	<table id="tbModulFile_datagrid"></table>
</body>
</html>