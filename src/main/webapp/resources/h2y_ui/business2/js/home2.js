/**
 * Function:首页
 */


/** 表格行元素 */
var trElem = null;
/** 地理位置层次化结构 */
var addressComp = null;
var flagSetFlag = 0;
var page = 1;
var uiPath = window.top.uiPath;
var zoneCode = window.top.zone_code;
/** 图片标签加载完成的标志 */
/** 测试中文字符的正则 */
var chinaReg=/[\u4E00-\u9FA5]/g;

$(document).ready(function(){
    $(window.parent.document).find("#myTab").show();
    setCity(localStorage.getItem("wechatshop_user_zoneCode"));
});

/**
 * 搜索框
 */
function goGoodsSearchInterface(){
	window.location.assign("mGoodsSearch.htm");
}

/**
 * 回到顶部
 */
function goToTop(){
	$("#contentDiv").animate({scrollTop:0},500);
}

/**
 * 设置城市 
 */
function setCity(_code){
	_code = "cs2";
	window.top.saveZoneCode(_code);
	window.top.setZoneCode(_code);
	$("#zoneCode").html(_code);
	$("#contentDiv").empty();
    adCarousel(); // 广告栏位
	getPublicServiceList(); // 分类
	getCommonActivityList(); // 促销活动
}

/**
 *  广告轮播 
 */
function adCarousel(){
	$("#owl-carousel-show").remove();
	var owlCarousel = $("[data-carousel=\"owlCarousel\"]").clone();
	owlCarousel.show();
	owlCarousel.attr("id","owl-carousel-show");
	owlCarousel.removeAttr("data-carousel");
	owlCarousel.appendTo("#contentDiv");
	var localBannerJsonStr = window.localStorage.getItem("wechatshop_banner_data_" + window.top.zone_code);
	if(localBannerJsonStr != null && localBannerJsonStr != "" && localBannerJsonStr != "undefined"){
		try {
			var localBannerJsonObj = $.parseJSON(localBannerJsonStr);
			drawBannersByData(localBannerJsonObj);
		} catch (e) {
		}
	}
	var params = {};
	params.zoneCode = window.top.zone_code;
	params.memberId = window.top.openId;
	$.post("setBanners.htm", { paraJson : JSON.stringify(params) }, function(data){
//		alert("广告"+data);
		var jsonReturn = eval("(" + data + ")");
		window.localStorage.removeItem("wechatshop_banner_data_" + window.top.zone_code);
		window.localStorage.setItem("wechatshop_banner_data_" + window.top.zone_code,JSON.stringify(jsonReturn));
		$("#owl-carousel-show").remove();
		var owlCarousel = $("[data-carousel=\"owlCarousel\"]").clone();
		owlCarousel.show();
		owlCarousel.attr("id","owl-carousel-show");
		owlCarousel.removeAttr("data-carousel");
		owlCarousel.prependTo("#contentDiv");
		drawBannersByData(jsonReturn);
	});
	
}

/**
 * 由数据绘制广告栏位
 * @param jsonReturn
 */
function drawBannersByData(jsonReturn){
	if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){  // 返回数据成功
		$.each(jsonReturn.resultData, function(i,n){
			var carouselObj = $("#owl-carousel-template").clone();
			carouselObj.removeAttr("id");
			carouselObj.find("img").attr("src", window.top.imagePath + n.img);
			
			var spanBannerId = carouselObj.find("span[data-bannerId=\"bannerId\"]");
			var spanSubjectName = carouselObj.find("span[data-subjectName=\"subjectName\"]");
			var spanSubjectType = carouselObj.find("span[data-subjectType=\"subjectType\"]");
			var spanUrl = carouselObj.find("span[data-url=\"url\"]");
			
			spanBannerId.html(this.id);
			spanSubjectName.html(this.subjectName);
			spanSubjectType.html(this.subjectType);
			spanUrl.html(this.url);
			
			carouselObj.click(function(){
				goPerAdCarouselList(spanBannerId.html(), spanSubjectName.html(), spanSubjectType.html(), spanUrl.html());
			});
			carouselObj.appendTo("#owl-carousel-show");
			carouselObj.show();
		});
		
		var dataLength = jsonReturn.resultData.length;	// 轮播广告个数
		if( dataLength >= 1 ){
//			$(".owl-carousel").css("width", clientWidth + "px");
			$("#owl-carousel-show").show();
			$("#owl-carousel-show").owlCarousel({
				items: 1,
				loop: dataLength == 1 ? false : true,
				autoplay: false,
				autoplayTimeout: 2000,
				autoplayHoverPause: true
			});
		}
	}else{
		console.log(jsonReturn.resultMsg);
	}
}


