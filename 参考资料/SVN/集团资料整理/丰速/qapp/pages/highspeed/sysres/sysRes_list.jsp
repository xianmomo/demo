<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<script type="text/javascript">
		$('#sysRes_list_treeGrid')
				.treegrid(
						{
							url : '${pageContext.request.contextPath}/main/sys/querySysResData',
							method : "POST",
							idField : 'res_id',
							treeField : 'res_name',
							rownumbers : true,
							columns : [ [ {
								title : '资源名称',
								field : 'res_name',
								halign : 'center',
								width : 140
							}, {
								title : '资源路径',
								field : 'res_path',
								halign : 'center',
								width : 180,
							}, {
								title : '上级资源',
								field : 'parent_name',
								halign : 'center',
								align : 'center',
								width : 100
							}, {
								title : '资源类型',
								field : 'res_type',
								halign : 'center',
								align : 'center',
								width : 80,
								formatter:function(value){
									return value=="0"?"菜单":"按钮";
								}
							}, {
								title : '资源状态',
								field : 'res_statu',
								halign : 'center',
								align : 'center',
								width : 80,
								formatter : function(value){
									return value=="0"?"<span style='color:blue;'>正常</span>":"<span style='color:red;'>禁用</span>";
								}
							}, {
								title : '创建人',
								field : 'create_name',
								halign : 'center',
								align : 'center',
								width : 80
							}, {
								title : '创建时间',
								field : 'create_time_str',
								halign : 'center',
								align : 'center',
								width : 160
							}, {
								title : '备注',
								field : 'remark',
								halign : 'center',
								width : 180
							} ] ]
						});

		//查询数据
		function seachData() {
			$('#sysRes_list_treeGrid').treegrid('load');
		}

		//新增
		function addMenu() {
			top.openDialog({
				id : 'addSysRes',
			    title: '新增资源',
			    width: 350,
			    height: 360,
			    href: '${pageContext.request.contextPath}/main/sys/sysResAdd'
			});
		}
		//编辑
		function modifyMenu() {
			//获取选中的行
			var selectRows = $('#sysRes_list_treeGrid').treegrid('getSelected');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作失败", "请选择要编辑的资源");
				return;
			}
			top.openDialog({
				id : 'modifySysRes',
			    title: '编辑资源',
			    width: 350,
			    height: 360,
			    href: '${pageContext.request.contextPath}/main/sys/sysResModify?resId='+selectRows.res_id
			});
		}
		//删除
		function delMenu() {
			//获取选中的行
			var selectRows = $('#sysRes_list_treeGrid').treegrid('getSelected');
			if (selectRows == null) {
				$.messager.alert('系统提示', '请选择要删除的数据', 'info');
				return;
			}
			top.ajaxData({
				url : '${pageContext.request.contextPath}/main/sys/delSysRes',
				data : {
					levelPath:selectRows.level_path
				},
				success : function(obj) {
					var data = eval("(" + obj + ")");
					if (data.success) {
						seachData();
					}else{
						top.messageAlert(false,"删除失败",data.msg);
					}
				}
			});
		}
	</script>
	<div style="padding: 5px 0;">
		<a onclick="addMenu()" href='javascript:void("#")'
			class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a>
		<a onclick="modifyMenu()" href='javascript:void("#")'
			class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
		<a onclick="delMenu()" href='javascript:void("#")'
			class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
	</div>
	<table id="sysRes_list_treeGrid"></table>
</body>
</html>