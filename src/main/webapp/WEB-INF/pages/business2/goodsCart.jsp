<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.theme.default.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/OwlCarousel/css/owl.carousel.min.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/jquery-migrate-1.2.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/OwlCarousel/owl.carousel.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/accurateMathCalculate.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/goodsCart.js"></script>
		<title>购物车</title>
	</head>
	<style>
		h4{
			margin-top:0px;
			margin-bottom:0px;
		}
		p{
			margin-bottom:0px;
		}
		
		
		/* 去除type=number的箭头  开始 */
		input[type="number"] {
		    -moz-appearance:textfield;
		}
		input[type="number"]::-webkit-outer-spin-button,
		input[type="number"]::-webkit-inner-spin-button {
		    -webkit-appearance: none;
		}
		/* 去除type=number的箭头 结束 */
		
		button:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		.glyphicon:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		
		.owl-theme .owl-controls {
			position: relative;
			margin-top: -5px;
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
		<div style="position:absolute;background:#1A90F0;width:100%;height:45px;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<!-- 返回 -->
					<td style="width:64px;">
					
					</td>
					
					<!-- 标题 -->
					<td style="padding-left:5px;padding-right:5px;text-align:center;">
						<span style="color:#FFF;font-size:18px;">购物车</span>
						<!-- <span style="color:#FFF;font-size:25px;" onclick="javascript: window.location.reload();">刷新</span> -->
					</td>
					
					<!-- 删除 -->
					<td style="width:64px;padding-left:5px;padding-right:5px;text-align:right;">
						<button id="topDelBtn" onclick="deleteCartGoods(this)" class="btn btn-primary" style="background:#0079ff;">删除</button>
					</td>
			  </tr>
			</table>
		</div>
		
		<!-- 模板开始 -->
		<div id="cartListTemplate" data-div="div" style="display:none;">
		<table class="tableNoBottomBorder" style="table-layout:fixed;width:100%;margin-left:auto;margin-right:auto;">
			<tr>
				<!-- <td data-delete="delete_btn" onclick="deleteCartGoods()" style="width:60px;text-align:center;display:none">
					<span class="glyphicon glyphicon-minus-sign" style="color:#ef4e3a;font-size:30px"></span>
				</td> -->
				
				<td style="width:40px;text-align:center;">
					<!-- <input data-selected="selected" onclick="ifChecked(this)" type="checkbox" checked="checked" style="display:none;width:30px;height:30px;"/> -->
					<span class="glyphicon glyphicon-check" data-selected="selected" onclick="ifChecked(this)" style="color:#337AB7;font-size:25px;"></span>
				</td>
				
				<td style="width:80px;padding-top:10px;padding-bottom:10px;padding-left:2px;">
					<img src="" data-img="img" width="80px" height="80px" />
				</td>
				
				<td style="padding:10px;">
					<p style="width:100%;"><span data-name="name" class="oneLineWordsShow" style="display:block;width:100%;"></span><span class="pull-right" style="color:red;">￥<span data-perTotal="perTotal"></span></span></p>
					<p>
						<span>单价:</span>
						<span style="color:red;">￥&nbsp;<span data-price="price"></span></span>
						<span data-isGift="isGift" class="badge pull-right" style="background:red;color:#fff;display:none;">赠</span>
					</p>
					<p style="padding-top:6px;white-space:nowrap; ">
						<button class="btn btn-primary" onclick="minusGoodsNum(this,1)" style="text-align:center;padding:4px 7px;"><span class="glyphicon glyphicon-minus" style="font-size:10px;"></span></button>
						<input type="number" onclick="setNumTanChuang(this)" data-number="num" value="2" readonly="readonly" style="width:80px;height:30px;text-align:center;border:1px solid #E7E7E7;border-radius:2px;margin-left:10px;margin-right:10px;"/>
						<button class="btn btn-primary" onclick="plusGoodsNum(this,1)" style="text-align:center;padding:4px 7px;"><span class="glyphicon glyphicon-plus"  style="font-size:10px;"></span></button>
						<span data-id="id" style="display:none;"></span><!--删除购物车id  -->
						<span data-goodsPriceId="goodsPriceId" style="display:none;"></span><!-- 跳转详情页面需id  -->
					</p>
				</td>
			</tr>
		</table>
		</div><!--  -->
		<!-- 模板结束 -->
		<div id="cartNoGoodsDiv" style="position:absolute;display:none;width:100%;top:45px;bottom:116px;overflow-y:auto;">
			<div style="width:100%;margin:10px auto;text-align:center;border:1px solid #e7e7e7;">
				<img src="<%=uiPath %>business2/images/cart_no_data_icon.png" width="80px" style="margin:20px auto 15px;"/>
				<p style="text-align:center;color:grey;">购物车还是空的，快去选购吧~!</p>
				<div style="width:50%;max-width:200px;display:block;border:1px solid #A3CFF8;border-radius:5px;color:#A3CFF8;padding:8px 15px;margin:10px auto 20px;" onclick="goShopping()">随便逛逛</div>
			</div>
		</div>
		<div id="cartHasGoodsDiv" style="position:absolute;display:none;width:100%;top:46px;bottom:116px;overflow-y:auto;overflow-x:hidden;">
			
			<div id="myShoppingList" style="width:100%;margin:5px auto 0;">
			
			</div>
		</div>
		
		<div id="noSelectWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:96px;color:#fff;"><span class="badge" style="background:black;line-height:30px;">请勾选商品结算</span></div>
		<div style="position:absolute;display:block;width:100%;height:50px;bottom:66px;background:#f6f2ed;padding:8px 15px;z-index:50;">
			<!-- <input onclick="ifWholeChecked(this)" type="checkbox" checked="checked" style="display:none;width:30px;height:30px;"/> -->
			<span class="glyphicon glyphicon-check" onclick="ifWholeChecked(this)" style="font-size:25px;color:#337AB7;float:left;"></span>
			<span style="font-size:18px;float:left;padding-top:6px;">&nbsp;&nbsp;总价:</span>
			<span style="color:red;font-size:18px;padding-top:6px;float:left;">&nbsp;￥<span id="totalMoney">0</span></span>
			<button id="jieSuan" class="btn pull-right" style="width:70px;color:#FFF;background:#0079ff;margin-top:2px;" disabled="disabled" onclick="jiesuan()">结算</button>
		</div>
		
		
		<!-- 更改达人币数量模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		   aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog"  style="width:100%;">
		      <div class="modal-content">
		         <div class="modal-header" style="background:#F1F1F1;text-align:center;">
		           修改购买数量
		         </div>
		         <div class="modal-body" style="text-align:center;white-space:nowrap;">
		            数量:&nbsp;&nbsp;
		            <button class="btn" onclick="minusGoodsNum(this,2)" style="text-align:center;padding:4px 7px;"><span class="glyphicon glyphicon-minus" style="font-size:10px;"></span></button>
					<input type="number" onclick="" data-number="num" value="2" oninput="setMinValue(this)"style="width:80px;height:30px;text-align:center;border:1px solid #E7E7E7;border-radius:2px;margin-left:10px;margin-right:10px;"/>
					<button class="btn" onclick="plusGoodsNum(this,2)" style="text-align:center;padding:4px 7px;"><span class="glyphicon glyphicon-plus"  style="font-size:10px;"></span></button>
		         </div>
		         <div class="modal-footer oneLineWordsShow" style="background:#F1F1F1;text-align:center;">
		            <button type="button" class="btn btn-default" 
		               data-dismiss="modal" style="width:49%;height:40px;">取消
		            </button>
		            <button type="button" class="btn btn-primary" onclick="confirmClick()" style="background:#4997E8;width:49%;height:40px;">
		               确定
		            </button>
		         </div>
		      </div><!-- /.modal-content -->
		</div><!-- /.modal -->
		</div>
		</div>
	</body>
	
</html>