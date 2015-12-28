/**
 * Author:Mr.Lu
 * Function:调用微信js api
 * CreateDate:2015年7月27日 14:56:45
 */
function getSingature(){
	$.post("wxs/getJsTicket.htm",{"url":window.location.href.split("#")[0]},function(data){
  		var jsonReturn = eval("(" + data + ")");
  		//alert(jsonReturn.appId + "   " + jsonReturn.timestamp + "   " + jsonReturn.nonce + "  " + jsonReturn.signature)
  		wx.config({
  	      debug: false,
  	      appId: jsonReturn.appId,
  	      timestamp: jsonReturn.timestamp,
  	      nonceStr: jsonReturn.nonce,
  	      signature: jsonReturn.signature,
  	      jsApiList: [
  	        'checkJsApi',
  	        'onMenuShareTimeline',
  	        'onMenuShareAppMessage',
  	        'onMenuShareQQ',
  	        'onMenuShareWeibo',
  	        'hideMenuItems',
  	        'showMenuItems',
  	        'hideAllNonBaseMenuItem',
  	        'showAllNonBaseMenuItem',
  	        'translateVoice',
  	        'startRecord',
  	        'stopRecord',
  	        'onRecordEnd',
  	        'playVoice',
  	        'pauseVoice',
  	        'stopVoice',
  	        'uploadVoice',
  	        'downloadVoice',
  	        'chooseImage',
  	        'previewImage',
  	        'uploadImage',
  	        'downloadImage',
  	        'getNetworkType',
  	        'openLocation',
  	        'getLocation',
  	        'hideOptionMenu',
  	        'showOptionMenu',
  	        'closeWindow',
  	        'scanQRCode',
  	        'chooseWXPay',
  	        'openProductSpecificView',
  	        'addCard',
  	        'chooseCard',
  	        'openCard'
  	      ]
  	});
  		
  });

}
wx.ready(function () {	
	//chooseImg();
	wx.onMenuShareTimeline({
	    title: '微信测试 ', // 分享标题
	    link: 'http://www.baidu.com?a=1', // 分享链接
	    imgUrl: '', // 分享图标
	    success: function () { 
	        // 用户确认分享后执行的回调函数
	    	
	    },
	    cancel: function () { 
	        // 用户取消分享后执行的回调函数
	    	
	    }
	});
	

});
function chooseImg(){
	wx.chooseImage({
	    count: 1, // 默认9
	    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
	    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
	    success: function (res) {
	       var localIds  = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
	       test= localIds;
	       alert(test);
	    }
	});
	
}
function getLocation(){
	wx.getLocation({
	    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	    success: function (res) {
	        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	        var speed = res.speed; // 速度，以米/每秒计
	        var accuracy = res.accuracy; // 位置精度
	        /*var gpsPoint = new BMap.Point(res.longitude, res.latitude); 
	    	
	    	var geocoder = new BMap.Geocoder();   
	    	geocoder.getLocation(gpsPoint, function(rs){
	    		
	    		addressComp = rs.addressComponents;
	    	});*/
	    }
	});
}

function previewImage(imgUrl,imgArry){
	
	 wx.previewImage({
	     current: imgUrl,
	     urls: imgArry
	 });
}

wx.error(function (res) {
  console.log(res.errMsg);
});
