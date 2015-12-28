<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath %>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,maxinum-scale=1,minium-scale=1,user-scalable=no">
		<link rel="stylesheet" href="<%=uiPath%>business2/css/style.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/showTip.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/unifyUrlJump.js"></script>
		<title>${title}</title>
	</head>
	
	<style type="text/css">
		
		p{
			margin-top:8px;
			margin-bottom:3px;
		}
		
		.btn:focus, .btn:hover {
			color: #fff;
			text-decoration: none;
		}
		
		button:active,.glyphicon:active{
			filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
			-moz-opacity:0.5; /*Firefox私有，透明度50%*/
			opacity:0.5;/*其他，透明度50%*/
		}
		.perList:active{
			background:#D1D1D4;
		}
		
	</style>
	
	<body style="width:100%;height:100%;background:#f6f2ed;">
		<div style="-webkit-overflow-scrolling:touch;">
		<div style="position:absolute;width:100%;height:45px;background:#1a90f0;text-align:center;">
		<table style="width:100%;margin-top:5px;table-layout:fixed;">
			<tr >
				<td onclick="_goBack()" style="width:43px;padding-right:5px;">
					<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
				</td>
				
				<!-- 标题 -->
				<td style="padding-left:5px;padding-right:5px;text-align:center;">
					<span style="color:#FFF;font-size:18px;">${title}</span>
				</td>
				
				<!-- 更多 -->
				<td style="width:43px;">
					
				</td>
		  </tr>
		</table>
	</div>
		<div style="position:absolute;top:45px;width:100%;overflow-y:hidden;bottom:0;-webkit-overflow-scrolling:touch;overflow-y:hidden;">
		<iframe id="unifyFrame" src="" style="width:100%;height:100%;border:none;">
			
		</iframe>
		</div>
		</div>
		
		<script type="text/javascript">
			var title = '${title}';
			var url = '${url}';
		</script>
	</body>
</html>