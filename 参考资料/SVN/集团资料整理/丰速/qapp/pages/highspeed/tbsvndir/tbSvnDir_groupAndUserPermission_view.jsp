<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div style="margin: 10px 5px 0px 5px">
		<div class="easyui-accordion" data-options="multiple:true">
			<div title="组及权限展示" style="padding-bottom:5px;overflow: hidden;">
				<table class="custom-table-show">
					<thead>
						<tr>
							<td>组及组权限类型</td>
							<td>子组名</td>
							<td>组用户及权限有效期</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${groupData }" var="group">
						<tr>
							<c:if test="${empty group.permission }">
								<td class="easyui-tooltip" title="${group.group_name }">${group.group_name }</td>
							</c:if>
							<c:if test="${!empty group.permission }">
								<td class="easyui-tooltip" title="${group.group_name } = ${group.permission}">${group.group_name } = ${group.permission}</td>
							</c:if>
							<c:set value="${fn:split(group.groups,',') }" var="groupList" />
							<c:set value="" var="childGroupShow"/>
							<c:forEach items="${groupList }" var="childGroup" varStatus="childGroupIndex">
								<c:if test="${childGroupIndex.index != 0 }">
									<c:set value="${childGroupShow }<br/>" var="childGroupShow"/>
								</c:if>
								<c:set value="${childGroupShow }${childGroup }" var="childGroupShow"/>
							</c:forEach>
							<c:if test="${empty childGroupShow }">
								<td></td>
							</c:if>
							<c:if test="${!empty childGroupShow }">
								<td class="easyui-tooltip" title="${childGroupShow }">${childGroupShow }</td>
							</c:if>
							<c:set value="${fn:split(group.user_permission,',') }" var="userList" />
							<c:set value="" var="userPermissionShow"/>
							<c:forEach items="${userList }" var="user" varStatus="userIndex">
								<c:set value="${fn:split(user,'###') }" var="userPermission" />
								<c:forEach items="${userPermission }" var="permission" varStatus="permissionIndex">
									<c:if test="${permissionIndex.index eq 0 }">
										<c:set value="${permission }" var="userPermissions"/>
									</c:if>
									<c:if test="${permissionIndex.index eq 1 }">
										<c:set value="${userPermissions }(${permission }" var="userPermissions"/>
									</c:if>
									<c:if test="${permissionIndex.index eq 2 }">
										<c:set value="${userPermissions }至${permission })" var="userPermissions"/>
									</c:if>
								</c:forEach>
								<c:if test="${userIndex.index !=0 }">
									<c:set value="${userPermissionShow }<br/>" var="userPermissionShow"/>
								</c:if>
								<c:if test="${!empty userPermissions }">
									<c:set value="${userPermissionShow }${userPermissions }" var="userPermissionShow"/>
								</c:if>
							</c:forEach>
							<c:if test="${empty userPermissionShow }">
								<td></td>
							</c:if>
							<c:if test="${!empty userPermissionShow }">
								<td class="easyui-tooltip" title="${userPermissionShow }">${userPermissionShow }</td>
							</c:if>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div title="用户及权限展示" style="padding-bottom:5px;">
				<table class="custom-table-show">
					<thead>
						<tr>
							<td>用户</td>
							<td>权限类型</td>
							<td>权限有效期</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userData }" var="user">
						<tr>
							<td class="easyui-tooltip" title="${user.user_name }">${user.user_name }</td>
							<td class="easyui-tooltip" title="${user.permission }">${user.permission }</td>
							<td class="easyui-tooltip" title="${user.permission_time }">${user.permission_time }</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>