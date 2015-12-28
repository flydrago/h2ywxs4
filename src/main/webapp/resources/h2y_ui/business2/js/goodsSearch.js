/**
 * Function:搜索列表
 */

/** 轮播总长度 */
var carouselTotalLength = 0;

/** 轮播显示个数 */
var _items=0;

/** 轮播的边距 */
var _margin = 10;

///** showStyle 显示类型  1 列表 2表格 */
//var showStyle = 1;

/** 搜索关键字 */
var keyWords = "";

/** 返回的列表数据集合 */
var returnDataAll = []; 
/** 热门搜索数据 */
var hotSearchData = [];

/**
 * 返回上一页   
 */
function _goBack(){
	window.history.back();
}


/**
 * 搜索框获取焦点
 */
function searchInputGetFocus(){
	$("#searchGoodsList").hide();
}

/**
 * 搜索商品 模糊查询 -----即点击搜索按钮
 */
function searchGoods(){
	
	page = 1;
	var temp = $("#searchContent").val();
	
	if(keyWords == temp &&  keyWords != ""){
		$("#searchGoodsList").show();
		$("#goods_table").empty();
		drawUserInterface(returnDataAll);
		return;
	}else{
		
		keyWords = temp;
	}
	
	if(keyWords == ""){
		
		$("#warmTipWarning").show();
		$("#warmTipWarning").find("span").html("请输入搜索内容");
		var timer = setInterval(function(){
			clearInterval(timer);
			$("#warmTipWarning").hide();
		},2000);
		return;
	}else{
		$("#searchGoodsList").show();
		
		$("#goods_table").empty();
		returnDataAll.splice(0, returnDataAll.length);
		
		getGoodsList(page, pageSize, zoneCode, keyWords);
	}
}

/**
 * 获取热门搜索列表
 */
function getHotList(){
	
	var params = {};
	params.mainCode = "topSearch";
	params.zoneCode = window.top.zone_code;
	
	$.post("getHotSearchList.htm",{paraJson: JSON.stringify(params)}, function(data){
//		alert(data);
		var jsonReturn = eval("(" + data + ")");
        
        if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){ // 返回数据成功
        	hotSearchData = jsonReturn.resultData;
        	adCarousel(hotSearchData);
		}else if(jsonReturn.resultFlag == 0 || jsonReturn.resultFlag == "0"){ // 返回数据失败
			console.log("数据返回失败");
		}else if(jsonReturn.resultFlag == 2 || jsonReturn.resultFlag == "2"){ // 暂无数据
			console.log("暂无数据");
		}else if(jsonReturn.resultFlag == -1 || jsonReturn.resultFlag == "-1"){ // 发生其他错误
			console.log("发生其他错误");
		}else{ // 数据为{}
			console.log("返回的数据是这样的" + data);
		}
	});
}


/**
 * 获取列表 
 */
