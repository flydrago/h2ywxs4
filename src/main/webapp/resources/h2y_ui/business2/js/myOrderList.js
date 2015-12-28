/**
 * Function: 订单列表
 */

	var imagePath = window.top.imagePath;
	var zone_code = window.top.zone_code;
	var page = 1;	
	var pagesize = 10;

	
$(document).ready(function(){
		$(".checkMoreOrder").click(function(){
			checkMoreOrder(this);
		});
		getOrderList();
		
	});
	
/**
 * 返回 
 */
function _goBack(){
	window.history.back();
}

/**
 * 获取订单列表
 */
function getOrderList(){
	window.top.showLoading();
	var params = {};
	params.memberId = window.top.openId;
	params.page = page;
	params.pagesize = pagesize;
	params.zoneCode = window.top.zone_code;
	
	$.post("cmbs/order/getList.htm",{postData:JSON.stringify(params)}, function (data) {
//		alert("商品列表数据："+data);
		window.top.toggleLoading();
		$(".checkMoreOrder").removeAttr("disabled");
        var jsonReturn = eval("(" + data + ")");
        if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){
        	
        	drawUerInterface(jsonReturn.resultData);
        }else if(jsonReturn.resultFlag == "2" || jsonReturn.resultFlag == 2){
        	$("#myOrderList").unbind("scroll");
        	$("#lookMoreBtn").hide();
			if(page == 1){
				showTip("抱歉,暂无数据");
			}else{
//				showTip("没有更多数据了");
			}
		}else{
			$("#myOrderList").unbind("scroll");
			console.log("返回数据为空或请求失败");
		}
    });
}

/**
 * 绘制用户界面  ---即填充数据并显示
 * @perDataObj 每条数据
 * @showStyle 显示类型  1 列表 2表格
 */
