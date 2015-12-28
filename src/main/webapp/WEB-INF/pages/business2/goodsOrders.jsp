<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath %>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-switch-dist/css/bootstrap3/bootstrap-switch.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.2.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-switch-dist/js/bootstrap-switch.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/accurateMathCalculate.js"></script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=NBGkLqkg5hMbP2VWke9rEwLy"></script> 
		<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script> 
		<script type="text/javascript" src="<%=uiPath%>business2/js/goodsOrders.js"></script>
		<title>订单</title>
	</head>
	<style type="text/css">
		
		p{
			margin-top:8px;
			margin-bottom:3px;
		}
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
		
		.normalColor{
			background:#F5F5F5;
		}
		.defaultColor{
			background:#4A87EE;
		}
	</style>
	
	
	<body style="width:100%;height:100%;background:#f6f2ed;">
	<div style="-webkit-overflow-scrolling:touch;">
		<div id="addressDiv" style="width:100%;top:0px;bottom:66px;overflow-y:auto;display:none;"></div>
		<div id="titleDiv" style="position:absolute;width:100%;height:45px;background:#1a90f0;text-align:center;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<td onclick="_goBack()" style="width:43px;padding-left:8px;padding-right:5px;">
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
					</td>
					
					<!-- 标题 -->
					<td style="padding-left:5px;padding-right:5px;text-align:center;">
						<span style="color:#FFF;font-size:18px;">填写订单</span>
					</td>
					
					<td style="width:43px;">
						
					</td>
			  </tr>
			</table>
		</div>
		
		<div id="contentDiv" style="position:absolute;width:100%;top:45px;bottom:50px;overflow-y:auto;overflow-x:hidden;">
		
			<div class="addressBgImg" style="width:100%;padding-top:10px;padding-bottom:10px;">
				<table style="width:100%;margin-top:10px;">
					<tr>
						<td style="min-width:52px;max-width:52px;width:52px;padding-right:10px;padding-bottom:10px;">
						</td>	
						
						<td style="text-align:center;padding-bottom:10px;">
							<span style="color:#bcbcbc;">收货地址</span>
						</td>
						<td onclick="creatNewAddress()" style="min-width:52px;max-width:52px;width:52px;padding-right:10px;padding-bottom:10px;">	
							<span class="glyphicon glyphicon-plus-sign pull-right" style="font-size:25px;color:#0e64c2"></span>
							<span class="glyphicon glyphicon-map-marker pull-right" style="font-size:25px;color:#0e64c2;display:none;"></span>
						</td>
					</tr>
				</table>
				<div id="getAddrSuccess" style="display:none;">
				<table style="width:100%;font-size:12px;">
					<tr style="border-bottom:1px solid #e7e7e7;">
						<td style="min-width:75px;max-width:75px;width:75px;padding:10px;">
							<span style="color:grey;">收货人</span>
						</td>	
						<td style="padding:10px 10px 10px 0px;">
							<input data-receiveName="receiveName" value="六" style="width:100%;border:none;text-overflow:ellipsis;"/>
						</td>
						<td style="min-width:48px;max-width:48px;width:48px;padding:10px 10px 10px 0;">
							<span style="color:grey;">手机</span>
						</td>
						<td style="padding:10px 10px 10px 0;">	
							<input data-receivePhone="receivePhone" value="150236192585" style="width:100%;border:none;text-overflow:ellipsis;"/>
						</td>
					</tr>
					<tr style="border-bottom:1px solid #e7e7e7;">
						<td style="min-width:65px;max-width:65px;width:65px;padding:10px;">
							<span style="color:grey;">地址</span>
						</td>	
						<td colspan="3" style="padding:10px 10px 10px 0;">
							<input data-receiveAddr="receiveAddr" value="六" style="width:100%;border:none;text-overflow:ellipsis;"/>
							<span data-id="id" style="display:none;"></span>
							<span data-zoneLon="longitude" style="display:none;"></span>
							<span data-zoneLat="latitude" style="display:none;"></span>
						</td>
					</tr>
					<tr style="border-bottom:1px solid #e7e7e7;">
						<td style="min-width:48px;max-width:48px;width:48px;padding:10px">
							<span style="color:grey;">备注</span>
						</td>
						<td colspan="3" style="padding:10px 10px 10px 0;">
							<input data-receiveRemark="receiveRemark" value="" placeholder="例如:889房间" style="width:100%;border:none;"/>
						</td>
					</tr>
				</table>
				</div>
			</div>
			<div id="cartList" style="width:100%;margin-top:10px;">
			</div>
			<div style="width:100%;padding:10px 10px;background:#fff;margin-top:10px;border-bottom:1px solid #e7e7e7;">
				<div style="width:100%;padding:10px 0px;border-bottom:1px solid #e7e7e7;">
					商品总数:<span class="pull-right"><span id="goodsCount"></span></span>
				</div>
				<div style="width:100%;padding:10px 0px;">
					商品总额:<span class="pull-right">￥<span id="goodsTotalMoney">0.00</span></span>
				</div>
			</div>
		</div>
		<div id="noSelectWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:60px;color:#fff;z-index:3;"><span class="badge" style="background:black;line-height:30px;">订单提交失败,检查网络，稍后重试</span></div>
		<div id="bottomOptDiv" style="position:absolute;display:block;width:100%;height:60px;bottom:0;background:#f6f2ed;">
			<!-- <span id="orderMsg" style="width:100%;color:red;font-size:10px;display:block;"></span> -->
			<table style="width:100%;height:100%;table-layout:fixed;">
				<tr>
					<td style="padding-left:10px;">
						<span style="font-size:15px;">实付款</span>
						<span style="color:red;font-size:20px;">￥<span id="realTotalMoney"></span></span>
					</td>
					<td id="bottomSubmitBtn" style="background:#3385FF;" onclick="selectIfSubmit()">
						<div style="width:100%;text-align:center;color:#fff;">提交订单</div>
					</td>
				</tr>
			</table>
		</div>
		<!-- 模板开始 -->
		<div id="cartListTemplate" data-div="div" style="display:none;background:#fff;">
			<table class="tableBottomBorder" style="width:99%;margin-left:auto;margin-right:auto;">
				<tr>
					<td style="width:80px;padding:6px 0 6px 2px;">
						<img src="" data-img="img" width="80px" height="80px" />
					</td>
					<td style="padding:6px 10px;">
						<p style="width:100%;">
							<span data-name="name" class="oneLineWordsShow" style="display:block;"></span>
							<span class="pull-right" style="color:red;">￥&nbsp;<span data-perTotal="perTotal"></span></span>
						</p>
						<p>
							<span>单价:</span>
							<span style="color:red;">￥&nbsp;<span data-price="price"></span></span>
							<span data-isGift="isGift" class="badge pull-right" style="background:red;color:#fff;display:none;">赠</span>
						</p>
						<p>
							<span class="pull-right">数量:&nbsp;&nbsp;<span data-number="num" >222</span></span>
							<span data-goodsPriceId="goodsPriceId" style="display:none;"></span><!-- 跳转详情页面需id  -->
						</p>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 提交订单模态框（Modal） -->
		<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" 
		   aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog">
		      <div class="modal-content">
		         <div class="modal-header" style="text-align:left;color:#38BDF8;border-bottom:1px solid #38BDF8;">
		           提交订单
		         </div>
		         <div class="modal-body" style="text-align:center;border-bottom:1px solid #38BDF8;">
		            确认提交订单么？
		         </div>
		         <div class="modal-footer" style="text-align:center;white-space:nowrap;">
		            <button type="button" class="btn btn-default" 
		               data-dismiss="modal" style="width:49%;height:40px;color:#38BDF8;">取消
		            </button>
		            <button type="button" class="btn btn-default" onclick="submitOrderForm()" style="width:49%;height:40px;color:#38BDF8;">
		               确定
		            </button>
		         </div>
		      </div><!-- /.modal-content -->
		</div><!-- /.modal -->
		</div>
		
		<!-- 提交订单成功模态框（Modal） -->
		<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" 
		   aria-labelledby="myModalLabel" aria-hidden="true" style="width:100%;">
		   <div class="modal-dialog" style="width:100%;height:100%;">
		      <div class="modal-content" style="width:100%;height:100%;border-radius:0;border:none;background:#f6f2ed;">
		         <div class="modal-header"style="background:#4A87EE;color:#fff;height:45px;line-height:45px;padding:0px;border:none;" >
			         <table style="width:100%;">
						<tr >
							<td onclick="goBackToCart()" style="width:43px;padding-left:8px;padding-right:5px;">
								<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
							</td>
							
							<!-- 标题 -->
							<td style="padding-left:5px;padding-right:5px;text-align:center;">
								<span style="color:#FFF;font-size:18px;">提交成功</span>
							</td>
							
							<!-- 更多 -->
							<td style="width:43px;">
								
							</td>
					  </tr>
					</table>
		         </div>
		         <div class="modal-body" style="text-align:left;background:#fff;padding:5px 10px;">
		            <div style="padding:10px;border-bottom:1px solid #e7e7e7;"><span style="padding-right:5px;">订单编号:</span>&nbsp;<span data-orderNo="orderNo"></span></div>
		            <div style="padding:10px;border-bottom:1px solid #e7e7e7;"><span style="padding-right:5px;">订单金额:</span>&nbsp;<span data-orderMoney="orderMoney"></span></div>
		            <div style="padding:10px;"><span style="padding-right:5px;">下单时间:</span>&nbsp;<span data-orderTime="orderTime"></span></div>
		         </div>
		         
		      </div><!-- /.modal-content -->
		</div><!-- /.modal -->
		</div>
		</div>
	</body>
	
	<script type="text/javascript">
		var imagePath = window.top.imagePath;
	 	var zone_code = window.top.zone_code;
	 	var paraJson = ${paraJson};
	 	var totalMoney = ${totalMoney};
	 	var orderParams = null;//${orderParams};
	 	/** 订单商品总数 */
	 	var goodsTotalNum = 0;
	 	
		$(document).ready(function(){
	 		$(window.parent.document).find("#myTab").hide();
	 		localStorage.removeItem("wechatshop_fromFlag");
	 		getOrderData();
	 		getSessionData();
	 		
	 	});
	</script>
	
</html>