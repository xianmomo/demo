<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/layout.jsp"%>
<body>
	<div style="margin: 10px 5px 0px 5px">
		<div class="easyui-accordion" data-options="multiple:true">
			<div title="组及组用户展示" style="padding-bottom:5px;overflow: hidden;">
				<table class="custom-table-show">
					<thead>
						<tr>
							<td>组名</td>
							<td>子组名</td>
							<td>组用户及权限有效期</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${groupData }" var="group">
						<tr>
							<td class="easyui-tooltip" title="${group.group_name }">${group.group_name }</td>
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
			<div title="目录及权限展示" style="padding-bottom:5px;">
				<table class="custom-table-show">
					<thead>
						<tr>
							<td>目录</td>
							<td>目录组权限</td>
							<td>目录用户权限及权限有效期</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${dirData }" var="dir">
						<tr>
							<td class="easyui-tooltip" title="${dir.dir_path }">${dir.dir_path }</td>
							<c:set value="${fn:split(dir.group_permission,',') }" var="groupPermissionList" />
							<c:set value="" var="groupPermissionShow"/>
							<c:forEach items="${groupPermissionList }" var="groupPermission" varStatus="groupPermissionIndex">
								<c:if test="${groupPermissionIndex.index != 0 }">
									<c:set value="${groupPermissionShow }<br/>" var="groupPermissionShow"/>
								</c:if>
								<c:set value="${groupPermissionShow }${groupPermission }" var="groupPermissionShow"/>
							</c:forEach>
							<c:if test="${empty groupPermissionShow }">
								<td></td>
							</c:if>
							<c:if test="${!empty groupPermissionShow }">
								<td class="easyui-tooltip" title="${groupPermissionShow }">${groupPermissionShow }</td>
							</c:if>
							<c:set value="${fn:split(dir.user_permission,',') }" var="dirUserList" />
							<c:set value="" var="dirUserPermissionShow"/>
							<c:forEach items="${dirUserList }" var="dirUser" varStatus="dirUserIndex">
								<c:set value="${fn:split(dirUser,'###') }" var="dirUserPermission" />
								<c:forEach items="${dirUserPermission }" var="dirPermission" varStatus="dirPermissionIndex">
									<c:if test="${dirPermissionIndex.index eq 0 }">
										<c:set value="${dirPermission }" var="dirUserPermissions"/>
									</c:if>
									<c:if test="${dirPermissionIndex.index eq 1 }">
										<c:set value="${dirUserPermissions } = ${dirPermission }" var="dirUserPermissions"/>
									</c:if>
									<c:if test="${dirPermissionIndex.index eq 2 }">
										<c:set value="${dirUserPermissions }(${dirPermission }" var="dirUserPermissions"/>
									</c:if>
									<c:if test="${dirPermissionIndex.index eq 3 }">
										<c:set value="${dirUserPermissions }至${dirPermission })" var="dirUserPermissions"/>
									</c:if>
								</c:forEach>
								<c:if test="${dirUserIndex.index !=0 }">
									<c:set value="${dirUserPermissionShow }<br/>" var="dirUserPermissionShow"/>
								</c:if>
								<c:if test="${!empty dirUserPermissions }">
									<c:set value="${dirUserPermissionShow }${dirUserPermissions }" var="dirUserPermissionShow"/>
								</c:if>
							</c:forEach>
							<c:if test="${empty dirUserPermissionShow }">
								<td></td>
							</c:if>
							<c:if test="${!empty dirUserPermissionShow }">
								<td class="easyui-tooltip" title="${dirUserPermissionShow }">${dirUserPermissionShow }</td>
							</c:if>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>