function drawUerInterface(returnData){
	
	if(returnData.length < pagesize && page > 1){
		showTip("没有更多数据");
	}
	
	$(returnData).each(function(i,n){
		//totalFriends++;
		var perLineElemBlock = $("#myOrderList_template2").clone();
		perLineElemBlock.removeAttr("id");		
		var spanSerialNum = perLineElemBlock.find("span[data-serial=\"serialNum\"]");
		spanSerialNum.html(n.orderNo);
		perLineElemBlock.find("span[data-status=\"orderStatus\"]").html(n.orderStatusName);
		perLineElemBlock.find("span[data-realMoney=\"realMoney\"]").html(n.realAmount.toFixed(2));
		
		//查看物流
		perLineElemBlock.find("button[data-funbtn=\"traceRecord\"]").click(function(){
			 event.stopPropagation(); 
			 goOrderTraceInterface(spanSerialNum.html());
		});
		
		//alert(n.orderStatus);
		if(n.orderStatus == 12){
			var orderFinishEle = $("#orderFinish").clone();
			orderFinishEle.removeAttr("id");
			orderFinishEle.show();
			orderFinishEle.appendTo(perLineElemBlock);
			
			//再次购买
			var shoppingAgain = perLineElemBlock.find("button[data-funBtn=\"traceRecord\"]").clone();
			shoppingAgain.appendTo(perLineElemBlock.find("div[data-buttonArry=\"buttonArry\"]"));
			shoppingAgain.attr("data-funBtn","addCartAgain");
			shoppingAgain.text("再次购买");
			shoppingAgain.click(function(){
				event.stopPropagation();
				var params = {};
				params.memberId = window.top.user.id;
				params.zoneCode = window.top.zone_code;
				params.goodsList = [];
				var orderListArry = perLineElemBlock.find("div[data-goodsList=\"goodsList\"] [data-orderList=\"orderList\"]");
				$.each(orderListArry,function(k,v){
					var tempParam = {};
					tempParam.goodsPriceId = $(v).find("span[data-goodsPriceId=\"goodsPriceId\"]").html();
					tempParam.buyType = 0;//$(v).find("span[data-buyType=\"buyType\"]").html();
					tempParam.count = $(v).find("span[data-buyCount=\"buyCount\"]").html();
					params.goodsList.push(tempParam);
				});
				
				//alert(JSON.stringify(params));
				$.post("addBatch.htm",{paraJson:JSON.stringify(params)},function(data){
					var jsonReturn = eval("("+ data + ")");
					if(jsonReturn.resultFlag == 1 ){
						window.top.qieHuan(4);
					}else{
						showTip(jsonReturn.resultMsg);
					}
				});
				
			});
		}
		
		var goodsList = n.goodsList;
		if(goodsList.length == 1){
			var tableElem = $("#line_one_template").clone();
			tableElem.removeAttr("id");
			tableElem.show();
			$.each(goodsList,function(j,m){
				tableElem.find("img").attr("src",imagePath + m.img);
				tableElem.find("span[data-name=\"name\"]").html(m.goodsNickName);
				tableElem.find("span[data-price=\"single\"]").html(m.singlePrice.toFixed(2));
				tableElem.find("span[data-number=\"num\" ]").html(m.goodsCount);
				tableElem.find("span[data-perTotal=\"perTotal\"]").html(m.goodsAmount.toFixed(2));
				tableElem.find("span[data-goodsPriceId=\"goodsPriceId\"]").html(m.goodsPriceId);
				tableElem.find("span[data-buyType=\"buyType\"]").html(m.buyType);
				tableElem.find("span[data-buyCount=\"buyCount\"]").html(m.goodsCount);
				if(m.buyType == 1){
					tableElem.find("div[data-isJiuKu=\"isJiuKu\"]").show().addClass("jiuku");
				}
				tableElem.appendTo(perLineElemBlock.find("div[data-goodsList=\"goodsList\"]"));
			});
		}else if(goodsList.length > 1){
			$.each(goodsList,function(j,m){
				var divElem = $("#moreGoodsDivTemplate").clone();
				divElem.removeAttr("id");
				divElem.css("display","inline-block");
				divElem.find("img").attr("src",imagePath + m.img);
				divElem.find("span[data-goodsPriceId=\"goodsPriceId\"]").html(m.goodsPriceId);
				divElem.find("span[data-buyType=\"buyType\"]").html(m.buyType);
				divElem.find("span[data-buyCount=\"buyCount\"]").html(m.goodsCount);
				divElem.appendTo(perLineElemBlock.find("div[data-goodsList=\"goodsList\"]"));
				if(j >=3){
					if(goodsList.length > 4){
						var ellipsisHtml = "<span>…</span>";
						divElem.html(divElem.html() + ellipsisHtml);
					}
					return false;
				}
				
			})
		}
		
//		perLineElemBlock.find("button").attr({"onclick":"goOrderTraceInterface('"+n.orderNo+"')"});

		if(page == 1){
			perLineElemBlock.show();
		}else{
			perLineElemBlock.fadeIn();
		}
		perLineElemBlock.css("position","relative");//没有该设置，印章会重叠
		perLineElemBlock.appendTo("#myOrderList");
	});
	
	if(returnData.length < pagesize){
		$("#lookMoreBtn").hide();
	}else{
		$("#lookMoreBtn").show();
	}
}


/**
 * 去订单详情页面
 */
function goToOrderDetailInterface(elem){
	var orderNo = $(elem).find("span[data-serial=\"serialNum\"]").html();
	var params = {};
	params.orderNo = orderNo;
	window.location.assign("goToOrderDetailInterface.htm?paraJson=" + JSON.stringify(params));
	
}

/**
 * 订单追踪页面
 */
function goOrderTraceInterface(orderNo){
	window.location.assign("goToMyOrderTraceInterface.htm?orderId="+orderNo);
}

/**查看更多**/
function checkMoreOrder(elem){
	$(elem).attr("disabled","disabled");
	page++;
	getOrderList();
}
