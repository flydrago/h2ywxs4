/**
 * Author:Mr.Lu
 * Function:微信浏览器选择退出（针对物理返回键）
 * CreateDate:2015年7月27日 19:44:35
 */

pushHistory();

setTimeout(function () {
  window.addEventListener("popstate", function(e) {
	  pushHistory();
	  layer.confirm('您确定离开酒运达微商城吗？', {
			btn: ['确定','取消'], //按钮
			icon:0,
			shade: 0.5 //不显示遮罩false
		}, function(){
			 WeixinJSBridge.call('closeWindow');
		}, function(){
			layer.close();
		});
  }, false);
}, 300);

function pushHistory() {
  var state = {
    title: "title",
    url: "#"
  };
  window.history.pushState(state, "title", "#");
}
	 
