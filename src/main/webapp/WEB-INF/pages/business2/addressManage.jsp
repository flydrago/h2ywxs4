<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath %>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="<%=uiPath%>business2/css/addressManager.css" />
		<link rel="stylesheet" href="<%=uiPath%>lib/bootstrap-3.3.2-dist/css/bootstrap.min.css" />
		<script type="text/javascript" src="<%=uiPath%>lib/jquery/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="<%=uiPath%>lib/bootstrap-3.3.2-dist/js/bootstrap.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/util/showTip.js"></script>
		<script type="text/javascript" src="<%=uiPath%>business2/js/addressManage.js"></script>
		<title>地址管理</title>
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
						<span style="color:#FFF;font-size:18px;">地址显示</span>
					</td>
					
					<!-- 更多 -->
					<td style="width:43px;">
						
					</td>
			  </tr>
			</table>
		</div>
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		  
        <!-- 新建收货地址 -->
        <div class="addressBgImg" style="position:absolute;top:50px;width:100%;height:60px;line-height:60px;text-align:center;" onclick="setUpNewAddr()">
			<span>新建收货地址</span>
		</div>
		
		<!-- ----------------------------------------------------------------------------------------------------------------- -->
		
		<!-- 已有收货地址 -->
		<!-- 默认地址标记 -->
		<div id="addrDefaultTemplate" class="addrDefaultDiv" style="width:25px;height:25px;display:none;"></div>
		<!-- 模板 开始 -->
		<div id="cusAddrTemplate" style="width:100%;padding:10px 15px;margin-bottom:10px;border-bottom:1px solid #e7e7e7;background:#fff;display:none;">
			<span data-cusName="cusName" class="pull-left" ></span>
			<span data-cusPhone="cusPhone" class="pull-right" ></span>
			<br/>
			<p data-cusAddr="cusAddr"></p>
			<span data-addressId="addressId" style="display:none;"></span>
		</div>
		<!-- 模板 结束 -->
		
		<div id="contentDiv" style="position:absolute;width:100%;top:120px;bottom:67px;overflow-y:auto;overflow-x:hidden;">
			<div id="cusAddrList">
			</div>
			
			<!-- 查看更多 -->
			<div id="lookMoreBtn" style="display:none;width:98%;margin-left:auto;margin-right:auto;text-align:center;margin-top:15px;">
				<div style="width:100%;">上拉加载更多</div>
<!-- 				<button type="button" class="btn btn-primary" style="width:100%;">查看更多</button> -->
			</div>
		</div>
		
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		   aria-labelledby="myModalLabel" aria-hidden="true" style="display:none">
		   <div class="modal-dialog" style="">
		      <div class="modal-content">
		         <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" 
		               aria-hidden="true">×
		            </button>
		            <h4 class="modal-title" id="myModalLabel" style="color:#0D4FFA">
		               操作
		            </h4>
		            <input type="hidden" id="opAddrID">
		         </div>
		         <div class="modal-body" style="border-bottom:1px solid #e7e7e7" onclick="deleteAddrMsg()">
		            删除信息
		         </div>
				 <div class="modal-body" style="border-bottom:1px solid #e7e7e7" onclick="modifyAddrMsg()">
		            修改信息
		         </div>
				 <div class="modal-body" onclick="setDefaultAddrMsg()">
		            设为默认
		         </div>
         
		      	</div><!-- /.modal-content -->
		   </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		<input id="fromFlagInput" type="hidden" value='<%=request.getAttribute("fromFlag")%>'>
		
		<div id="warmWarning" class="alert" style="position:absolute;display:none;width:100%;text-align:center;bottom:76px;color:#fff;">
			<span class="badge" style="background:red;line-height:25px;"></span>
		</div>
		</div>
	</body>
</html>