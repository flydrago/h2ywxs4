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
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/showTip.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/goodsList.js"></script>
		<title>商品列表</title>
	</head>
	
	<style type="text/css">
		
		/* 列表每行点击时的颜色 */
		[data-list-per=perItem]:active{
			background:#D9D9D9;
		}
		
		.glyphicon:active,button:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
	</style>
	
	<body style="width:100%;height:100%;" >
		<div style="-webkit-overflow-scrolling:touch;">
		<!-- 顶部标题栏 -->
		<div style="position:absolute;background:#1a90f0;width:100%;height:45px">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<!-- 公司logo -->
					<td onclick="_goBack()" style="width:105px;padding-left:5px;">
						<%-- <div style="width:105px;height:30px;line-height:30px;background-image:url(<%=uiPath%>business2/images/logo.png);background-size:70px;background-position:35px center;background-repeat:no-repeat;">
							<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
						</div> --%>
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
						<img src="<%=uiPath%>business2/images/logo.png" width="70px" />
					</td>
					<!-- 搜索框 -->
					<td style="padding-left:5px;padding-right:5px;">
						<input type="text" class="homeTitleInput" readonly="readonly" placeholder="搜索酒运达商品" onclick="goGoodsSearchInterface()" style="width:100%;height:35px;border:none;padding-left:28px;background-image:url(<%=uiPath%>business2/images/search.png);background-size:22px 22px;background-repeat:no-repeat;background-position:3px center;" />
					</td>
					<!-- 列表显示样式切换 -->
					<td style="width:35px;padding-left:10px;padding-right:5px;text-align:right;" onclick="switListOrGridStyle()">
						<img id="list_show" src="<%=uiPath%>business2/images/listIcon.png" width="30px" />
						<img id="grid_show" src="<%=uiPath%>business2/images/gridIcon.png" width="30px" style="display:none;"/>
					</td>
			  </tr>
			</table>
		</div>
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		
		<!-- 综合 价格 销量 排序显示  -->
		<div style="position:absolute;top:45px;width:100%;background:#ebf2fc;height:40px;z-index:3;">
			<table style="width:100%;text-align:center;">
				<tr style="width:100%;">
					<td onclick="switSynOrPriOrSal(this,1)" class="divider" style="width:33.33%;padding-top:5px;padding-bottom:5px;">
						<span>综合</span><!-- height:3px;margin-top:-3px; -->
						<div style="position:absolute;width:33.33%;left:0;bottom:-5px;text-align:center;"><img src="<%=uiPath%>business2/images/tab_selected.png"/></div>
					</td>
					<td onclick="switSynOrPriOrSal(this,2)" class="divider" style="width:33.33%;padding-top:10px;padding-bottom:10px;">
						<span>价格&nbsp;<span id="price_icon" class="glyphicon glyphicon-menu-up" style="visibility:hidden;color:red;"></span></span>
						<div style="visibility:hidden;position:absolute;width:33.33%;left:33.33%;bottom:-5px;text-align:center;"><img src="<%=uiPath%>business2/images/tab_selected.png" /></div>
					</td>
					<td onclick="switSynOrPriOrSal(this,3)" style="width:33.33%;padding-top:10px;padding-bottom:10px;">
						<span>销量</span>
						<div style="visibility:hidden;position:absolute;width:33.33%;left:66.66%;right:33.33%;bottom:-5px;text-align:center;"><img src="<%=uiPath%>business2/images/tab_selected.png" /></div>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		
		<!-- 列表项模板 开始 -->
		<table style="width:100%;display:none">
		
			<!-- 一行一个模板 开始 -->
			<tr id="line_one_template" data-list-per="perItem" style="width:100%;border-bottom:1px solid #E7E7E7;">
				<td style="padding:10px;height:80px">
					<div data-privilege="huoDongOrCuXiao" class="huodongtip" style="position:absolute;z-index:2;width:25px;height:25px;display:none;"></div>
					<img src="" data-img="img" width="80px" height="80px" style="float:left"/>
					<div style="position:absolute;height:80px;left:100px;right:10px;">
						<p class="oneLineWordsShow" data-name="name" style="margin-bottom:2px;"></p>
						<p style="color:red;font-weight:bold;margin-bottom:2px;">
							<span data-priceName="priceName">会员价:</span>
							<span>￥&nbsp;<span data-price="single">899</span></span>
							<span data-isGift="isGift" class="badge pull-right" style="background:red;color:#fff;display:none;">赠</span>
						</p>
						<p style="color:grey;margin-bottom:2px;">
							<span style="text-decoration:line-through;">市场价:</span>
							<span style="text-decoration:line-through;">￥&nbsp;<span data-price="market">999</span></span>
						</p>
						<p style="display:none">
							<span data-id="id">id</span>
							<span data-version="version">version</span>
						</p>
					</div>
				</td>
			</tr> 
			<!-- 一行一个模板  结束 -->
			
			<!-- 一行两个模板  开始-->
			<tr>
				<td class="tdRightBorder" id="line_two_template" data-list-per="perItem"  style="width:50%;border-bottom:1px solid #e7e7e7;">
					<div data-privilege="huoDongOrCuXiao" class="huodongtip" style="position:absolute;z-index:2;width:25px;height:25px;display:none;"></div>
					<img src="" data-img="img" width="100%" style="border:none;border-spacing:0;" />
					<div style="margin-left:8px;margin-bottom:5px;">
						<p class="oneLineWordsShow" data-name="name" style="margin-top:0px;margin-bottom:4px;width:100px;"></p>
						<p style="color:red;font-weight:bold;margin-top:2px;margin-bottom:2px;">
							<span data-priceName="priceName">会员价:</span>
							<span>￥&nbsp;<span data-price="single">899</span></span>
							<span data-isGift="isGift" class="badge pull-right" style="background:red;color:#fff;display:none;">赠</span>
						</p>
						<p style="color:grey;margin-top:2px;margin-bottom:2px;">
							<span >市场价:</span>
							<span style="text-decoration:line-through;">￥&nbsp;<span data-price="market">999</span></span>
						</p>
						<p style="display:none">
							<span data-id="id">id</span>
							<span data-version="version">version</span>
						</p>
					</div>
				</td>
				<td id="line_two_empty_template" style="width:50%;">
					
				</td>
			</tr>
			<!-- 一行两个模板  结束 -->
		</table>
		
		<!-- 列表项模板 结束 -->

		<!-- ----------------------------------------------------------------------------------------------------------------- -->

		<!-- 列表 -->
		<div id="contentDiv" style="position:absolute;top:85px;width:100%;overflow-y:auto;bottom:80px;">
			<table id="goods_table" style="table-layout:fixed;width:100%;">
				
			</table>
			<div style="width:100%;text-align:center;margin-top:20px;">
				<!-- <button id="bottomMoreBtn" class="btn btn-primary" onclick="lookMoreGoods()"style="display:none;width:98%;height:40px;">点击查看更多</button> -->
				<div id="bottomMoreBtn" style="display:none;width:98%;height:40px;">上拉加载更多</div>
				<span id="noMoreDataWarning" class="badge" style="display:none;background:red;line-height:30px;">没有更多数据!</span>
			</div>
		</div>
		</div>
	</body>
	

	
	<script type="text/javascript">
	
		var goodsTypeId = '${goodsTypeId}';
		var zone_code = window.top.zone_code;
		var imagePath = window.top.imagePath;
		var page = 1;		
		var pageSize = 10;
		/** 排序类型  综合(默认):0 价格:升(10)降(11) 销量:(2)*/
		var rankType = 0;
		var markId = '${markId}';
		var markInfoId = '${markInfoId}';
		var keyWords = '${keyWords}';
		 /**
		  * 初始化页面 
		  */
		 $(function(){
			 $(window.parent.document).find("#myTab").show();
			 getGoodsList(page, pageSize, zone_code, goodsTypeId, rankType,markId,markInfoId,keyWords);
		 });
	</script>
</html>