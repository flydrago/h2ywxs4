/**
 * Author: Mr.Lu
 * Function: 百度地图
 * DateTime: 2015年6月2日 16:23:20
 */

var map = null;  
var autoComplete = null;
/** 地址信息 */
var myValue = "";
/** 标注 */
var bmapMarker = null;
/** 地理位置文字 */
var geogStr = "";
/** 定位是否结束的标志 */
var locationFlag = 0;

$(document).ready(function(){
	
	$(window.parent.document).find("#myTab").hide();
	window.top.showLoading();
	getPosition();
	//initParam();
});	


/**
 * 定位用户地理位置
 */
function getPosition(){
	
	if (navigator.geolocation){
		navigator.geolocation.getCurrentPosition(showSuccess, showError); //定位
    }else{
    	console.log("浏览器不支持获取地理位置");
    }
}

/**
 * 获取地理位置成功   进行反地理位置解析
 * @param position
 */
function showSuccess(position){
	window.top.toggleLoading();
	var currLat = position.coords.latitude; 
	var currLon = position.coords.longitude; 
	var gpsPoint = new BMap.Point(currLon, currLat); 
	initParam(gpsPoint);
} 

/**
 * 获取地理位置失败
 * @param error
 */
function showError(error){
	window.top.toggleLoading();
	initParam(null);
	switch(error.code)
	  {
	  case error.PERMISSION_DENIED:
	    console.log("用户不允许地理定位");
	    break;
	    
	  case error.POSITION_UNAVAILABLE:
		  console.log("无法获取当前位置");
	    break;
	    
	  case error.TIMEOUT:
		  console.log("操作超时");
	    break;
	    
	  case error.UNKNOWN_ERROR:
		  console.log("发生未知错误");
	    break;
	  }
	console.log("将获取默认的地址");
}



/**
 * 初始化变量
 */
function initParam(_point){
	
	map = new BMap.Map("l-map");  
	if(_point != null){
		map.centerAndZoom(_point, 14);
	}else{
		map.centerAndZoom("郑州", 14);  
	}
	map.addEventListener("click", function(e){  // 地址点击事件
		clickMap(e);
	});	
	
	autoComplete = new BMap.Autocomplete({ // 建立一个自动完成的对象
		"input" : "suggestId",
		"location" : map
	});
	
	autoComplete.addEventListener("onhighlight", function(e) { //鼠标放在下拉列表上的事件
		hoverListOpt(e);
	});
	
	autoComplete.addEventListener("onconfirm", function(e) { //鼠标点击下拉列表后的事件
		clickListOpt(e);
	});
	
	if(_point != null){
		bmapMarker = new BMap.Marker(_point);
		map.disableDoubleClickZoom();
		map.clearOverlays(); 
		map.addOverlay(bmapMarker);    //添加标注
		 
		draggMaker()
		getGeograge(gpsPoint);
	}
}

/**
 * 百度地图API功能
 */
function G(id) {
	
	return document.getElementById(id);
}



/**
 * 地图点击
 */
function clickMap(_event){
	
	var gpsPoint = _event.point; 

	if(bmapMarker == null){
		bmapMarker = new BMap.Marker(gpsPoint);
	}else{
		bmapMarker.setPosition(gpsPoint);
	} 
	map.clearOverlays(); 
	map.addOverlay(bmapMarker);    //添加标注
	 
	draggMaker()
	getGeograge(gpsPoint);
}


/**
 * 鼠标放在下拉列表上的事件
 */
function hoverListOpt(_event){
	
	var str = "";
	var value = "";
	var _value = _event.fromitem.value;
	
	if (_event.fromitem.index > -1) {
		value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
	}    
	str = "FromItem<br />index = " + _event.fromitem.index + "<br />value = " + value;
	
	value = "";
	if (_event.toitem.index > -1) {
		_value = _event.toitem.value;
		value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
	}    
	str += "<br />ToItem<br />index = " + _event.toitem.index + "<br />value = " + value;
	G("searchResultPanel").innerHTML = str;
}


/**
 * 鼠标点击下拉列表后的事件
 */
function clickListOpt(_event){
	
	var _value = _event.item.value;
	myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
	G("searchResultPanel").innerHTML ="onconfirm<br />index = " + _event.item.index + "<br />myValue = " + myValue;
	
	setPlace();
}


/**
 * 标注地址
 */
function setPlace(){
	map.clearOverlays();    //清除地图上所有覆盖物
	function myFun(){
		var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
		map.centerAndZoom(pp, 18);
		
		if(bmapMarker == null){
			bmapMarker = new BMap.Marker(pp);
		}else{
			bmapMarker.setPosition(pp);
		}
		
		map.addOverlay(bmapMarker);    //添加标注
		draggMaker(); //拖拽
	}
	var local = new BMap.LocalSearch(map, { //智能搜索
	  onSearchComplete: myFun
	});
	local.search(myValue);
}

/**
 * 反地理编码
 */
function getGeograge(_point){
	
	longitude = _point.lng;
	lautitude = _point.lat;
	var geocoder = new BMap.Geocoder();   
	geocoder.getLocation(_point, function(rs){
		
		var addressComp = rs.addressComponents;
		geogStr = addressComp.province + " " + addressComp.city + " " + addressComp.district + " " + addressComp.street;
		showTip(geogStr,1000);
	});
}


/**
 * 标注拖拽事件
 */
function draggMaker(){
	
	bmapMarker.enableDragging();   
	bmapMarker.addEventListener("dragend", function(e){ 
	bmapMarker.setPosition(e.point);		
//		alert("当前位置：" + e.point.lng + ", " + e.point.lat);   
		getGeograge(e.point);
	}) 
}


/**
 * 返回上一页   
 */
function _goBack(){
	
	window.history.back();
}

/**
 * 点击确定按钮
 */
function clickSureOpt(){
	localStorage.removeItem("jiuyuda_GeogFlag");
	localStorage.setItem("jiuyuda_GeogFlag","1");
	localStorage.removeItem("jiuyuda_GeogString");
	localStorage.setItem("jiuyuda_GeogString",geogStr);
	localStorage.removeItem("jiuyuda_LngString");
	localStorage.setItem("jiuyuda_LngString",longitude);
	localStorage.removeItem("jiuyuda_LatString");
	localStorage.setItem("jiuyuda_LatString",lautitude);
	_goBack();
}