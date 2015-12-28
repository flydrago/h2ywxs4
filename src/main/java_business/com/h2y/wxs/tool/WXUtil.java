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
	public static String getOauth(String code) {
		log.debug("code==" + code);
		String tokenByCode = WXKeys.Oauth.tokenByCodeUri + code;
		String result = HttpTookit.doGet(tokenByCode, null);
		log.debug("result==" + result);
		JSONObject obj = JSONObject.fromObject(result);
		if (obj.containsKey("openid")) {
			return obj.getString("openid");
		}
		log.debug("无法得到OPENID");
		return "";
	}
}
