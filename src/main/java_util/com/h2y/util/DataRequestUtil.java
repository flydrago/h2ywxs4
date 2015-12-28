package com.h2y.util;

import java.util.HashMap;
import java.util.Map;

import com.h2y.wxs.basic.WbsKeys.SInvokeKeys;

/**
 * 项目名称：h2ygdsos  
 * 类名称：DataResponseUtil  
 * 类描述：  服务数据请求数据工具类
 * 创建人：侯飞龙  
 * 创建时间：2015年4月14日 下午2:40:14  
 * 修改人：侯飞龙
 * 修改时间：2015年4月14日 下午2:40:14  
 * 修改备注：  
 * @version
 */
public class DataRequestUtil{
	
	/**
	 * 得到请求数据
	 * @param postData 访问的参数
	 * @return
	 */
	public static Map<String,Object> getRequestData(Map<String,Object> postData) {
		
		postData.put(SInvokeKeys.os.value(),"wechat");
		postData.put(SInvokeKeys.osv.value(),"1");
		postData.put(SInvokeKeys.appv.value(),"1");
		postData.put(SInvokeKeys.userKey.value(),"1");

		return getRequestData(JSONUtil.getJson(postData));
    } 
	
	
	
	/**
	 * 得到请求数据
	 * @param postDataJson 访问的参数的json形式
	 * @return
	 */
	public static Map<String,Object> getRequestData(String postDataJson) {
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put(SInvokeKeys.slock.value(),"1");
		resultMap.put(SInvokeKeys.skey.value(),"1");
		resultMap.put(SInvokeKeys.sid.value(),"1");
		resultMap.put(SInvokeKeys.os.value(),"wechat");
		resultMap.put(SInvokeKeys.osv.value(),"1");
		resultMap.put(SInvokeKeys.appv.value(),"1");
		resultMap.put(SInvokeKeys.userKey.value(),"1");
		
		resultMap.put(SInvokeKeys.postData.value(), postDataJson);
		return resultMap;
    } 
}
