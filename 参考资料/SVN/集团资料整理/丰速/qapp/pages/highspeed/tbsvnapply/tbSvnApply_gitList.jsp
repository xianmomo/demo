<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
<style>
h3, h4, h5 {
	margin: 0px;
	padding: 0px;
	font-weight: 100;
}
</style>
	<script type="text/javascript">
		$("#tbSvnApply_gitList").find("#dataGrid").datagrid({
			url : '${pageContext.request.contextPath}/main/bus/tbSvnApplyListData',
			method : "POST",
			rownumbers : true,
			singleSelect : true,
			pagination : true,
			striped : true,
			autoRowHeight:false,
			queryParams:{
				applyStatu:"3",
				repositoryTypeName:"GIT系统库"
			},
			columns : [ [
					{
						title : '申请单Id',
						field : 'apply_id',
						hidden : true,
						halign : 'center',
						width : 10
					},
					{
						title : '申请模板',
						field : 'apply_model_type',
						halign : 'center',
						align : 'center',
						width : 80
					},
					{
						title : '申请人工号',
						field : 'apply_user_name',
						halign : 'center',
						align : 'center',
						width : 80,
					},
					{
						title : '申请人',
						field : 'apply_user_alias',
						halign : 'center',
						align : 'center',
						width : 60,
					},
					{
						title : '申请类型',
						field : 'apply_type_name',
						halign : 'center',
						align : 'center',
						width : 100
					},
					{
						title : '申请时间',
						field : 'apply_time_str',
						halign : 'center',
						align : 'center',
						width : 120
					},
					{
						title : '申请单状态',
						field : 'apply_statu_str',
						halign : 'center',
						align : 'center',
						width : 100,
						formatter : function(value) {
							if (value == "丰速处理完成") {
								return "<span style='color:green;'>丰速处理完成</span>";
							} else if (value == "丰速处理异常") {
								return "<span style='color:red;'>丰速处理异常</span>";
							} else if (value == "ECP审批中") {
								return "<span style='color:#FF7F00;'>ECP审批中</span>";
							} else {
								return value;
							}
						}
					},
					{
						title : 'ECP归档时间',
						field : 'receive_time',
						halign : 'center',
						align : 'center',
						width : 160
					},
					{
						title : '丰速完成时间',
						field : 'over_time',
						halign : 'center',
						align : 'center',
						width : 160
					},
					{
						title : '规则校验备注',
						field : 'rule_check_remark',
						halign : 'center',
						width : 200,
						formatter : function(value) {
							if (value != null && value != '') {
								return "<span title='"+value+"'>"+ value + "</span>";
							}
						}
					},{
						title : '备注',
						field : 'remark',
						halign : 'center',
						width : 200,
						formatter : function(value) {
							if (value != null && value != '') {
								return "<span title='"+value+"'>"
										+ value + "</span>";
							}
						}
					},{
						title : 'ECP流程编码',
						field : 'process_number',
						halign : 'center',
						width : 260
					} ] ]
			});

		//查询数据
		function seachData_tbSvnApply_gitList() {
			$("#tbSvnApply_gitList").find("#dataGrid").datagrid('load',{
				repositoryTypeName:$("#tbSvnApply_gitList").find("#repositoryTypeName").val(),
				applyStatu:$("#tbSvnApply_gitList").find("#applyStatu").val(),
				applyTimeBegin:$("#tbSvnApply_gitList").find("#applyTimeBegin").val(),
				applyTimeEnd:$("#tbSvnApply_gitList").find("#applyTimeEnd").val(),
				applyUserNameLike:$("#tbSvnApply_gitList").find("#applyUserNameLike").val(),
				processNumber: $("#tbSvnApply_gitList").find("#processNumber").val()
			});
		}

		//ECP审批
		function checkMenu_tbSvnApply_gitList() {
			//获取选中的行
			var selectRows = $("#tbSvnApply_gitList").find("#dataGrid").datagrid('getSelected');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作失败","请选择要审核的数据");
				return;
			}
			if (selectRows.apply_statu_str != "申请单已提交"
					&& selectRows.apply_statu_str != "申请单转向QA") {
				top.messageAlert(false,"业务操作失败","请选择申请单已提交或申请单转向QA的申请单进行审核");
				return;
			}
			top.ajaxData({
				url : '${pageContext.request.contextPath }/main/bus/checkSvnApply',
				data : {
					applyId:selectRows.apply_id
				},
				success : function(obj) {
					var data = eval("(" + obj + ")");
					if (data.success) {
						seachData();
					}else{
						top.messageAlert(false,"ECP审批失败",data.msg);
					}
				}
			});
		}

		//查看申请
		function showMenu_tbSvnApply_gitList() {
			//获取选中的行
			var selectRows = $("#tbSvnApply_gitList").find("#dataGrid").datagrid('getSelected');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作","请选择要查看的数据");
				return;
			}
			top.addNewTab(
							'SVN申请单查看',
							'${pageContext.request.contextPath}/main/bus/tbSvnApplyView?applyId='
									+ selectRows.apply_id);
		}
		
		function exceptionProcess_tbSvnApply_gitList(){
			//获取选中的行
			var selectRows = $("#tbSvnApply_gitList").find("#dataGrid").datagrid('getSelections');
			if (selectRows == null) {
				top.messageAlert(false,"业务操作失败","请选择要执行的数据");
				return;
			}
			var applyIdArray = [];
			for(i=0;i<selectRows.length;i++){
				if (selectRows[i].apply_statu_str != "丰速处理异常") {
					top.messageAlert(false,"业务操作失败","请选择丰速处理异常的申请单进行处理");
					return;
				}
				applyIdArray.push(selectRows[i].apply_id);
			}
			top.ajaxData({
				url : '${pageContext.request.contextPath}/main/bus/endWorkflow',
				data : {
					applyId:applyIdArray.join()
				},
				success : function(obj) {
					var data = eval("(" + obj + ")");
					if (data.success) {
						seachData();
					}else{
						top.messageAlert(false,"结束工作流失败",data.msg);
					}
				}
			});
		}
	</script>
	<div id="tbSvnApply_gitList">
		<div style="padding: 5px 0;">
			<a onclick="checkMenu_tbSvnApply_gitList()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="iconCls:'icon-lock'">ECP审批</a>
			<a onclick="showMenu_tbSvnApply_gitList()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="iconCls:'icon-view'">查看申请</a>
			<a onclick="exceptionProcess_tbSvnApply_gitList()" href='javascript:void("#")'
				class="easyui-linkbutton" data-options="">异常数据处理</a>
		</div>
		<div style="padding: 5px 0;">
			<form class="custom-query-form">
				<label-title>申请单状态:</label-title>
				<label-value>
					<select class="easyui-combobox" id="applyStatu">
						<option value="">无</option>
						<option value="0">申请单已保存</option>
						<option value="6">申请单转向QA</option>
						<option value="1">申请单已提交</option>
						<option value="2">ECP审批中</option>
						<option selected="selected" value="3">ECP审批归档</option>
						<option value="4">丰速处理完成</option>
						<option value="5">丰速处理异常</option>
					</select>
				</label-value>
				<label-title>申请开始时间:</label-title>
				<label-value>
					<input style="width:100px;" data-options="formatter:initQueryDate,parser:initQueryDateParser" class="easyui-datebox" id="applyTimeBegin" />
				</label-value>
				<label-title>申请结束时间:</label-title>
				<label-value>
					<input style="width:100px;" data-options="formatter:initQueryDate,parser:initQueryDateParser" class="easyui-datebox" id="applyTimeEnd" />
				</label-value>
				<label-title>申请人工号:</label-title>
				<label-value>
					<input class="easyui-textbox" id="applyUserNameLike" />
				</label-value>
				<label-title>ECP流程编码:</label-title>
				<label-value>
					<input class="easyui-textbox" id="processNumber" />
				</label-value>
			</form>
			<label onclick="seachData_tbSvnApply_gitList();" class="easyui-linkbutton custom-search" data-options="iconCls:'icon-search'" style="width:80px">搜索</label>
		</div>
		<table id="dataGrid"></table>
	</div>
</body>
</html>