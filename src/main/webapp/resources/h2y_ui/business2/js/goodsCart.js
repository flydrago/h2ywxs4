/**
 *  Author:Mr.Lu
 *  Function:购物车
 *  DateTime: 2015年4月2日 15:25:12
 */

/** 总钱数 */
var totalMoney = 0;
/** 本地商品的总钱数 */
var localTotalMoney = 0;
/** 结算的提交数据 */
var submitJsonReturn = [];
/** 商品数量输入框 */
var inputElem = null;
var imagePath = window.top.imagePath;
var page = 1;
var pageSize = 10;
/** 本地购物车数据 */
var localCartArry = [];
/** 轮播总长度 */
var carouselTotalLength = 0;
var unLoginCartGoodsNum = 0;
	
$(document).ready(function(){
	$(window.parent.document).find("#myTab").show();
	if(window.top.zone_code != null && window.top.zone_code != ""){
		getCartList2();
	}
});


function getCartList2(){
	window.top.toggleLoading();
	var params = {};
	params.memberId = window.top.openId;
	params.zoneCode = window.top.zone_code;
//	params.page = page;
//	params.pagesize = pageSize;
	
	$.post("goodsCartList.htm",{ paraJson : JSON.stringify(params) }, function (data) {
		window.top.toggleLoading();
//		alert(data);
		var jsonReturn = eval("(" + data + ")");
        if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){ // 返回数据成功
        	if(jsonReturn.resultData.length == 0){
        		$("#cartNoGoodsDiv").show();
//        		$("#cartNoGoodsDiv").css({"top":"45px"});
        		$("#cartHasGoodsDiv").hide();
        		$("#topDelBtn").attr("disabled","disabled");
        		$("#yourLoveDiv").show().appendTo("#cartNoGoodsDiv");
        		return;
        	}
        	$("#cartHasGoodsDiv").show();
//        	$("#cartHasGoodsDiv").css({"top":"45px"});
//        	$("#myShoppingList").css({"margin":"5px auto 0"});
        	$("#yourLoveDiv").show().appendTo("#cartHasGoodsDiv");
        	$("#jieSuan").removeAttr("disabled");
        	submitJsonReturn = jsonReturn.resultData;
			drawUserInterface(jsonReturn.resultData);
		}else if(jsonReturn.resultFlag == 0 || jsonReturn.resultFlag == "0"){ // 返回数据失败
			console.log("数据返回失败");
		}else if(jsonReturn.resultFlag == 2 || jsonReturn.resultFlag == "2"){ // 暂无数据
			$("#cartNoGoodsDiv").show();
//			$("#cartNoGoodsDiv").css({"top":"45px"});
    		$("#cartHasGoodsDiv").hide();
    		$("#yourLoveDiv").show().appendTo("#cartNoGoodsDiv");
    		$("#topDelBtn").attr("disabled","disabled");
			console.log("暂无数据");
		}else if(jsonReturn.resultFlag == -1 || jsonReturn.resultFlag == "-1"){ // 发生其他错误
			console.log("发生其他错误");
		}else{ // 数据为{}
			console.log("返回的数据是这样的" + data);
		}
	});
}

/**
 * 去逛逛
 */
function goShopping(){
	$("#loginDiv").hide();
	$("#cartNoGoodsDiv").hide();
	$("#cartHasGoodsDiv").show();
	$("#yourLoveDiv").show().appendTo("#cartHasGoodsDiv");
	window.top.tabLabel(2);
}

/**
 * 绘制用户界面  ---即填充数据并显示
 * @perDataObj 每条数据
 */
function drawUserInterface(returnData){
//	returnData = returnData.concat(returnData); // 测试
	var tempGoodsNum = 0;
	$(returnData).each(function(i, n){
		tempGoodsNum = tempGoodsNum + n.goodsCount;
		var perListObj = $("#cartListTemplate").clone();
		perListObj.removeAttr("id");
		perListObj.show();
		perListObj.appendTo("#myShoppingList");	
		
		var perTotal = accurateMultiply(this.singlePrice, this.goodsCount);
		totalMoney = accurateSum(totalMoney, perTotal);
		if(n.isGift == 1){
			perListObj.find("span[data-isGift=\"isGift\"]").show();
		}
		var _img = perListObj.find("img");
		_img.attr("src",imagePath + this.img);
		perListObj.find("span[data-name=\"name\"]").html(this.goodsNickName);
		perListObj.find("span[data-perTotal=\"perTotal\"]").html(perTotal);
		perListObj.find("span[data-price=\"price\"]").html(this.singlePrice);
		perListObj.find("input[data-number=\"num\"]").val(this.goodsCount);
		
		var spanId = perListObj.find("span[data-id=\"id\"]")
		var spanGoodsPriceId = perListObj.find("span[data-goodsPriceId=\"goodsPriceId\"]")
		
		spanId.html(this.id);
		spanGoodsPriceId.html(this.goodsPriceId);
		_img.click(function(){ 
			goToGoodsDetailInterface( spanGoodsPriceId.html() );
		});
		if(i == returnData.length - 1){
			perListObj.find("table").addClass("tableBottomBorder");
		}
	});
	window.top.setGoodsCount(tempGoodsNum);
	$("#totalMoney").html(totalMoney);
}

