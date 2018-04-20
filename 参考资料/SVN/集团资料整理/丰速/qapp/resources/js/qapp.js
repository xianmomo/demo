var pathName = window.document.location.pathname;
var _ctx = pathName.substring(0, pathName.substr(1).indexOf("/") + 1);

// 自适应窗口
function initHeight(px) {
	var easyLayout = $('#easyLayout');
	easyLayout.layout('resize', {
		height : $(window).height(),
		width : $(window).width()
	});
	var easyAccordion = $(".easyui-accordion");
	easyAccordion.accordion('resize', {
		height : document.body.offsetHeight - easyAccordion.offset().top - px
	});
	var indexTab = $("#easyuiTabs");
	indexTab.tabs('resize', {
		height : document.body.offsetHeight - indexTab.offset().top - px
	});
}

// ---------------tab start
// 添加一个新的标签页面板（tab panel）
function addNewTab(title, url, parentTitle) {
	// 判断tab页是否存在
	if (!$('#easyuiTabs').tabs('exists', title)) {
		var tabHeight = document.body.offsetHeight
				- $('#easyuiTabs').offset().top - 2;
		// 不存在，则新增
		$('#easyuiTabs').tabs('add', {
			title : title,
			style : {
				height : tabHeight
			},
			href : url,
			closable : false

		});
		if (parentTitle) {
			getCurrentTab().attr("data-parentTitle", parentTitle);
		}
		// 添加下拉工具栏
		var mb = getCurrentTab().find('a.tabs-inner');
		// 判断下拉菜单是否被销毁，如果销毁，则根据模板重新生成
		if ($("#tabMenu").length == 0) {
			$("body").append(
					'<div id="tabMenu" style="display: none;">'
							+ $("#tabMenuTemp").html() + '</div>');
		}
		mb.menubutton({
			menu : '#tabMenu'
		}).click(function() {
			selectTab(title);
		});
	} else {
		// 存在则跳转该tab页
		selectTab(title);
	}
}

// 下拉菜单点击事件
function menuButtonEvent(obj) {
	// 获取当前活动的tabs的title
	var tabTitle = $(".tabs .m-btn-plain-active .tabs-title").text();
	selectTab(tabTitle);
	var eventType = $(obj).text();
	if (eventType == "刷新") {
		refreshTab(tabTitle);
	} else if (eventType == "关闭当前") {
		removeTab(tabTitle);
	} else if (eventType == "关闭其他") {
		// 点击关闭其他
		var allTabs = $('#easyuiTabs').tabs('tabs');
		// 关闭除了首页的其他tabs
		for (var i = 0; i < allTabs.length; i++) {
			if (allTabs[i].panel('options').title != "首页"
					&& allTabs[i].panel('options').title != tabTitle) {
				removeTab(allTabs[i].panel('options').title);
				allTabs = $('#easyuiTabs').tabs('tabs');
				i = 0;
			}
		}
	} else if (eventType == "关闭所有") {
		// 点击关闭所有
		var allTabs = $('#easyuiTabs').tabs('tabs');
		// 关闭除了首页的其他tabs
		for (var i = 0; i < allTabs.length; i++) {
			if (allTabs[i].panel('options').title != "首页") {
				// 销毁下拉菜单
				allTabs[i].panel('options').tab.find('a.tabs-inner')
						.menubutton('destroy');
				removeTab(allTabs[i].panel('options').title);
				allTabs = $('#easyuiTabs').tabs('tabs');
				i = 0;
			}
		}
	}
}
function removeTab(title) {
	if (!title) {
		title = getCurrentTabTitle();
	}
	$('#easyuiTabs').tabs("close", title);
}
function refreshTab(title) {
	if (title) {
		$('#easyuiTabs').tabs('select', title);
	}
	var currentTab = getCurrentTabBody();
	if (currentTab) {
		currentTab.panel('refresh', currentTab.panel('options').href);
	}
}
function getCurrentTab() {
	return $('#easyuiTabs').tabs('getSelected').panel('options').tab;
}
function getCurrentTabTitle() {
	return $('#easyuiTabs').tabs('getSelected').panel('options').title;
}
function getCurrentTabBody() {
	return $('#easyuiTabs').tabs('getSelected');
}
function selectTab(title) {
	$('#easyuiTabs').tabs('select', title);
}
// ---------------tab end

