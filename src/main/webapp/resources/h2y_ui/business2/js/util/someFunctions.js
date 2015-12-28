/**
 * Author:Mr.Lu
 * Function:偶然遇到的实用方法收集一下。
 * CreateDate:2015年8月5日 08:48:50
 */

function _getRandomString(len) {
    len = len || 32;
    var $chars = "ABCDEFGHIJKMNOPQRSTUVWXYZabcdefhijkmnoprstuvwxyz0123456789"; // 默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1
    var maxPos = $chars.length;
    var pwd = '';
    for (i = 0; i < len; i++) {
        pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
    }
    return pwd;
}


function ReadFiles() 
{ 
 var fso, f1, ts, s; 
 var ForReading=1; 
 fso=new ActiveXObject("Scripting.FileSystemObject"); 
 f1=fso.CreateTextFile("c:\\testfile.txt1",true); 
 f1.WriteLine("Hello World!"); 
 f1.WriteBlankLines(1); 
 f1.Close(); 
 ts=fso.OpenTextFile("c:\\testfile.txt1",ForReading); 
 s=ts.ReadLine(); 
 document.write("File contents=''"+s+"''"); 
 ts.Close(); 
 f2=fso.CreateTextFile("c:\\testfile.txt2",true); 
 f2.WriteLine("File contents=''"+s+"''"); 
 f2.WriteBlankLines(1); 
 f2.Close(); 
}



function loadImage(url, imgElem) { 
	var tempImgArry = localStorage.getItem("juyunda_goodsImages");
	var tempLoadFlag = false;
	$.each(tempImgArry,function(i,n){
		if(n.src == url){
			$(imgElem).attr("src", n.src);
			tempFlag = true;
			return false;
		}
	});
	if(tempLoadFlag){
		return;
	};
	var img = new Image(); //创建一个Image对象，实现图片的预下载 
	img.src = url; 
	/*if (img.complete) { // 如果图片已经存在于浏览器缓存，直接调用回调函数 
		$(imgElem).attr("src", img.src);
		return; // 直接返回，不用再处理onload事件 
	} */
	img.onload = function () { //图片下载完毕时异步调用callback函数。 
		$(imgElem).attr("src", img.src);
		window.top.imgArry.push(img);
	}; 
}; 

//plupload.js上传文件


//首页秒杀


/**
 * 获取秒杀数据
 * 再次请求数据标志
 */
