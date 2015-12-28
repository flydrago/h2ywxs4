/**
 * Function:分类
 */


/** 表格行元素 */
var trElem = null;
/** 选中的商品类型 */
var goodsTyId = "";
var page = 1;
var pageSize = 10;
var zoneCode = window.top.zone_code;
var imagePath = window.top.imagePath;



$(document).ready(function(){
	$(window.parent.document).find("#myTab").show();
	if(window.top.zone_code != null && window.top.zone_code != ""){
		setLeftNav();
	}
});


/**
 * 搜索框  ----去商品搜索页面
 */
function goGoodsSearchInterface(){
	window.location.assign("mGoodsSearch.htm");
}


/**
 * 设置左侧导航栏
 */
function setLeftNav(){
	var params = {};
	params.parentId = 1;
	params.zoneCode = window.top.zone_code;
	params.goodsTypeId =  0;
	params.memberId = window.top.openId;
	$.post("getGoodsTypeListData.htm", { paraJson : JSON.stringify(params) }, function(data){
//		alert(data);
		var jsonReturn = eval("(" + data + ")");
		if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){  //返回数据成功
			$.each(jsonReturn.resultData, function(i,n){
				var navPerObj = $("#left_nav_template").clone();
				navPerObj.removeAttr("id");
				navPerObj.appendTo("#left_nav");
				
				var spanGoodsType = navPerObj.find("span[data-goodsType=\"goodsType\"]");
				var spanGoodsTypeId = navPerObj.find("span[data-goodsTypeId=\"goodsTypeId\"]");
				spanGoodsType.html(n.typeName);
				spanGoodsTypeId.html(n.id);
				
				if(i == 0){
					//navPerObj.addClass("active");
					selectWineType(navPerObj);
					//$("#right_goodsType").find("span[data-goodsType=\"goodsType\"]").html(spanGoodsType.html());
					//$("#right_goodsType").find("span[data-goodsTypeId=\"goodsTypeId\"]").html(spanGoodsTypeId.html());
				}
			});
		}else{ // 返回数据失败
			console.log(jsonReturn.resultMsg);
		}
		
	});
	
}
/**
 * 选定分类   ----即点击左侧导航
 */
function selectWineType(elemDom){
	window.top.showLoading();
//	$("#bottomMoreBtn").hide();
	
	$(elemDom).find("a").tab("show");
	
	var offset = $(elemDom).find("a").offset();
	$("#selected_flag").animate({top: offset.top + 17});
	
	var spanGoodsType = $("#right_goodsType").find("span[data-goodsType=\"goodsType\"]");
	var spanGoodsTypeId = $("#right_goodsType").find("span[data-goodsTypeId=\"goodsTypeId\"]");
	
	spanGoodsType.html($(elemDom).find("span[data-goodsType=\"goodsType\"]").html());
	spanGoodsTypeId.html($(elemDom).find("span[data-goodsTypeId=\"goodsTypeId\"]").html());
	
	$("#right_goodsType").hide();
	$("#contentDiv").css({"top":"45px","padding-top":"10px"});
	
	$("#goods_table").empty();
	$("#secSortDiv").empty();
	getGoodsList(page, pageSize, zoneCode, spanGoodsTypeId.html());
}


/**
 * 去商品列表界面   ----即点击右侧酒种
 */
function goGoodsListInterface(elemDom){
	
	$("#goods_table").show();
	
//	var spanGoodsTypeId = $(elemDom).find("span[data-goodsTypeId=\"goodsTypeId\"]");
	
	var params = {};
//	params.goodsTypeId = spanGoodsTypeId.html();
	params.goodsTypeId = goodsTyId;
	params.zoneCode = zoneCode;
	
	var markId = $(elemDom).attr("data-markId");
	var markInfoId = $(elemDom).attr("data-markInfoId");
	if(markId != null && markId != "undefined" && markId != "" 
		&& markInfoId != null && markInfoId != "undefined" && markInfoId != ""){
		params.markId = markId;
		params.markInfoId = markInfoId;
		params.keyWords = $(elemDom).html();
	}
	window.location.assign("mGoodsList.htm?paraJson=" + JSON.stringify(params) );
}


/**
 * 获取列表 
 */
function getGoodsList(_page, _pageSize, _zone_code, _typeId){
	
	goodsTyId = _typeId;
	var params = {};
	params.parentId = 1;
	params.goodsTypeId = _typeId;
	params.page = _page;
	params.pagesize = _pageSize;
	params.zoneCode = _zone_code;
	params.memberId = window.top.openId;
	
	$.post("getSelfGoodsList.htm",{ paraJson:JSON.stringify(params) }, function (data) {
//		alert(data);
		window.top.toggleLoading();
        var jsonReturn = eval("(" + data + ")");
        if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){ // 返回数据成功
        	//if(_typeId == -1){
        		$("#goods_table").show();
        		$("#secSortDiv").hide();
        		drawUserInterface(jsonReturn.resultData);
        	/*}else{
        		$("#goods_table").hide();
        		$("#secSortDiv").show();
        		drawUserInterface2(jsonReturn.resultData);
        	}*/
		}else if(jsonReturn.resultFlag == 0 || jsonReturn.resultFlag == "0"){ // 返回数据失败
			console.log(jsonReturn.resultMsg);
		}else if(jsonReturn.resultFlag == 2 || jsonReturn.resultFlag == "2"){ // 暂无数据
			$("#noMoreDataWarning").html(jsonReturn.resultMsg).show();
    		var timer = setInterval(function(){
    			clearInterval(timer);
    			$("#noMoreDataWarning").hide();
    		},2000);
			console.log(jsonReturn.resultMsg);
		}else if(jsonReturn.resultFlag == -1 || jsonReturn.resultFlag == "-1"){ // 发生其他错误
			console.log(jsonReturn.resultMsg);
		}else{ // 数据为{}
			console.log("商品返回的数据是这样的" + data);
		}
		
    });
}

