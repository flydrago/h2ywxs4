<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/adPerBannerGoodsList.js"></script>
		<title>商品列表</title>
	</head>
	
	<style type="text/css">
		
		/* 列表每行点击时的颜色 */
		[data-list-per=perItem]:active{
			background:#D9D9D9;
		}
		
		img:active, .glyphicon:active, button:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
	</style>
	
	<body style="width:100%;height:100%;" >
		<div style="-webkit-overflow-scrolling:touch;">
		<!-- 顶部标题栏 -->
		<div style="position:absolute;background:#1a90f0;width:100%;height:45px;z-index:3;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<!-- 公司logo -->
					<td onclick="_goBack()" style="width:30px;padding-left:8px;padding-right:5px;">
						<!-- <span class="glyphicon glyphicon-menu-left" style="color:#FFF;font-size:25px;"></span> -->
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
					</td>
					<!-- 搜索框 -->
					<td style="padding-left:5px;padding-right:5px;text-align:center;">
						<span id="titleBar" style="color:#FFF;">${subjectName}</span> <!-- font-size:20px; -->
					</td>
					<!-- 列表显示样式切换 -->
					<td style="width:30px;padding-right:8px;" onclick="switListOrGridStyle()">
						<!-- <span id="list_show" class="glyphicon glyphicon-th-list pull-right" style="color:#FFF;font-size:25px;margin-right:10px;"></span>
						<span id="grid_show" class="glyphicon glyphicon-th-large pull-right" style="display:none;color:#FFF;font-size:25px;margin-right:10px;"></span> -->
						<img id="list_show" src="<%=uiPath%>business2/images/listIcon.png" width="28px" />
						<img id="grid_show" src="<%=uiPath%>business2/images/gridIcon.png" width="28px" style="display:none;"/>
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
					<img src="" data-img="img" width="80px" height="80px" style="float:left" />
					<!-- <div style="float:left;height:80px;margin-left:8px;"> -->
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
						<p class="oneLineWordsShow" data-name="name" style="margin-top:0px;margin-bottom:4px;"></p>
						<p style="color:red;font-weight:bold;margin-top:2px;margin-bottom:2px;">
							<span data-priceName="priceName">会员价:</span>
							<span>￥&nbsp;<span data-price="single">899</span></span>
							<span data-isGift="isGift" class="badge pull-right" style="background:red;color:#fff;display:none;">赠</span>
						</p>
						<p style="color:grey;margin-top:2px;margin-bottom:2px;">
							<span style="text-decoration:line-through;">市场价:</span>
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
		<div id="contentDiv" style="position:absolute;top:45px;width:100%;overflow-y:auto;bottom:66px;">
			
			<table id="adGoods_table" style="table-layout:fixed;width:100%;">
				
			</table>
			<div style="width:100%;text-align:center;margin-top:20px;margin-bottom:20px;">
				<button id="bottomMoreBtn" class="btn btn-primary" onclick="lookMoreGoods()"style="display:none;width:98%;height:40px;">点击查看更多</button>
				<span id="noMoreDataWarning" class="badge" style="display:none;background:red;line-height:30px;">没有更多数据!</span>
			</div>
		</div>
		</div>
	</body>
	

	
	<script type="text/javascript">
	
		var imagePath = window.top.imagePath;
		var page = ${page};
		var pageSize = ${pageSize};
		var bannerId = ${bannerId};
		 /**
		  * 初始化页面 
		  */
		 $(function(){
			 $(window.parent.document).find("#myTab").show();
			 getAdPerBannerGoodsList( page, pageSize, bannerId);
		 });
	</script>
</html>