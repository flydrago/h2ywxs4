<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../../include/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>酒运达</title>
    <base href="<%=basePath%>"/>
    <link href="<%=uiPath%>lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css"/>


    <script src="<%=uiPath%>lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=uiPath%>lib/ligerUI/js/ligerui.all.js" type="text/javascript"></script>

    <script type="text/javascript">

        var tab = null;
        var tree = null;
        var tabItems = [];
        var tabcount=6;

        $(function () {

            //布局
            $("#layout1").ligerLayout({ leftWidth: 190, height: '100%', heightDiff: -34, space: 4, onHeightChanged: f_heightChanged });

            var height = $(".l-layout-center").height();

            //Tab
            $("#framecenter").ligerTab({
                height: height,
                showSwitchInTab: true,
                showSwitch: true
            });

            $(".l-link").hover(function () {
                $(this).addClass("l-link-over");
            }, function () {
                $(this).removeClass("l-link-over");
            });
            //树
            $("#tree1").ligerTree({
                //data : indexdata,
                url: "portal/login/getMenu.htm",
                checkbox: false,
                idFieldName: "id",
                parentIDFieldName: "pid",
                textFieldName: "text",
                onSelect: function (node) {
                    if (!node.data.url) return;
                    var tabid = $(node.target).attr("tabid");
                    if (!tabid) {
                        tabid = new Date().getTime();
                        $(node.target).attr("tabid", tabid)
                    }
                    f_addTab(tabid, node.data.text, node.data.url);
                }
            });

            tab = liger.get("framecenter");
            tree = liger.get("tree1");
            $("#pageloading").hide();
        });
        function f_heightChanged(options) {
            if (tab)
                tab.addHeight(options.diff);
        }

        /*
         根据url生成 tabID
         */
        function generateTabId(url) {
            var tabid = url.replace(new RegExp("[/:\.\?\=\&,]","gm"),"_");
            return tabid;
        }

        function f_addTab(tabid,text, url){
            if(tabid==null) {
                tabid = generateTabId(url);
            }
            //alert(url);
            tab.addTabItem({ tabid : tabid,text: text, url: url });
        }


        //删除指定标签
        function f_delTab(tabid)
        {
            tab.removeTabItem(tabid);
        }
        //删除活动的标签
        function f_delActivityTab()
        {
            tab.removeTabItem(tab.getSelectedTabItemID());
        }
        //获取活动的标签ID
        function f_getSelectedTabItemID()
        {
            return tab.getSelectedTabItemID();
        }
        //刷新执行标签
        function f_refreshTab(tabid)
        {
            tab.reload(tabid);
        }


    </script>
    <style type="text/css">
        body, html {
            height: 100%;
        }

        body {
            padding: 0px;
            margin: 0;
            overflow: hidden;
        }

        .l-link {
            display: block;
            height: 26px;
            line-height: 26px;
            padding-left: 10px;
            text-decoration: underline;
            color: #333;
        }

        .l-link2 {
            text-decoration: underline;
            color: white;
            margin-left: 2px;
            margin-right: 2px;
        }

        .l-layout-top {
            background: #102A49;
            color: White;
        }

        .l-layout-bottom {
            background: #E5EDEF;
            text-align: center;
        }

        #pageloading {
            position: absolute;
            left: 0px;
            top: 0px;
            background: white url('<%=uiPath%>lib/images/loading.gif') no-repeat center;
            width: 100%;
            height: 100%;
            z-index: 99999;
        }

        .l-link {
            display: block;
            line-height: 22px;
            height: 22px;
            padding-left: 16px;
            border: 1px solid white;
            margin: 4px;
        }

        .l-link-over {
            background: #FFEEAC;
            border: 1px solid #DB9F00;
        }

        .l-winbar {
            background: #2B5A76;
            height: 30px;
            position: absolute;
            left: 0px;
            bottom: 0px;
            width: 100%;
            z-index: 99999;
        }

        .space {
            color: #E7E7E7;
        }

        /* 顶部 */
        .l-topmenu {
            margin: 0;
            padding: 0;
            height: 31px;
            line-height: 31px;
            background: url('<%=uiPath%>lib/images/top.jpg') repeat-x bottom;
            position: relative;
            border-top: 1px solid #1D438B;
        }

        .l-topmenu-logo {
            color: #E7E7E7;
            padding-left: 35px;
            line-height: 26px;
            background: url('<%=uiPath%>lib/images/topicon.gif') no-repeat 10px 5px;
        }

        .l-topmenu-welcome {
            position: absolute;
            height: 24px;
            line-height: 24px;
            right: 30px;
            top: 2px;
            color: #070A0C;
        }

        .l-topmenu-welcome a {
            color: #E7E7E7;
            text-decoration: underline
        }

        .body-gray2014 #framecenter {
            margin-top: 3px;
        }

        .viewsourcelink {
            background: #B3D9F7;
            display: block;
            position: absolute;
            right: 10px;
            top: 3px;
            padding: 6px 4px;
            color: #333;
            text-decoration: underline;
        }

        .viewsourcelink-over {
            background: #81C0F2;
        }

        .l-topmenu-welcome label {
            color: white;
        }

        #skinSelect {
            margin-right: 6px;
        }
    </style>
</head>
<body style="padding:0px;background:#EAEEF5;">
<div id="pageloading"></div>
<div id="topmenu" class="l-topmenu">
    <div class="l-topmenu-logo">酒运达主页</div>
    <div class="l-topmenu-welcome">
        <label> 皮肤切换：</label>
        <select id="skinSelect">
            <option value="aqua">默认</option>
            <option value="silvery">Silvery</option>
            <option value="gray">Gray</option>
            <option value="gray2014">Gray2014</option>
        </select>
        <a href="index.aspx" class="l-link2">服务器版本</a>
        <span class="space">|</span>
        <a href="https://me.alipay.com/daomi" class="l-link2" target="_blank">捐赠</a>
        <span class="space">|</span>
        <a href="http://bbs.ligerui.com" class="l-link2" target="_blank">论坛</a>
    </div>
</div>
<div id="layout1" style="width:99.2%; margin:0 auto; margin-top:4px; ">
    <div position="left" title="功能菜单">
        <ul id="tree1" style="margin-top:3px;">
    </div>
    <div position="center" id="framecenter">
        <div tabid="home" title="我的主页" style="height:300px">
            <iframe frameborder="0" name="home" id="home" src="welcome.htm"></iframe>
        </div>
    </div>

</div>
<div style="height:32px; line-height:32px; text-align:center;">
    Copyright © 2011-2014 www.ligerui.com
</div>
<div style="display:none"></div>
</body>
</html>
