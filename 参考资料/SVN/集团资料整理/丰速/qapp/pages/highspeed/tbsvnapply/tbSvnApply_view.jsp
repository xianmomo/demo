<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body style="text-align: center;">
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

h3, h4, h5 {
	margin: 0px;
	padding: 0px;
	font-weight: 100;
}
</style>
<table>
	<thead>
		<tr>
			<th colspan="6" class="panel-header">（SVN/GIT）配置库新建及权限申请</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td class="panel-body headTd" colspan="6">基本信息</td>
		</tr>
		<tr>
			<td class="panel-body labelTd">申请人工号:</td>
			<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
				${tbSvnApply.applyUserName }</td>
			<td class="panel-body labelTd">申请部门:</td>
			<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
				${applyUser.orgName }</td>
			<td class="panel-body labelTd">申请日期:</td>
			<td class="panel-body panel-body-noleft inputTd">
				<fmt:formatDate value="${tbSvnApply.applyTime }"
					pattern="YYYY-MM-dd" />
			</td>
		</tr>
		<tr>
			<td class="panel-body headTd" colspan="6">业务信息</td>
		</tr>
		<tr>
			<td class="panel-body labelTd">申请类型:</td>
			<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
				${tbSvnApply.applyTypeName }</td>
			<td class="panel-body labelTd">配置库类型:</td>
			<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
				${tbSvnApply.repositoryTypeName }</td>
			<td class="panel-body labelTd">是否顺丰科技人员:</td>
			<td class="panel-body panel-body-noleft inputTd">
				<c:if test="${tbSvnApply.applyUserType == '0'}">是</c:if>
				<c:if test="${tbSvnApply.applyUserType != '0'}">否</c:if>
			</td>
		</tr>
		<tr>
			<td class="panel-body labelTd">配置库所属部门:</td>
			<td class="panel-body panel-body-noleft panel-body-norigth inputTd">
				${sysUserRepository.orgName }</td>
			<td class="panel-body labelTd">配置库部门负责人:</td>
			<td class="panel-body panel-body-noleft inputTd" colspan="3">
				<c:if test="${!empty sysUserRepository.userAlias}">${sysUserRepository.userAlias }(${sysUserRepository.userCode })</c:if>
			</td>
		</tr>
		<tr>
			<td class="panel-body headTd" colspan="6">模板下载/附件上传</td>
		</tr>
		<tr>
			<td class="panel-body labelTd">流程附件:</td>
			<td class="panel-body panel-body-noleft inputTd" colspan="5">
				<label id="tbSvnApplyView_fileList">
					<c:if test="${!empty sysFileList}">
						<c:forEach items="${sysFileList }" var="sysFile">
							<span>
								<a style="text-decoration: none;" target="_blank"
									title="${sysFile.fileUploadName }"
									href="${pageContext.request.contextPath }/main/bus/file/download?fileId=${sysFile.fileId }">${sysFile.fileUploadName }</a>
							</span>
						</c:forEach>
					</c:if>
				</label>
			</td>
		</tr>
		<tr>
			<td class="panel-body headTd" colspan="6">备注信息</td>
		</tr>
		<tr>
			<td class="panel-body labelTd">备注:</td>
			<td class="panel-body panel-body-noleft inputTd" colspan="5">
				${tbSvnApply.remark }</td>
		</tr>
	</tbody>
</table>
</body>
</html>