/**
 * Author: Mr.Lu
 * Function:统一url跳转
 * DateTime: 2015-9-16 16:15:02
 */


/**************init***************/
		
var zone_code = window.top.zone_code;
var imagePath = window.top.imagePath;
var userId = window.top.openId;

$(document).ready(function(){
	$(window.parent.document).find("#myTab").hide();
	loadSignPage();
});


/**返回**/
function _goBack(){
	window.history.back();
}


function loadSignPage(){
	$("#unifyFrame").attr("src",url);
}