function getGoodsList(_page, _pageSize, _zone_code, _keyWords){
	window.top.showLoading();
	var params = {};
	params.page = _page;
	params.pagesize = _pageSize;
	params.zoneCode = _zone_code;
	params.keyWord = _keyWords
	
	$.post("getSelfGoodsList.htm",{paraJson:JSON.stringify(params)}, function (data) {
		window.top.toggleLoading();
//		alert(data);
		$("#bottomMoreBtn").removeAttr("disabled");
        var jsonReturn = eval("(" + data + ")");
        
        if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){ // 返回数据成功
//        	$("#bottomMoreBtn").show();
        	if(jsonReturn.resultData.length < pageSize && page >= 1){
        		$("#bottomMoreBtn").hide();
        		$("#searchGoodsList").unbind("scroll");
        		if(page > 1){
        			/*$("#noMoreDataWarning").show();
        			var timer = setInterval(function(){
        				clearInterval(timer);
        				$("#noMoreDataWarning").hide();
        			},2000);*/
        		}
        	}
        	returnDataAll = returnDataAll.concat(jsonReturn.resultData);
			drawUserInterface(jsonReturn.resultData);
		}else if(jsonReturn.resultFlag == 0 || jsonReturn.resultFlag == "0"){ // 返回数据失败
			
			$("#bottomMoreBtn").hide();
			$("#searchGoodsList").unbind("scroll");
    		/*$("#noMoreDataWarning").html("商品数据返回失败").show();
    		var timer = setInterval(function(){
    			clearInterval(timer);
    			$("#noMoreDataWarning").hide();
    		},2000);*/
    		
			console.log("商品数据返回失败");
		}else if(jsonReturn.resultFlag == 2 || jsonReturn.resultFlag == "2"){ // 暂无数据
			$("#searchGoodsList").unbind("scroll");
			$("#bottomMoreBtn").hide();
			
    		/*$("#noMoreDataWarning").html("商品暂无数据").show();
    		var timer = setInterval(function(){
    			clearInterval(timer);
    			$("#noMoreDataWarning").hide();
    		},2000);*/
    		
			console.log("商品暂无数据");
		}else if(jsonReturn.resultFlag == -1 || jsonReturn.resultFlag == "-1"){ // 发生其他错误
			$("#bottomMoreBtn").hide();
			$("#searchGoodsList").unbind("scroll");
    		$("#noMoreDataWarning").html("商品发生其他错误").show();
    		var timer = setInterval(function(){
    			clearInterval(timer);
    			$("#noMoreDataWarning").hide();
    		},2000);
    		
			console.log("商品发生其他错误");
		}else{ // 数据为{}
			$("#searchGoodsList").unbind("scroll");
			console.log("商品返回的数据是这样的" + data);
		}
    });
}

/**
 * 绘制用户界面  ---即填充数据并显示
 * @perDataObj 每条数据
 * @showStyle 显示类型  1 列表 2表格
 */
function drawUserInterface(returnData){
	if(returnData.length == 0){
		$("#searchGoodsList").hide();
		$("#warmTipWarning").show();
		$("#warmTipWarning").find("span").html("抱歉，暂无数据！");
		return;
	}
	
	$(returnData).each(function(i,n){
		var perLineElemBlock = null;
		perLineElemBlock = $("#line_one_template").clone();
		perLineElemBlock.removeAttr("id");
		
		if(n.isActivity == 1 || n.isActivity == "1"){
			perLineElemBlock.find("span[data-priceName=\"priceName\"]").html("活动价:");
			perLineElemBlock.find("div[data-privilege=\"huoDongOrCuXiao\"]").show();
		}else{
			perLineElemBlock.find("span[data-priceName=\"priceName\"]").html("会员价:");
		}
		
		perLineElemBlock.find("img").attr("src",imagePath + n.img);
//		perLineElemBlock.find("h4").html(n.goodsName);
		perLineElemBlock.find("p[data-name=\"name\"]").html(n.goodsName);
		perLineElemBlock.find("span[data-price='single']").html(n.singlePrice);
		perLineElemBlock.find("span[data-price='market']").html(n.marketPrice);

		var spanId = perLineElemBlock.find("span[data-id=\"id\"]");
		spanId.html(n.id);
		
		perLineElemBlock.click(function(){
			goToGoodsDetailInterface( spanId.html()) ;
		});
		perLineElemBlock.appendTo("#goods_table");
	});
	
	if(returnData.length < pageSize){
		$("#bottomMoreBtn").hide();
		$("#searchGoodsList").unbind("scroll");
	}else{
		$("#bottomMoreBtn").show();
		$("#searchGoodsList").bind("scroll",function(){
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
	window.location.assign("mGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
}


/**
 * 查看更多 
 */
function lookMoreGoods(elem){
	$(elem).attr("disabled","disabled");
	page++;
	getGoodsList(page, pageSize, zoneCode, keyWords);
}


/**
 * 解决点击回车搜索的功能
 */
$(window).keydown(function(event){
	if(event.keyCode == 13) {
		searchGoods();
	}
});