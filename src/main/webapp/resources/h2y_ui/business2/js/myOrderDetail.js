/**
 * Function: 订单详情
 */
/** 订单数据 */
var orderDetailData = null;
/** 图片服务器路径 */
var imagePath = window.top.imagePath;

$(document).ready(function(){
	var tempData = $("#orderDetail").val();
	orderDetailData = eval("(" + tempData + ")");
	if(orderDetailData.resultFlag == 1){
		if(orderDetailData.resultData.receiverStatus == 21){
			$("#orderItem").find("button").attr("disabled","disabled");
		}
		drawDeliverUI();
		drawGoodsListUI(orderDetailData.resultData.goodsList);
	}else{
		showTip(orderDetailData.resultMsg);
	}
});




/**
 * 返回上一页   
 */
function _goBack(){
	window.history.back();
}


/**
 * 配送员数据填充
 */
function drawDeliverUI(){
	var tempDeliverName = orderDetailData.resultData.deliveryerName;
	var tempDeliverPhone = orderDetailData.resultData.deliveryerMobile;
	$("#deliverymanItem").find("span[data-name=\"name\"]").html(tempDeliverName == null ? "暂无" : tempDeliverName);
	var aPhone = $("#deliverymanItem").find("a[data-phone=\"phone\"]");
	aPhone.html(tempDeliverPhone == null ? "暂无" : tempDeliverPhone);
	aPhone.attr("href",tempDeliverPhone == null ? "javascript:void(0)" : "tel:" + tempDeliverPhone);
	
}

/**
 * 订单商品列表
 * @param goodsAttr
 */
function drawGoodsListUI(goodsAttr){
	
	$.each(goodsAttr, function(i,n){
		var perLineBlock = $("#line_one_template").clone();
		perLineBlock.removeAttr("id");
		perLineBlock.appendTo("#goodsList table");
		
		perLineBlock.find("img").attr("src", imagePath + n.img);
		perLineBlock.find("span[data-name=\"name\"]").html(n.goodsNickName);
		perLineBlock.find("span[data-price=\"single\"]").html(n.singlePrice);
		perLineBlock.find("span[data-number=\"num\" ]").html(n.goodsCount);
		perLineBlock.find("span[data-perTotal=\"perTotal\"]").html(n.goodsAmount);
		var spanId = perLineBlock.find("span[data-goodsPriceId=\"goodsPriceId\"]");
		spanId.html(n.goodsPriceId);
		perLineBlock.click(function(){
			goToGoodsDetailInterface(spanId.html());
		});
		if(i == goodsAttr.length - 1){
			perLineBlock.removeClass("tableBottomBorder");
		}
	});
}


/**
 * 进入商品详情 
 */
function goToGoodsDetailInterface(_id){
	
	var params = {};
	params.id = _id;
	params.zoneCode = window.top.zone_code;
	if(window.top.user.id != null || window.top.user.id != ""){
		params.memberId = window.top.user.id;
	}
	window.location.assign("mGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
}

/**
 * 完成操作
 */
function goToFinish(elem){
	$(elem).attr("disabled","disabled");
	var params = {};
	params.orderNo = orderDetailData.resultData.orderNo;
	params.memberId = window.top.openId;
	params.orderStatus = "21";
	params.zoneCode = window.top.zone_code;
	
	$.post("cmbs/order/memberDeal.htm",{postData:JSON.stringify(params)},function(data){
		
		var jsonReturn = eval("(" + data + ")");
		if(jsonReturn.resultFlag == 1){
			$(elem).html("已完成");
		}
	})
}