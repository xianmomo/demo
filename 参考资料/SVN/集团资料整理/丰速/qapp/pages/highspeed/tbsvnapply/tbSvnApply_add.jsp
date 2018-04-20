<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<style>
table .headTd {
	padding-left: 2px;
	font-size: 16px;
	font-weight: bold;
	text-align: left;
	line-height: 24px;
}

table .labelTd {
	width: 160px;
	text-align: right;
	font-size: 16px;
	line-height: 24px;
}

table .inputTd {
	padding-left: 2px;
	width: 160px;
	text-align: left;
	font-size: 14px;
	line-height: 24px;
}

table .inputTd select {
	width: 140px;
}

table .inputTd .repositoryDept {
	width: 360px;
}

table .inputTd .repositoryUser {
	width: 135px;
}

.custom-button {
	text-align: left;
	padding: 5px 0px 10px 0px;
}

.custom-button .l-btn-text {
	font-size: 16px;
	font-weight: bold;
}

h3, h4, h5 {
	margin: 0px;
	padding: 0px;
	font-weight: 100;
}
</style>
<body style="text-align: center; margin: 10px;">
<c:if test="${empty errorMsg}">
	<div class="custom-button">
		<a href='javascript:void("#")' onclick="saveApply()"
			title="对未填写完的数据进行保存草稿" class="easyui-linkbutton"
			data-options="iconCls:'icon-save'">保存草稿</a>
		<a href='javascript:void("#")' onclick="submitApply()"
			title="对填写完的数据进行提交申请" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok'">提交申请</a>
		<a href='javascript:void("#")' onclick="toForwardOther()"
			title="强制提交需要QA进行审核" class="easyui-linkbutton"
			data-options="iconCls:'icon-redo'">转向QA</a>
		<a href='javascript:void("#")' onclick="toWorkflowShow()"
			title="查看申请流转图" class="easyui-linkbutton"
			data-options="iconCls:'icon-search'">流程示意图</a>
	</div>
	<form id="tbSvnApplyAdd_form">
		<table>
			<thead>
				<tr>
					<th colspan="8" class="panel-header">（SVN/GIT）配置库新建及权限申请</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="panel-body headTd" colspan="8">基本信息</td>
				</tr>
				<tr>
					<td class="panel-body labelTd">申请人姓名:</td>
					<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
						${sysUser.userAlias }</td>
					<td class="panel-body labelTd">申请人工号:</td>
					<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
						<input type="hidden" name="applyUserName"
							value="${sysUser.userCode }" />
						${sysUser.userCode }
					</td>
					<td class="panel-body labelTd">申请部门:</td>
					<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
						${sysUser.orgName }</td>
					<td class="panel-body labelTd">申请日期:</td>
					<td class="panel-body panel-body-noleft inputTd">
						<fmt:formatDate value="${tbSvnApply.applyTime }"
							pattern="YYYY-MM-dd" />
					</td>
				</tr>

				<tr>
					<td class="panel-body headTd" colspan="8">业务信息</td>
				</tr>
				<tr>
					<td class="panel-body labelTd">申请类型:</td>
					<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
						<select name="applyTypeName" class="easyui-combobox"
							data-options="required:true">
							<option
								<c:if test="${empty tbSvnApply.applyTypeName}">selected</c:if>
								value="">请选择</option>
							<option
								<c:if test="${!empty tbSvnApply.applyTypeName && tbSvnApply.applyTypeName eq '配置库新建'}">selected</c:if>
								value="配置库新建">配置库新建</option>
							<option
								<c:if test="${!empty tbSvnApply.applyTypeName && tbSvnApply.applyTypeName eq '配置库权限申请'}">selected</c:if>
								value="配置库权限申请">配置库权限申请</option>
							<option
								<c:if test="${!empty tbSvnApply.applyTypeName && tbSvnApply.applyTypeName eq '配置库编码变更'}">selected</c:if>
								value="配置库编码变更">配置库编码变更</option>
						</select>
					</td>
					<td class="panel-body labelTd">配置库类型:</td>
					<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
						<select name="repositoryTypeName" class="easyui-combobox"
							data-options="required:true">
							<option
								<c:if test="${empty tbSvnApply.repositoryTypeName}">selected</c:if>
								value="">请选择</option>
							<option
								<c:if test="${!empty tbSvnApply.repositoryTypeName && tbSvnApply.repositoryTypeName eq 'SVN系统库'}">selected</c:if>
								value="SVN系统库">SVN系统库</option>
							<option
								<c:if test="${!empty tbSvnApply.repositoryTypeName && tbSvnApply.repositoryTypeName eq 'SVN管理库'}">selected</c:if>
								value="SVN管理库">SVN管理库</option>
							<option
								<c:if test="${!empty tbSvnApply.repositoryTypeName && tbSvnApply.repositoryTypeName eq 'GIT系统库'}">selected</c:if>
								value="GIT系统库">GIT系统库</option>
						</select>
					</td>
					<td class="panel-body labelTd">是否顺丰科技人员:</td>
					<td class="panel-body panel-body-noleft inputTd" colspan="3">
						<select name="applyUserType" class="easyui-combobox">
							<option
								<c:if test="${empty tbSvnApply.applyUserType}">selected</c:if>
								value="">请选择</option>
							<option
								<c:if test="${!empty tbSvnApply.applyUserType && tbSvnApply.applyUserType eq '0'}">selected</c:if>
								value="0">是</option>
							<option
								<c:if test="${!empty tbSvnApply.applyUserType && tbSvnApply.applyUserType eq '1'}">selected</c:if>
								value="1">否</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="panel-body labelTd">配置库所属部门:</td>
					<td class="panel-body panel-body-noleft panel-body-norigth inputTd"
						colspan="3">
						<input class="easyui-combotree repositoryDept"
							value="${tbSvnApply.repositoryDept }" name="repositoryDept"
							data-options="url:'${pageContext.request.contextPath }/main/bus/queryTreeData?id=0&currentOrgId=${tbSvnApply.repositoryDept }',
							loadFilter:top.convertTree,
							editable:true,
							onSelect: initUserComboBySelected" />
					</td>
					<td class="panel-body labelTd">配置库部门负责人:</td>
					<td class="panel-body panel-body-noleft inputTd" colspan="3">
						<input type="hidden" class="repositoryUser" name="repositoryUser">
						<input class="easyui-combobox repositoryUserShow"
							value="${tbSvnApply.repositoryUser }" name="repositoryUserShow"
							data-options="url:'${pageContext.request.contextPath }/main/bus/queryUserDataByOrg?orgCode=${tbSvnApply.repositoryDept }',valueField: 'id',textField: 'text',onSelect: initRepositoryUserSelected" />
					</td>
				</tr>

				<tr>
					<td class="panel-body headTd" colspan="8">模板下载/附件上传</td>
				</tr>
				<tr>
					<td class="panel-body labelTd">流程附件模板下载:</td>
					<td class="panel-body panel-body-noleft inputTd" colspan="7">
						<c:if test="${!empty tbModulFileList}">
							<c:forEach items="${tbModulFileList }" var="tbModulFile">
								<a style="text-decoration: none;" target="_blank"
									title="${tbModulFile.modul_upload_name }"
									href="${pageContext.request.contextPath }/main/bus/modulFile/download?fileId=${tbModulFile.modul_id }">${tbModulFile.modul_upload_name }</a>
								&nbsp;
							</c:forEach>
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="panel-body labelTd">流程附件:</td>
					<td class="panel-body panel-body-noleft inputTd" colspan="7">
						<label id="tbSvnApply_fileList">
							<c:if test="${!empty sysFileList}">
								<c:forEach items="${sysFileList }" var="sysFile">
									<span>
										<input type="hidden" name="tbSvnApply_fileList_fileMsg"
											value="${sysFile.fileId }" />
										<a style="text-decoration: none;" target="_blank"
											title="${sysFile.fileUploadName }"
											href="${pageContext.request.contextPath }/main/bus/file/download?fileId=${sysFile.fileId }">${sysFile.fileUploadName }</a>
										<a style="text-decoration: none;" href='javascript:void("#")'
											onclick='top.deleteFile(this,"${sysFile.fileId}","file")'>&nbsp删除&nbsp</a>
									</span>
								</c:forEach>
							</c:if>
						</label>
						<a href='javascript:void("#")' onclick="tbSvnApply_uploadFile();"
							class="easyui-linkbutton">上传</a>
					</td>
				</tr>
				<tr>
					<td class="panel-body headTd" colspan="8">流程相关说明</td>
				</tr>
				<tr>
					<td class="panel-body labelTd">其他说明:</td>
					<td class="panel-body panel-body-noleft inputTd" colspan="7">
						<div class="demo-info">
							1、SVN管理员：
							<c:forEach items="${svnUser}" var="tempUser" varStatus="status">
								<c:if test="${status.index !=0 }">,</c:if>
								${tempUser.userAlias }(${tempUser.userCode })
							</c:forEach>
							<c:if test="${fn:length(svnUser) == 0 }">
								没有配置负责人或者没有找到配置的负责人
							</c:if>
							<br />
							2、GIT管理员：
							<c:forEach items="${gitUser}" var="tempUser" varStatus="status">
								<c:if test="${status.index !=0 }">,</c:if>
								${tempUser.userAlias }(${tempUser.userCode })
							</c:forEach>
							<c:if test="${fn:length(gitUser) == 0 }">
								没有配置负责人或者没有找到配置的负责人
							</c:if>
							<br />
							3、本流程适用于顺丰科技人员申请新建配置库、配置库编码变更以及配置库权限，非顺丰科技人员只能申请配置库权限；
							<br />
							4、申请新建配置库（含系统类配置库、管理类配置库）时填写业务信息中第1部分；系统配置库权限会根据配置管理制度为不同系统角色分配对应的权限；管理库权限按目录授权，并只授权管控到一级目录；
							<br />
							5、申请配置库权限时填写业务信息中第2部分；
							<br />
							6、配置库编码变更时则填写业务信息中第3部分；
							<br />
							7、配置库编码规则：如果是系统配置库，配置库编码为dev-系统编码（如：dev-elog-tms），如果是管理库，配置库编码直接为英文简称，所有配置库编码均为小写字母（如：hr）；
							<br />
							8、融合项目和同城配项目新建库请与刘小青（01106063）沟通同意后，提交沟通附件到本流程中申请
							<br />
							<label style="color: red;">
								9、附件说明：如果配置库类型为SVN系统库或管理库时，上传的附件必须使用《SVN-申请模版》填写；如果配置库类型为GIT系统库时，上传的附件必须使用《GIT-申请模版》填写。
							</label>
						</div>
					</td>
				</tr>
				<tr>
					<td class="panel-body labelTd">备注:</td>
					<td class="panel-body panel-body-noleft inputTd" colspan="7">
						<div class="errorMsg"
							style="margin-bottom: 10px; margin-left: 10px;">
							${tbSvnApply.remark }</div>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<script type="text/javascript">
		function saveApply() {
			top.ajaxSubmitForm({
				formId : "tbSvnApplyAdd_form",
				url : "${pageContext.request.contextPath }/main/bus/tbSvnApplySave",
				params : {
					applyStatu : 0
				},
				success : function(data) {
					if (data.success) {
						top.messageAlert(true, "保存成功");
					} else {
						top.messageAlert(false, "保存失败", data.msg);
					}
				}
			});
		}

		function submitApply() {
			top.ajaxSubmitForm({
				formId : "tbSvnApplyAdd_form",
				url : "${pageContext.request.contextPath }/main/bus/tbSvnApplySave",
				params : {
					applyStatu : 1
				},
				success : function(data) {
					if (data.success) {
						top.messageAlert(false, "提交成功","",function(){
							location.replace(location.href.substr(0,location.href.indexOf("?"))); 
						});
					} else {
						$(".errorMsg").html(data.msg);
						top.messageAlert(false, "提交失败", data.msg);
					}
				}
			});
		}

		function toForwardOther() {
			$.messager.confirm("系统提示", "转向QA前，需要先与QA确认。是否继续",
					function(result) {
						if (result) {
							top.ajaxSubmitForm({
								formId : "tbSvnApplyAdd_form",
								url : "${pageContext.request.contextPath }/main/bus/tbSvnApplySave",
								params : {
									applyStatu : 6
								},
								success : function(data) {
									if (data.success) {
										top.messageAlert(false, "转向QA成功","",function(){
											location.replace(location.href.substr(0,location.href.indexOf("?"))); 
										});
									} else {
										top.messageAlert(false, "转向QA失败", data.msg);
									}
								}
							});
						}
					});
		}

		function tbSvnApply_uploadFile() {
			$(this).customUpload({
				id : 'tbSvnApplyUploadFile',
				title : '选择文件',
				width : 500,
				height : 600,
				uploadParams : {
					auto : false,
					multi : true,
					requestParams : "foreignKey=${tbSvnApply.applyId }",
					fileTypeExts : '*.*',
					buttonText : '附件上传',
					callBack : function(file, data) {
						var dataObj = eval("(" + data + ")");
						if (dataObj.success) {
							top.showUploadHtml(
									"tbSvnApply_fileList",
									dataObj);
						} else {
							top.messageAlert(true, "上传成功",
									file.name + dataObj.msg);
						}
					}
				}
			});
		}

		function toWorkflowShow() {
			if ("${workflowShowUrl}" == "") {
				top.messageAlert(false, "流程示意图查看失败", "没有配置流程示意图地址");
				return;
			}
			window.open("${workflowShowUrl}", "_blank");
		}

		function initUserComboBySelected(rec) {
			$(".repositoryUser").val("");
			$(".repositoryUserShow").combobox("clear");
			$(".repositoryUserShow").combobox(
					"reload",
					"${pageContext.request.contextPath }/main/bus/queryUserDataByOrg?orgCode="
							+ rec.id);
		}
		
		function initRepositoryUserSelected(rec){
			$(".repositoryUser").val(rec.id);
		}
	</script>
</c:if>
<c:if test="${!empty errorMsg}">
	<div style="font-size: 24px;">${errorMsg }</div>
</c:if>
</body>
</html>