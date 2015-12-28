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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=6GrVcGBVo9PHLc13fvY6MTOF"></script>
<script type="text/javascript" src="<%=uiPath%>business2/js/util/showTip.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=uiPath%>business2/js/baiduMap.js"></script>
<title>更多</title>
</head>

<style type="text/css">

	button:active{
		filter:alpha(opacity=50); /*IE滤镜，透明度50%*/
		-moz-opacity:0.5; /*Firefox私有，透明度50%*/
		opacity:0.5;/*其他，透明度50%*/
	}
	p{
		margin-bottom:5px;
	}
	.glyphicon:active{
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
					<span style="color:#FFF;font-size:18px;">位置选择</span>
				</td>
				
				<!-- 更多 -->
				<td style="width:43px;">
					<span style="color:#fff;" onclick="clickSureOpt()">确定</span>
				</td>
		  </tr>
		</table>
	</div>
	
	<div  style="position:absolute;width:100%;top:45px; height:45px;line-height:45px;overflow:hidden;" >
		<input id="suggestId" value="" placeholder="请输入地址" style="padding:0 10px;border:none;width:100%;"/>
	</div>
	
	<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
	<div id="l-map" style="position:absolute;width:100%;top:90px;bottom:0px;overflow-y:auto;overflow-x:hidden;" ></div>
	
	<div id="warmWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:76px;color:#fff;">
		<span class="badge" style="background:red;line-height:25px;"></span>
	</div>
	</div>
</body>
</html>