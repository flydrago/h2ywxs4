/**
 * Mr.Lu 2015年4月2日 11:12:27
 */

var uiPath = window.top.uiPath;
var imagePath = window.top.imagePath;


/*******************init*********************/
$(document).ready(function(){
	
	$(window.parent.document).find("#myTab").show();
	
	if(window.top.zone_code != null && window.top.zone_code != ""){
		$("#contentDiv").show();
		$("#moreBtn").removeAttr("disabled");
		var tempFlag = window.top.getLoginFlag();
		if(tempFlag == 0){
			window.top.toggleLoading();
			$("#unLoginDivTip").show();
			$("#loginedDivShow").hide();
		}else if(tempFlag == 1){
			
			$("#unLoginDivTip").hide();
			$("#loginedDivShow").show();
			
			initLoginedDivShow();
		}
	}else{
		$("#contentDiv").hide();
	}
	
	$("#contentDiv").scroll(function() {
		if($("#contentDiv").scrollTop() > 0){
			$("#titleDiv").css({"background":"#1a90f0","opacity":"0.5"});
		}else{
			$("#titleDiv").css({"background":"","opacity":"1"});
		}
	});

	
});	

/****************function*****************/
function decodeHtmlUnicode(val) {
	var reg = /&#([0-9]+);/
		while(reg.test(val)) {
			var v = reg.exec(val)[1];
			v = String.fromCharCode(v);
			val = val.replace(reg, v);
		}
	return val;
}


/**
 * 去更多页面
 */
function goMeMoreInterface(){
	
	window.location.assign("goMeMoreInterface.htm");
}


/**
 * 给已登录的div填充数据
 */
function initLoginedDivShow(){
	
	var loginedShowDiv = $("#loginedDivShow");
	loginedShowDiv.find("img[data-headIcon=\"headIcon\"]").attr("src",window.top.user.headPath == null || window.top.user.headPath == ""? uiPath + "business2/images/no_image.9.png" : window.top.imagePath + window.top.user.headPath);
	loginedShowDiv.find("p[data-account=\"account\"]").html(window.top.user.account);

	if(window.top.user.nickName != "" || window.top.user.nickName != null){
		loginedShowDiv.css("padding-top","8px");
		loginedShowDiv.find("table").css("margin-top","-15px");
		loginedShowDiv.find("p[data-nickName=\"nickName\"]").show().html(window.top.user.nickName);
	}else{
		loginedShowDiv.css("padding-top","15px");
		loginedShowDiv.find("p[data-nickName=\"nickName\"]").hide();
	}
	
	var params = {};
	params.id = window.top.user.id;
	params.zoneCode = window.top.zone_code;
	
	$.post("getMyIncomeData.htm",{ paraJson:JSON.stringify(params)},function(data){
		
		window.top.toggleLoading();
		
		//alert(data);
		
		var jsonReturn = eval("(" + data + ")");
		if(jsonReturn.resultFlag == "1" || jsonReturn.resultFlag == 1){
			loginedShowDiv.find("span[data-bean=\"bean\"]").html(jsonReturn.resultData.vipBean == null || jsonReturn.resultData.vipBean == "" ? (0).toFixed(2):jsonReturn.resultData.vipBean.toFixed(2));
			loginedShowDiv.find("span[data-coin=\"coin\"]").html(jsonReturn.resultData.vipCoin == null || jsonReturn.resultData.vipCoin == "" ? (0).toFixed(2):jsonReturn.resultData.vipCoin.toFixed(2));
		}else{
			console.log(jsonReturn.resultMsg);
		}
	});
	
}

/**
 * 获取二维码
 */
function getQRCode(){
	$("#myModal").modal("show");
	
	$("#myModal").on("shown.bs.modal", function () {
	    $(".modal-dialog").css({"margin-top":"60px"});
	    $("#myModal").css({"padding-left":"0"});
	})
	$("#myModal").find(".modal-header span[data-account=\"account\"]").html(window.top.user.account);
	$("#myModal").find("img").attr("src",imagePath + window.top.user.qrPath);
}



/**
 * 去登录界面
 */
function goToLoginInterface(){
	
	window.location.assign("goLoginInterface.htm");
}

/**
 *	去优惠券界面 
 */
function goToCouponInterface(){
//	window.location.assign("goCouponInterface.htm");
	ifJumpLogin("goCouponInterface.htm");
}

/**
 * 进入我的收益页面
 */
function goToMyIncomeInterface(){

	ifJumpLogin("lookMyIncomeList.htm");
}

/**
 * 进入我的关注页面
 */
function goToMyCareInterface(){
	
	ifJumpLogin("lookMyCareList.htm");
}


/**
 * 进入订单查询界面
 */
function goToMyOrderInterface(){
	
	ifJumpLogin("goToMyOrderListInterface.htm");
}


/**
 * 进入我的好J友界面
 */
function goToMyJFriendsInterface(){
	
	ifJumpLogin("goToMyJFriendsInterface.htm");
}


/**
 * 地址管理  ----进入地址列表界面
 */
function addressManageInterface(){
	
	ifJumpLogin("goAddrManageInterface.htm");
}

/**进入签到页面**/
function goSignInterface(){
	
	ifJumpLogin("goSignInterface.htm");
}

/**
 * 二维码
 */
function lookQrCode(){
	
	window.location.assign("lookQrCode.htm");
}