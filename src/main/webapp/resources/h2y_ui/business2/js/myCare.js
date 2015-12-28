/**
 * Mr.Lu 2015年4月21日 19:21:56
 */


var page =1;
var pagesize = window.top.pagesize;
var zone_code = window.top.zone_code;
var imagePath = window.top.imagePath;

$(document).ready(function(){
	/**初始化页面**/
	$(window.parent.document).find("#myTab").show();
	getMyCareData();
});


/**
 * 返回
 */
function _goBack(){
	window.top.toggleLoading();
	window.history.back();
}


/**
 * 获取我的关注数据
 */
function getMyCareData(){
	window.top.showLoading();
	var reqParam = {};
	reqParam.memberId = window.top.user.id;
	reqParam.page = page;
	reqParam.pagesize = pagesize;
	reqParam.focusType = "0";
	reqParam.zoneCode = window.top.zone_code;
	
	$.post("getMyCareData.htm",{postParam:JSON.stringify(reqParam)},function(data){
		window.top.toggleLoading();
		$(".checkMoreOrder").removeAttr("disabled");
//		alert(data);
		var jsonReturn = eval("(" + data + ")");
		if(jsonReturn.resultFlag == "1" || jsonReturn.resultFlag == 1){
			setCareList(jsonReturn.resultData);
		}else if(jsonReturn.resultFlag == "2" || jsonReturn.resultFlag == 2){
			$("#lookMoreBtn").hide();
			$("#contentDiv").unbind("scroll");
			if(page == 1){
				showTip("抱歉,暂无数据");
			}else{
//				showTip(jsonReturn.resultMsg);
			}
		}else{
			$("#contentDiv").unbind("scroll");
			console.log("返回数据为空或请求失败");
		}
	});
	
}


/***设置显示关注商品列表*/
function setCareList(listData){
	
	$.each(listData,function(i,n){
		
		var carePerObj = $("#careGoodsTemplate").clone();
		carePerObj.removeAttr("id");
		carePerObj.find("img").attr("src",imagePath + n.img);
		carePerObj.find("p[data-name=\"name\"]").html(n.goodsNickName);
//		carePerObj.find("h4").html(n.goodsNickName);
		carePerObj.find("span[data-price=\"single\"]").html(n.memberPrice.toFixed(2));
		carePerObj.find("span[data-price=\"market\"]").html(n.marketPrice.toFixed(2));
//		carePerObj.find("span[data-goodsId=\"goodsId\"]").html(n.goodsId);
		carePerObj.find("span[data-id=\"id\"]").html(n.id);
		
		if(n.isActivity == 1 || n.isActivity == "1"){
			carePerObj.find("span[data-priceName=\"priceName\"]").html("活动价:");
		}else{
			carePerObj.find("span[data-priceName=\"priceName\"]").html("会员价:");
		}
		
		carePerObj.appendTo("#care_table");
		carePerObj.click(function(){
			goGoodsDetailPage( carePerObj.find("span[data-id=\"id\"]").html()) 
		});
	});
	
	if(listData.length < pagesize){
		$("#lookMoreBtn").hide();
		$("#contentDiv").unbind("scroll");
	}else{
		$("#lookMoreBtn").show();
		$("#contentDiv").bind("scroll",function(){
			lookMoreCare();
		});
	}
}


/**
 * 进入商品详情 
 */
function goGoodsDetailPage(_id){
	
	var params = {};
	params.id = _id;
	params.zoneCode = window.top.zone_code;
	if(window.top.user.id != null || window.top.user.id != ""){
		params.memberId = window.top.user.id;
	}
	window.location.assign("mGoodsDetail.htm?paraJson=" + JSON.stringify(params) );
}


/**
 * 查看更多
 */
function lookMoreCare(elem){
	if(elem != null){
		$(elem).attr("disabled","disabled");
	}
	page++;
	getMyCareData();
}
