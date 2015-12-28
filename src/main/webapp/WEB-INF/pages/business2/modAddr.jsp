<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath %>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="dns-prefetch" href="<%=basePath%>" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/showTip.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/modAddr.js"></script>
		<title>修改地址</title>
	</head>
	
	<style type="text/css">
		
		p{
			margin:6px 0 0;
		}
		button:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		
		.btn:focus, .btn:hover {
			color: #fff;
			text-decoration: none;
		}
		
		.glyphicon:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		
		
	</style>
	
	<body style="width:100%;height:100%;">
		<div style="-webkit-overflow-scrolling:touch;">
		<!-- 标题栏 -->
		<div style="position:absolute;width:100%;height:45px;background:#1a90f0;text-align:center;">
			<table style="width:100%;margin-top:5px;">
				<tr >
					<td onclick="_goBack()" style="width:43px;padding-left:8px;padding-right:5px;">
						<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
						<input type="hidden" id="fromFlagInput" value="3">
					</td>
					
					<!-- 标题 -->
					<td style="padding-left:5px;padding-right:5px;text-align:center;">
						<span style="color:#FFF;font-size:18px;">修改地址</span>
					</td>
					
					<!-- 更多 -->
					<td style="width:43px;">
						
					</td>
			  </tr>
			</table>
		</div>
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		  
		<!-- 修改收货地址 -->
		
		<div style="position:absolute;width:100%;top:50px;overflow-y:auto;overflow-x:hidden;" >
			<table style="width:100%;">
				<tr style="width:90%;border-bottom:1px solid #e7e7e7;">
					<td style="width:100px;padding:10px;">收货人</td>
					<td colspan="2"style="padding:10px;">
						<input class="form-control modCustomer" value="${addrInfo.resultData.receiverName }" placeholder="请输入您的姓名" style="border:none;"/>
						<input type="hidden" class="modAddrID" value="${addrInfo.resultData.id }">	
						<input type="hidden" class="modIsDefault" value="${addrInfo.resultData.isDefault }">	
					</td>
				</tr>
				<tr style="width:90%;border-bottom:1px solid #e7e7e7;">
					<td style="width:100px;padding:10px;">手机</td>
					<td colspan="2"style="padding:10px;">
						<input class="form-control modCusPhone" value="${addrInfo.resultData.receiverMobile }" placeholder="请输入您的手机号码"  style="border:none;"/>
					</td>
				</tr>
				<tr style="width:90%;border-bottom:1px solid #e7e7e7;">
					<td style="width:100px;padding:10px;">地址</td>
					<td style="padding:10px;">
						<input class="form-control modCusAddr" value="${addrInfo.resultData.zoneName}" placeholder="请选择您的所在地" style="bborder:none;"/>
					</td>
					<td style="width:40px;" onclick="locateUser()"><img src="<%=uiPath %>business2/images/map_sign.png" width="22px" height="22px;"/></td>
				</tr>
				<tr style="width:90%;border-bottom:1px solid #e7e7e7;">
					<td style="width:100px;padding:10px;">详细地址</td>
					<td colspan="2" style="padding:10px;">
						<input class="form-control modCusDetailAddr" value="${addrInfo.resultData.zoneDetail }" style="border:none;" placeholder="请填写您的详细地址" />
					</td>
				</tr>
			</table>
			<div style="width:100%;text-align:center;margin-top:10px;">
				<button class="btn" onclick="modAddr()" style="width:98%;color:#fff;background:#3879D9">确定</button>
			</div>
		</div>
		<div id="warmWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:76px;color:#fff;">
			<span class="badge" style="background:red;line-height:25px;"></span>
		</div>
		</div>
	</body>
	
</html>