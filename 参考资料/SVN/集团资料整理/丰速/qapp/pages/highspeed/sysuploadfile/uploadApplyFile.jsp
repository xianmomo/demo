<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>itdd-qapp</title>
</head>
<body>
<link rel="stylesheet" type="text/css"
		href="${pageContext.request.contextPath}/plugins/uploadify/uploadify.css">
<script type="text/javascript"
		src="${pageContext.request.contextPath}/plugins/uploadify/jquery.uploadify.js"></script>
<style type="text/css">
.custom-button {
	width: 102px;
	height: 38px;
}
</style>
	<form>
		<div id="uploadApplyFileQueue"></div>
		<input id="uploadApplyFile" name="uploadApplyFile" type="file"
			multiple=true "/>
		<input id="uploadApplyFileStart"
			class="uploadify uploadify-button custom-button"
			name="uploadApplyFileStart" type="button" value="开始上传"
			onclick='return $("#uploadApplyFile").uploadify("upload", "*");' />
	</form>
	<script type="text/javascript">
		$(function() {
			var uploadApplyFile_onSelectError = function(file, errorCode,
					errorMsg) {
				var msgText = "上传失败\n";
				switch (errorCode) {
				case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
					msgText += "上传的文件数量已经超出系统限制的"
							+ $('#file_upload').uploadify('settings',
									'queueSizeLimit') + "个文件！";
					break;
				case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
					msgText += "文件 ["
							+ file.name
							+ "] 大小超出系统限制的"
							+ $('#file_upload').uploadify('settings',
									'fileSizeLimit') + "大小！";
					break;
				case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
					msgText += "文件大小为0";
					break;
				case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
					msgText += "文件格式不正确，仅限 " + this.settings.fileTypeExts;
					break;
				default:
					msgText += "错误代码：" + errorCode + "\n" + errorMsg;
				}
				$.messager.alert("系统提示", msgText);
			};

			var uploadApplyFile_onUploadError = function(file, errorCode,
					errorMsg, errorString) {
				// 手工取消不弹出提示
				if (errorCode == SWFUpload.UPLOAD_ERROR.FILE_CANCELLED
						|| errorCode == SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED) {
					return;
				}
				var msgText = "上传失败\n";
				switch (errorCode) {
				case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
					msgText += "HTTP 错误\n" + errorMsg;
					break;
				case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
					msgText += "上传文件丢失，请重新上传";
					break;
				case SWFUpload.UPLOAD_ERROR.IO_ERROR:
					msgText += "IO错误";
					break;
				case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
					msgText += "安全性错误\n" + errorMsg;
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
					msgText += "每次最多上传 " + this.settings.uploadLimit + "个";
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
					msgText += errorMsg;
					break;
				case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND:
					msgText += "找不到指定文件，请重新操作";
					break;
				case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
					msgText += "参数错误";
					break;
				default:
					msgText += "文件:" + file.name + "\n错误码:" + errorCode + "\n"
							+ errorMsg + "\n" + errorString;
				}
				$.messager.alert("系统提示", msgText);
			};

			var uploadApplyFile_onUploadSuccess = function(file, data, response) {
				if ( data.substr(0,1)!="{") {
					// 表单请求，session过期跳转
					messageAlert(false, '上传失败', '由于时间过长或系统升级，会话已过期', function() {
						window.location.href = window.location.href;
					});
					return;
				}
				var dataObj = eval("(" + data + ")");
				if (dataObj.success) {
					$.messager.alert("系统提示", file.name + ":上传成功");
				}else{
					$.messager.alert("系统提示", file.name + ":" + dataObj.msg);					
				}
			};

			$("#uploadApplyFile")
					.uploadify(
							{
								'swf' : '${pageContext.request.contextPath}/plugins/uploadify/uploadify.swf',//控件flash文件位置
								'uploader' : '${pageContext.request.contextPath}/main/bus/file/upload',
								'queueID' : 'uploadApplyFileQueue',//与下面HTML的div.id对应  
								'width' : '100',//按钮宽度
								'height' : '32',//按钮高度
								'auto' : false,//取消自动上传
								'fileTypeDesc' : '指定类型文件',
								'fileTypeExts' : '*.xls;*.xlsx', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc 
								'fileObjName' : '"uploadApplyFileName"',
								'buttonText' : '批量选择',//上传按钮显示内容，还有个属性可以设置按钮的背景图片
								'fileSizeLimit' : '101024KB',
								'multi' : true,
								'overrideEvents' : [ 'onDialogClose',
										'onUploadSuccess', 'onUploadError',
										'onSelectError' ],//重写默认方法
								'onFallback' : function() {//检测FLASH失败调用
									alert("您未安装FLASH控件，无法上传文件！请安装FLASH控件后再试。");
								},
								'onSelectError' : uploadApplyFile_onSelectError,
								'onUploadSuccess' : uploadApplyFile_onUploadSuccess,
								'onUploadError' : uploadApplyFile_onUploadError
							});
		});

	</script>
</body>
</html>