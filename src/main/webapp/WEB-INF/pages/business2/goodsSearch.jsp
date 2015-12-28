<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.theme.default.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.carousel.min.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/OwlCarousel/owl.carousel.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/goodsSearch.js"></script>
		<title>商品列表</title>
	</head>
	
	<style type="text/css">
		
		/* 列表每行点击时的颜色 */
		[data-list-per=perItem]:active{
			background:#D9D9D9;
		}
		
		.glyphicon:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		
		button:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
	</style>
	
	<body style="width:100%;height:100%;background:#f6f2ed;" >
		<div style="-webkit-overflow-scrolling:touch;">
		<!-- 顶部标题栏 -->
		<div style="position:absolute;background:#1a90f0;width:100%;height:45px">
			<table style="width:100%;margin-top:2px;">
				<tr >
					<!-- 返回键 -->
					<td onclick="_goBack()" style="width:45px;padding-left:10px;">
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
					</td>
					<!-- 搜索框 -->
					<td style="padding-left:5px;padding-right:5px;">
						<input id="searchContent" class="homeTitleInput" type="text" placeholder="搜索商品" onfocus="searchInputGetFocus()" />
					</td>
					<!-- 列表显示样式切换 -->
					<td style="width:35px;padding-left:10px;padding-right:5px;text-align:right;" onclick="searchGoods()">
						<span class="pull-right" style="color:#fff;margin-right:10px;">搜&nbsp;索</span>
					</td>
			  </tr>
			</table>
		</div>
		
		<!-- 列表项模板 开始 -->
		<table style="display:none">
			<!-- 一行一个模板 开始 -->
			<tr id="line_one_template" data-list-per="perItem" style="width:100%;background:#fff;border-bottom:1px solid #E7E7E7;">
				<td style="padding:10px;height:80px">
					<img src="" data-img="img" width="80px" height="80px" style="float:left"/>
					<div style="position:absolute;height:80px;left:100px;right:10px;">
						<p class="oneLineWordsShow" data-name="name" style="margin-bottom:2px;"></p>
						<p style="color:red;font-weight:bold;margin-bottom:2px;">
							<span data-priceName="priceName">会员价:</span>
							<span>￥&nbsp;<span data-price="single"></span></span>
						</p>
						<p style="color:grey;margin-bottom:2px;">
							<span >市场价:</span>
							<span style="text-decoration:line-through;">￥&nbsp;<span data-price="market"></span></span>
						</p>
						<p style="display:none">
							<span data-id="id"></span>
						</p>
					</div>
				</td>
			</tr> 
			<!-- 一行一个模板  结束 -->
			
		</table>
		
		<!-- 列表项模板 结束 -->

		<!-- ----------------------------------------------------------------------------------------------------------------- -->

		<!-- 列表 -->
		<div id="searchGoodsList" style="position:absolute;top:45px;width:100%;overflow-y:auto;bottom:66px;padding-bottom:20px;display:none;">
			
			<table id="goods_table" style="width:100%;">
			
			</table>
			
			<div style="width:100%;text-align:center;margin-top:20px;">
				<div id="bottomMoreBtn" style="display:none;width:98%;height:40px;">上拉加载更多</div>
<!-- 				<button id="bottomMoreBtn" class="btn btn-primary" onclick="lookMoreGoods()"style="display:none;width:98%;height:40px;">点击查看更多</button> -->
		        <span id="noMoreDataWarning" class="badge" style="display:none;background:red;line-height:30px;">没有更多数据!</span>
			</div>
		</div>
		<div id="warmTipWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:96px;color:#fff;"><span class="badge" style="background:black;line-height:30px;">请输入搜索内容</span></div>
		</div>
	</body>
	

	
	<script type="text/javascript">
		
		var imagePath = window.top.imagePath;
		var page = 1;
		var pageSize = 10;
		var zoneCode = window.top.zone_code;
		
		 /**
		  * 初始化页面 
		  */
		 $(function(){
		 
		 });
	</script>
</html>