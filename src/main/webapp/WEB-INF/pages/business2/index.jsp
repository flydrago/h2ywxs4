<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>" />
		<title>微商城</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,maxinum-scale=1,minium-scale=1,user-scalable=no">
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css"/>
		<link rel="stylesheet" href="<%=uiPath%>business2/css/index.css"/>
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css"/>
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/spin/spin.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/loading.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/index.js"></script>
	</head>
	<style>
	.tooltip.top .tooltip-arrow{
		border-top-color:red;
		border-width:5px 5px 0px;
	}
	html{
		width:100%;
		height:100%;
		margin:0;
		padding:0;
	}
	.tooltip-inner{
		background:red;
		color:#fff;
		padding:2px 5px;
	}
	.tab-content .frameDiv .tab-pane{
		display: none;
 		visibility: hidden;
	}
	.tab-content .frameDiv .active{
		  display: block;
  		  visibility: visible;
	}
	.nav>li>a{
		height:66px;
		/* padding:10px 15px 0 15px; */
	} 
	.navbar-inverse {
	  background-color: #F3F7F8;
	  border-color: #F3F7F8;
	}
	.nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
	  background-color: #1A90F0;
	  color:#fff;
	}
	</style>
	<script type="text/javascript">
		var imagePath = '<%=imgPath%>';
		var uiPath = '<%=uiPath%>';
		var serverPath = '<%=serverPath%>';
		
		var zone_name = "";
		var zone_code = '${zoneCode}';//区域码
		var openId = '${openId}';//openid
		var pagesize = 10;
		
		var spinner = null;
	</script>
	
	<body style="width:100%;height:100%;margin:0;padding:0;font-size:12px;overflow:hidden;">
		<div class="tab-content" >
			<div class="frameDiv" style="position:relative;-webkit-overflow-scrolling:touch;max-width:640px;min-width:320px;height:100%;margin:0 auto;padding:0;overflow:hidden;">
				<iframe id="home" class="tab-pane iframeStyle active" style=""></iframe>
				<iframe id="goodsSort" class="tab-pane iframeStyle" style=""></iframe>
				<iframe id="shoppingCart" class="tab-pane iframeStyle" style=""></iframe>
			 </div>
		</div>
		
		<!-- 底部导航栏  开始-->
		<ul id="myTab" class="nav nav-pills navbar-inverse navbar-fixed-bottom" style="position:absolute;bottom:-1px;height:66px;padding:0;max-width:640px;min-width:320px;margin:0 auto;">
		   <li id="tab_home" class="active" onclick="qieHuan(1)" style="width:33%;margin-left:0px;text-align:center;border-right:1px solid #e7e7e7;">
			   <a href="#home" data-toggle="pill" style="text-align:center;">
				  <span class="glyphicon glyphicon-home" style="font-size:18px;"></span><br/>
				   <span style="text-align:center;font-size:12px">首页</span>
			   </a>
		   </li>
		   <li id="tab_sort" onclick="qieHuan(2)" style="width:34%;margin-left:0px;text-align:center;border-right:1px solid #e7e7e7;">
			   <a href="#goodsSort" data-toggle="pill" >
				   <span class="glyphicon glyphicon-th-list" style="font-size:18px"></span><br/>
				   <span style="text-align:center;font-size:12px">分类</span>
			   </a>
		    </li>
		   <li id="tab_cart" onclick="qieHuan(4)"style="width:33%;margin-left:0px;text-align:center;">
			   <a href="#shoppingCart" data-toggle="pill">
				 <span id="goodsCount" class="badge" style="position:absolute;display:none;top:-5px;z-index:2;background:red;color:#fff;"></span>
				 <span class="glyphicon glyphicon-shopping-cart" style="font-size:18px"></span><br/>
				   <span style="text-align:center;white-space:nowrap;font-size:12px">购物车</span>
			   </a>
			   <div id="goodsCount" class="tooltip fade top in" style="z-index:3;top:0px;left:50%;display:none;">
					<div class="tooltip-arrow"></div>
					<div class="tooltip-inner"></div>
				</div>
		   </li>
		</ul>
		<!-- 底部导航栏  结束-->
		<div id="loadingDiv" style="display:none;"></div>
	</body>
</html>