/**
 * 删除购物车商品 
 */
function deleteCartGoods(btnElem){
	$(btnElem).attr("disabled","disabled"); // 【删除】按键不可点击
	var cartId = "";
	var ids = [];
	var tempTrArry = [];
	var checkBoxArry = [];
	
//	checkBoxArry = $("#myShoppingList").find("input[data-selected=\"selected\"]");
	checkBoxArry = $("#myShoppingList").find("span[data-selected=\"selected\"]");
	$.each(checkBoxArry , function(i, n){
//		if($(n).attr("checked") == "checked"){
		if($(n).hasClass("glyphicon-check")){
			var tempTr = $(n).parents("tr");
			tempTrArry.push(tempTr);
			cartId = tempTr.find("span[data-id=\"id\"]").html();
			ids.push(cartId);
		}
	});
	
	if(tempTrArry.length == 0){ // 购物车为【空】或【未选中任何商品】
		return;
	}
	
	var delSumNum = 0; // 删除商品的个数
	$.each(tempTrArry, function(i, n){
		delSumNum = delSumNum + $(n).find("input[data-number=\"num\"]").val();
		var plusOrMinusMoney = $(n).find("span[data-perTotal=\"perTotal\"]").html();
		var _divElem = $(n).parents("[data-div=\"div\"]");
		
//		alert(_divElem.html());
//		alert(_divElem.get(0).tagName); // 获取标签名称
		var tempId = $(n).find("span[data-id=\"id\"]").html();
		$(_divElem).slideUp("normal",function(){
			totalMoney = accurateMinus(totalMoney, plusOrMinusMoney);
			$("#totalMoney").html(totalMoney);
			if(i < tempTrArry.length - 1){
				return true; //结束each本次循环
			}
			var params = {};
			params.ids = [];
			params.ids = params.ids.concat(ids);
			params.zoneCode = window.top.zone_code;
			$.post("delCartGoods.htm",{ paraJson : JSON.stringify(params) },function(data){
				$(btnElem).removeAttr("disabled"); // 【删除】按键恢复可点击属性
				var jsonReturn = eval("(" + data + ")");
				if(jsonReturn.resultFlag == 1){ // 删除成功
					$(_divElem).remove();
					window.top.setGoodsCount(window.top.getGoodsCount() - delSumNum );
					if(window.top.getGoodsCount() ==  0){
						$("#cartNoGoodsDiv").show();
//						$("#cartNoGoodsDiv").css({"top":"45px"});
						$("#cartHasGoodsDiv").hide();
						$("#topDelBtn").attr("disabled","disabled");
					}
					$.each(submitJsonReturn, function(j, m){
						if(m.id == tempId){
							submitJsonReturn.splice(j,1);
							return false;
						}
					});
					console.log("删除成功  " + i);
					if(submitJsonReturn.length == 0){
						$("#cartHasGoodsDiv").hide();
						$("#cartNoGoodsDiv").fadeIn();
						$("#topDelBtn").attr("disabled","disabled");
						$("#jieSuan").attr("disabled","disabled");
						$("#yourLoveDiv").show().appendTo("#cartNoGoodsDiv");
					}
				}else{ // 删除失败
					$(_divElem).slideDown("normal",function(){
						totalMoney = accurateSum(totalMoney, plusOrMinusMoney) ;
						$("#totalMoney").html(totalMoney);
					});
					console.log("删除失败   " + i);
				}
			});
			
		});
	});

}


/**
 * 加订商品数量
 * @optFlag 1将与服务器交互 2临时改变不做服务器交互
 */
function plusGoodsNum(elem, optFlag){
	$(elem).attr("disabled","disabled");
	if(optFlag == 1){
		updateGoodsNum(elem, 2, 1);
	}else if(optFlag == 2){
		var numInput = $(elem).siblings("input");
		numInput.val(parseInt(numInput.val()+"") + 1);
		$(elem).removeAttr("disabled");
	}
}


/**
 * 减订商品数量 
 * @optFlag 1将与服务器交互 2临时改变不做服务器交互
 */
