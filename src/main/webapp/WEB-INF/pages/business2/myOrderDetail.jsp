<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=uiPath%>business2/js/util/showTip.js"></script>
<script type="text/javascript" src="<%=uiPath%>business2/js/myOrderDetail.js"></script>
<title>订单详情</title>
</head>

<style type="text/css">

	/* 表格下边框 */
	.tableBottomBorder{
		border-bottom:1px solid #e7e7e7;
	}
	
	p{
		margin-bottom:5px;
	}
	button:active,.glyphicon:active{
		filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
		-moz-opacity:0.5; /*Firefox私有，透明度50%*/
		opacity:0.5;/*其他，透明度50%*/
	}
	
	.list-group-item, .list-group-item:first-child, .list-group-item:last-child{
		border-radius: 0px;
		border-left:none;
		border-right:none;
	}
		
</style>
		
<body style="backgroud:#F9F9F9;">
<div style="-webkit-overflow-scrolling:touch;">
	<!-- 页头 -->
	<div style="position:absolute;width:100%;height:45px;background:#1a90f0;text-align:center;">
		<table style="width:100%;margin-top:5px;">
			<tr >
				<td onclick="_goBack()" style="width:43px;padding-left:8px;padding-right:5px;">
					<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
				</td>
				
				<!-- 标题 -->
				<td style="padding-left:5px;padding-right:5px;text-align:center;">
					<span style="color:#FFF;font-size:18px;">订单详情</span>
				</td>
				
				<!-- 更多 -->
				<td style="width:43px;">
					
				</td>
		  </tr>
		</table>
	</div>
	<table style="display:none">
			<!-- 一行一个模板 开始 -->
			<tr id="line_one_template" class="tableBottomBorder" style="width:100%;">
				<td style="padding:10px;height:80px">
					<div data-privilege="huoDongOrCuXiao" class="huodongtip" style="position:absolute;z-index:2;width:30px;height:30px;display:none;"></div>
					<img src="" data-img="img" width="70px" height="70px" style="float:left"/>
					<div style="position:absolute;height:80px;left:100px;right:20px;">
						<p>
							<span data-name="name"></span>
							<span class="pull-right" style="color:red;">￥<span data-perTotal="perTotal"></span></span>
						</p>
						<p style="color:red;font-weight:bold;margin-bottom:2px;">
							<span>单价:</span>
							<span>￥&nbsp;<span data-price="single"></span></span>
							<span class="pull-right">数量:&nbsp;&nbsp;<span data-number="num" ></span></span>
						</p>
						
						<p>
							<span data-isGift="isGift" class="badge pull-left" style="background:red;color:#fff;display:none;">赠</span>
							<span data-goodsPriceId="goodsPriceId"  style="display:none"></span>
						</p>
					</div>
				</td>
			</tr> 
		</table>
	<div style="position:absolute;top:45px;width:100%;overflow-y:auto;overflow-x:hidden;bottom:66px;background:#f6f2ed;">
		<div id="orderItem" style="width:98%;padding:5px;text-align:left;margin-left:auto;margin-right:auto;">
			<span>订单状态:&nbsp;</span><span data-orderState="orderState" style="color:red;">${orderDetail.resultData.orderStatusName}</span><br/>
			<span>订单编号:&nbsp;</span><span data-orderNum="orderNum">${orderDetail.resultData.orderNo}</span>
			<button class="btn" onclick="goToFinish(this)" style="position:absolute;top:8px;right:10px;">${orderDetail.resultData.receiverStatus eq "20" ? "完成" : "已完成"}</button>
		</div>
		
		<div id="deliverymanItem" style="width:98%;padding:10px 5px;border:1px solid #e7e7e7;background:#fff;margin-left:auto;margin-right:auto;">
			<table style="width:100%;">
				<tr>
					<td style="width:55px;min-width:55px;max-width:55px;text-align:left;"><span>送货员</span></td>
					<td style="text-align:center;"><span data-name="name"></span></td>
					<td style="width:100px;min-width:100px;max-width:100px;text-align:right;" >
						<a data-phone="phone" href=""></a>
					</td>
				</tr>
			</table>
		</div>
		
		<div id="orderMoney" style="width:98%;text-align:left;margin-left:auto;margin-right:auto;margin-top:10px;background:#fff;border:1px solid #e7e7e7;">
			<div style="background:#3EBDF9;padding:5px 10px;color:#fff;"><span>订单金额</span><span class="pull-right"><span>￥&nbsp;</span><span data-orderTotal=orderTotal>${orderDetail.resultData.realAmount}</span></span></div>
			<div style="padding:5px 10px;"><span>商品总额</span><span class="pull-right"><span>￥&nbsp;</span><span data-goodsTotal="goodsTotal">${orderDetail.resultData.goodsAmount}</span></span></div>
			<div style="padding:5px 10px;"><span>返现</span><span class="pull-right"><span>-￥&nbsp;</span><span data-backMoney="backMoney">0.00</span></span></div>
			<div style="padding:5px 10px;"><span>运费</span><span class="pull-right"><span>+￥&nbsp;</span><span data-freight="freight">${orderDetail.resultData.goodsTransportAmount}</span></span></div>
		</div>
		
		<div id="goodsList" style="width:98%;margin-left:auto;margin-right:auto;margin-top:10px;background:#fff;">
			<table style="width:100%;">
				  
			</table>
		</div>
		
		<div id="receiveItem" style="width:98%;text-align:left;margin-left:auto;margin-right:auto;margin-top:10px;margin-bottom:20px;background:#fff;">
			<div style="background:#fff;padding:10px 10px;border:1px solid #e7e7e7;border-bottom:none;">
				<span data-receiveName="receiveName">${orderDetail.resultData.receiverName}</span>
				<span data-recceivePhone="recceivePhone" class="pull-right">${orderDetail.resultData.receiverMobile}</span>
			</div>
			<div style="background:#fff;padding:10px 10px;border:1px solid #e7e7e7;">
				<span data-receiveAddr="receiveAddr">${orderDetail.resultData.receiverAddress}</span>
			</div>
		</div>
    </div>
    
	<div id="warmWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:76px;color:#fff;">
		<span class="badge" style="background:red;line-height:25px;"></span>
	</div>
	<input id="orderDetail" type="hidden" value='<%=request.getAttribute("orderDetail") %>' />
	</div>
</body>

</html>