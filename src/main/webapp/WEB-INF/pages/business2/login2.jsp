<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=uiPath%>business2/css/login.css" />
<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-switch-dist/css/bootstrap3/bootstrap-switch.css" />
<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-switch-dist/js/bootstrap-switch.js"></script>
<script type="text/javascript" src="<%=uiPath%>business2/js/login2.js"></script>
<title>登录</title>
</head>

<style type="text/css">
		
</style>
		
<body style="backgroud:#F9F9F9;">
<div style="-webkit-overflow-scrolling:touch;">
	<!-- 页头 -->
	<div style="position:absolute;width:100%;height:45px;padding-top:5px;background:#1a90f0;text-align:center;">
		<table style="width:100%;">
			<tr >
				<td onclick="_goBack()" style="width:43px;padding-left:8px;padding-right:5px;">
					<img src="<%=uiPath%>business2/images/goBack.png" width="16px" />
				</td>
				
				<!-- 标题 -->
				<td style="padding-left:5px;padding-right:5px;text-align:center;">
					<span style="color:#FFF;font-size:18px;">登录</span>
				</td>
				
				<!-- 更多 -->
				<td style="width:43px;">
					
				</td>
		  </tr>
		</table>
	</div>
	<div style="position:absolute;top:45px;width:100%;overflow-y:auto;overflow-x:hidden;bottom:0px;">
		<div class="loginUserIcon">
			<img src="<%=uiPath%>business2/images/login_user_default_icon.png">
		</div>
		<div style="width:98%;margin-left:auto;margin-right:auto;">
		<ul class="list-group" style="margin-top:10px;margin-bottom:10px;">
			<li class="list-group-item" style="padding-top:7px;padding-bottom:7px;">
				<table style="width:100%;">
					<tr>
						<td style="width:40px;min-width:40px;max-width:40px;text-align:left;"><span>帐号</span></td>
						<td style=""><input id="accountInput" type="number" oninput="forbidBlank()" placeholder="请输入手机号" style="width:100%;height:30px;border:none;background:#fff;text-overflow:ellipsis;"/></td>
						<td style="width:30px;min-width:30px;max-width:30px;text-align:right;" onclick="clearAccountInput()"><span class="glyphicon glyphicon-remove"></span></td>
					</tr>
				</table>
			</li>
			
			<li class="list-group-item" style="padding-top:7px;padding-bottom:7px;">
				<table style="width:100%;">
					<tr>
						<tr>
						<td style="width:40px;min-width:40px;max-width:40px;text-align:left;"><span>密码</span></td>
						<td style=""><input id="pwdInput" type="password" oninput="forbidBlank()" placeholder="请输入密码"  style="width:100%;height:30px;border:none;background:#fff;text-overflow:ellipsis;"/></td>
						<td style="width:75px;min-width:75px;max-width:75px;text-align:right;">
						<input data-switch="switch" type="checkbox" checked data-size="mini" data-handle-width="20" data-label-width="20" data-on-text="…" data-off-text="ABC">
						</td>
					</tr>
				</table>
			</li>
			</ul>
		</div>
		
		<div style="width:98%;margin-left:auto;margin-right:auto;text-align:right;color:#959595;display:none;">
			<span id="ifRemeberCheck" class="glyphicon glyphicon-check" onclick="ifRemeberPwd(this)" style="font-size:18px;"></span>&nbsp;<span>记住密码</span>
		</div>
		
		<div style="width:100%;text-align:center;margin-top:20px;">
			<button id="loginBtn" class="btn btn-primary" onclick="loginAccountOpt(this)"style="color:#fff;height:40px;width:95%;">登录</button>
		</div>
		<div style="width:95%;margin-left:auto;margin-right:auto;margin-top:15px;color:blue;">
			<span class="pull-left" onclick="goTofindMyPwdInterface()">找回密码</span>
			<!-- <span class="pull-right" onclick="goToRegisterInterface()">手机快速注册</span> -->
		</div>
	</div>
	<div id="warmWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:96px;color:#fff;">
		<span class="badge" style="background:red;line-height:25px;"></span>
	</div>
	</div>
</body>
</html>