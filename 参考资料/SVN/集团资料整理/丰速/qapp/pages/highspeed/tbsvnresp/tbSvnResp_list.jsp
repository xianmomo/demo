<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<script type="text/javascript">
		$('#tbSvnResp_list').find("#dataGrid").datagrid({
			url : '${pageContext.request.contextPath}/main/svn/queryTbSvnRespListData',
			method : "POST",
			rownumbers : true,
			singleSelect : true,
			pagination : true,
			striped : true,
			autoRowHeight:false,
			columns : [ [
					{
						title : '库Id',
						field : 'resp_id',
						hidden : true,
						halign : 'center',
						width : 10
					},
					{
						title : '库名称',
						field : 'resp_name',
						halign : 'center',
						align : 'left',
						width : 100
					},
					{
						title : '库类型',
						field : 'resp_type',
						halign : 'center',
						align : 'center',
						width : 80,
						formatter:function(value){
							if(value=="0"){
								return "产品库";
							}else if(value=="1"){
								return "系统库";
							}else if (value=="2"){
								return "管理库";
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
		function seachData_tbSvnResp_list() {
			$('#tbSvnResp_list').find("#dataGrid").datagrid('load',{
				respNameLike:$('#tbSvnResp_list').find("#respNameLike").val(),
				createTimeBegin:$('#tbSvnResp_list').find("#createTimeBegin").val(),
				createTimeEnd:$('#tbSvnResp_list').find("#createTimeEnd").val(),
				respType:$('#tbSvnResp_list').find("#respType").val()
			});
		}

		//新建配置库
		function addMenu_tbSvnResp_list() {
			top.openDialog({
				id : 'addTbResp',
			    title: '新增SVN配置库',
			    width: 350,
			    height: 240,
			    href: '${pageContext.request.contextPath}/main/svn/tbSvnRespAdd'
			});
		}
		
		//查看配置库目录及权限信息
		function showRepositoryDirAndPermission() {
			//获取选中的行
			var selectRows = $('#tbSvnResp_list').find("#dataGrid").datagrid('getSelected');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作","请选择要查看的库");
				return;
			}
			top.openDialog({
				id : 'showRepositoryDirAndPermission',
			    title: '查看SVN库【'+selectRows.resp_name+'】目录及权限',
			    width: 660,
			    height: 500,
			    href: '${pageContext.request.contextPath}/main/svn/tbSvnRespDirAndPermissionView?respId='+selectRows.resp_id
			});
		}
		
		//删除配置库信息及权限
		function delSvnRepository(){
			//获取选中的行
			var selectRows = $('#tbSvnResp_list').find("#dataGrid").datagrid('getSelected');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作","请选择要删除的库");
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
	<div id="tbSvnResp_list">
		<div style="padding: 5px 0;">
			<a onclick="addMenu_tbSvnResp_list()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="iconCls:'icon-add'">新增</a>
			<a onclick="showRepositoryDirAndPermission()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="iconCls:'icon-view'">查看库目录及权限</a>
			<!-- <a onclick="delSvnRepository()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a> -->
		</div>
		<div style="padding: 5px 0;">
			<form class="custom-query-form">
				<label-title>配置库类型:</label-title>
				<label-value>
					<select class="easyui-combobox" id="respType">
						<option value="">所有</option>
						<option value="0">产品库</option>
						<option value="1">系统库</option>
						<option value="2">管理库</option>
					</select>
				</label-value>
				<label-title>创建开始时间:</label-title>
				<label-value>
					<input style="width:100px;" data-options="formatter:initQueryDate,parser:initQueryDateParser" class="easyui-datebox" id="createTimeBegin" />
				</label-value>
				<label-title>创建结束时间:</label-title>
				<label-value>
					<input style="width:100px;" data-options="formatter:initQueryDate,parser:initQueryDateParser" class="easyui-datebox" id="createTimeEnd" />
				</label-value>
				<label-title>配置库名称:</label-title>
				<label-value>
					<input class="easyui-textbox" id="respNameLike" />
				</label-value>
			</form>
			<label onclick="seachData_tbSvnResp_list();" class="easyui-linkbutton custom-search" data-options="iconCls:'icon-search'" style="width:80px">搜索</label>
		</div>
		<table id="dataGrid"></table>
	</div>
</body>
</html>