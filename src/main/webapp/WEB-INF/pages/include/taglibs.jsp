<%@page import="com.h2y.wxshop.Util.Parameters2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	if (!path.endsWith("/")) {
		path = path + "/";
	}
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
	String uiPath = basePath + "resources/h2y_ui/";
	String skinName = "Aqua";
	String toolbar_bg = uiPath + "dg_ui/skins/" + skinName + "/images/buttons/panel-toolbar.jpg";

	String imgPath = Parameters2.FP;//"http\://125.40.63.12:8082/h2yfp/image/show.htm?";
	String serverPath = Parameters2.WXS;//"http\://125.40.63.12/h2ywxs/";
%>
