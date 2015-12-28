/**
 * Author: Mr.Liu  (Mr.Lu拆分)
 * Function: 新建地理位置
 * DateTime: 2015年5月25日 08:43:47
 */

/** 手机号码的正则表达式 */
var phoneReg = /^1[3|4|5|7|8][0-9]\d{8}$/;
	
	
$(document).ready(function(){
	$(window.parent.document).find("#myTab").show();
	initInput();
	// 禁止电话空格输入 
	inputForbidBlank($(".cusPhone"));
});


/*** 返回*/
function _goBack(){
	window.history.back();
}

/**
* 初始化输入框
*/
function initInput(){
	$(".customer").val();
	$(".cusPhone").val();
}


/**
 * 禁止空格输入 ---限制input元素
 */
function inputForbidBlank(elem){
	$(elem).on("input",function(){
		// 禁止空格输入
		var tempVal = ($(elem).val() + "").replace(/(^\s+)|(\s+$)/g,"");
		$(elem).val(tempVal);
	});
}

/**
 * 点击确定  ----确定按钮
 */
function makeSureNewAddr(elem){
	var customer = ($(".customer").val() + "").replace(/(^\s+)|(\s+$)/g,"");
	var cusPhone = $(".cusPhone").val();
	var cusAddr = $(".cusAddr").val();
	var cusDetailAddr = $(".cusDetailAddr").val();
	
	if(customer == ""){
		showTip("请填写收货人姓名",1000);
		return;
	}else if(cusPhone.length < 11){
		showTip("手机号码位数不对");
		return;
	}else if(!phoneReg.test(cusPhone)){
		showTip("手机号码格式不对");
		return;
	}else if(cusAddr == ""){
		showTip("请填写您的地址");
		return;
	}
	$(elem).attr("disabled","disabled");
	window.top.showLoading();
	var postData = {};
	postData.memberId = window.top.openId;
	postData.zoneCode = window.top.zone_code;;
	postData.receiverZoneDetail = cusDetailAddr;
	postData.receiverZoneName = cusAddr;
	postData.receiverName = customer;
	postData.receiverMobile = cusPhone;
	/*postData.isDefault = 0;*/
	$.post("cmbs/receiveaddress/add.htm",{postData:JSON.stringify(postData)},function(res){
		window.top.toggleLoading();
		$(elem).removeAttr("disabled");
		var resJo = eval("("+res+")");
		if(resJo.resultFlag == 1 || resJo.resultFlag == "1"){
			window.history.back();
		}else{
			showTip("新建地址失败或者出错！");
			console.log("新建地址失败或者出错！");
		}
	});
}
