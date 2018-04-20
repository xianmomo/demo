<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<script type="text/javascript">
	$('#tbOpera_list_treeGrid')
				.datagrid(
						{
							url : '${pageContext.request.contextPath}/main/bus/queryTbOperaData',
							method : "POST",
							rownumbers : true,
							pagination : true, // 分页
							pageSize : 20,
							pageList : [ 20, 30, 40 ],
							columns : [ [
									{
										title : '日志类型',
										field : 'operType',
										halign : 'center',
										align : 'center',
										width : 80,
										formatter : function(value) {
											if (value == "1") {
												return "SVN";
											}
										}
									},
									{
										title : '日志标题',
										field : 'operTitle',
										halign : 'center',
										width : 140,
									},
									{
										title : '日志结果',
										field : 'operResult',
										halign : 'center',
										align : 'center',
										width : 100,
										formatter : function(value) {
											if (value == "0") {
												return "<span style='color:green;'>成功</span>";
											} else if (value == "1") {
												return "<span style='color:red;'>失败</span>";
											}
										}
									},
									{
										title : '备注',
										field : 'operRemark',
										halign : 'center',
										width : 400,
										formatter : function(value) {
											if (value != null && value != '') {
												return "<span title='"+value+"'>"
														+ value + "</span>";
											}
										}
									}, {
										title : '创建时间',
										field : 'createTimeStr',
										halign : 'center',
										align : 'center',
										width : 160
									} ] ]
						});
		
		//查询数据
		function seachData() {
			$('#tbOpera_list_treeGrid').treegrid('load');
		}
	</script>
	<table id="tbOpera_list_treeGrid"></table>
</body>
</html>