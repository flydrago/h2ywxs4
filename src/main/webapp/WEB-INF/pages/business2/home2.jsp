<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html><!-- manifest="business2/cache/cache.manifest"   -->
	<head>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minium-scale=1,user-scalable=no" name="viewport">
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.theme.default.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.carousel.min.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/OwlCarousel/owl.carousel.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/accurateMathCalculate.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/home2.js"></script>
		<title>商城主页</title>
	</head>
	<style>
		.sortList:active{
			background: #D9D9D9
		}
		
		.owl-theme .owl-controls {
			position: relative;
			margin-top: -25px;
			z-index: 2;
		}
		.owl-theme .owl-dots .owl-dot.active span,.owl-theme .owl-dots .owl-dot:hover span{
			background: #F79B3B;
			width:6px;/* 10 */
			height:6px;
		}
		
		.owl-theme .owl-dots .owl-dot span{
			width:6px;
			height:6px;
			background:black;
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
	
	<body style="width:100%;height:100%;margin:0;padding:0;background:#cad8e5;"><!--background:#f6f2ed;  -->
		
		<div style="-webkit-overflow-scrolling:touch;overflow:hidden;width:100%;padding:0;margin:0;">
		
		<!-- 顶部标题栏 -->
		<div id="backGroundDiv" style="position:absolute;width:100%;height:50px;z-index:99;background:#1A90F0;display:block;"></div>
		<div style="position:absolute;width:100%;height:50px;z-index:99;">
			<table style="width:100%;height:100%;">
				<tr >
					<!-- 搜索框 -->
					<td style="padding-left:5px;padding-right:5px;">
						<input class="homeTitleInput" type="text" readonly="readonly" placeholder="搜索商品" style="" onclick="goGoodsSearchInterface()" /> 
					</td>
			  </tr>
			</table>
			<span id="zoneCode" style="display:none;"></span>
		</div>
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		
		<!--模板 开始  -->
		
			<!-- 轮播模板  开始-->
			<div id="owl-carousel-template" class="item" style="width:100%;display:none;">
            	<img src="" width="100%"/><!-- height="200px"   -->
            	<span data-bannerId="bannerId" style="display:none;"></span>
            	<span data-subjectName="subjectName" style="display:none;"></span>
            	<span data-subjectType="subjectType" style="display:none;"></span>
            	<span data-url="url" style="display:none;"></span>
            </div>
			
			<!-- 轮播模板 结束  -->
			
			
			<!-- 分类模板 开始-->
	 		<table style="display:none;">
				<tr>
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
		 	<!-- 分类模板 结束-->

		 	<!-- 促销类型外层div 模板  -->
			<div id="cxActivityDivTemplate" style="width:100%;padding-top:10px;display:none;">
			
			</div>
			
			<!-- 底部留白 -->
			<div id="bottomSpaceTemplate" style="width:100%;margin-bottom:1px;display:none;">
			
			</div>
			
			<!-- 标题模板 开始 -->
			<div id="titleDivTemplate" style="font-size:15px;background:white;border-bottom:1px solid #e7e7e7;padding:10px;display:none;">
				<span data-title="title" style="color:red;margin-left:5px;"></span> 
				<span data-more="more" style="float:right;color:#339AFE;margin-right:5px;">更多&gt;&gt;</span>
				<span data-activityId="activityId" style="display:none;"></span>
				<span data-dataType="dataType" style="display:none;"></span>
			</div>
			<!--图片模板 开始  -->
			<table style="display:none;">
				<tr>
					<!-- 1图片模板  添加 colspan="4"-->
					<td id="oddNumTemplate" style="width:100%;">
						<img src="" width="100%"/><!-- height="100px"  height="150px"-->
						<span data-dataId="dataId" style="display:none;"></span>
						<span data-dataType="dataType" style="display:none;"></span>
						<span data-subjectType="subjectType" style="display:none;"></span>
						<span data-subjectUrl="url" style="display:none;"></span>
						<span data-subjectName="subjectName" style="display:none;"></span>
					</td>
					
					<!-- 2图片模板   添加 colspan="2"-->
					<td id="twoNumTemplate" style="width:50%;" class="tdRightBorder">
						<img src="" width="100%" /><!-- height="150px"  height="130px"-->
						<span data-dataId="dataId" style="display:none;"></span>
						<span data-dataType="dataType" style="display:none;"></span>
						<span data-subjectType="subjectType" style="display:none;"></span>
						<span data-subjectUrl="url" style="display:none;"></span>
						<span data-subjectName="subjectName" style="display:none;"></span>
					</td>
					
					<!-- 3图片模板   添加 colspan="2"-->
					<td id="threeNumTemplate" style="width:50%;" class="tdRightBorder">
						<img src="" width="100%"/><!--height="300px"   height="220px"-->
						<span data-dataId="dataId" style="display:none;"></span>
						<span data-dataType="dataType" style="display:none;"></span>
						<span data-subjectType="subjectType" style="display:none;"></span>
						<span data-subjectUrl="url" style="display:none;"></span>
						<span data-subjectName="subjectName" style="display:none;"></span>
					</td>
					
					<!-- 3图片模板   添加 colspan="2"-->
					<td id="threeNumTemplate2" style="width:50%;vertical-align:top;">
						<div id="threeNumDivTemplate" class="tableBottomBorder">
							<img src="" width="100%"/><!--height="150px"  height="110px" -->
							<span data-dataId="dataId" style="display:none;"></span>
							<span data-dataType="dataType" style="display:none;"></span>
							<span data-subjectType="subjectType" style="display:none;"></span>
							<span data-subjectUrl="url" style="display:none;"></span>
							<span data-subjectName="subjectName" style="display:none;"></span>
						</div>
					</td>
				    
				    <!-- 4图片模板   添加 colspan="1"-->
					<td id="fourNumTemplate" style="width:25%;" class="tdRightBorder">
						<img src="" width="100%"/><!-- height="150px"  -->
						<span data-dataId="dataId" style="display:none;"></span>
						<span data-dataType="dataType" style="display:none;"></span>
						<span data-subjectType="subjectType" style="display:none;"></span>
						<span data-subjectUrl="url" style="display:none;"></span>
						<span data-subjectName="subjectName" style="display:none;"></span>
					</td>
				    
				</tr>
			</table>
			<!--图片模板 结束  -->
			
			<!-- 带有描述信息商品模板 开始 -->
			<table style="display:none;table-layout:fixed;">
				<tr>
					<td id="newsGoodsTdTemplate" style="width:50%;text-align:center;background:white;padding:0 0 5px 0;">
						<div data-imgDiv="imgDiv" style="text-align:left;height:160px;background-size:auto 160px;background-position:center;background-repeat:no-repeat;">
							<img data-huoDong="huoDong" src="<%=uiPath%>business2/images/huodong_tip.png" width="40px" height="40px" style="display:none;margin-left:5px;margin-top:2px;" />
						</div>
						<textarea rows="2" readonly="readonly" disabled="disabled" data-goodsName="goodsName" style="font-size:12px;text-overflow:ellipsis;color:black;background:white;padding-left:15px;padding-right:15px;width:90%;overflow:hidden;border:none;resize:none;margin-left:auto;margin-right:auto;"></textarea>
						<div style="padding-left:15px;padding-right:15px;font-size:12px;">
							<span data-goodsPrice="goodsPrice" class="pull-left" style="text-decoration:line-through;color:grey;"></span>
							<span class="pull-right" style="color:red;">￥<span data-goodsSinglePrice="goodsSinglePrice" ></span></span>
						</div>
						<span data-goodsId="goodsId" style="display:none;"></span>
						<span style="display:none;"></span>
						<span style="display:none;"></span>
					</td>
					
					<td id="newsGoodsEmptyTdTemplate" style="width:50%;text-align:center;padding-bottom:10px;">
						
					</td>
					
				</tr>
			</table>
			<!-- 带有描述信息商品模板 结束 -->
		
		
		<!--模板 结束  -->
		<div data-carousel="owlCarousel" class="owl-carousel" style="width:100%;display:none;">
	          
	    </div>
		
		<table data-goodsSortTable="goodsSortTable"  style="table-layout:fixed;width:100%;text-align:center;margin-top:0;border:none;display:none;background:white;">
			<tr>
				<td class="sortList" style="padding:10px 5px;border:1px solid #e7e7e7;" onclick="goPublicServiceRelateInterface(2)">
					<img src="<%=uiPath%>business2/images/orderlist.png" alt="" width="52px"/>
					<br>
					<span>我的订单</span>
				</td>
				<td class="sortList" style="padding:10px 5px;border:1px solid #e7e7e7;" onclick="goPublicServiceRelateInterface(3)">
					<img src="<%=uiPath%>business2/images/addresslist.png" alt="" width="52px"/><!--height="60px"  -->
					<br>
					<span>收货地址</span>
				</td>
			</tr>
		</table>
		
		<div data-activityDiv="activityDiv" style="width:100%;background:#f6f2ed;display:none;">
		</div>
		<!--模板 结束  -->
		
		
		<div id="contentDiv" style="position:absolute;top:45px;width:100%;overflow-y:auto;overflow-x:hidden;margin:0;padding:0;bottom:66px;"><!--top:50px;  -->
			
	    </div>
		</div>
		
		<div style="position:absolute;bottom:160px;text-align:center;width:100%;">
			<span id="noMoreDataWarning" class="badge" style="display:none;padding:5px 15px;background:red;line-height:30px;"></span>
		</div>
		<div id="goTopDiv" onclick="goToTop()" style="position:absolute;display:none;right:20px;bottom:100px;text-align:center;width:50px;height:50px;background:url(<%=uiPath %>business2/images/button_m_01.png)no-repeat;background-size:100% 100%;"></div>
	</body>
	
</html>