/**
 * 进入每项广告轮播对应的【商品列表】或【商品详情】或【宣传页面】  ----点击轮播图片
 * @_subjectType 栏位主题类型   0：跳转商品列表，1：跳转详细，2: 跳转宣传页面记载url
 */
function goPerAdCarouselList(_bannerId, _subjectName, _subjectType, _url){
	if(_subjectType == 0 || _subjectType == "0"){	// 跳转商品列表
		var params = {};
		params.zoneCode = zoneCode;
		params.id = _bannerId;
		params.page  = page;
		params.subjectName = _subjectName;
		params.memberId = window.top.openId;
		window.location.assign( "goToPerBannerListInterface.htm?paraJson=" + JSON.stringify(params));
	}else if(_subjectType == 1 || _subjectType == "1"){ // 跳转详细
		var params = {};
		params.zoneCode = zoneCode;
		params.id = _bannerId;
		params.memberId = window.top.openId;
		window.location.assign( "goBannerGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
	}else if(_subjectType == 2 || _subjectType == "2"){	 //	跳转宣传页面的url
//		$(window.parent.document).find("#myTab").hide();
		if(_url.indexOf("&") > -1){
			_url = _url.replace(/\&/g,"*@*");
		}
		var params = {};
		params.title = _subjectName;
		params.url = _url;
		window.location.assign("unifyUrlJump.htm?paraJson=" + JSON.stringify(params));
//		window.location.assign(_url);
	}
}


/**
 * 获取发现服务列表 ----即轮播下边的分类展示
 */
function getPublicServiceList(){
	$("#goodsSortTable").remove();
//	$("#goodsSortTable").empty();
	
	var sortTable = $("[data-goodsSortTable=\"goodsSortTable\"]").clone();
	sortTable.attr("id","goodsSortTable");
	sortTable.show();
	sortTable.appendTo("#contentDiv");
}

/**
 * 进入公共服务对应的界面  ---- 点击分类中任意项
 */
function goPublicServiceRelateInterface(_serviceCode){
	switch (_serviceCode){
		/*case 1 :	window.location.assign("lookMyCareList.htm"); // 关注列表
			        break;*/
		case 2  :	window.location.assign("goToMyOrderListInterface.htm"); //订单列表
		            break;
		case 3  :	window.location.assign("goAddrManageInterface.htm"); //收货地址列表
					break;
	    default: 	break;
	}
}

/**
 * 促销活动
 */
function getCommonActivityList(){
	$("#activityDiv").remove();
	var activityDiv = $("[data-activityDiv=\"activityDiv\" ]").clone();
	activityDiv.attr("id","activityDiv");
	activityDiv.show();
	activityDiv.appendTo("#contentDiv");
	var localCommonJsonStr = window.localStorage.getItem("wechatshop_common_data_" + window.top.zone_code);
	if(localCommonJsonStr != null && localCommonJsonStr != "" && localCommonJsonStr != "undefined"){
		try {
			var localCommonJsonObj = $.parseJSON(localCommonJsonStr);
			drawCommonActivityByData(localCommonJsonObj);
		} catch (e) {
		}
	}
	
	var params = {};
	params.activityType = "index";
	params.zoneCode = window.top.zone_code;
	params.memberId = window.top.openId;
	$.post("getCommonActivityList.htm", { paraJson : JSON.stringify(params) }, function(data){
//		alert("商品"+data);
		var jsonReturn = eval("(" + data + ")");
		window.localStorage.removeItem("wechatshop_common_data_" + window.top.zone_code);
		window.localStorage.setItem("wechatshop_common_data_" + window.top.zone_code,JSON.stringify(jsonReturn));
		$("#activityDiv").empty();
		drawCommonActivityByData(jsonReturn);
	});
}

/**
 * 由数据填充促销活动
 */
function drawCommonActivityByData(jsonReturn){
	if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){  // 返回数据成功
		$.each(jsonReturn.resultData, function(i,n){
			if(n.dataType == 0 && n.goodsList != null && n.goodsList.length >= 1){ // 图文信息商品展示   ----活动
				var cxActivityDivObj =  $("#cxActivityDivTemplate").clone();
				cxActivityDivObj.removeAttr("id");
				cxActivityDivObj.show();
				cxActivityDivObj.appendTo("#activityDiv");

				var titleDivObj = $("#titleDivTemplate").clone();
				titleDivObj.removeAttr("id");
				
				var spanTitle = titleDivObj.find("span[data-title=\"title\"]");
				var spanId = titleDivObj.find("span[data-activityId=\"activityId\"]");
				var spanDataType = titleDivObj.find("span[data-dataType=\"dataType\"]");
				spanTitle.html(n.title);
				spanId.html(n.id);
				spanDataType.html(n.dataType);
				
				titleDivObj.find("span[data-more=\"more\"]").click(function(){ // 更多
					goMoreInterface(spanId.html(), spanDataType.html());
				});
				titleDivObj.show();
				titleDivObj.appendTo(cxActivityDivObj);
				
				var _tableElem = $(document.createElement("table"));
				_tableElem.addClass("newsGoodsTable tableBottomBorder");
				_tableElem.css({"table-layout":"fixed"});
//				_tableElem.addClass("tableBottomBorder");
				_tableElem.appendTo(cxActivityDivObj);
				
				var _trElem = null;//$(document.createElement("tr"));
				var goodsListLength = n.goodsList.length;
				$.each(n.goodsList, function(j,m){
					var perNewsGoodsObj = $("#newsGoodsTdTemplate").clone();
					perNewsGoodsObj.removeAttr("id");
					if(j % 2 == 0){
						_trElem = $(document.createElement("tr"));
						_trElem.appendTo(_tableElem);
					}
					perNewsGoodsObj.appendTo(_trElem);
					if(m.isActivity == 1){ // 促销图标
//						perNewsGoodsObj.find("div[data-privilege=\"huoDongOrCuXiao\"]").show();
						perNewsGoodsObj.find("img[data-huoDong=\"huoDong\"]").show();
					}
					if(j < goodsListLength){ // 有边框
						perNewsGoodsObj.addClass("tdRightBorder");
					}
					//perNewsGoodsObj.find("img").attr("src", window.top.imagePath + m.img);
					perNewsGoodsObj.find("div[data-imgDiv=\"imgDiv\"]").css("background-image", "url(" + window.top.imagePath + m.img + ")");
					var spanGoodsName = perNewsGoodsObj.find("textarea[data-goodsName=\"goodsName\"]");
					var spanGoodsId = perNewsGoodsObj.find("span[data-goodsId=\"goodsId\"]");
					var spanGoodsPrice = perNewsGoodsObj.find("span[data-goodsPrice=\"goodsPrice\"]");
					var spanGoodsSinglePrice = perNewsGoodsObj.find("span[data-goodsSinglePrice=\"goodsSinglePrice\"]");
					spanGoodsName.html(m.goodsNickName);
					spanGoodsId.html(m.id);
					spanGoodsPrice.html(m.singlePrice.toFixed(2));
					spanGoodsSinglePrice.html(m.memberPrice.toFixed(2));
					
					perNewsGoodsObj.click(function(){
						goDetailInterface(spanGoodsId.html());
					});
					for(k=0; k < 2 - goodsListLength; k++){ // 添加空单元格  ----目的在于保持单元格尺寸
						var perNewsGoodsObj = $("#newsGoodsEmptyTdTemplate").clone();
						perNewsGoodsObj.removeAttr("id");
						perNewsGoodsObj.appendTo(_trElem);
					}
				});
			}else if(n.dataType == 1 && n.subjectList != null &&  n.subjectList.length >= 1){ // 图片消息商品展示  ----主题
				var _tableElem = $(document.createElement("table"));
				_tableElem.addClass("newsGoodsTable");
				_tableElem.appendTo("#activityDiv");
				_tableElem.css("margin-top","5px");
				var _trElem = $(document.createElement("tr"));
				_trElem.appendTo(_tableElem);
				
				var subjectListLength = n.subjectList.length;
				$.each(n.subjectList, function(j,m){
					var perPicGoodsObj = null;
					if(subjectListLength == 1/* || subjectListLength == 3*/){
						perPicGoodsObj = $("#oddNumTemplate").clone();
						perPicGoodsObj.attr("colspan", "4")
					}else if(subjectListLength == 2){
						perPicGoodsObj = $("#twoNumTemplate").clone();
						perPicGoodsObj.attr("colspan", "2")
					}else if(subjectListLength == 3){
						if(j == 0){
							perPicGoodsObj = $("#threeNumTemplate").clone();
							perPicGoodsObj.attr("colspan", "2")
						}else if(j == 1){
							perPicGoodsObj = $("#threeNumTemplate2").clone();
							perPicGoodsObj.find("div").removeAttr("id");
							perPicGoodsObj.attr("colspan", "2")
						}else if (j == 2){
							perPicGoodsObj = $("#threeNumDivTemplate").clone();
						}
					}else if (subjectListLength == 4){
						perPicGoodsObj = $("#twoNumTemplate").clone();
						perPicGoodsObj.attr("colspan", "2");
					}
					
					perPicGoodsObj.removeAttr("id");
					if(subjectListLength == 4 && j == 2){
						_trElem.addClass("tableBottomBorder");
						_trElem = $(document.createElement("tr"));
						_trElem.appendTo(_tableElem);
					}
					if(subjectListLength == 3 && j == 2){
						perPicGoodsObj.removeClass("tableBottomBorder");
						perPicGoodsObj.appendTo($(_trElem.find("td")[1]));
					}else{
						perPicGoodsObj.appendTo(_trElem);
					}	
					if(j == subjectListLength - 1){
						perPicGoodsObj.removeClass("tdRightBorder");
					}
					perPicGoodsObj.find("img").attr("src", window.top.imagePath + m.img);
					var spanDataId = perPicGoodsObj.find("span[data-dataId=\"dataId\"]");
					var spanDataType = perPicGoodsObj.find("span[data-dataType=\"dataType\"]");
					var spanSubjectType = perPicGoodsObj.find("span[data-subjectType=\"subjectType\"]");
					var spanSubjectUrl = perPicGoodsObj.find("span[data-subjectUrl=\"url\"]");
					var spanSubjectName = perPicGoodsObj.find("span[data-subjectName=\"subjectName\"]");
					spanDataId.html(m.id);
					spanDataType.html(n.dataType);
					spanSubjectType.html(m.subjectType);
					spanSubjectUrl.html(m.url == null ? "" : m.url);
					spanSubjectName.html(m.subjectName);
					
					perPicGoodsObj.click(function(){
						goSubjectInterface(spanDataId.html(), spanDataType.html(),  spanSubjectType.html(), spanSubjectUrl.html(),spanSubjectName.html());
					});
				});
			}
		});
		window.top.toggleLoading();
		var bottomSpaceDiv = $("#bottomSpaceTemplate").clone();
		bottomSpaceDiv.show();
		bottomSpaceDiv.removeAttr("id");
		bottomSpaceDiv.appendTo("#activityDiv");
	}else {
		console.log(jsonReturn.resultMsg);
	}
}

