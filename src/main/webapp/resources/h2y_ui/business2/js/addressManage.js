/**
 *  地址管理
 */

	
var page = 1;
var pagesize = 10;
var chosenAddress = window.top.zone_name;;
/** 页面来源标志*/
var fromFlag = "";

/***********************init**********************/

$(document).ready(function(){
	$(window.parent.document).find("#myTab").show();
	
	getAddrList();
	
	fromFlag = $("#fromFlagInput").val();
	
	// 查看更多地址信息
	lookMore();
	
});


/**
 * 查看更多
 */
function lookMore(){
	$(".checkMoreAddr").click(function(){
		page++;
		getAddrList();
	});
}

/*************************Define Functions**************************/

/**进入修改地址页面**/
function modifyAddrMsg(){
	window.location.assign("goModifyAddrInterface.htm?addrID="+$("#opAddrID").val());
}

/**获取当前用户所有地址**/
function getAddrList(){
	window.top.showLoading();
	var postData = {};
	postData.memberId = window.top.openId;
	postData.page = page;
	postData.pagesize = pagesize;
	postData.zoneCode = window.top.zone_code;
	
	$.post("cmbs/receiveaddress/getList.htm",{postData:JSON.stringify(postData)},function(res){
//		alert(res);
		window.top.toggleLoading();
		var resJo = eval("("+res+")");
		if(resJo.resultFlag == 1 || resJo.resultFlag == "1"){
			fitAddrList(resJo.resultData);
		}else{
			$("#contentDiv").unbind("scroll");
			console.log("查询地址信息为空或者出错！");
		}
	});
}

/**组装地址列表**/
function fitAddrList(addrJo){
	
	if(addrJo.length < pagesize && page > 1){
//		showTip("没有更多数据");
	}
	
	$.each(addrJo,function(i,n){
		var cusAddrObj = $("#cusAddrTemplate").clone();
		cusAddrObj.removeAttr("id");
		cusAddrObj.find("span[data-cusName='cusName']").html(n.receiverName);
		cusAddrObj.find("span[data-cusPhone='cusPhone']").html(n.receiverMobile);
		cusAddrObj.find("p[data-cusAddr='cusAddr']").html(n.zoneName+n.zoneDetail);
		
		cusAddrObj.find("span[data-addressId=\"addressId\"]").html(n.id);
		if(n.isDefault == 1){
			var addrDefaultDiv = $("#addrDefaultTemplate").clone();
			addrDefaultDiv.show();
			addrDefaultDiv.removeAttr("id");
			addrDefaultDiv.appendTo(cusAddrObj);
		}
		
//		cusAddrObj.attr("onclick","onClickModal("+n.id+")");
		cusAddrObj.click(function(){
			onClickModal(cusAddrObj.find("span[data-addressId=\"addressId\"]").html(),cusAddrObj);
		});
		cusAddrObj.fadeIn();
		cusAddrObj.appendTo("#cusAddrList");
	});
	
	if(addrJo.length < pagesize){
		$("#lookMoreBtn").hide();
		$("#contentDiv").unbind("scroll")
	}else{
		$("#lookMoreBtn").show();
		$("#contentDiv").bind("scroll",function(){
			page++;
			getAddrList();
		});
	}
}

/*** 返回*/
function _goBack(){
	window.top.toggleLoading();
	window.history.back();
}


/**
 * 新建地址信息页面 
 */
function setUpNewAddr(){
	window.location.assign("goNewAddrInterface.htm");
}

/**
 * 弹出模态框    ----单/双击已有地址信息
 */
//function dbClickModal(addrID){
function onClickModal(addrID, elem){
	if(fromFlag == 1){ 
		// 提交订单调用
		localStorage.removeItem("wechatshop_receiveDataFlag");
		localStorage.setItem("wechatshop_receiveDataFlag", "1");
		localStorage.removeItem("wechatshop_receiveName");
		localStorage.setItem("wechatshop_receiveName", $(elem).find("span[data-cusName=\"cusName\"]").html());
		localStorage.removeItem("wechatshop_receivePhone");
		localStorage.setItem("wechatshop_receivePhone", $(elem).find("span[data-cusPhone=\"cusPhone\"]").html());
		localStorage.removeItem("wechatshop_receiveAddr");
		localStorage.setItem("wechatshop_receiveAddr", $(elem).find("p[data-cusAddr=\"cusAddr\"]").html());
		localStorage.removeItem("wechatshop_addressId");
		localStorage.setItem("wechatshop_addressId", $(elem).find("span[data-addressId=\"addressId\"]").html());
		window.history.back();
	}else if(fromFlag == 2){ 
		// 我的地址管理调用
		$("#opAddrID").val(addrID);
		$("#myModal").modal("show");
	}
	
}

/**
 * 删除地址信息
 */
 function deleteAddrMsg(){
	 var postJson = {};
	 postJson.id = $("#opAddrID").val();
	 postJson.zoneCode = window.top.zone_code;
	 postJson.memberId = window.top.openId;
	 $.post("cmbs/receiveaddress/delete.htm",{postData:JSON.stringify(postJson)},function(res){
		 var resJo = eval("("+res+")");
		 if(resJo.resultFlag == 1 || resJo.resultFlag == "1"){
			 	$("#myModal").modal("hide");
			 	window.location.assign("goAddrManageInterface.htm");
			}else{
				console.log("删除地址出错！");
			}
	 });
 }
 
/**
 * 设为默认地址 
 */
function setDefaultAddrMsg(){
	 var postJson = {};
	 postJson.id = $("#opAddrID").val();
	 postJson.zoneCode = window.top.zone_code;
	 postJson.memberId = window.top.openId;
	 $.post("cmbs/receiveaddress/setDefault.htm",{postData:JSON.stringify(postJson)},function(res){
		 var resJo = eval("("+res+")");
		 if(resJo.resultFlag == 1 || resJo.resultFlag == "1"){
			 	$("#myModal").modal("hide");
			 	window.location.assign("goAddrManageInterface.htm");
			}else{
				console.log("设为默认地址出错！");
			}
	 });
}
