/**
 * Function: 促销商品对应的商品列表
 */

//var listContr = [];

/** showStyle 显示类型  1 列表 2表格 */
var showStyle = 1;

/** 表格行元素 */
var trElem = null;

/** 返回的列表数据集合 */
var returnDataAll = []; 

/** 价格排序升、降图标显示标示 0 升序 1 降序 */
var upOrDownFlag = 0;

/**
 * 返回上一页   
 */
function _goBack(){
	window.top.toggleLoading();
	window.history.back();
}


/**
 * 搜索框
 */
function goGoodsSearchInterface(){
	window.location.assign("mGoodsSearch.htm");
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
	
	$("#goods_table").empty();
	drawUserInterface(returnDataAll);
}


/**
 * 切换综合、价格、销量
 * @tdIndex 1 综合 2 价格 3 销量
 * 单词注释: Synthesis 综合 Syn    Price 价格 Pri   Sales 销量 Sal   switch 切换 swit
 */
function switSynOrPriOrSal(tdElem, tdIndex){
	
	var brotherElemArry =  $(tdElem).siblings().not( $(tdElem) );
	
	$(tdElem).find("div").css("visibility","visible");
	$.each(brotherElemArry, function(i,n){ // 隐藏同级的其他元素内部的div
		
		$(n).find("div").css("visibility","hidden");
	});
	
	page = 1;
	$("#goods_table").empty();
	returnDataAll.splice(0, returnDataAll.length);
	
	if(tdIndex == 1){ // 综合  ----此处实现综合排序请求
		rankType = 0;
		$("#price_icon").css("visibility","hidden");// 价格图标隐藏
		getGoodsList(page, pageSize, zone_code, dataId, dataType, rankType);
	}else if(tdIndex == 2){ // 价格
		
		$("#price_icon").css("visibility","visible");
		
		if( upOrDownFlag % 2 == 0 ){ // 升序   ----此处实现价格升序请求
			
			rankType = 10;
			getGoodsList(page, pageSize, zone_code, dataId, dataType, rankType);
			
			upOrDownFlag++;
			$("#price_icon").removeClass("glyphicon-menu-down");
			$("#price_icon").addClass("glyphicon-menu-up");
			
			
		}else if( upOrDownFlag % 2 == 1 ){ // 降序 ----此处实现价格降序请求
			
			rankType = 11;
			getGoodsList(page, pageSize, zone_code, dataId, dataType, rankType);
			
			upOrDownFlag = 0;
			$("#price_icon").removeClass("glyphicon-menu-up");
			$("#price_icon").addClass("glyphicon-menu-down");
		}
		
	}else if(tdIndex == 3){ // 销量   ----此处实现销量排序请求
		
		$("#price_icon").css("visibility","hidden");// 价格正序图标隐藏
		
		rankType = 2;
		getGoodsList(page, pageSize, zone_code, dataId, dataType, rankType);
	}
	
}


/**
 * 获取列表 
 */
function getGoodsList(_page, _pageSize, _zone_code, _id, _typeId, _rankType){
	window.top.showLoading();
	var params = {};
	params.dataId = _id; 
	params.dataType = _typeId;
	params.page = _page;
	params.pagesize = _pageSize;
	params.zoneCode = _zone_code;
	
	switch(rankType){
	
		case 0: 	break; 	// 综合(默认)
		
		case 10:	params.sortname = "price" ;	//	价格升序
					params.sortorder = "asc";
					break;
					
		case 11:	params.sortname = "price" ; // 价格降序
					params.sortorder = "desc";
					break;
					
		case 2:		params.sortname = "sellRate" ; // 销量降序
					params.sortorder = "desc";
					break;
					
		default: 	break;
	}
	
	
	$.post("goToActivityGoodsListData.htm",{ paraJson : JSON.stringify(params) }, function (data) {
		window.top.toggleLoading();
        var jsonReturn = eval("(" + data + ")");
        
        if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){ // 返回数据成功
        	if(jsonReturn.resultData.length < pageSize && page > 1){
        		$("#bottomMoreBtn").hide();
        		$("#noMoreDataWarning").show();
        		var timer = setInterval(function(){
        			clearInterval(timer);
        			$("#noMoreDataWarning").hide();
        		},2000);
        		return;
        	}
        	
			returnDataAll = returnDataAll.concat(jsonReturn.resultData);
			drawUserInterface(jsonReturn.resultData);
		}else if(jsonReturn.resultFlag == 0 || jsonReturn.resultFlag == "0"){ // 返回数据失败
			console.log("促销商品数据返回失败");
		}else if(jsonReturn.resultFlag == 2 || jsonReturn.resultFlag == "2"){ // 暂无数据
			$("#noMoreDataWarning").html("促销商品暂无数据").show();
    		var timer = setInterval(function(){
    			clearInterval(timer);
    			$("#noMoreDataWarning").hide();
    		},2000);
			console.log("促销商品暂无数据");
		}else if(jsonReturn.resultFlag == -1 || jsonReturn.resultFlag == "-1"){ // 发生其他错误
			console.log("促销商品发生其他错误");
		}else{ // 数据为{}
			console.log("促销商品返回的数据是这样的" + data);
		}
		
    });
}

/**
 * 绘制用户界面  ---即填充数据并显示
 * @perDataObj 每条数据
 * @showStyle 显示类型  1 列表 2表格
 */
function drawUserInterface(returnData){
	
//	var temp = returnData.concat();
//	returnData = returnData.concat(returnData,temp);
	
	if(returnData.length == 0){
		
		$("#listDataDiv").hide();
		$("#rankTypediv").hide();
		$("#noDataDiv").show();
		$("#noDataDiv").find("span").html("抱歉，暂无数据！");
		return;
	}
	
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
			perLineElemBlock.find("span[data-priceName=\"priceName\"]").html("市场价:");
		}
		
		if(n.isGift == 1){
			
			perLineElemBlock.find("span[data-isGift=\"isGift\"]").show();
		}
		
		perLineElemBlock.find("img").attr("src",imagePath + n.img);
//		perLineElemBlock.find("h4").html(n.goodsName);
		perLineElemBlock.find("p[data-name=\"name\"]").html(n.goodsName);
		perLineElemBlock.find("span[data-price=\"single\"]").html(n.singlePrice.toFixed(2));
		perLineElemBlock.find("span[data-price=\"market\"]").html(n.marketPrice.toFixed(2));

		var spanId = perLineElemBlock.find("span[data-id=\"id\"]");
		
		spanId.html(n.id);
		
		perLineElemBlock.click(function(){ 
			goToGoodsDetailInterface( spanId.html()) ;
		});
		
		if(showStyle == 1){//列表样式
			
			perLineElemBlock.appendTo("#goods_table");
		}else if(showStyle == 2){//表格样式
			
			if(i % 2 == 0){
				
				trElem = $(document.createElement("tr"));
				trElem.css("width","100%");
				perLineElemBlock.appendTo(trElem);
				trElem.appendTo("#goods_table");
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
	}else{
		$("#bottomMoreBtn").show();
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
	getGoodsList(page, pageSize, zone_code, dataId, dataType, rankType);
}

