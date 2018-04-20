var pathName = window.document.location.pathname;
var _ctx = pathName.substring(0, pathName.substr(1).indexOf("/") + 1);

(function($) {
	$.fn.customUpload = function(options) {
		var defaults = {
			id : 'customUploadId',
			uploader : _ctx + '/main/bus/file/upload',
			auto : true,
			fileTypeExts : '*.*',
			buttonText : '批量选择',
			fileSizeLimit : '101024KB',
			multi : false
		}

		options.uploadParams = $.extend(defaults, options.uploadParams);
		
		top.openDialog({
			id : options.id,
			title : options.title,
			width : options.width,
			height : options.height,
			href : _ctx + '/pages/common/upload.jsp',
			onLoad : function() {
				uploadManager(options.uploadParams);
			}
		});
	}
})($);