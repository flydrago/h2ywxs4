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
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/showTip.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/myCare.js"></script>
		<title>关注列表</title>
	</head>
	
	<style type="text/css">
		p{
			margin-bottom:0px;
		}
		tr:active{
			background:#D9D9D9;
		}
		button:active,.glyphicon:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		
	</style>
	
	<body>
	<div style="-webkit-overflow-scrolling:touch;">
		<!-- 顶部标题栏 -->
		<!-- <div style="width:100%;height:40px;background:#1A90F0;text-align:center;">
			<div class="pull-left" style="display:inline-block;padding:8px 10px 8px 0;" onclick="_goBack()">
				<span class="glyphicon glyphicon-menu-left pull-left" style="color:#FFF;font-size:20px;margin-left:10px;"></span>
			</div>
			<div style="display:inline-block;" >
				<span style="color:#FFF;font-size:25px;line-height:40px;">我的关注</span>
			</div>
			<div class="pull-right" style="display:inline-block;padding-right:10px;">
				<span class="pull-right" style="color:#FFF;margin-right:10px;line-height:40px;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</div>
		</div> -->
		
		<div style="position:absolute;width:100%;height:45px;background:#1a90f0;text-align:center;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<td onclick="_goBack()" style="width:43px;padding-left:8px;padding-right:5px;text-align:left;">
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
					</td>
					
					<!-- 标题 -->
					<td style="padding-left:5px;padding-right:5px;text-align:center;">
						<span style="color:#FFF;font-size:18px;">我的关注</span>
					</td>
					
					<!-- 更多 -->
					<td style="width:43px;">
						
					</td>
			  </tr>
			</table>
		</div>
		<!-- 模板开始 -->
		<table style="width:100%;display:none;">
		    <tr id="careGoodsTemplate" style="width:100%;border-bottom:1px solid #E7E7E7;">
				<td style="padding:5px 10px;width:80px">
					<div style="width:80px;height:80px;border-radius:3px;"><!-- background:url(<%=uiPath%>business2/images/icon1.png) top center no-repeat; -->
						<img src="" data-img="img" style="width:80px;height:80px;"/>
					</div>
				</td>
				<td style="padding:5px 10px">
					<p data-name="name" class="oneLineWordsShow" style="width:100%;"></p>
					<p style="color:red;">
						<span data-priceName="priceName"></span>
						<span>￥&nbsp;<span data-price="single"></span></span>
					</p>
					<p>
						<span style="color:grey;text-decoration:line-through;">市场价:</span>
						<span style="text-decoration:line-through;color:grey">￥&nbsp;<span data-price="market"></span></span>
					</p>
					<p style="display:none">
						<!-- <span data-goodsId="goodsId"></span> -->
						<span data-id="id"></span>
					</p>
				</td>
			</tr> 
		</table>
		<!-- 模板结束 -->
		<div id="contentDiv" style="position:absolute;top:45px;bottom:66px;padding-bottom:20px;width:100%;overflow-y:auto;">
			<table id="care_table" style="width:100%;table-layout:fixed;">
			</table>
			<div id="lookMoreBtn" style="display:none;width:98%;margin-left:auto;margin-right:auto;margin-top:10px;">
				<div class="checkMoreOrder" style="width:100%;">上拉加载更多</div>
<!-- 				<button type="button" class="btn btn-primary checkMoreOrder" onclick="lookMoreCare(this)"style="width:100%;">查看更多</button> -->
			</div>
		</div>
		
		
		<div id="warmWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:76px;color:#fff;">
			<span class="badge" style="background:red;line-height:25px;"></span>
		</div>
		</div>
	</body>
</html>