function minusGoodsNum(elem, optFlag){
	$(elem).attr("disabled","disabled");

	if(optFlag == 1){
		updateGoodsNum(elem, 1, 1);
	}else if(optFlag == 2){
		var numInput = $(elem).siblings("input");
		if(numInput.val() == 1){ return; }
		numInput.val(parseInt(numInput.val()) - 1);
		$(elem).removeAttr("disabled");
	}
}

/**
 * 设置商品数量的弹窗
 */
function setNumTanChuang(elem){
	inputElem = $(elem);
	$("#myModal").modal("show");
	$("#myModal").find("input").val($(elem).val());
}

/**
 * 设置批量修改的最小值
 * @param elem
 */
function setMinValue(elem){
	if($(elem).val() <= 0){
		$(elem).val(1);
	}
}

/**
 * 点击确定
 */
function confirmClick(){
	$("#myModal").modal("hide");
	var goodsNum = parseInt($(".modal-body").find("input").val());
	updateGoodsNum(inputElem, 3, goodsNum);
}


/**
 * 更新购物车商品数量  -- 供增、减调用
 * @operateFlag 1 : 减
 *               2 : 加
 *               3 : 批处理
 */
function updateGoodsNum(elem, operateFlag, gCount){
	window.top.showLoading();
	var _numInput = $(elem).parent().find("input");
	var count =  parseInt(_numInput.val() + "");
	
	if(operateFlag == 1 && count == 1 ){ // 减
		window.top.toggleLoading();
		$(elem).removeAttr("disabled");
		console.log(" 数量更新失败---->当前商品在购物车数量已达到了下限，不可继续减少！")
		return;
	}
	var spanPerTotal = $(elem).parents("table").find("span[data-perTotal=\"perTotal\"]")
	var plusOrMinusMoney = spanPerTotal.html();
	var _price = $(elem).parents("td").find("span[data-price=\"price\"]").html();
	var goodsPriceId = $(elem).parent().find("span[data-goodsPriceId=\"goodsPriceId\"]").html();

	var params = {};
	params.memberId = window.top.openId;
	params.goodsPriceId = goodsPriceId;
	params.zoneCode = window.top.zone_code;
	if(operateFlag == 3){
		params.goodsCount = gCount;
	}
	var url = "";
	switch (operateFlag){
		case 1: 	url = "reduceCartGoods.htm"; //减
					break;
		case 2: 	url = "addCart.htm"; //加
					break;
		case 3: 	url = "updateCartGoodsNum.htm"; // 批更新
					break;
	}
	$.post(url, { paraJson: JSON.stringify(params) }, function(data){
		window.top.toggleLoading();
		$(elem).removeAttr("disabled");
		var jsonReturn = eval("(" + data + ")");
		if( jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1" ){
//			var checkBoxInput =  $(elem).parents("table").find("input[data-selected=\"selected\"]");
			var checkBoxInput =  $(elem).parents("table").find("span[data-selected=\"selected\"]");
			if(operateFlag == 1 || operateFlag == "1"){ // 减
				_numInput.val(count - gCount);
				window.top.setGoodsCount(window.top.getGoodsCount() - gCount );
				spanPerTotal.html("");
				spanPerTotal.html( accurateMinus(plusOrMinusMoney, _price) );
				
//				if(checkBoxInput.attr("checked") == "checked" ){
				if(checkBoxInput.hasClass("glyphicon-check") ){
					totalMoney = accurateMinus(totalMoney, _price);
					$("#totalMoney").html(totalMoney );
				}else{
				}
				$.each(submitJsonReturn, function(i,n){
					if(n.goodsPriceId == goodsPriceId){
						n.goodsCount = n.goodsCount - gCount;
						return false;
					}
				});
			}else if(operateFlag == 2 || operateFlag == "2"){ // 加
				_numInput.val(count + gCount);
				window.top.setGoodsCount(window.top.getGoodsCount() + 1 );
				spanPerTotal.html("");
				spanPerTotal.html( accurateSum(plusOrMinusMoney, _price) );
//				if( checkBoxInput.attr("checked") == "checked" ){
				if(checkBoxInput.hasClass("glyphicon-check") ){
					totalMoney = accurateSum(totalMoney, _price);
					$("#totalMoney").html( totalMoney );
				}else{
				}
				$.each(submitJsonReturn, function(i,n){
					if(n.goodsPriceId == goodsPriceId){
						n.goodsCount = n.goodsCount + gCount;
						return false;
					}
				});
			}else if(operateFlag == 3 || operateFlag == "3"){ // 批量更新
				_numInput.val(gCount);
				window.top.setGoodsCount(window.top.getGoodsCount() + (gCount - count) );
				spanPerTotal.html("");
				spanPerTotal.html( accurateMultiply(gCount, _price));
				plusOrMinusMoney = spanPerTotal.html();
//				if( checkBoxInput.attr("checked") == "checked" ){
				if(checkBoxInput.hasClass("glyphicon-check") ){
					totalMoney = accurateSum(totalMoney, accurateMultiply(_price, gCount - count));
					$("#totalMoney").html( totalMoney );
				}else{
				}
				$.each(submitJsonReturn, function(i,n){
					if(n.goodsPriceId == goodsPriceId){
						n.goodsCount = gCount;
//						n.goodsCount = n.goodsCount + (gCount - count);
						return false;
					}
				});
			}
			console.log("数量更新成功");
		}else{
			console.log("数量更新失败---->" + jsonReturn.resultMsg);
		}
		
	});
}