/**
 *  主题促销跳转  ----即点击图片跳转
 */
function goSubjectInterface(_id, _dataType, _subjectType, _url,_sujectName){
	if(_subjectType == 0 || _subjectType == "0"){	// 跳转商品列表
		goMoreInterface(_id, _dataType);
	}else if(_subjectType == 1 || _subjectType == "1"){ // 跳转详细
		var params = {};
		params.id = _id;
		params.memberId = window.top.openId;
		params.zoneCode = window.top.zone_code;
		window.location.assign( "goToActivityGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
	}else if(_subjectType == 2 || _subjectType == "2"){	 //	跳转宣传页面的url
		$(window.parent.document).find("#myTab").hide();
		if(_url.indexOf("&") > -1){
			_url = _url.replace(/\&/g,"*@*");
		}
		var params = {};
		params.title = _subjectName;
		params.url = _url;
		window.location.assign("unifyUrlJump.htm?paraJson=" + JSON.stringify(params));
//		window.location.assign(_url);
	}
	
}

/**
 * 更多的跳转 
 */
function goMoreInterface(_id, _dataType){
	var params = {};
	params.dataId = _id;
	params.dataType = _dataType;
	params.zoneCode = window.top.zone_code;
	params.memberId = window.top.openId;
	window.location.assign("goToActivityGoodsList.htm?paraJson=" + JSON.stringify(params) );
}

/**
 *  活动促销跳转  ----图文商品点击跳转
 */
function goDetailInterface(_id){
	var params = {};
	params.id = _id;
	params.zoneCode = window.top.zone_code;
	params.memberId = window.top.openId;
	window.location.assign("mGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
}
