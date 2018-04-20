<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<table id="sysQuartz_list_dataGrid" class="easyui-propertygrid"></table>
	<script type="text/javascript">
		$('#sysQuartz_list_dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/main/sys/queryQuartzDataData',
			method : "POST",
			rownumbers : true,
			singleSelect : true,
			pagination : false,
			striped : true,
			autoRowHeight : false,
			columns : [ [ {
				field : "context_instance",
				title : "实例Id",
				width : 100,
				hidden : true,
				halign : 'center'
			}, {
				field : "trigger_name",
				title : "触发器名称",
				width : 120,
				halign : 'center',
				align : 'center'
			}, {
				field : "job_name",
				title : "任务名称",
				width : 160,
				halign : 'center',
				align : 'center'
			}, {
				field : "job_statu",
				title : "任务状态",
				width : 80,
				halign : 'center',
				align : 'center',
				formatter : function(value) {
					if (value == "正在执行") {
						return "<span style='color:red;'>"+value+"</span>";
					} else if (value == "未执行") {
						return "<span style='color:green;'>"+value+"</span>";
						
					} else if (value == "过时") {
						return "<span style='color:#FF7F00;'>"+value+"</span>";
					} else {
						return value;
					}
				}
			}, {
				field : "start_time",
				title : "开始执行时间",
				width : 120,
				halign : 'center',
				align : 'center'
			}, {
				field : "next_time",
				title : "下次执行时间",
				width : 120,
				halign : 'center',
				align : 'center'
			} ] ]
		});
	</script>
</body>
</html>