function getSecKillData2(_flag){
	var seckillObj = null ;
	var seckillTitleObj = null ;
	if(_flag == 1){
		$("#seckillTitleDiv").empty();
		seckillTitleObj = $("#seckillTitleDiv");
		
		$("#seckillDiv").empty();
		seckillObj = $("#seckillDiv");
	}else{
		$("#seckillTitleDiv").remove();
		seckillTitleObj = $("[data-seckillTitleDiv=\"seckillTitleDiv\"]").clone();
		seckillTitleObj.show();
		seckillTitleObj.attr("id","seckillTitleDiv");
		seckillTitleObj.removeAttr("data-seckillTitleDiv");
		seckillTitleObj.appendTo("#contentDiv");
		
		$("#seckillDiv").remove();
		seckillObj = $("[data-seckillDiv=\"seckillDiv\"]").clone();
		seckillObj.show();
		seckillObj.attr("id","seckillDiv");
		seckillObj.removeAttr("data-seckillDiv");
		seckillObj.appendTo("#contentDiv");
	}
	
	$("#seckill-owl-carousel-show").remove();
	var seckillOwlCarousel = null;
	seckillOwlCarousel = $("[data-carousel=\"owlCarousel\"]").clone();
	seckillOwlCarousel.show();
	seckillOwlCarousel.attr("id","seckill-owl-carousel-show");
	seckillOwlCarousel.removeAttr("data-carousel");
	seckillOwlCarousel.appendTo(seckillObj);
	
	var param = {};
	param.zoneCode = window.top.zone_code;
	param.spikeEvent = 0;
	param.page = 1;
	param.pagesize = window.top.pagesize;
	$.post("cmbs/commonSpike/getCommonSpikeGoodsList.htm",{postData:JSON.stringify(param)},function(data){
//		alert(data);
		
		var jsonReturn = eval("(" + data + ")");
		$("#seckillDiv").hide();
		if(jsonReturn.resultFlag == 1 || jsonReturn.resultFlag == "1"){  // 返回数据成功
			$("#seckillDiv").show();
			var titleDivObj = $("#seckillTitleDivTemplate").clone();
			titleDivObj.removeAttr("id");
			titleDivObj.css("padding","15px 10px")
			startTime = (new Date()).getTime() + jsonReturn.resultData.countdownMap.timeCount * 1000;
//        	countTime(startTime,titleDivObj);
        	titleDivObj.find("span[data-title=\"title\"]").css("color","grey").html(jsonReturn.resultData.countdownMap.timeText);
			titleDivObj.find("span[data-activityLimitTime=\"activityLimitTime\"]").html(jsonReturn.resultData.countdownMap.timeCount);
			titleDivObj.find("span[data-timeFlag=\"timeFlag\"]").html(jsonReturn.resultData.countdownMap.timeFlag);
			timeFlag = jsonReturn.resultData.countdownMap.timeFlag;
			
			titleDivObj.show();
//			seckillObj.prepend(titleDivObj);
			seckillTitleObj.prepend(titleDivObj);
			titleDivObj.click(function(){
				window.location.assign("mSecKillGoodsInterface.htm");
			});
			
//			var test = jsonReturn.resultData.commonSpikeGoodsList;
//			test = test.concat(test,test.concat());
//			test.splice(0,2);
//			alert(test.length);
//			return;
//			$.each(test,function(i,n){
			$.each(jsonReturn.resultData.commonSpikeGoodsList,function(i,n){
				var owlObj = $("#owl-carousel-template2").clone();
				owlObj.removeAttr("id");
//				owlObj.css({"background-image":"url(" +  window.top.imagePath + n.img + ")",
//							"background-width":"120px 120px",
//							"background-position":"center auto",
//							"background-repeat":"no-repeat"
//				});
				owlObj.find("img").attr("src", window.top.imagePath + n.img);
				owlObj.find("p span").html(n.singlePrice);
				var spanGoodsId = owlObj.find("span[data-goodsId=\"goodsId\"]");
				spanGoodsId.html(n.id);
				owlObj.appendTo("#seckill-owl-carousel-show");
				owlObj.show();
				owlObj.click(function(){
					if(timeFlag == 0){
						if(startTime > (new Date()).getTime()){
							$("#noMoreDataWarning").html("抱歉，活动时间还没有开始").show();
							var timer = setInterval(function(){
								clearInterval(timer);
								$("#noMoreDataWarning").hide();
							},1500);
							return;
						}
					}else if(timeFlag == 1){
						goDetailInterface(spanGoodsId.html());
					}
				});
			});
			
			$("#seckill-owl-carousel-show").owlCarousel();
			
		}else if(jsonReturn.resultFlag == 0 || jsonReturn.resultFlag == "0"){
			
			console.log("【返回失败】");
		}else if(jsonReturn.resultFlag == 2 || jsonReturn.resultFlag == "2"){
			
			console.log("【暂无数据】");
		}else if(jsonReturn.resultFlag == -1 || jsonReturn.resultFlag == "-1"){
			
			console.log("【其他错误】");
		}
	});
	
}


/*<!-- 分类模板 开始-->
	<table style="display:none;">
	<tr>
		<td id="wineSortTemplate" class="sortList" style="width:25%;padding:10px 5px;border:1px solid #e7e7e7;">
			<img src="" alt="" width="60px" height="78px"/><!--height="60px"  -->
			<span data-sortId="sortId" style="display:none;"></span>
			<span data-serviceCode="serviceCode" style="display:none;"></span>
			<span data-serviceUrl="serviceUrl" style="display:none;"></span>
			<span data-clickEvent="clickEvent" style="display:none;"></span>
			<span data-isLogin="isLogin" style="display:none;"></span>
			<span data-memo="memoGoodsTypeId" style="display:none;"></span>
			<p style="margin-top:5px;margin-bottom:0px;display:none;"></p>
		</td>
		<td id="wineSortTemplate1"  class="sortList" style="width:20%;padding:10px 5px;border:1px solid #e7e7e7;">
			<img src="" alt="" width="52px" height="72px"/><!--height="60px"  -->
			<span data-sortId="sortId" style="display:none;"></span>
			<span data-serviceCode="serviceCode" style="display:none;"></span>
			<span data-serviceUrl="serviceUrl" style="display:none;"></span>
			<span data-clickEvent="clickEvent" style="display:none;"></span>
			<span data-isLogin="isLogin" style="display:none;"></span>
			<span data-memo="memoGoodsTypeId" style="display:none;"></span>
			<p style="margin-top:5px;margin-bottom:0px;display:none;"></p>
		</td>
	</tr>
</table>
*/
/*秒杀可滑动
<div id="owl-carousel-template2" class="item" style="width:100%;height:140px;display:none;">
<img src="" /><!-- height="100px"  -->
<p style="text-align:center;color:red;">￥<span></span></p>
<span data-goodsId="goodsId" style="display:none;"></span>
</div>*/
