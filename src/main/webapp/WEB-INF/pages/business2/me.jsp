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
<link rel="stylesheet" href="<%=uiPath%>business2/css/me.css" />
<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=uiPath%>business2/js/util/jumpLogin.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=uiPath%>business2/js/me.js" charset="UTF-8"></script>

<title>我的</title>
</head>

<style type="text/css">

	p{
		margin-bottom:2px;
		padding:0;
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
		
<body>
<div style="-webkit-overflow-scrolling:touch;">
	<!-- 页头 -->
	<div id="titleDiv" style="position:absolute;width:100%;height:45px;z-index:3;display:block;"><!--background:#1a90f0;  -->
		<table style="width:100%;height:45px;">
			<tr >
				<td style="width:64px;">
					</td>
				
				<!-- 标题 -->
				<td style="padding-left:5px;padding-right:5px;text-align:center;">
					<!-- <span style="color:#FFF;font-size:18px;">我的酒运达</span> -->
				</td>
				
				<!-- 更多 -->
				<td style="width:64px;padding-left:5px;padding-right:10px;text-align:right;">
					<img alt="" id="moreBtn" onclick="goMeMoreInterface()"  src="<%=uiPath %>business2/images/more_icon.png" width="40px"/>
					<!-- <button disabled="disabled" class="btn btn-primary" style="background:#0079ff;">更多</button> -->
				</td>
		  </tr>
		</table>
	</div>
	<div id="contentDiv" style="position:absolute;display:none;top:0px;width:100%;overflow-y:auto;overflow-x:hidden;bottom:66px;">
		
		<div class="topDiv">
			<div id="unLoginDivTip" style="display:none;width:100%;height:100%;padding-top:15px;text-align:center;">
				<!-- <span style="color:#fff;font-size:22px;">欢迎来到酒运达</span><br/> -->
				<img alt="" src="<%=uiPath %>business2/images/no_def.png" class="img-circle" height="70px" style="border:3px solid white;"/>
				<a href="javascript:void(0)" onclick="goToLoginInterface()" style="display:block;width:100px;margin-left:auto;margin-right:auto;margin-top:10px;border:1px solid white;padding:8px 10px;border-radius:5px;color:white;font-weight:bold;text-decoration:none">点击登录</a>
			</div>
			
			<div id="loginedDivShow" style="display:block;width:98%;height:100%;margin-left:auto;color:white;margin-right:auto;padding-top:15px;text-align:center;">
				<img alt="" data-headIcon="headIcon" src="" class="img-circle" height="70px" style="border:3px solid white;"/>
				<p data-nickName="nickName" style="color:white;font-weight:bold;font-size:18px;display:none;"></p>
				
				<table style="width:100%;">
					<tr>
						<td style="padding-right:15px;text-align:left;width:130px;">
							<p >
								<img src="<%=uiPath %>business2/images/icon_dou.png" width="16px"/>
								<span data-bean="bean"></span>&nbsp;豆
							</p>
							<p>
								<img src="<%=uiPath %>business2/images/icon_bi.png" width="16px"/>
								<span data-coin="coin"></span>&nbsp;币
							</p>
						</td>
						<td>
							<p data-account="account"></p>
						</td>
						<td style="text-align:right;padding-left:15px;padding-right:5px;width:130px;" onclick="getQRCode()">
							<img src="<%=uiPath %>business2/images/er_weima.png" width="25px"/>
							<!-- <span class="glyphicon glyphicon-qrcode" style="background:#fff;font-size:30px;"></span> -->
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<!-- 用户账户菜单 -->
		<div style="width:100%;margin-left:auto;margin-right:auto;z-index:0;">
		
			<ul class="list-group" style="margin-top:10px;">
				<li class="list-group-item" onclick="goToMyOrderInterface()">
					<table style="width:100%;">
						<tr>
							<td style="width:40px;text-align:left;"><img src="<%=uiPath %>business2/images/order.png" height="30px" width="30px"/></td>
							<td><span>订单查询</span></td>
							<td style="width:20px;text-align:right;"><span class="glyphicon glyphicon-menu-right pull-right" style="color:#bdbdbd;"></span></td>
						</tr>
					</table>
				</li>
				
				<li class="list-group-item" onclick="goToMyJFriendsInterface()" style="margin-top:10px;">
					<table style="width:100%;">
						<tr>
							<td style="width:40px;text-align:left;"><img src="<%=uiPath %>business2/images/j_friend.png" height="30px" width="30px"/></td>
							<td><span>好J友</span></td>
							<td style="width:20px;text-align:right;"><span class="glyphicon glyphicon-menu-right pull-right" style="color:#bdbdbd;"></span></td>
						</tr>
					</table>
				</li>
				<%-- <li class="list-group-item" onclick="goToCouponInterface()" style="margin-top:10px;">
					<table style="width:100%;">
						<tr>
							<td style="width:40px;text-align:left;"><img src="<%=uiPath %>business2/images/coupon.png" height="30px" width="30px"/></td>
							<td><span>优惠券</span></td>
							<td style="width:20px;text-align:right;"><span class="glyphicon glyphicon-menu-right pull-right" style="color:#bdbdbd;"></span></td>
						</tr>
					</table>
				</li> --%>
				<li class="list-group-item" onclick="goToMyCareInterface()" style="margin-top:10px;">
					<table style="width:100%;">
						<tr>
							<td style="width:40px;text-align:left;"><img src="<%=uiPath %>business2/images/collects.png" height="30px" width="30px"/></td>
							<td><span>我的关注</span></td>
							<td style="width:20px;text-align:right;"><span class="glyphicon glyphicon-menu-right pull-right" style="color:#bdbdbd;"></span></td>
						</tr>
					</table>
				</li>
				
				<li class="list-group-item" onclick="goToMyIncomeInterface()" style="margin-top:10px;"><!--padding-top:7px;padding-bottom:7px;  -->
					<table style="width:100%;">
						<tr>
							<td style="width:40px;text-align:left;"><img src="<%=uiPath %>business2/images/income.png" height="30px" width="30px"/></td>
							<td><span>我的收益</span></td>
							<td style="width:20px;text-align:right;"><span class="glyphicon glyphicon-menu-right pull-right" style="color:#bdbdbd;"></span></td>
						</tr>
					</table>
				</li>
				
				<li class="list-group-item" onclick="addressManageInterface()" style="margin-top:10px;">
					<table style="width:100%;">
						<tr>
							<td style="width:40px;text-align:left;"><img src="<%=uiPath %>business2/images/addr_mananger.png" height="30px" width="30px"/></td>
							<td><span>地址管理</span></td>
							<td style="width:20px;text-align:right;"><span class="glyphicon glyphicon-menu-right pull-right" style="color:#bdbdbd;"></span></td>
						</tr>
					</table>
				</li>
				
				<li class="list-group-item" style="margin-top:10px;display:none;">
					<table style="width:100%;">
						<tr>
							<td style="width:40px;text-align:left;"><img src="<%=uiPath %>business2/images/share_icon.png" height="30x" width="30px"/></td>
							<td><span>分享给好友</span></td>
							<td style="width:20px;text-align:right;"><span class="glyphicon glyphicon-menu-right pull-right" style="color:#bdbdbd;"></span></td>
						</tr>
					</table>
				</li>
			</ul>
		</div>
	</div>
	
		<!-- 提交订单模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		   aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog" >
		      <div class="modal-content" style="width:50%;min-width:200px;margin-left:auto;margin-right:auto;">
		         <div class="modal-header" style="text-align:left;color:#38BDF8;border-bottom:1px solid #38BDF8;">
		           <span data-account="account"></span>
		           <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="position:absolute:top:0;right:0;"> &times;</button>
		         </div>
		         <div class="modal-body" style="text-align:center;border-bottom:1px solid #38BDF8;">
		           <img src="" width="80%" />
		         </div>
		         <div class="modal-footer" style="text-align:center;white-space:nowrap;">
		           	扫一扫我的二维码图案
		         </div>
		      </div><!-- /.modal-content -->
		</div><!-- /.modal -->
		</div>
		</div>
</body>

</html>