/**
 * Author:Mr.Lu
 * Function:商品详情
 * DateTime: 2015年3月31日 17:45:43
 */


var addCartGoodsNum = 0;
var unLoginCartGoodsNum = 0;

var uiPath = window.top.uiPath;	
var imagePath = window.top.imagePath;
var zoneCode = window.top.zone_code;

var goodsDetailData;
var goodsDetailDataJo;

var ggClickFlag = 0;

//var clientWidth = document.documentElement.clientWidth || document.body.clientWidth;
//var clientHeight = document.documentElement.clientHeight || document.body.clientHeight;

$(document).ready(function(){
	$(window.parent.document).find("#myTab").hide();
	goodsDetailData = $("#goodsDetailData").val();
//	alert(goodsDetailData);
	goodsDetailDataJo = eval("("+goodsDetailData+")");
	if(goodsDetailDataJo.resultData == ""){
		return;
	}
	adCarousel(goodsDetailDataJo.resultData.imgs);

	if(goodsDetailDataJo.resultData.isFocus == 0 || goodsDetailDataJo.resultData.isFocus == "0"){
		$("#unCareBtn").show();
		$("#alreadyCareBtn").hide();
	}else if(goodsDetailDataJo.resultData.isFocus == 1 || goodsDetailDataJo.resultData.isFocus == "1"){
		$("#unCareBtn").hide();
		$("#alreadyCareBtn").show();
	} 
	
	if(goodsDetailDataJo.resultData.giftList.length > 0){
		$(".giftInfo").show();
		drawGiftListUI(goodsDetailDataJo.resultData.giftList);
	}
	
	if(goodsDetailDataJo.resultData.goods.isActivity == 1){
		$(".activityInfo").show();
	}else{
		$(".activityInfo").hide();
	}
	
	//关注商品活动详情
	$(".activityInfo").click(function(){
		$(".detail-focus-liquor-li").slideToggle();
	});
	
	$(".liquor-introduce").click(function(){
		$(".detail-focus-liquor-intro").slideToggle();
	});
	
	// 赠品
	$(".giftInfo").click(function(){
		$(".giftInfo-liquor-li").slideToggle();
	});
	
	$(".guige").click(function(){
		
		if(ggClickFlag == 0){
			getRelationList();
		}else{
			$(".guigeli").slideToggle();
		}
		ggClickFlag++;
	});
});


/**
 * 返回 
 */
function _goBack(){
	window.history.back();
}


/**
 * 广告轮播   ----此处用于显示商品图片
 */
function adCarousel(imgArr){
	$.each(imgArr, function(i, n){
		var carouselObj = $("#owl-carousel-template").clone();
		carouselObj.removeAttr("id");
		carouselObj.find("img").attr("src", imagePath + n.img);
		carouselObj.appendTo("#owl-carousel-show");
		carouselObj.show();
	});

	var dataLength = imgArr.length;	// 轮播广告个数
	
	if( dataLength >= 1 ){
		
//		$(".owl-carousel").css("width", clientWidth + "px");
		$("#owl-carousel-show").show();
		$("#owl-carousel-show").owlCarousel({
			items:1,
			loop: dataLength > 1 ? true : false   // 一张图片时loop不能为true,否则会报错
		});
	}
}


/**
 * 获取商品规格列表 
 */
function getRelationList(){
	
	var params = {};
	params.goodsPriceId = goodsDetailDataJo.resultData.goods.id;
	params.zoneCode = window.top.zone_code;
	$.post("cmbs/goods/getRelationList.htm",{postData:JSON.stringify(params)}, function (data) {
//		alert(data);
		var jsonReturn = eval("(" + data + ")");

		if(jsonReturn.resultFlag == 1){
			drawGuiGeListUI(jsonReturn.resultData);
		}else{
			ggClickFlag = 0;
			$(".guigeli").slideToggle();
			$(".guigeli div div").show();
			
			console.log(jsonReturn.resultFlag + "--->" + jsonReturn.resultMsg);
		}
	});
		
}


/**
 * 关注商品
 */
function goCareGoodsOpt(){
	
	var params = {};
	params.focusType = 0;
	params.memberId = window.top.openId;
	params.zoneCode = window.top.zone_code;
	params.goodsPriceId = goodsDetailDataJo.resultData.goods.id;
	params.unitId = "";
	$.post("goAddCareGoods.htm", {paraJson: JSON.stringify(params)}, function(data){
		
		var jsonReturn = eval("(" + data + ")");
		if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1" ){
			
			$("#unCareBtn").hide();
			$("#alreadyCareBtn").show();
			console.log(jsonReturn.resultMsg);
		}else if(jsonReturn.resultFlag == 0 || jsonReturn.resultFlag == "0"){
			
			console.log(jsonReturn.resultMsg);
			$("#unCareBtn").hide();
			$("#alreadyCareBtn").show();
		}
		
	});
}

