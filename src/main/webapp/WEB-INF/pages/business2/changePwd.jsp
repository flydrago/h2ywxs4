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
<script type="text/javascript" src="<%=uiPath%>business2/js/changePwd.js"></script>
<title>修改密码</title>
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
				<td onclick="_goBack()" style="width:43px;padding-right:5px;">
					<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
				</td>
				
				<!-- 标题 -->
				<td style="padding-left:5px;padding-right:5px;text-align:center;">
					<span style="color:#FFF;font-size:18px;">修改密码</span>
				</td>
				
				<!-- 更多 -->
				<td style="width:43px;">
					
				</td>
		  </tr>
		</table>
	</div>
	
	<div style="position:absolute;top:40px;width:100%;overflow-y:auto;overflow-x:hidden;bottom:0px;">
		<ul class="list-group" style="margin-top:10px;margin-bottom:0px;">
			<li class="list-group-item" style="padding-top:7px;padding-bottom:7px;">
				<input data-pwd="oldPwd" value="" placeholder="旧密码" type="text" style="width:100%;height:30px;border:none;background:#fff;text-overflow:ellipsis;"/>
			</li>
			<li class="list-group-item" style="padding-top:7px;padding-bottom:7px;">
				<input data-pwd="newPwd" value="" placeholder="新密码" type="text" style="width:100%;height:30px;border:none;background:#fff;text-overflow:ellipsis;"/>
			</li>
			<li class="list-group-item" style="padding-top:7px;padding-bottom:7px;">
				<input data-pwd="surePwd" value="" placeholder="确认密码" type="text" maxlength="20" style="width:100%;height:30px;border:none;background:#fff;text-overflow:ellipsis;"/>
			</li>
		</ul>
		<p style="text-align:center;padding:10px;">密码由6-20位英文字母，数字或符号组成</p>
		<div style="width:100%;text-align:center;">
			<button class="btn btn-primary" onclick="submitNewPwd(this)" style="color:#fff;height:40px;width:95%;">修改密码</button>
		</div>
    </div>
    
    
	<div id="warmWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:76px;color:#fff;">
		<span class="badge" style="background:red;line-height:25px;"></span>
	</div>
	</div>
</body>
</html>