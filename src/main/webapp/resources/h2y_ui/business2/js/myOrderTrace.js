/**
 * Author: Mr.Lu
 * Function: 好J友 
 * DateTime: 2015年4月29日 13:16:47
 */

/** 订单跟踪前的图标位置 */
var _imgOffset = [];
/** 订单跟踪前的图标高度 */
var _imgHeight = [];
/** 每条线头距图标的留白 */
var _perSpace = 4;
var uiPath = "<%=uiPath %>";
var imagePath = window.top.imagePath;
var zone_code = window.top.zone_code;
var currOrderId = $("#currOrderId").val()+"";

/***************init***************/

$(document).ready(function(){
	
	traceOrderInfo(currOrderId);
	
});


/**
 * 返回 
 */

function traceOrderInfo(orderId){
	window.top.showLoading();
	var postData = {};
	postData.orderNo = orderId;
	postData.zoneCode = window.top.zone_code;
	
	$.post("cmbs/order/getTrack.htm",{postData:JSON.stringify(postData)},function(result){
		window.top.toggleLoading();
		var resultJo = eval("("+result+")");
		if(resultJo.resultFlag == 1 || resultJo.resultFlag == "1"){
			setCustomerAndDeliverymanInfo(resultJo.resultData);
			getSendProcessList(resultJo.resultData.trackList);
		}else{
			console.log("返回数据为空或请求失败");
		}
	});
}

function _goBack(){
	window.history.back();
}

function setCustomerAndDeliverymanInfo(CDInfo){
	$("#myOrderList").find("span[data-receive='orderReceiver']").text(CDInfo.receiverName);
	$("#myOrderList").find("span[data-serial='orderSerial']").text(CDInfo.orderNo);
	$("#myOrderList").find("span[data-deliveryman='orderDeliveryman']").text(CDInfo.deliveryerName);
	$("#myOrderList").find("span[data-deliPhone='orderDeliPhone']").text(CDInfo.deliveryerMobile);
	$("#myOrderList").fadeIn();
}

function getSendProcessList(SPInfo){
	var perLineElemBlock;
	$.each(SPInfo,function(i,n){
		if(i==0){
			perLineElemBlock = $("#sendProcessHead_template").clone();
			perLineElemBlock.find("span[data-person=\"processPerson\"]").html(n.operatorName);
			perLineElemBlock.find("span[data-sendType=\"sendType\"]").html(n.orderStatusName);
			perLineElemBlock.find("span[data-time=\"orderTime\"]").html(n.createDate);
		}else{
			perLineElemBlock = $("#sendProcess_template").clone();
			perLineElemBlock.find("span[data-person=\"processPerson\"]").html(n.operatorName);
			perLineElemBlock.find("span[data-sendType=\"sendType\"]").html(n.orderStatusName);
			perLineElemBlock.find("span[data-time=\"orderTime\"]").html(n.createDate);
		}
		perLineElemBlock.removeAttr("id");
		perLineElemBlock.fadeIn();
		perLineElemBlock.appendTo("#sendProcessList");
		
		var imgElem = perLineElemBlock.find("img");
		_imgOffset.push(imgElem.offset().top);
		_imgHeight.push(imgElem.height());
		test();
	});
}

function test(){
	if(_imgOffset.length >= 2){
		var greyLine = $("#greyLine_template").clone();
		greyLine.removeAttr("id");
		greyLine.show();
		greyLine.css("height",_imgOffset[_imgOffset.length-1] - _imgOffset[_imgOffset.length-2] - _imgHeight[_imgHeight.length-2] - _perSpace + "px");
		greyLine.css("top",_imgOffset[_imgOffset.length-2] + _imgHeight[_imgHeight.length-2] + _perSpace/2 - $("#sendProcessDiv").offset().top + "px");
		greyLine.appendTo("#sendProcessList");
	}
}