/**
 * 是否全选
 */
function ifWholeChecked(elem){
	$(elem).attr("disabled","disabled");
	var selectedInput = $("#myShoppingList").find("span[data-selected=\"selected\"]");
	if(selectedInput.length == 0){
		$(elem).removeAttr("disabled");
	}
	if($(elem).hasClass("glyphicon-check")){
		$(elem).removeClass("glyphicon-check");
		$(elem).addClass("glyphicon-unchecked");
		
		$.each(selectedInput , function(i, n){
			if( $(n).hasClass("glyphicon-check")){
				$(n).removeClass("glyphicon-check");
				$(n).addClass("glyphicon-unchecked");
				totalMoney = 0;
			}else{
			}
			if(i == selectedInput.length - 1){
				$(elem).removeAttr("disabled");
			}
		});
	}else{
		$(elem).removeClass("glyphicon-unchecked");
		$(elem).addClass("glyphicon-check");
		$.each(selectedInput , function(i, n){
			if( $(n).hasClass("glyphicon-check")){
			}else{
				$(n).removeClass("glyphicon-unchecked");
				$(n).addClass("glyphicon-check");
				var tempTr = $(n).parents("tr");
				var plusOrMinusMoney = tempTr.find("span[data-perTotal=\"perTotal\"]").html();
				totalMoney = accurateSum(totalMoney, plusOrMinusMoney) ;
			}
			if(i == selectedInput.length - 1){
				$(elem).removeAttr("disabled");
			}
		});
	}
	$("#totalMoney").html(totalMoney);
}


/**
 * 是否选中商品进行结算
 */
function ifChecked(elem){
	$(elem).attr("disabled","disabled");
	var tempTr = $(elem).parents("tr");
	var plusOrMinusMoney = tempTr.find("span[data-perTotal=\"perTotal\" ]").html();
	if($(elem).hasClass("glyphicon-check")){ // 选中
		$(elem).removeClass("glyphicon-check");
		$(elem).addClass("glyphicon-unchecked");
		totalMoney = accurateMinus(totalMoney, plusOrMinusMoney);
	}else{  // 不选中
		$(elem).removeClass("glyphicon-unchecked");
		$(elem).addClass("glyphicon-check");
		totalMoney = accurateSum(totalMoney, plusOrMinusMoney);
	}
	$("#totalMoney").html( totalMoney );
	$(elem).removeAttr("disabled");
}


/**
 * 结算 
 */
function jiesuan(){
	var tempData = submitJsonReturn.concat();
//	var selectedInput = $("#myShoppingList").find("input[data-selected=\"selected\"]");
	var selectedInput = $("#myShoppingList").find("span[data-selected=\"selected\"]");
	$.each(selectedInput , function(i, n){
//		if( $(n).attr("checked") == "checked" ){
		if( $(n).hasClass("glyphicon-check")){
		}else{
			var tempVal = $(n).parents("table").find("span[data-id=\"id\"]").html();
			$.each(submitJsonReturn, function(j, m){
				if( m.id == tempVal){
					submitJsonReturn.splice(j,1);
					return false;
				}
			});
		}
	});
	if(submitJsonReturn.length == 0){
		submitJsonReturn = tempData.concat();
		$("#noSelectWarning").show();
		var timer = setInterval(function(){
			clearInterval(timer);
			$("#noSelectWarning").hide();
		},2000);
		return;
	}
	var params = {};
	params.zoneCode = window.top.zone_code;
	params.memberId = window.top.openId;
	params.shoppingCartList = [];
	$.each(submitJsonReturn,function(i,n){
		var tempParams = {};
		tempParams.id = n.id;
		params.shoppingCartList.push(tempParams);
	});
	window.location.assign( "goToMyOrderSubmit.htm?paraJson=" + JSON.stringify(params) + "&totalMoney=" + totalMoney);	
}

/**
 * 进入商品详情 
 */
function goToGoodsDetailInterface(_id){
	var params = {};
	params.id = _id;
	params.zoneCode = window.top.zone_code;
	params.memberId = window.top.openId;
	window.location.assign("mGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
}