/**
 * 取消关注商品
 */
function goUnCareGoodsOpt(){
	
	$("#unCareBtn").toggle();
	$("#alreadyCareBtn").toggle();
	var params = {};
	params.focusType = 0;
	params.memberId = window.top.openId;
	params.goodsPriceId = goodsDetailDataJo.resultData.goods.id;
	params.zoneCode = window.top.zone_code;
	
	$.post("goCancelCareGoods.htm", {paraJson:JSON.stringify(params)}, function(data){
		
		var jsonReturn = eval("(" + data + ")");
		if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1" ){
			$("#unCareBtn").show();
			$("#alreadyCareBtn").hide();
			console.log(jsonReturn.resultMsg);
		}
	});
}


/**
 * 赠品列表
 */
function drawGiftListUI(giftAttr){
	
	$.each(giftAttr,function(i,n){
		
		var perLineBlock = $("#line_one_template").clone();
		perLineBlock.removeAttr("id");
		perLineBlock.appendTo(".giftInfo-liquor-li table");
		
		perLineBlock.find("img").attr("src", imagePath + n.img);
		perLineBlock.find("span[data-name=\"name\"]").html(n.goodsNickName);
		perLineBlock.find("span[data-price=\"single\"]").html(n.singlePrice);
		perLineBlock.find("span[data-number=\"num\" ]").html(n.goodsCount);
		perLineBlock.find("span[data-perTotal=\"perTotal\"]").html(accurateMultiply(n.singlePrice,n.goodsCount));
		var spanId = perLineBlock.find("span[data-id=\"id\"]");
		spanId.html(n.id);
		perLineBlock.click(function(){
			goToGoodsDetailInterface(spanId.html());
		});
		if(i == giftAttr.length - 1){
			perLineBlock.removeClass("tableBottomBorder");
		}
	});
}


/**
 * 赠品列表
 */
function drawGuiGeListUI(ggAttr){
	$(".guigeli table").empty();
	$.each(ggAttr,function(i,n){
		
		var perLineBlock = $("#line_one_template").clone();
		perLineBlock.removeAttr("id");
		perLineBlock.appendTo(".guigeli table");
		
		perLineBlock.find("img").attr("src", imagePath + n.img);
		perLineBlock.find("span[data-name=\"name\"]").html(n.goodsNickName);
		perLineBlock.find("span[data-price=\"single\"]").html(n.singlePrice);
		perLineBlock.find("span[data-number=\"num\" ]").html(n.goodsCount);
		perLineBlock.find("span[data-perTotal=\"perTotal\"]").html(accurateMultiply(n.singlePrice,n.goodsCount));
		var spanId = perLineBlock.find("span[data-id=\"id\"]");
		spanId.html(n.id);
		perLineBlock.click(function(){
			goToGoodsDetailInterface(spanId.html());
		});
		if(i == ggAttr.length - 1){
			perLineBlock.removeClass("tableBottomBorder");
		}
	});
	$(".guigeli").slideToggle();
}


/**
 * 进入商品详情 
 */
function goToGoodsDetailInterface(_id){
	var params = {};
	params.id = _id;
	params.memberId = window.top.openId;
	params.zoneCode = window.top.zone_code;
	window.location.assign("mGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
}


/**
 * 加入购物车 
 */
function addToShoppingCart(elem){
	$(elem).attr("disabled","disabled");
	var params = {};
	params.memberId = window.top.openId;
	params.goodsPriceId = goodsDetailDataJo.resultData.goods.id;
	params.zoneCode = window.top.zone_code;
	
	$.post("addCart.htm", { paraJson : JSON.stringify(params) }, function(data){
		$(elem).removeAttr("disabled");
		var jsonReturn = eval("(" + data + ")");
		if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1" ){ // 添加购物车成功
			addCartGoodsNum = addCartGoodsNum + 1;
			$("#addCartGoodsNum").css({"visibility": "visible"});
			$("#addCartGoodsNum").find("span[data-addNum=\"addNum\"]").html(addCartGoodsNum);
			window.top.setGoodsCount(parseInt(window.top.getGoodsCount()) + 1);
		}
	});
	
}



/**
 * 去结算  ----点击购物车图标进入【购物车】
 */
function goToPayMoney(){
	window.top.tabLabel(4);//跳转购物车页面
}
