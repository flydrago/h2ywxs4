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
		<script type="text/javascript" src="<%=uiPath%>business2/js/goodsSort.js"></script>
		<title>分类</title>
	</head>
	
	<style>
	button:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
	}
	.list-group-item:first-child, .list-group-item:last-child{
		border-top-left-radius: 0px;
		border-top-right-radius: 0px;
		border-top:1px solid #e7e7e7;
		border-bottom:1px solid #e7e7e7;
	}
	
	.list-group-item{
		border-top:1px dotted #e7e7e7;
		border-bottom:1px dotted #e7e7e7;
		border-left:none;
		border-right:none;
	}
		
	.nav>li>a{
		color:black;
	}
	.nav>li>a:focus, .nav>li>a:hover {
		text-decoration: none;
		/*background-color: #bcbcbc;*/
		color: red;
	}
	
	.nav>li.active>a, .nav>li.active>a:focus, .nav>li.active>a:hover {
		color: red;
		background-color: #F9F9F9;
		text-decoration: none;
	}
	
	
	.list-group-item:active, .list-group-item:focus, .list-group-item:hover {
		z-index: 2;
		background-color: #efefef;
		border-top:1px dotted #e7e7e7;
		border-bottom:1px dotted #e7e7e7;
	}
	.list-group-item.active, .list-group-item.active:focus, .list-group-item.active:hover {
		z-index: 2;
		background-color: #efefef;
		border-top:1px dotted #e7e7e7;
		border-bottom:1px dotted #e7e7e7;
	}
	
	</style>
	
	<body style="width:100%;height:100%;">
	<div style="-webkit-overflow-scrolling:touch;">
		<div style="-webkit-overflow-scrolling:touch;">
		<!-- 顶部标题栏 -->
		<div style="position:absolute;background:#1A90F0;width:100%;height:45px">
			<table style="width:100%;margin-top:3px;">
				<tr >
					<!-- 搜索框 -->
					<td style="padding-left:5px;padding-right:5px;">
						<input class="homeTitleInput" type="text" readonly="readonly" placeholder="搜索酒运达商品" onclick="goGoodsSearchInterface()" /> 
					</td>
				</tr>
			</table>
		</div>
		
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		
		<!-- 左侧导航 -->
		
		<!-- 模板 开始-->
		<ul style="display:none;">
		   <li id="left_nav_template" class="list-group-item" onclick="selectWineType(this)" style="background-color:#F6F2ED;padding:0;">
			   <a data-toggle="tab" style="padding:20px 6px;">
				   <span data-goodsType="goodsType"></span>
				   <span data-goodsTypeId="goodsTypeId" style="display:none"></span>
			   </a>
		   </li>
		</ul>
		<!-- 模板 结束-->
		
		<div id="selected_flag" style="position:absolute;top:62px;left:70px;z-index:3;">
			<img  src="<%=uiPath%>business2/images/tab_select.png" >
		</div>
		<div style="position:absolute;top:45px;width:80px;overflow-y:visible;overflow-x:hidden;bottom:66px;background:#F6F2ED;border-right:1px solid #e7e7e7;">
			
			<ul id="left_nav" class="nav" style="float:left;width:100%;text-align:center;">
			   
			</ul>
			
		</div>
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		 
		<!-- 右侧显示 -->
		<ul id="right_goodsType" class="list-group" onclick="goGoodsListInterface(this)" style="position:absolute;top:45px;left:80px;right:0px;margin:0;">
		   <li class="list-group-item" style="height:42px;border-left:none;border-radius:0px;padding:10px 8px 10px 15px;">
			   <span data-goodsType="goodsType" style="color:#47AAEC"></span>
			   <span data-goodsTypeId="goodsTypeId" style="display:none"></span>
			   <span class="pull-right" style="color:#C4C4C7;">查看全部
			   <span class="glyphicon glyphicon-menu-right" style="color:#C4C4C7;"></span></span>
		   </li> 
		</ul>
		
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		
		<!-- 模板 开始 -->
		<table style="display:none;table-layout:fixed;">
			<tr>
				<td class="tdRightBorder" id="line_two_template" data-list-per="perItem"  style="width:50%;text-align:center;border-bottom:1px solid #e7e7e7;">
					<div style="width:100%;text-align:center;">
						<div data-privilege="huoDongOrCuXiao" class="huodongtip" style="position:absolute;z-index:2;width:35px;height:35px;display:none;"></div>
						<img src="" width="80px" height="80px"style="border:none;border-spacing:0;"/>
					</div>
					<textarea rows="2" readonly="readonly" data-name="name" style="text-overflow:ellipsis;font-size:12px;overflow:hidden;border:none;resize:none;margin-left:auto;margin-right:auto;width:90%;" ></textarea>
					<span data-id="id" style="display:none"></span>
					<div style="padding-left:15px;padding-right:15px;font-size:12px;">
						<span data-goodsPrice="goodsPrice" class="pull-left" style="text-decoration:line-through;color:grey;display:none;"></span>
						<span class="pull-left" style="color:red;">￥<span data-goodsSinglePrice="goodsSinglePrice" ></span></span>
					</div>
				</td>
				
				<td id="line_two_empty_template" style="width:50%;">
					
				</td>
			</tr>
		</table>
		<!-- 模板 结束 -->
		
		<!-- 列表 -->
		<div id="contentDiv" style=";position:absolute;top:90px;padding-bottom:20px;bottom:66px;left:80px;right:0px;overflow-y:auto;overflow-x:hidden;">
			<table id="goods_table" style="table-layout:fixed;width:100%;">
				
			</table>
			<div id="secSortDiv" style="width:100%;padding:5px;text-align:center;"></div>
			<div style="width:100%;text-align:center;margin-top:20px;">
				<!-- <button id="bottomMoreBtn" class="btn btn-primary" onclick="lookMoreGoods()"style="display:none;width:90%;height:40px;">点击查看更多</button> -->
				<span id="noMoreDataWarning" class="badge" style="display:none;background:red;line-height:30px;">没有更多数据!</span>
			</div>
		</div>
	</div>
	</div>
	</body>
	
</html>