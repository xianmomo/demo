<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/layout.jsp"%>
<script type="text/javascript">
	$(function() {
		//加载easy面板
		var indexLayout = $("#easyLayout").height($(window).height());
		indexLayout.width($(window).width()).layout();
		//加载easy选项框
		var indexTab = $("#easyuiTabs");
		indexTab
				.height(document.body.offsetHeight - indexTab.offset().top - 20);
		indexTab.tabs();
		//调整页面模块的高度
		initHeight(0);
	})

	$(window).resize(function() {
		//调整页面模块的高度
		initHeight(10);
	});
</script>
<body>
	<div id="easyLayout">
		<div data-options="region:'north',split:true" class="indexTop">
			<div style="float: left; padding-left: 10px;">
				<h2>
					丰速-权限控制系统
					<c:if test="${showEnvironment eq '0'}">
						<span style="color: red;">(测试环境)</span>
					</c:if>
					<c:if test="${showEnvironment eq '1'}">
						<span style="color: blue;">(准生产环境)</span>
					</c:if>
					<c:if test="${showEnvironment eq '2'}">
						<span style="color: green;">(生产环境)</span>
					</c:if>
				</h2>
			</div>
			<div style="float: right; text-align: right; padding-right: 10px;">
				<h2>当前登录用户：${loginUser.userAlias }(${loginUser.userCode })</h2>
				<div>
					<a
						style="font-size: 16px; font-weight: bold; color: blue; text-decoration: none;"
						href="${pageContext.request.contextPath}/index/logout">退出</a>
				</div>
			</div>
		</div>
		<div data-options="region:'west',title:'功能区',split:true"
			style="width: 180px;">
			<div class="easyui-accordion custom-menu" style="width: 100%;">
				<!-- 加载系统菜单 -->
				<c:if test="${empty resourceList}">
					没有权限
				</c:if>
				<c:forEach var="res" items="${resourceList }" varStatus="status">
					<c:if test="${status.index == '0' && res.parentId == '999999'}">
						<div title="${res.resName }" style="padding: 2px;overflow: auto;">
							<ul>
								<c:forEach var="menu" items="${resourceList }">
									<c:if test="${res.resId == menu.parentId }">
										<li onclick="addNewTab('${menu.resName}','${pageContext.request.contextPath}/${menu.resPath}');">
											${menu.resName }
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</c:if>
					<c:if test="${status.index != '0' && res.parentId == '999999'}">
						<div title="${res.resName }" style="padding: 2px;overflow: auto;">
							<ul>
								<c:forEach var="menu" items="${resourceList }">
									<c:if test="${res.resId == menu.parentId }">
										<li onclick="addNewTab('${menu.resName}','${pageContext.request.contextPath}/${menu.resPath}');">
											${menu.resName }
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div data-options="region:'center'">
			<div id="easyuiTabs" style="width: 100%;">
				<div title="首页" style="padding: 10px;">大家好，欢迎进入丰速系统！！！</div>
			</div>
		</div>
	</div>
	<div id="tabMenuTemp" style="display: none;">
		<div onclick="menuButtonEvent(this);"
			data-options="iconCls:'icon-reload'">刷新</div>
		<div onclick="menuButtonEvent(this);"
			data-options="iconCls:'icon-cancel'">关闭当前</div>
		<div onclick="menuButtonEvent(this);"
			data-options="iconCls:'icon-cancel'">关闭其他</div>
		<div onclick="menuButtonEvent(this);"
			data-options="iconCls:'icon-cancel'">关闭所有</div>
	</div>
</body>
</html>
