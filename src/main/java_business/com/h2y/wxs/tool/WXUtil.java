package com.h2y.wxs.tool;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import com.h2y.util.HttpTookit;

/**
 * 微信获取值相关工具
 * 
 * @author Administrator
 * 
 */
public class WXUtil {

	final static Logger log = Logger.getLogger(WXUtil.class);

	/**
	 * 通过授权流程得到OPENID
	 * 
	 * @param code
	 * @return
	 */
	public static String getOauth(String code,String appId,String appScret) {
		log.debug("code==" + code);
		
		String tokenByCodeUri = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appId + "&secret=" + appScret + "&grant_type=authorization_code&code="+ code;
		String result = HttpTookit.doGet(tokenByCodeUri, null);
		log.debug("result==" + result);
		JSONObject obj = JSONObject.fromObject(result);
		if (obj.containsKey("openid")) {
			return obj.getString("openid");
		}
		log.debug("无法得到OPENID");
		return "";
	}
}
