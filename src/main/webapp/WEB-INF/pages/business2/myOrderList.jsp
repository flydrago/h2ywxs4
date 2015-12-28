<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath %>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/showTip.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/myOrderList.js"></script>
		<title>我的订单列表</title>
	</head>
	
	<style type="text/css">
		
		
		button:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		
		.btn:focus, .btn:hover {
			color: #fff;
			text-decoration: none;
		}
		
		.glyphicon:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		
		
	</style>
	
	<body style="background:#f6f2ed;"><!--  style="width:100%;height:100%;background:#f6f2ed;" -->
		<div style="-webkit-overflow-scrolling:touch;">
		<!-- 标题栏 -->
		<div style="position:absolute;width:100%;height:45px;background:#1a90f0;text-align:center;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<td onclick="_goBack()" style="width:43px;padding-left:8px;padding-right:5px;">
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
					</td>
					
					<!-- 标题 -->
					<td style="padding-left:5px;padding-right:5px;text-align:center;">
						<span style="color:#FFF;font-size:18px;">全部订单</span>
					</td>
					
					<!-- 更多 -->
					<td style="width:43px;">
						
					</td>
			  </tr>
			</table>
		</div>
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		
		<!-- 已有收货地址 -->
		
		<!-- 模板 开始 -->
		<div id="myOrderList_template" onclick="goToOrderDetailInterface(this)" style="display:none;width:100%;padding:10px 15px;margin-bottom:10px;border-bottom:1px solid #e7e7e7;background:#fff;">
			<div><span style="font-weight:bold;">订单编号:</span><span data-serial="serialNum" style="margin-left:10px;">2165445612316549852</span></div>
			<div><span style="font-weight:bold;">订单金额:</span><span style="color:red;margin-left:10px;">￥<span data-price="orderPrice" >123</span></span><button class="btn pull-right" style="font-weight:bold;">订单跟踪</button></div>
			<div><span style="font-weight:bold;">下单时间:</span><span data-time="orderTime" style="margin-left:10px;">2015-4-29 11:29:07</span></div>
			<div><span style="font-weight:bold;float:left;">收货地址:</span><div style="margin-left:10px;display:inline-block;"><span data-address="orderAddr">路信号&nbsp;15236192585&nbsp;河南省洛阳市洛<br/>龙区开元大道123号</span></div></div>
			<div><span style="font-weight:bold;color:red;">订单状态:</span><span data-status="orderStatus" style="margin-left:10px;">拒签</span></div>
	    </div>
		<!-- 模板 结束 -->
				
		<!-- 模板 开始 -->
		<div id="myOrderList_template2" onclick="goToOrderDetailInterface(this)" style="display:none;width:100%;padding:0;margin-bottom:10px;background:#fff;">
			
			<div style="padding:8px 10px;width:100%;">
				<span>订单号:</span>
				<span data-serial="serialNum" style="margin-left:10px;"></span>
				<span data-status="orderStatus" class="pull-right" style="margin-left:10px;color:#72B5E3;"></span>
			</div>
			
			<div data-goodsList="goodsList" style="border-bottom:1px solid #e7e7e7; border-top:1px solid #e7e7e7;width:100%;">
				
			</div>
			
			<div style="padding:8px 10px;">
				<span style="font-weight:bold;color:grey;">实付:</span>
				<span style="color:red;">￥<span data-realMoney="realMoney" ></span></span>
				<div data-buttonArry="buttonArry" class="pull-right" style="display:inline;">
					<button class="btn btn-primary" data-funBtn="traceRecord" style="padding:2px 3px;background:white;color:#72B5E3;border:1px solid #72B5E3;">查看物流</button>
				</div>
			</div>
	    </div>
	    
	   <table id="line_one_template" data-orderList="orderList" style="display:none;">
			<!-- 一行一个模板 开始 -->
			<tr style="width:100%;">
				<td style="padding:10px;height:80px">
					<div data-privilege="huoDongOrCuXiao" class="huodongtip" style="position:absolute;z-index:2;width:30px;height:30px;display:none;"></div>
					<img src="" data-img="img" width="70px" height="70px" style="float:left"/>
					<div style="position:absolute;height:80px;left:100px;right:20px;">
						<p>
							<span data-name="name"></span>
							<span class="pull-right" style="color:red;">￥<span data-perTotal="perTotal"></span></span>
						</p>
						<p style="color:red;margin-bottom:2px;">
							<span style="color:black;">单价:</span>
							<span>￥&nbsp;<span data-price="single"></span></span>
							<span class="pull-right" style="color:black;">x<span data-number="num" ></span></span>
						</p>
						
						<div>
							<div data-isJiuKu="isJiuKu" class="pull-right" style="display:none;"></div>
							<span data-isGift="isGift" class="badge pull-left" style="background:red;color:#fff;display:none;">赠</span>
							<span data-goodsPriceId="goodsPriceId"  style="display:none"></span>
							<span data-buyType="buyType"  style="display:none"></span>
							<span data-buyCount="buyCount"  style="display:none"></span>
						</div>
					</div>
				</td>
			</tr> 
		</table>
		
		<!-- 模板 结束 -->	
			
		<!--图片模板  -->
		<div id="moreGoodsDivTemplate" data-orderList="orderList" style="width:25%;padding:10px;text-align:center;display:none;">
			<img src="" data-img="img" width="70px" height="70px" />
			<span data-goodsPriceId="goodsPriceId"  style="display:none"></span>
			<span data-buyType="buyType"  style="display:none"></span>
			<span data-buyCount="buyCount"  style="display:none"></span>
		</div>
		
		<!--完成  -->
		<div id="orderFinish" style="position:absolute;float:right;right:20px;top:5px;display:none;" class="orderFinish"></div>
		
			<div id="contentDiv" style="position:absolute;width:100%;top:50px;bottom:66px;padding-bottom:20px;overflow-y:auto;overflow-x:hidden;">
				<div id="myOrderList" >
				</div>
			
				<!-- 查看更多 -->
				<div id="lookMoreBtn" style="display:none;width:98%;margin-left:auto;margin-right:auto;text-align:center;margin-top:15px;">
					<button type="button" class="btn btn-primary checkMoreOrder"  style="width:100%;">查看更多</button>
				</div>
			</div>
			
		<div id="warmWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:76px;color:#fff;">
			<span class="badge" style="background:red;line-height:25px;"></span>
		</div>
		</div>
	</body>
</html>