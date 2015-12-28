/**
 * Function: 广告栏位对应的商品列表
 */

var page = 1;		
var pageSize = 10;
var listContr = [];

/** showStyle 显示类型  1 列表 2表格 */
var showStyle = 1;

/** 表格行元素 */
var trElem = null;

/** 返回的列表数据集合 */
var returnDataAll = []; 


/**
 * 返回上一页   
 */
function _goBack(){
	window.top.toggleLoading();
	window.history.back();
}


/**
 * 列表显示样式切换
 */
function switListOrGridStyle(){
	
	$("#list_show").toggle();
	$("#grid_show").toggle();
	
	//切换表格和列表的展示效果
	if(showStyle == 1){
		showStyle = 2;
	}else if(showStyle == 2){
		showStyle = 1;
	}
	
	$("#adGoods_table").empty();
	drawUserInterface(returnDataAll);
}


/**
 * 获取列表 
 */
function getAdPerBannerGoodsList(_page, _pageSize, _bannerId){
	window.top.showLoading();
	var params = {};
	params.zoneCode = window.top.zone_code;
	params.id = _bannerId;
	params.page  = _page;
	$.post("goToPerBannerListData.htm", { paraJson : JSON.stringify(params) }, function(data){
		window.top.toggleLoading();
//		alert(data);
		var jsonReturn = eval("(" + data + ")");
		if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){ // 返回数据成功
			if(jsonReturn.resultData.length < pageSize && page >= 1){
        		$("#bottomMoreBtn").hide();
        		if(page > 1){
        			$("#noMoreDataWarning").show();
        			var timer = setInterval(function(){
        				clearInterval(timer);
        				$("#noMoreDataWarning").hide();
        			},2000);
        		}
        	}
			returnDataAll = returnDataAll.concat(jsonReturn.resultData);
			drawUserInterface(jsonReturn.resultData);
		}else if(jsonReturn.resultFlag == 0 || jsonReturn.resultFlag == "0"){ // 返回数据失败
			console.log("广告栏位数据返回失败");
		}else if(jsonReturn.resultFlag == 2 || jsonReturn.resultFlag == "2"){ // 暂无数据
			$("#bottomMoreBtn").hide();
    		$("#noMoreDataWarning").html("广告栏位暂无数据").show();
    		var timer = setInterval(function(){
    			clearInterval(timer);
    			$("#noMoreDataWarning").hide();
    		},2000);
			console.log("广告栏位暂无数据");
		}else if(jsonReturn.resultFlag == -1 || jsonReturn.resultFlag == "-1"){ // 发生其他错误
			console.log("广告栏位发生其他错误");
		}else{ // 数据为[]
			$("#contentDiv").unbind("scroll");
			console.log("广告栏位返回的数据是这样的" + data);
		}
		
	});
	
}

/**
 * 绘制用户界面  ---即填充数据并显示
 * @perDataObj 每条数据
 * @showStyle 显示类型  1 列表 2表格
 */
function drawUserInterface(returnData){
	
//	returnData = returnData.splice(0,1); // 测试
	$(returnData).each(function(i,n){
		var perLineElemBlock = null;
		if(showStyle == 1){
			perLineElemBlock = $("#line_one_template").clone();
		}else if(showStyle == 2){
			perLineElemBlock = $("#line_two_template").clone();
		}
		perLineElemBlock.removeAttr("id");
		if(n.isActivity == 1 || n.isActivity == "1"){
			perLineElemBlock.find("span[data-priceName=\"priceName\"]").html("活动价:");
			perLineElemBlock.find("div[data-privilege=\"huoDongOrCuXiao\"]").show();
		}else{
			perLineElemBlock.find("span[data-priceName=\"priceName\"]").html("会员价:");
		}
		if(n.isGift == 1){
			perLineElemBlock.find("span[data-isGift=\"isGift\"]").show();
			
		}
		perLineElemBlock.find("img").attr("src",imagePath + n.img);
		perLineElemBlock.find("p[data-name=\"name\"]").html(n.goodsName);
//		perLineElemBlock.find("h4").html(n.goodsName);
		perLineElemBlock.find("span[data-price=\"single\"]").html(n.memberPrice.toFixed(2));
		perLineElemBlock.find("span[data-price=\"market\"]").html(n.marketPrice.toFixed(2));
		
		var spanId = perLineElemBlock.find("span[data-id=\"id\"]");
		spanId.html(n.id);
		
		perLineElemBlock.click(function(){ 
			goToGoodsDetailInterface( spanId.html()) ;
		});
		
		
		if(showStyle == 1){//列表样式
			perLineElemBlock.appendTo("#adGoods_table");
		}else if(showStyle == 2){//表格样式
			if(i % 2 == 0){
				trElem = $(document.createElement("tr"));
				trElem.css("width","100%");
				perLineElemBlock.appendTo(trElem);
				trElem.appendTo("#adGoods_table");
			}else if(i % 2 == 1){
				perLineElemBlock.removeClass("tdRightBorder");
				perLineElemBlock.appendTo(trElem);
			}
		}
	});
	
	if(returnData.length == 1 && showStyle == 2){
		var perLineElemBlock = $("#line_two_empty_template").clone();
		perLineElemBlock.appendTo(trElem);
	}
	
	if(returnData.length < pageSize){
		$("#bottomMoreBtn").hide();
		$("#contentDiv").unbind("scroll");
	}else{
		$("#bottomMoreBtn").show();
		$("#contentDiv").bind("scroll",function(){
			lookMoreGoods();
		});
	}
	
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


/**
 * 查看更多 
 */
function lookMoreGoods(){
	page++;
	getAdPerBannerGoodsList( page, pageSize, bannerId);
}

