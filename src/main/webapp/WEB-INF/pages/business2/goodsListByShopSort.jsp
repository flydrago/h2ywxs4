<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<%-- <base href="<%=basePath%>" /> --%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<%-- <link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.theme.default.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.carousel.min.css" /> --%>
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<%-- <script type="text/javascript" src="<%=uiPath%>lib/OwlCarousel/owl.carousel.min.js"></script> --%>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/goodsListByShopSort.js"></script>
		<title>本地服务门店对应商品列表</title>
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
		
		.list-group-item:first-child, .list-group-item:last-child{
			border-top-left-radius: 0px;
			border-top-right-radius: 0px;
			border-top:none;
			border-bottom:none;
		}
		
		.pull-left .list-group-item{
			background-color:#EEEEEE;
			border:none;
		}
		.list-group-item{
			border:none;
		}
		.pull-left .list-group-item:active, .pull-left .list-group-item:focus , .pull-left .list-group-item:hover{
			color: red;
			background-color: white;
			border:none;
		}
		
		.pull-left .list-group-item.active, .pull-left .list-group-item.active:focus, .pull-left .list-group-item.active:hover{
			color: red;
			background-color:white;
			text-decoration:none;
			border:none;
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
		<!-- 顶部标题栏 -->
		<%-- <div style="position:absolute;background:#1a90f0;width:100%;height:45px;z-index:3;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<!-- 公司logo -->
					<td onclick="_goBack()" style="width:105px;padding-left:5px;">
						<div style="width:105px;height:30px;line-height:30px;background-image:url(<%=uiPath%>business2/images/logo.png);background-size:70px;background-position:35px center;background-repeat:no-repeat;">
							<img src="<%=uiPath%>business2/images/goBack.png" width="30px" />
						</div>
					</td>
					<!-- 搜索框 -->
					<td style="padding-left:5px;padding-right:5px;">
						<input type="text" readonly="readonly" placeholder="搜索酒运达商品" onclick="goGoodsSearchInterface()" style="width:100%;height:35px;border:none;padding-left:28px;background-image:url(<%=uiPath%>business2/images/search.png);background-size:22px 22px;background-repeat:no-repeat;background-position:3px center;" />
					</td>
					<!-- 列表显示样式切换 -->
					<td style="width:35px;padding-left:10px;padding-right:5px;text-align:right;" onclick="switListOrGridStyle()">
						<img id="list_show" src="<%=uiPath%>business2/images/listIcon.png" width="30px" />
						<img id="grid_show" src="<%=uiPath%>business2/images/gridIcon.png" width="30px" style="display:none;"/>
					</td>
			  </tr>
			</table>
		</div> --%>
		<div style="position:absolute;width:100%;height:45px;background:#1a90f0;text-align:center;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<td onclick="_goBack()" style="width:30px;padding-left:8px;padding-right:5px;">
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
					</td>
					
					<!-- 标题 -->
					<td style="padding-left:5px;padding-right:5px;text-align:center;">
						<span style="color:#FFF;">门店详情</span>
					</td>
					
					<!-- 更多 -->
					<td style="width:30px;">
						
					</td>
			  </tr>
			</table>
		</div>
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		
		<!-- 综合 价格 销量 排序显示  -->
		<div style="position:absolute;top:45px;width:100%;background:#ebf2fc;height:40px;z-index:3; display:none;">
			<table style="width:100%;text-align:center;">
				<tr style="width:100%;">
					<td onclick="switSynOrPriOrSal(this,1)" class="divider" style="width:33.33%;padding-top:5px;padding-bottom:5px;">
						<span>综合</span>
						<div style="position:absolute;width:33.33%;left:0;bottom:-5px;;text-align:center;"><img src="<%=uiPath%>business2/images/tab_selected.png"/></div>
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
					<div data-privilege="huoDongOrCuXiao" class="huodongtip" style="position:absolute;z-index:2;width:30px;height:30px;display:none;"></div>
					<img src="" data-img="img" width="80px" height="80px" style="float:left"/>
					<div style="position:absolute;height:80px;left:120px;right:10px;">
						<p class="oneLineWordsShow" data-name="name" style="margin-bottom:2px;"></p>
						<p style="color:red;font-weight:bold;margin-bottom:2px;">
							<span>会员价:</span>
							<span>￥&nbsp;<span data-price="single"></span></span>
							<span data-isGift="isGift" class="badge pull-right" style="background:red;color:#fff;display:none;">赠</span>
						</p>
						<p style="color:grey;margin-bottom:2px;">
							<span style="text-decoration:line-through;">市场价:</span>
							<span style="text-decoration:line-through;">￥&nbsp;<span data-price="market"></span></span>
						</p>
						<p style="display:none">
							<span data-id="id"></span>
						</p>
					</div>
				</td>
			</tr> 
			<!-- 一行一个模板  结束 -->
			
			<!-- 一行两个模板  开始-->
			<tr>
				<td class="tdRightBorder" id="line_two_template" data-list-per="perItem"  style="width:50%;border-bottom:1px solid #e7e7e7;">
					<div data-privilege="huoDongOrCuXiao" class="huodongtip" style="position:absolute;z-index:2;width:30px;height:30px;display:none;"></div>
					<img src="" data-img="img" width="100%" style="border:none;border-spacing:0;" />
					<div style="margin-left:8px;margin-bottom:5px;right:0px;">
						<p class="oneLineWordsShow" data-name="name" style="margin-bottom:2px;"></p>
						<p style="color:red;font-weight:bold;margin-top:2px;margin-bottom:2px;">
							<span data-priceName="priceName">会员价:</span>
							<span>￥&nbsp;<span data-price="single">899</span></span>
							<span data-isGift="isGift" class="badge pull-right" style="background:red;color:#fff;display:none;">赠</span>
						</p>
						<p style="color:grey;margin-top:2px;margin-bottom:2px;">
							<span style="text-decoration:line-through;">市场价:</span>
							<span style="text-decoration:line-through;">￥&nbsp;<span data-price="market"></span></span>
						</p>
						<p style="display:none">
							<span data-id="id">id</span>
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
		<div id="contentDiv" style="position:absolute;top:45px;width:100%;overflow-y:auto;bottom:80px;"><!--top:88px;  -->
	       
	        <div style="width:100%;height:150px;">
	        	
	        	<!--缩略图  -->
	        	<div style="width:100%;height:100%;z-index:2;">
	      	  		<img id="thumbPic" height="100%" width="100%"/>
	      	  	</div>
	      	  	
	      	  	<!-- logo -->
	      	  	<div style="position:relative;padding:0 10px;z-index:30;margin-top:-80px;float:right;">
	      	  		<img id="logoPic" height="80px" width="80px"/>
	      	  	</div>
	      	  	
	      	  	<!-- 星级 -->
	      	  	<div style="position:relative;width:100%;height:40px;padding:2px 10px;margin-top:-40px;z-index:3;">
	      	  		<div style="position:absolute;width:100%;height:100%;background:black;top:0;left:0;z-index:2;opacity:0.5;"></div>
	      	  		<div id="deptName" style="position:relative;display:block;color:white;font-weight:bold;padding-left:3px;z-index:100;"></div>
	      	  		<div id="startLeval" class="startLeval" style="position:relative;display:inline-block;height:15px;width:20px;z-index:100;"></div>
	      	  		<span style="position:relative;color:#FE9C09;z-index:100;"><span data-leval="numLeval">5</span>分</span>
	      	  		
	      	 	 </div>
	      	  
	        </div>
	        
	        <!--地址  -->
			<div class="panel-heading">
				<img src="<%=uiPath%>business2/images/icon_address.png" width="25px" height="25px"/>
				<span id="address"></span>
			</div>
			<!--电话  -->
			<div class="panel-footer" style="display:none;">
				<img src="<%=uiPath%>business2/images/shop_phone.png" width="25px" height="25px"/>
				<a id="phone" href="javascript:void(0)"></a>
			</div>
			
			<table id="goods_table" style="width:100%;">
				
			</table>
			<div style="width:100%;text-align:center;margin-top:20px;">
				<div id="bottomMoreBtn" style="display:none;width:98%;height:40px;color:#FFF;font-size:16px;">上拉加载更多</div>
<!-- 				<button id="bottomMoreBtn" class="btn btn-primary" onclick="lookMoreGoods()"style="display:none;width:98%;height:40px;color:#FFF;font-size:16px;">点击查看更多</button> -->
				<span id="noMoreDataWarning" class="badge" style="display:none;background:red;line-height:30px;">没有更多数据!</span>
			</div>
		</div>
		
		<!-- 模板 开始-->
		<a id="leftNavTemplate" href="javascript:void(0)" data-toggle="tab" class="list-group-item" style="display:none;"><span data-sortName="sortName"></span><span class="glyphicon glyphicon-menu-right pull-right"></span></a>
		<a id="rightNavTemplate" href="javascript:void(0)" data-toggle="tab" class="list-group-item" style="display:none;"><span data-sortName="sortName" ></span><span style="display:none;"><span data-parentId="parentId"></span><span data-id="id"></span></span></a>
		
		<div id="sortDiv" style="position:absolute;width:100%;top:85px;bottom:120px;background:#fff;z-index:3;display:none;">
	        
	         <div id="navLeft" class="pull-left" style="display:inline-block;width:50%;height:100%;background:#fff;overflow-y:auto;">
	       
	         </div>
	       
	         <div id="navRight" class="pull-right" style="display:inline-block;width:50%;height:100%;background:#fff;overflow-y:auto;">
	         	
		     </div>
		</div>
          
          
          
			<!-- 轮播模板-->
			<div id="owl-carousel-template" class="item" style="display:none;width:100%;text-align:center;">
	        	<img src=""/>
	        </div>
			 <!-- 轮播 -->
			<div id="picExplore" style="display:none;position:absolute;top:0;left:0;right:0;bottom:0;z-index:100;background:black;">
				<table style="width:100%;height:100%;">
				<tr>
					<td>
						<div id="owl-carousel-show" class="owl-carousel" style="display:none;max-height:100%;">
			            
			       		 </div>
					</td>
				</tr>
		        </table>
	        </div>
	        </div>
		        
	</body>
	
<script type="text/javascript">
	
		var paraJson = ${paraJson};
		var zone_code = window.top.zone_code;
		var imagePath = window.top.imagePath;
		var page = 1;		
		var pageSize = 10;
		/** 排序类型  全部(默认):0  分类:1 距离:升(20)降(21)*/
		var rankType = 0;
		var unitId = paraJson.unitId;
		var mId = paraJson.id;
		
		 /**
		  * 初始化页面 
		  */
		 $(document).ready(function(){
				 $(window.parent.document).find("#myTab").show();
				 getGoodsList(page, pageSize, unitId, zone_code, "", "",mId);
			 });
	</script>
</html>