// -------------- dialog start
// 打开弹窗
function openDialog(options) {
	// 判断是否有弹窗id,如果没有则不能创建
	if (typeof options.id == "undefined" || typeof options.id == "") {
		$.messager.alert('温馨提示', '传入对象没有id属性', 'info');
	}
	if (typeof options.onLoad == "undefined" || typeof options.onLoad == "") {
		options.onLoad = function() {
			// 把dialog的id传递到页面，充当body的dialog-id值
			$(this).append(
					'<input type="hidden" id="dialogId" value="' + options.id
							+ '" />');
		};
	}
	// 则根据模板重新生成弹窗元素
	if ($("#" + options.id).length == 0) {
		$("body").append('<div id="' + options.id + '"></div>');
		$("#" + options.id).dialog({
			id : options.id,
			title : options.title,
			width : options.width,
			height : options.height,
			closed : false,
			onClose : function() {
				// 销毁弹窗
				$("#" + options.id).dialog("destroy");
			},
			href : options.href,
			modal : true,
			onLoad : options.onLoad,
			buttons : initButton(options)
		});
	} else {
		$("#" + options.id).dialog('open');
	}
}
// 初始化按钮
function initButton(options) {
	var createButton = [];
	var defaultTools = {
		text : '确定',
		iconCls : 'icon-ok',
		handler : function() {
			$("#" + options.id).dialog("destroy");
		}
	}
	// 创建OK按钮
	if (typeof options.isOk == "object") {
		options.isOk = $.extend(defaultTools, options.isOk);
		createButton.push({
			text : options.isOk.text,
			iconCls : options.isOk.iconCls,
			handler : function() {
				options.isOk.handler.call();
			}
		});
		// 创建取消按钮
		createButton.push({
			text : '取消',
			handler : function() {
				// 销毁弹窗
				$("#" + options.id).dialog("destroy");
			}
		});
	}
	return createButton;
}
// -------------- dialog end

// ------------id,pid的treeData转children start
// 根据id,pid的treeDate转children的treeDate
function convertTree(rows) {
	var nodes = [];
	// 得到顶层节点
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		if (!exists(rows, row.parentId)) {
			nodes.push(row);
		}
	}
	var toDo = [];
	for (var i = 0; i < nodes.length; i++) {
		toDo.push(nodes[i]);
	}
	while (toDo.length) {
		var node = toDo.shift(); // 父节点
		// 得到子节点
		for (var i = 0; i < rows.length; i++) {
			var row = rows[i];
			if (row.parentId == node.currentId) {
				if (node.children) {
					node.children.push(row);
				} else {
					node.children = [ row ];
				}
				toDo.push(row);
			}
		}
	}
	return nodes;
}
function exists(rows, parentId) {
	for (var i = 0; i < rows.length; i++) {
		if (rows[i].currentId == parentId)
			return true;
	}
	return false;
}
// ------------id,pid的treeData转children end