/**
 * 绘制用户界面  ---即填充数据并显示
 * @perDataObj 每条数据
 */
function drawUserInterface(returnData){
	
//	returnData.splice(1,returnData.length-1); // 测试
	$(returnData).each(function(i,n){
		
		var perLineElemBlock = $("#line_two_template").clone();
		perLineElemBlock.removeAttr("id");
		
		if(n.isActivity == 1 || n.isActivity == "1"){
			perLineElemBlock.find("div[data-privilege=\"huoDongOrCuXiao\"]").show();
		}
//		alert(imagePath + n.img);
		perLineElemBlock.find("img").attr("src",imagePath + n.img);
		perLineElemBlock.find("textarea[data-name=\"name\"]").html(n.goodsNickName);
		
		var spanId = perLineElemBlock.find("span[data-id=\"id\"]");
		var spanGoodsSinglePrice = perLineElemBlock.find("span[data-goodsSinglePrice=\"goodsSinglePrice\"]");
		
		spanId.html(n.id);
		spanGoodsSinglePrice.html(n.singlePrice.toFixed(2));
		
		perLineElemBlock.click(function(){ 
			
			goToGoodsDetailInterface( spanId.html()) ;
		});
		
		if(i % 2 == 0){
			
			trElem = $(document.createElement("tr"));
//			trElem.css("width","100%");
			perLineElemBlock.appendTo(trElem);
			trElem.appendTo("#goods_table");
		}else if(i % 2 == 1){
			
			perLineElemBlock.removeClass("tdRightBorder");
			perLineElemBlock.appendTo(trElem);
		}
		
	});
	
	if(returnData.length == 1){
		
		var perLineElemBlock = $("#line_two_empty_template").clone();
		perLineElemBlock.appendTo(trElem);
	}
	
//	if(returnData.length < pageSize){
//		$("#bottomMoreBtn").hide();
//	}else{
//		$("#bottomMoreBtn").show();
//	}
	
}

/**
 * 绘制用户界面
 * @param returnData
 */
function drawUserInterface2(returnData){
	$(returnData).each(function(i,n){
		
		$("#secSortDiv").append("<p style=\"text-align:left;margin:10px 2px 5px;\">" + n.mark_name + "</p>");
		var tableStr = "<table style=\"width:100%;table-layout:fixed;\">";
		$.each(n.markInfoList,function(j,m){
			if(j % 3 == 0){
				tableStr = tableStr + "<tr>";
			}
			if(n.is_show_img == 0){
				tableStr = tableStr + "<td onclick=\"goGoodsListInterface(this)\"" 
				+ " data-markId=\"" + m.mark_id + "\"" 
				+ " data-markInfoId=\"" + m.mark_info_id + "\""
				+ " class=\"oneLineWordsShow\" style=\"border:1px solid #e7e7e7;padding:10px;\">" + m.name + "</td>";
			}else if(n.is_show_img == 1){
				tableStr = tableStr + "<td onclick=\"goGoodsListInterface(this)\"" 
				+ " data-markId=\"" + m.mark_id + "\"" 
				+ " data-markInfoId=\"" + m.mark_info_id + "\""
				+ " class=\"oneLineWordsShow\" style=\"border:1px solid #e7e7e7;padding:10px;\">" 
				+ " <img src=\""  +imagePath + m.img + "?bn=fileDataService&id=89745\" width=\"100%\"/><p>" + m.name + "</p></td>";//?bn=fileDataService&id=52433  ?bn=fileDataService&id=89745
			}
			if(j % 3 == 2){
				tableStr = tableStr + "</tr>";
			}
			if(j == n.markInfoList.length - 1){
				if(j % 3 != 2){
					tableStr = tableStr + "</tr>";
				}
				tableStr = tableStr + "</table>";
			}
		});
		$("#secSortDiv").append(tableStr);
	});
}


/**
 * 进入商品详情 
 */
function goToGoodsDetailInterface(_id){
	var params = {};
	params.id = _id;
	params.zoneCode = window.top.zone_code;
	params.memberId = window.top.openId;
	window.location.assign( "mGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
}


/**
 * 查看更多 
 */
function lookMoreGoods(elem){
	$(elem).attr("disabled","disabled");
	window.top.showLoading();
	page++;
	getGoodsList(page, pageSize, zoneCode, goodsTyId);
}


