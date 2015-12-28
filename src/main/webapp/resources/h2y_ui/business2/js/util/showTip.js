/**
 * Author: Mr.Lu 
 * Function: 提醒显示
 * DateTime: 2015年5月22日 16:51:35
 */

/**
 *  显示提示
 *  @_tipStr 要显示的信息
 *  @_time 显示时长
 *  @_backFlag 返回标志
 */
function showTip(_tipStr,_time,_backFlag){

	$("#warmWarning").show().find("span").html(_tipStr);
	var timer = setInterval(function(){
		clearInterval(timer);
		$("#warmWarning").hide();
		if(_backFlag == 1){
			window.history.back();
		}
	},_time == null ||  _time == "" ? 2000 : _time);
}