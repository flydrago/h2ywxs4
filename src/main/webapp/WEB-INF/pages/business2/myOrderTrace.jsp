<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath %>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<title>订单跟踪</title>
	</head>
	
	<style type="text/css">
		
		.btn:focus, .btn:hover {
			color: #fff;
			text-decoration: none;
		}
		
		.glyphicon:active,button:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		
		
	</style>
	
	<body style="width:100%;height:100%;background:#f6f2ed;">
		<div style="-webkit-overflow-scrolling:touch;">
		<!-- 标题栏 -->
		<div style="position:absolute;width:100%;height:45px;background:#1a90f0;text-align:center;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<td onclick="_goBack()" style="width:43px;padding-left:8px;padding-right:5px;">
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
					</td>
					
					<!-- 标题 -->
					<td style="padding-left:5px;padding-right:5px;text-align:center;">
						<span style="color:#FFF;font-size:18px;">订单跟踪</span>
					</td>
					
					<!-- 更多 -->
					<td style="width:43px;">
						
					</td>
			  </tr>
			</table>
		</div>
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		
		<input type="hidden" id="currOrderId" value="<%=request.getAttribute("currOrderId")%>">
		<!-- 已有收货地址 -->
		
		<!-- 模板 开始 -->
		
		<!-- 模板 结束 -->
		
		<div id="myOrderList" style="position:absolute;width:100%;top:50px;bottom:67px;overflow-y:auto;overflow-x:hidden;display:none;">
			<div style="width:97%;padding:10px 15px;margin:0px auto 10px;font-weight:bold;border:1px solid #b6bccc;background:#fff;">
				<div style="width:100%;"><span>收货人</span><span data-receive="orderReceiver" style="margin-left:10px;">暂无</span></div>
				<div style="width:100%;margin-top:5px;padding-bottom:10px;border-bottom:1px solid #e7e7e7;"><span>订单号</span><span data-serial="orderSerial" style="margin-left:10px;">暂无</span></div>
				
				<div style="width:100%;margin-top:10px;"><span>送货人</span><span data-deliveryman="orderDeliveryman" style="margin-left:10px;">暂无</span></div>
				<div style="width:100%;margin-top:5px;"><span>手机号</span><span data-deliPhone="orderDeliPhone" style="margin-left:10px;">暂无</span></div>
		    </div>
		    
		    <!-- 模板 开始 -->
		    <table style="display:none;">
		    	<tr id="sendProcessHead_template">
	   				<td style="width:40px;padding:12px 10px 44px 15px;background-color:transparent;z-index:20;"><img alt="" src="<%=uiPath%>business2/images/logistics_track_arrive.png" style="z-index:3;"></td>
	   				<td style="border-bottom:1px solid #e7e7e7;padding-top:10px;padding-bottom:10px;">
		   				<div style="width:100%;font-weight:bold;"><span data-person="processPerson"></span>&nbsp;&nbsp;<span data-sendType="sendType">提交</span></div>
						<div style="width:100%;"><span data-time="orderTime" style="color:#c0c0c4"></span></div>
					</td>
	   			</tr>
	   			
		    	<tr id="sendProcess_template" style="background:#F3F5F2;">
	   				<td style="width:40px;padding:10px 7px 32px 18px;"><img alt="" src="<%=uiPath%>business2/images/logistics_track_point.png"style="z-index:3;"></td>
	   				<td style="border-bottom:1px solid #b6bccc;padding-top:10px;padding-bottom:10px;">
		   				<div style="width:100%;font-weight:bold;"><span data-person="processPerson"></span>&nbsp;&nbsp;<span data-sendType="sendType">提交</span></div>
						<div style="width:100%;"><span data-time="orderTime" style="color:#c0c0c4"></span></div>
					</td>
	   			</tr>
		    </table>
		    <!-- 连接线 -->
		    <div id="greyLine_template" style="position:absolute;left:27px;width:1px;background:#c9cdcc;display:none;"></div>
		    <!-- 模板 结束 -->
		    
		    <div id="sendProcessDiv" style="position:relative;width:97%;padding:0px 2px 0px 0px;margin:0px auto 10px;border:1px solid #b6bccc;background:#fff;">
		   		
		   		<table id="sendProcessList" style="width:100%;">
		   		
		   		</table>
		   </div>
		</div>
		</div>
	</body>
	
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/myOrderTrace.js"></script>	
</html>