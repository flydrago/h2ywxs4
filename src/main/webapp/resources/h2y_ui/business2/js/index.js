/**
 * 索引页
 */
/** 登录标志 0 未登录 1 已登录 */
var loginFlag = 0;
/**
 * 标签页显示  
 */
$(document).ready(function () {
	spinner = new Spinner(opts);
	saveOpenId();
	getOpenId();
	clearAllSession();
	tabLabel(1);
});


/**
 *   切换标签  
 */
function qieHuan(value){
	tabLabel(value);
}

/** 
 *    标签页显示  
 */
function tabLabel(value){
	toggleLoading();
	showLoading();
	switch(value){
		case 1:	  $("#myTab li:eq(0) a").tab("show");//首页
			      $("#home").attr("src","indexHome.htm");
				  break;
		case 2:	  $("#myTab li:eq(1) a").tab("show");//分类
			      $("#goodsSort").attr("src","indexSort.htm");
		          break;
		case 4:	  $("#myTab li:eq(2) a").tab("show");//购物车
        		  $("#shoppingCart").attr("src","goodsCart.htm");
        		  localStorage.removeItem("wechatshop_fromflag");
        		  localStorage.setItem("wechatshop_fromflag", 1);
        		  break;
        default: break;
	}
}

/**
 * 保存OpenId
 */
function saveOpenId(){
	if(openId != null || openId != "" || openId != "undefined"){
		localStorage.removeItem("wechatshop_user_openid");
		localStorage.setItem("wechatshop_user_openid",openId);
	}
}

/**
 * 设置openId
 */
function getOpenId(){
	var tempVal = localStorage.getItem("wechatshop_user_openid");
	if(tempVal != null && tempVal != "" && tempVal != "undefined"){
		openId = tempVal;
	}
	return openId;
}

/**
 * 保存区域编码
 */
function saveZoneCode(){
	if(zone_code != null || zone_code != "" || zone_code != "undefined"){
		localStorage.removeItem("wechatshop_user_zoneCode");
		localStorage.setItem("wechatshop_user_zoneCode",zone_code);
	}
}
function setZoneCode(_zoneCode){
	zone_code = _zoneCode;
}
/**
 * 获取区域编码
 */
function getZoneCode(){
	var tempVal = localStorage.getItem("wechatshop_user_zoneCode");
	if(tempVal != null && tempVal != "" && tempVal != "undefined"){
		zone_code = tempVal;
	}
	return zone_code;
}

/**
 * 初始化购物车商品数量
 */
function initCartGoodsNum(_async){
	var params = {};
	params.memberId = user.id;
	params.zoneCode = zone_code;
	$.ajax({
		type:"post",
		url:"goodsCartList.htm",
		data:{ paraJson : JSON.stringify(params) }, 
		dataType:"json",
		async: _async == false?_async:true,
		success:function (data) {
//			alert(JSON.stringify(data));
			var cartGoodsNum = 0;
	        $.each(data.resultData,function(i,n){
	        	cartGoodsNum = parseInt(cartGoodsNum) + parseInt(n.goodsCount);
	        });
	        setGoodsCount(cartGoodsNum);
		}
	});
}


/**
 * 设置显示加入购物车的商品数量  
 */
function setGoodsCount(value){
	if(value <= 0 || value == "0"){
		$("#goodsCount").hide();
		$("#goodsCount").find(".tooltip-inner").html("");
	}else{
		$("#goodsCount").show();
		$("#goodsCount").find(".tooltip-inner").html(value + "");
	}
}

/**
 * 获取购物车商品数量
 */
function getGoodsCount(){
	var goodsNum = parseInt( $("#goodsCount").find(".tooltip-inner").html() == "" ? "0" : $("#goodsCount").find(".tooltip-inner").html());
	return goodsNum;
}

/**
 * 显示缓冲条
 */
function showLoading(){
	$("#loadingDiv").show();
	var tempTarget = $("#loadingDiv").get(0);
    spinner.spin(tempTarget);   
}

/**
 * 隐藏缓冲条
 */
function toggleLoading(){
	 spinner.spin();
}

/**
 * 清空session
 */
function clearAllSession(){
	//localStorage.clear();
	localStorage.removeItem("wechatshop_chosenAddr");
	localStorage.removeItem("wechatshop_fromFlag");
	localStorage.removeItem("wechatshop_GeogFlag");
	localStorage.removeItem("wechatshop_GeogString");
	localStorage.removeItem("wechatshop_LngString");
	localStorage.removeItem("wechatshop_LatString");
	localStorage.removeItem("wechatshop_receiveDataFlag");
	localStorage.removeItem("wechatshop_receiveName");
	localStorage.removeItem("wechatshop_receivePhone");
	localStorage.removeItem("wechatshop_receiveAddr");
	localStorage.removeItem("wechatshop_addressId");
	localStorage.removeItem("wechatshop_addressLon");
	localStorage.removeItem("wechatshop_addressLat");
}

function previewImage(imgUrl,imgArry){
	 wx.previewImage({
		 current: imgUrl,
		 urls: imgArry
	 });
}