// ----------------uploadFile start
// 上传文件回显UI
function showUploadHtml(id, data, isNewRow) {
	html = [];
	if (typeof isNewRow != "undefined" && isNewRow) {
		html.push("<span style='display:block;'>");
	} else {
		html.push("<span>");
	}
	html.push('<input type="hidden" name="' + id + '_fileMsg" value="'
			+ data.fileId + '" />');
	html.push('<a style="text-decoration:none;" href="' + _ctx + '/main/bus/'
			+ data.uploadType + '/download?fileId=' + data.fileId
			+ '" target="_blank" title="' + data.fileUploadName + '">'
			+ data.fileUploadName + '</a>');
	html
			.push("<a style='text-decoration:none;' href='javascript:void(\"#\")' onclick='top.deleteFile(this,\""
					+ data.fileId
					+ "\",\""
					+ data.uploadType
					+ "\")'>&nbsp删除&nbsp</a>");
	html.push("</span>");
	$("#" + id).append(html.join(""));
}
// 删除文件
function deleteFile(ele, fileId, uploadType) {
	ajaxData({
		url : _ctx + "/main/bus/" + uploadType + "/delete",
		data : {
			fileId : fileId
		},
		success : function(obj) {
			var obj = eval('(' + obj + ')');
			if (!obj.success) {
				$.messager.alert('系统提示', obj.msg);
			} else {
				$(ele).parent().detach();
			}
		}
	});
}
// ----------------uploadFile end

// 异步提交数据
function ajaxData(dataMap) {
	$.messager.progress({
		msg : '正在处理中，请耐心等候...'
	});
	var defaultMap = {
		url : null,
		errorUrl : window.location.href,
		data : {},
		type : "GET",
		success : function(obj) {
			$.messager.alert('系统提示', " 操作成功");
		}
	};
	dataMap = $.extend(defaultMap, dataMap);
	$.ajax({
		url : dataMap.url,
		type : dataMap.type,
		data : dataMap.data,
		success : function(obj) {
			$.messager.progress('close');
			if (obj == "" || obj.substr(0, 1) != "{") {
				// 表单请求，session过期跳转
				messageAlert(false, '请求失败', '由于时间过长或系统升级，会话已过期', function() {
					window.location.href = dataMap.errorUrl;
				});
				return;
			}
			dataMap.success(obj);
		}
	});
}

// 异步提交表单
function ajaxSubmitForm(dataMap) {
	var jsonObj = conveterSerializeToJson(decodeURIComponent($('#' + dataMap.formId).serialize(),true));
	dataMap.params = $.extend(jsonObj,dataMap.params);
	ajaxData({
		url : dataMap.url,
		data : dataMap.params,
		type : "POST",
		success : function(obj) {
			var data = eval('(' + obj + ')');
			dataMap.success(data);
		}
	});
}

// 消息弹窗样式调整
function messageAlert(isSuccess, msgTitle, msgContent, callback) {
	var AlertMsg = "";
	if (isSuccess) {
		AlertMsg = AlertMsg + "<div class='AlertTheme AlertSuccess'>";
		AlertMsg = AlertMsg + msgTitle;
		AlertMsg = AlertMsg + "</div>";
	} else {
		AlertMsg = AlertMsg + "<div class='AlertTheme AlertError'>";
		AlertMsg = AlertMsg + msgTitle;
		AlertMsg = AlertMsg + "</div>";
	}

	if (typeof msgContent != "undefined") {
		AlertMsg = AlertMsg + msgContent;
	}

	if (typeof callback == "function") {
		$.messager.alert({
			title : '系统提示',
			msg : AlertMsg,
			fn : callback
		});
	} else {
		$.messager.alert('系统提示', AlertMsg);
	}
}

// ------------date formatter start
// 搜索页面日期格式
function initQueryDate(date) {
	var y = date.getFullYear();
	var m = date.getMonth() + 1;
	var d = date.getDate();
	return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
}
function initQueryDateParser(date) {
	if (!date)
		return new Date();
	var dateArray = (date.split('-'));
	var y = parseInt(dateArray[0], 10);
	var m = parseInt(dateArray[1], 10);
	var d = parseInt(dateArray[2], 10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
		return new Date(y, m - 1, d);
	} else {
		return new Date();
	}
}
// ------------date formatter end

// --------------------form data serialize 转 json
function conveterSerializeToJson(formSerialize) {
	var jsonObj = {};
	var formData = formSerialize.split("&");
	for (var i = 0; i < formData.length; i++) {
		var params = formData[i].split("=");
		jsonObj[params[0]] = params[1];
	}
	return jsonObj;
}
