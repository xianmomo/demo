<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<script type="text/javascript">
		$('#tbSvnDir_list').find("#dataGrid").datagrid({
			url : '${pageContext.request.contextPath}/main/svn/queryTbSvnDirListData',
			method : "POST",
			rownumbers : true,
			singleSelect : true,
			pagination : true,
			striped : true,
			autoRowHeight:false,
			columns : [ [
					{
						title : '目录Id',
						field : 'dir_id',
						hidden : true,
						halign : 'center',
						width : 10
					},
					{
						title : '所属配置库',
						field : 'resp_name',
						halign : 'center',
						align : 'left',
						width : 100
					},
					{
						title : '目录路径',
						field : 'dir_path',
						halign : 'center',
						align : 'left',
						width : 230
					},
					{
						title : '目录类型',
						field : 'dir_type',
						halign : 'center',
						align : 'center',
						width : 80,
						formatter:function(value){
							if(value=="0"){
								return "<span style='color:green;'>标准</span>";
							}else if(value=="1"){
								return "<span style='color:#FF7F00;'>非标准</span>";
							}else{
								return value;
							}
						}
					},
					{
						title : '创建人',
						field : 'create_name',
						halign : 'center',
						align : 'center',
						width : 80,
					},
					{
						title : '创建时间',
						field : 'create_time_str',
						halign : 'center',
						align : 'center',
						width : 140
					},
					{
						title : '备注',
						field : 'remark',
						halign : 'center',
						width : 220,
						formatter : function(value) {
							if (value != null && value != '') {
								return "<span title='"+value+"'>"
										+ value + "</span>";
							}
						}
					} ] ]
		});

		//查询数据
		function seachData_tbSvnDir_list() {
			$('#tbSvnDir_list').find("#dataGrid").datagrid('load',{
				respNameLike:$('#tbSvnDir_list').find("#respNameLike").val(),
				createTimeBegin:$('#tbSvnDir_list').find("#createTimeBegin").val(),
				createTimeEnd:$('#tbSvnDir_list').find("#createTimeEnd").val(),
				dirPathLike:$('#tbSvnDir_list').find("#dirPathLike").val()
			});
		}

		//新建目录
		function addMenu_tbSvnDir_list() {
			//获取选中的行
			var selectRows = $('#tbSvnDir_list').find("#dataGrid").datagrid('getSelected');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作","请选择要新增的目录上级");
				return;
			}
			top.openDialog({
				id : 'addTbDir',
			    title: '新增SVN目录',
			    width: 350,
			    height: 270,
			    href: '${pageContext.request.contextPath}/main/svn/tbSvnDirAdd?dirId='+selectRows.dir_id
			});
		}
		
		//编辑目录
		function modifyMenu_tbSvnDir_list() {
			//获取选中的行
			var selectRows = $('#tbSvnDir_list').find("#dataGrid").datagrid('getSelected');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作","请选择要编辑的目录");
				return;
			}
			if (selectRows.dir_path == "/") {
				top.messageAlert(false,"业务操作","不能编辑根目录");
				return;
			}
			top.openDialog({
				id : 'modifyTbDir',
			    title: '编辑SVN目录',
			    width: 350,
			    height: 270,
			    href: '${pageContext.request.contextPath}/main/svn/tbSvnDirModify?dirId='+selectRows.dir_id
			});
		}
		
		//查看目录组及用户权限信息
		function showGroupAndUserPermission() {
			//获取选中的行
			var selectRows = $('#tbSvnDir_list').find("#dataGrid").datagrid('getSelected');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作","请选择要查看的目录");
				return;
			}
			top.openDialog({
				id : 'showDirGroupAndUserPermission',
			    title: '查看SVN配置库【'+selectRows.resp_name+'】下目录【'+selectRows.dir_path+'】的组及用户权限',
			    width: 660,
			    height: 500,
			    href: '${pageContext.request.contextPath}/main/svn/tbSvnDirGroupAndUserPermissionView?dirId='+selectRows.dir_id
			});
		}
		
		//删除目录信息及权限
		function delMenu_tbSvnDir_list(){
			//获取选中的行
			var selectRows = $('#tbSvnDir_list').find("#dataGrid").datagrid('getSelected');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作","请选择要删除的目录");
				return;
			}
			top.ajaxData({
				url : '${pageContext.request.contextPath}/main/svn/deleteTbSvnResp',
				data : {
					respId : selectRows.resp_id
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
	<div id="tbSvnDir_list">
		<div style="padding: 5px 0;">
			<a onclick="addMenu_tbSvnDir_list()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a>
			<a onclick="showGroupAndUserPermission()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="iconCls:'icon-view'">查看组及用户权限</a>
			<a onclick="modifyMenu_tbSvnDir_list()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="iconCls:'icon-edit'">编辑</a>
			<!-- <a onclick="delMenu_tbSvnDir_list()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a> -->
		</div>
		<div style="padding: 5px 0;">
			<form class="custom-query-form">
				<label-title>配置库名称:</label-title>
				<label-value>
					<input class="easyui-textbox" id="respNameLike" />
				</label-value>
				<label-title>创建开始时间:</label-title>
				<label-value>
					<input style="width:100px;" data-options="formatter:initQueryDate,parser:initQueryDateParser" class="easyui-datebox" id="createTimeBegin" />
				</label-value>
				<label-title>创建结束时间:</label-title>
				<label-value>
					<input style="width:100px;" data-options="formatter:initQueryDate,parser:initQueryDateParser" class="easyui-datebox" id="createTimeEnd" />
				</label-value>
				<label-title>目录地址:</label-title>
				<label-value>
					<input class="easyui-textbox" id="dirPathLike" />
				</label-value>
			</form>
			<label onclick="seachData_tbSvnDir_list();" class="easyui-linkbutton custom-search" data-options="iconCls:'icon-search'" style="width:80px">搜索</label>
		</div>
		<table id="dataGrid"></table>
	</div>
</body>
</html>