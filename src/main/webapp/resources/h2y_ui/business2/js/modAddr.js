/**
 * Author: Mr.Liu (Mr.Lu拆分)
 * Function: 修改地址
 * DateTime: 2015年5月25日 10:00:34
 */
	
var uiPath = window.top.uiPath;
var imagePath = window.top.imagePath;
var zone_code = window.top.zone_code;
var zone_name = window.top.zone_name;
var page = 1;
//var pagesize = window.top.pagesize;
var pagesize = 10;
var memberId = window.top.user.id;
var chosenAddress = zone_name;
/** 页面来源标志  Mr.Lu 2015年5月12日 19:30:14*/
var fromFlag = "";

/** 手机号码的正则表达式 */
var phoneReg = /^1[3|4|5|7|8][0-9]\d{8}$/;

/***********************init**********************/

$(document).ready(function(){
	$(window.parent.document).find("#myTab").show();
	initInput();
	// 初始化地址选择框
	initAddr();
	
	// 选择地址
	clickSelectAddr();
	// 电话号码禁止空格输入
	inputForbidBlank($(".modCusPhone"));
});


/*** 返回*/
function _goBack(){
	
	window.history.back();
}


/**
 * 初始化输入框
 */
function initInput(){
	
	if(localStorage.getItem("jiuyuda_GeogFlag") != null && localStorage.getItem("jiuyuda_GeogFlag") == "1"){
		$(".modCusAddr").val(localStorage.getItem("jiuyuda_GeogString"));
		$(".cusLongitude").val(localStorage.getItem("jiuyuda_LngString"));
		$(".cusLatitude").val(localStorage.getItem("jiuyuda_LatString"));
		clearStorage();
	}
}

/**
 * 清楚相关存储数据
 */
function clearStorage(){
	localStorage.removeItem("jiuyuda_GeogFlag");
	localStorage.removeItem("jiuyuda_GeogString");
	localStorage.removeItem("jiuyuda_LngString");
	localStorage.removeItem("jiuyuda_LatString");
}

/**
 * 初始化地址选择框
 */
function initAddr(){
	var chosenAddr = localStorage.getItem("jiuyuda_chosenAddr");
	if(chosenAddr != null && chosenAddr != ""){
		$(".modCusAddr").val(chosenAddr);
		localStorage.removeItem("jiuyuda_chosenAddr");
		
	}
}

/**
 * 地址选择
 */
function clickSelectAddr(){
	
	$(".modCusAddr").click(function(){
		window.location.assign("chooseCityPage.htm");
	});
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

/**修改地址操作**/
function modAddr(){
	
	var modAddrId = $(".modAddrID").val();
	var modCustomer = $(".modCustomer").val();
	var modIsDefault = $(".modIsDefault").val();
	var modCusPhone = $(".modCusPhone").val();
	var modCusAddr = $(".modCusAddr").val();
	var modCusDetailAddr = $(".modCusDetailAddr").val();
	var modCusLongitude = $(".cusLongitude").val();
	var modCusLatitude = $(".cusLatitude").val();
	
	if(modCustomer == ""){
		showTip("请填写收货人姓名",1000);
		return;
	}else if(modCusPhone.length < 11){
		showTip("手机号码位数不对");
		return;
	}else if(!phoneReg.test(modCusPhone)){
		showTip("手机号码格式不对");
		return;
	}else if(modCusAddr == ""){
		showTip("请选择收货地址");
		return;
	}
	
	
	var postData = {};
	postData.id = modAddrId;
	postData.receiverZoneDetail = modCusDetailAddr;
	postData.receiverZoneName = modCusAddr;
	postData.receiverName = modCustomer;
	postData.receiverMobile = modCusPhone;
	postData.receiverTelephone;
	postData.isDefault = modIsDefault;
	
	$.post("cmbs/receiveaddress/update.htm",{postData:JSON.stringify(postData)},function(res){
		var resJo = eval("("+res+")");
		 if(resJo.resultFlag == 1 || resJo.resultFlag == "1"){
			 
			 window.history.back();
		 }else{
				console.log("地址修改出错！");
			}
	});
}  

