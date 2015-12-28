<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath %>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.theme.default.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.carousel.min.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/OwlCarousel/owl.carousel.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/accurateMathCalculate.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/goodsDetail.js"></script>
		<title>商品详情</title>
	</head>
	
	<style type="text/css">
	
		.detail-focus-liquor{
			padding:8px;
		}
		.liquor-intro{
			padding:8px;
		}
	
		h4{
			margin-top:0px;
			margin-bottom:0px;
		}
		p{
			margin-bottom:0px;
		}
		
		.btn:focus, .btn:hover {
			color: #fff;
			text-decoration: none;
		}
		
		button:active,.glyphicon:active,#add_cart_img:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		
		.owl-theme .owl-controls {
			position: relative;
			margin-top: -25px;
			z-index: 2;
		}
		
		.owl-theme .owl-dots .owl-dot.active span,.owl-theme .owl-dots .owl-dot:hover span{
			background: black;
			width:6px;/* 10 */
			height:6px;
		}
		
		.owl-theme .owl-dots .owl-dot span{
			width:6px;
			height:6px;
		}
		
		.owl-item{
			width:100%;
		}
		
		.owl-carousel {
			margin:0;
		}
		
		.owl-carousel .item {
			/* background:#4DC7A0; */
		}
	</style>
	
	<body style="width:100%;height:100%;" >
		<div style="-webkit-overflow-scrolling:touch;">
		<!-- 标题栏 -->
		<div style="position:absolute;background:#1a90f0;width:100%;height:45px;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<!-- 返回 -->
					<td onclick="_goBack()" style="width:43px;padding-left:8px;padding-right:5px;">
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
					</td>
					<!-- 标题 -->
					<td style="padding-left:5px;padding-right:5px;text-align:center;">
						<span style="color:#FFF;font-size:18px;">商品详情</span> 
					</td>
					<!-- 为了标题居中 -->
					<td style="width:43px;">
					
					</td>
			  </tr>
			</table>
		</div>
		
		<!-- 商品详情 -->
		<div style="position:absolute;width:100%;top:45px;bottom:50px;overflow-y:auto;overflow-x:hidden;background:#f6f2ed">
			
			<!-- 商品图片  -->
				
			<!-- 轮播模板-->
			<div id="owl-carousel-template" class="item" style="width:100%;display:none;">
	        	<img src="" width="100%"/>
	        </div>
			
			<!-- 轮播 -->
			<div id="owl-carousel-show" class="owl-carousel" style="width:100%;display:none;">
	            
	        </div>
	        
	        <!-- ——————————————------------------------------------------------- -->
	        
			<!-- 模板开始 -->
			<ul style="display:none">
				<li id="template" class="list-group-item"><span data-name="name">香型</span><span>:&nbsp;&nbsp;&nbsp;&nbsp;</span><span data-value="value">浓香型</span></li>
			</ul>
			<!-- 模板结束 -->
		
		<div style="margin-top:10px;">
			<ul class="list-group" style="width:100%;">
			   <li class="list-group-item"><span>价格</span><span style="font-size:18px;font-weight:bold;color:red">&nbsp;&nbsp;&nbsp;&nbsp;￥<span id="wine_price"><fmt:formatNumber type="number" value="${goodsDetail.resultData.goods.singlePrice}" pattern="0.00" maxFractionDigits="2"/></span></span></li><!-- goodsDetail.resultData.goods.goodsName  eq "null"? goodsDetail.resultData.goods.goodsNickName : goodsDetail.resultData.goods.goodsName -->
			   <li class="list-group-item"><span id="wine_name"  style="display:block;width:100%;font-weight:bold;">${goodsDetail.resultData.goods.goodsNickName}</span></li>
			   <li class="list-group-item"><span>库存:</span><span>&nbsp;&nbsp;${goodsDetail.resultData.goods.inventory}</span></li>
			   <li class="list-group-item" style="padding:0px;"><span style="display:inline-block;text-align:center;padding:10px 0px;width:50%;border-right:1px solid #e7e7e7;">浏览(<span style="color:grey;">${goodsDetail.resultData.goods.clickRate}</span>)</span><span style="display:inline-block;padding:10px 0px;text-align:center;width:50%;">销量(<span style="color:grey;">${goodsDetail.resultData.goods.sellRate}</span>)</span></li>
			</ul>
			
			<ul class="list-group" style="width:100%;margin-top:10px;">
			   <li class="list-group-item activityInfo"><span>活动信息</span><span class="pull-right"> <span style="font-size:18px;font-weight:bold;color:red">￥<span id="wine_price"><fmt:formatNumber type="number" value="${goodsDetail.resultData.activity.activityPrice}" pattern="0.00" maxFractionDigits="2"/></span></span> &nbsp;&nbsp;<span class="glyphicon glyphicon-menu-right" style="color:grey;"></span></span></li>
			   <li  class="list-group-item detail-focus-liquor-li" style="display:none;">
			   <div>
			   		<div class="detail-focus-liquor">
			   			<span>活动价格</span>
			   			<span class="pull-right">
			   			<span style="color:rgb(39, 132, 207)">
			   				￥<span><fmt:formatNumber type="number" value="${goodsDetail.resultData.activity.activityPrice}" pattern="0.00" maxFractionDigits="2"/></span><!--  id="wine_price" -->
			   			</span>
			   			</span>
			   		</div>
			   		<div class="detail-focus-liquor">
			   			<span>活动数量</span>
			   			<span class="pull-right">
			   			<span style="color:rgb(39, 132, 207)">
			   				<span>
			   					<c:if test="${goodsDetail.resultData.activity.limitNumber eq 0}">
			   						不限
			   					</c:if>
			   					<c:if test="${goodsDetail.resultData.activity.limitNumber ne 0}">
			   						${goodsDetail.resultData.activity.limitNumber}
			   					</c:if>
			   					
			   				</span>
			   			</span>
			   			</span>
			   		</div>
			   		<div class="detail-focus-liquor">
			   			<span>已销售</span>
			   			<span class="pull-right">
			   			<span style="color:rgb(39, 132, 207)">
			   				<span>${goodsDetail.resultData.activity.sellNumber}</span>
			   			</span>
			   			</span>
			   		</div>
			   		<div class="detail-focus-liquor">
			   			<span>开始时间</span>
			   			<span class="pull-right">
			   			<span style="color:rgb(39, 132, 207)">
			   				<span>${goodsDetail.resultData.activity.startDate}</span>
			   			</span>
			   			</span>
			   		</div>
			   		<div class="detail-focus-liquor">
			   			<span>结束时间</span>
			   			<span class="pull-right">
			   			<span style="color:rgb(39, 132, 207)">
			   				<span>${goodsDetail.resultData.activity.endDate}</span>
			   			</span>
			   			</span>
			   		</div>
			   </div>
			   </li>
			   <li class="list-group-item guige">
				   <table style="width:100%;">
					   <tr>
						   <td style="width:50px;min-width:50px;max-width:50px;padding-right:10px;"><span>规格</span></td><!--${goodsDetail.resultData.goods.goodsName eq "null"? goodsDetail.resultData.goods.goodsNickName : goodsDetail.resultData.goods.goodsName}  -->
						   <td><span>${goodsDetail.resultData.goods.goodsNickName}</span></td>
						   <td style="width:14px;min-width:14px;max-width:14px;"><span class="glyphicon glyphicon-menu-right" style="color:grey;"></span></td>
					   </tr>
				   </table>
			   </li>
			   <li  class="list-group-item guigeli" style="display:none;padding:0 15px;">
				   <div>
				   		<table style="width:100%;">
				   		
				   		</table>
				   		<div style="padding-top:10px;padding-bottom:10px;display:none;color:red;text-align:center;"><span>暂无数据!</span></div>
				   </div>
			   </li>
			   <li class="list-group-item giftInfo" style="display:none;"><span>赠品</span><span class="pull-right"><span class="glyphicon glyphicon-menu-right" style="color:grey;"></span></span></li>
			   <li  class="list-group-item giftInfo-liquor-li" style="display:none;padding:0 15px;">
				   <div>
				   		<table style="width:100%;">
				   		
				   		</table>
				   </div>
			   </li>
			</ul>
			
			<ul class="list-group" style="width:100%;margin-top:10px;">
			   <c:forEach var="c" items="${goodsDetail.resultData.tags}">
			   		<li class="list-group-item"><span data-name="name">${c.markName}</span><span>:&nbsp;&nbsp;&nbsp;&nbsp;</span><span data-value="value">${c.markValue }</span></li>
			   </c:forEach>
			</ul>
			
			<ul class="list-group" style="width:100%;margin-top:10px;">
			   <li class="list-group-item liquor-introduce"><span>商品详情</span>
			   		<span class="glyphicon glyphicon-menu-right pull-right" style="color:grey;"></span>
			   </li>
			  	<li  class="list-group-item detail-focus-liquor-intro" style="display:none;">
			  		<div class="liquor-intro">
			  			<span>${goodsDetail.resultData.info.introduce }</span>
			  		</div>
			  	</li> 
			</ul>
			
			<ul class="list-group" style="width:100%;margin-top:10px;margin-bottom:0px;display:none;">
			   <li class="list-group-item"><span>商品评价</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-star" style="color:#febe2b;"></span><span class="glyphicon glyphicon-star" style="color:#febe2b;"></span><span class="glyphicon glyphicon-star" style="color:#febe2b;"></span><span class="glyphicon glyphicon-star" style="color:#febe2b;"></span><span class="glyphicon glyphicon-star" style="color:#febe2b;"></span><span class="glyphicon glyphicon-menu-right pull-right" style="color:grey;"></span></li>
			</ul>
			
			<div style="width:100%;text-align:center;display:none;">
				<button class="btn" onclick="addToShoppingCart(this)" style="width:98%;height:40px;color:#FFF;font-size:20px;background:#ef4e3a;border-color:#cc2311">加入购物车</button>
			</div><!-- ${goodsDetail.resultData.goods.id} -->
		</div>
		</div>
		<table style="display:none">
			<!-- 一行一个模板 开始 -->
			<tr id="line_one_template" class="tableBottomBorder" style="width:100%;">
				<td style="padding:10px;height:80px">
					<div data-privilege="huoDongOrCuXiao" class="huodongtip" style="position:absolute;z-index:2;width:30px;height:30px;display:none;"></div>
					<img src="" data-img="img" width="70px" height="70px" style="float:left"/>
					<div style="position:absolute;height:80px;left:110px;right:10px;">
						<p>
						<span data-name="name">fdsfasdfas</span>
						<span class="pull-right" style="color:red;">￥<span data-perTotal="perTotal"></span></span>
						</p>
						<p style="color:red;font-weight:bold;margin-bottom:2px;">
							<span>单价:</span>
							<span>￥&nbsp;<span data-price="single"></span></span>
							<span class="pull-right">数量:&nbsp;&nbsp;<span data-number="num" ></span></span>
						</p>
						
						<p style="display:none">
							<span data-id="id">id</span>
						</p>
					</div>
				</td>
			</tr> 
		</table>
		<div id="cartAnim" style="position:absolute;z-index:3;display:none;">
			<img src="<%=uiPath %>business2/images/pd_car.png" style="height:30px;width:30px;"/>
		</div>
		
		<div style="position:absolute;display:block;width:100%;height:50px;bottom:0px;background:#f6f2ed;padding:8px 15px;">
			
			<%-- <button id="unCareBtn" class="btn detailPageUnCareBtnNormal" onclick="goCareGoodsOpt()" style="width:100px;height:34px;">关注</button>
			<button id="alreadyCareBtn" class="btn detailPageAlreadyCareBtn" onclick="goUnCareGoodsOpt()" style="width:100px;height:34px;display:none;">取消关注</button> --%>
			<button class="btn detailPageCartsBtnNormal" onclick="addToShoppingCart()" style="height:34px;margin-left:20px;">加入购物车</button>
			<div onclick="goToPayMoney()" style="position:absolute;display:inline-block;height:30px;right:15px;">
				<img id="cartIcon" src="<%=uiPath %>business2/images/pd_car.png" style="height:30px;width:30px;"/>
				<span id="addCartGoodsNum" class="badge" style="position:absolute;background:red;top:-3px;right:-4px;visibility:hidden;z-index:2;"><span>+</span>&nbsp;<span data-addNum="addNum"></span></span>
			</div>
		</div>
		
		<input id="goodsDetailData" type="hidden" value='<%=request.getAttribute("goodsDetail")%>'>
		</div>
	</body>
	
</html>