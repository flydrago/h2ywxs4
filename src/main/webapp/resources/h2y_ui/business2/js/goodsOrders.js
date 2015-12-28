/**
 * Function:结算页面
 */


/**
 * 返回 -----点击左上角返回
 */
function _goBack(){
	window.history.back();
}

/**
 * 获取session数据
 */
function getSessionData(){
	var receiveDataFlag = localStorage.getItem("wechatshop_receiveDataFlag");
	if(receiveDataFlag == 1){
		var tempName = localStorage.getItem("wechatshop_receiveName");
		var tempPhone = localStorage.getItem("wechatshop_receivePhone");
		var tempAddr = localStorage.getItem("wechatshop_receiveAddr");
		var tempId = localStorage.getItem("wechatshop_addressId");
		setAddrMsg(tempName, tempPhone, tempAddr, tempId);
		clearSessionData();
	}
}

/**
 * 获取订单数据
 */
function getOrderData(){
	$.post("cmbs/order/orderParams.htm",{"postData":JSON.stringify(paraJson)},function(data){
		//alert(data);
		var jsonReturn = eval("(" + data + ")");
		orderParams = jsonReturn;
 		if(orderParams.resultFlag == 1){
 			setDataToInterface();
 		}else if(orderParams.resultFlag == 0){
 			$("#bottomSubmitBtn").removeAttr("onclick");
 			$("#noSelectWarning").show().find("span").html(orderParams.resultMsg);
 			var timer = null;
			timer = setInterval(function(){
				clearInterval(timer);
				$("#noSelectWarning").hide();
			},2000);
 		}
	});
}

/**
 * 清除session数据
 */
function clearSessionData(){
	localStorage.removeItem("wechatshop_receiveDataFlag");
	localStorage.removeItem("wechatshop_receiveName");
	localStorage.removeItem("wechatshop_receivePhone");
	localStorage.removeItem("wechatshop_receiveAddr");
	localStorage.removeItem("wechatshop_addressId");
	localStorage.removeItem("wechatshop_addressLon");
	localStorage.removeItem("wechatshop_addressLat");
}

/**
 * 定位地址成功，填充ui
 * @param _addressComp
 */
function setAddrMsg(_name, _phone, _addrString, _id){
	var addrSucDiv = $("#getAddrSuccess");
	addrSucDiv.show();
	addrSucDiv.find("input[data-receiveName=\"receiveName\"]").val(_name);
	addrSucDiv.find("input[data-receivePhone=\"receivePhone\"]").val(_phone);
	addrSucDiv.find("input[data-receiveAddr=\"receiveAddr\"]").val(_addrString);
	addrSucDiv.find("span[data-addressId=\"addressId\"]").html(_id);
}


/**
 * 新建收货地址
 */
function creatNewAddress(){
	window.location.assign("goAddrManageInterface.htm?fromFlag=" + "1");
}


/**
 * 数据填充ui
 */
function setDataToInterface(){
//	alert(JSON.stringify(orderParams));
	setOrderListInterface(orderParams.resultData.goodsList);
	$("#goodsTotalMoney").html(totalMoney);
	$("#goodsCount").html(orderParams.resultData.goodsCount);
	$("#realTotalMoney").html(orderParams.resultData.realAmount);
}

/**
 * 订单商品列表
 * @param listDataAttr
 */
function setOrderListInterface(listDataAttr){
	$.each(listDataAttr, function(i, n){
		goodsTotalNum = goodsTotalNum + n.goodsCount;
		var perLineElemBlock = $("#cartListTemplate").clone();
		perLineElemBlock.removeAttr("id");
		perLineElemBlock.show();
		perLineElemBlock.appendTo("#cartList");
		
		/*if(n.isActivity == 1 || n.isActivity == "1"){
			perLineElemBlock.find("div[data-privilege=\"huoDongOrCuXiao\"]").show();
		}*/
		if(i == 0){
			perLineElemBlock.attr("margin-top","10px");
		}
		perLineElemBlock.find("img").attr("src",imagePath + n.img);
		perLineElemBlock.find("span[data-name=\"name\"]").html(n.goodsNickName);
		perLineElemBlock.find("span[data-perTotal=\"perTotal\"]").html(n.goodsAmount);
		perLineElemBlock.find("span[data-price=\"price\"]").html(n.singlePrice);
		perLineElemBlock.find("span[data-number=\"num\" ]").html(n.goodsCount);
		if(n.isGift == 1 || n.isGift == "1"){
			perLineElemBlock.find("span[data-isGift=\"isGift\"]").show();
		}
		var spanGoodsPriceId = perLineElemBlock.find("span[data-goodsPriceId=\"goodsPriceId\"]");
		spanGoodsPriceId.html(n.goodsPriceId);
		perLineElemBlock.click(function(){ 
			goToGoodsDetailInterface( spanGoodsPriceId.html()) ;
		});
	});
}

/**
 * 商品详情页面
 * @param _id
 */
function goToGoodsDetailInterface(_id){
	var params = {};
	params.id = _id;
	params.zoneCode = window.top.zone_code;
	params.memberId = window.top.openId;
	if(window.top.user.id != null || window.top.user.id != ""){
		params.memberId = window.top.user.id;
	}
	window.location.assign("mGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
}

/**
 * 提交订单前的再次确定的操作
 */
function selectIfSubmit(){
	$("#myModal2").modal("show");
}

/**
 * 提交订单
 */
function submitOrderForm(){
	$("#myModal2").modal("hide");
	var params = {};
	params.receiverAddressId = $("span[data-id=\"id\"]").html();
	params.receiverAddress = $("input[data-receiveAddr=\"receiveAddr\"]").val();
	params.shoppingCartList = paraJson.shoppingCartList;
	params.receiverMobile = $("input[data-receivePhone=\"receivePhone\"]").val();
	params.receiverName = $("input[data-receiveName=\"receiveName\"]").val();
	params.memberId = window.top.openId;
	params.zoneCode = window.top.zone_code;
	$.post("submitOrder.htm", {paraJson: JSON.stringify(params)}, function(data){
//		alert(data);
		var jsonReturn = eval("(" + data + ")");
		if(jsonReturn.resultFlag == 1){
			window.top.setGoodsCount(window.top.getGoodsCount() - goodsTotalNum );
			$("#myModal3").find(".modal-body span[data-orderNo=\"orderNo\"]").html(jsonReturn.resultData.orderNo);
			$("#myModal3").find(".modal-body span[data-orderMoney=\"orderMoney\"]").html(jsonReturn.resultData.realAmount);
			$("#myModal3").find(".modal-body span[data-orderTime=\"orderTime\"]").html(jsonReturn.resultData.createDate);
			$("#myModal3").modal("show");
			$("#myModal3").on("shown.bs.modal", function () {
			    $("#myModal3").css({"padding-left":"0px","height":"100%"});
			});
		}else{
			$("#noSelectWarning").show().find("span").html("订单提交失败---》" + jsonReturn.resultMsg);
			var timer = setInterval(function(){
				clearInterval(timer);
				$("#noSelectWarning").hide();
			},2000);
			console.log("订单提交失败---》" + jsonReturn.resultMsg);
		}
	});
	
}


/**
 * 订单提交成功后弹出的订单结果，点击关闭按钮，关闭界面
 */
function closeOrderResult(){
	$("#myModal2").modal("hide");
}


/**
 * 返回购物车
 */
function goBackToCart(){
	/*$("#myModal3").modal("hide");
	$("#myModal3").on("hidden.bs.modal",function(){
		_goBack();
	});*/
	window.top.tabLabel(1);
}
