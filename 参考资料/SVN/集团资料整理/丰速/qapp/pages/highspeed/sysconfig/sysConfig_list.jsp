<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<table id="sysConfig_list_propertyGrid" class="easyui-propertygrid">
	</table>
	<div style="float: right;margin:5px 20px 5px 0px;">
		<a href="javascript:void(0)" data-options="iconCls:'icon-save'" class="easyui-linkbutton" onclick="saveChanges()">保存配置</a>
	</div>
	<script type="text/javascript">
		$('#sysConfig_list_propertyGrid').propertygrid({
			url:'${pageContext.request.contextPath}/main/sys/querySysConfigData',
			showGroup : true,
			showHeader:true,
			scrollbarSize : 0,
			columns: [[{
	            field: "config_id",
	            title: "config_id",
	            width: 10,
	            hidden:true
	        },{
	            field: "name",
	            title: "配置项",
	            width: 60,
	            sortable: true
	        },{
	            field: "value",
	            title: "配置值",
	            width: 160,
	            resizable: false
	        },{
	            field: "remark",
	            title: "备注",
	            width: 80,
	            resizable: false
	        }]],
		});
		
		function saveChanges(){
			var args = [];
			var rows = $('#sysConfig_list_propertyGrid').propertygrid('getChanges');
			if(rows.length<1){
				$.messager.alert('系统提示','没有修改任何配置项');
				return;
			}
			for(var i=0; i<rows.length; i++){
				var temp = new Object();
				temp.id=rows[i].config_id;
				temp.value=rows[i].value;
				args.push(temp);
			}
			top.ajaxData({
				url : "${pageContext.request.contextPath}/main/sys/saveConfigValue",
				data : {
					args : JSON.stringify(args)
				},
				success : function(obj) {
					var obj = eval('(' + obj + ')');
					if (obj.success) {
						$.messager.alert('系统提示', obj.msg);
					} else {
						$.messager.alert('系统提示', obj.msg);
					}
				}
			});
		}
	</script>
</body>
</html>