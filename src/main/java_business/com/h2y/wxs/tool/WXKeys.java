package com.h2y.wxs.tool;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import net.sf.json.JSONObject;

import org.apache.http.client.ClientProtocolException;
import org.apache.log4j.Logger;

import com.h2y.util.PropertiesUtil;
import com.h2y.wxshop.Util.Parameters2;

public class WXKeys {
	/*// 全局TOKEN
	public static String accessToken = "6ejglTOMn85Ttyk5y4CPHyhUkUPPPNbc3hB31Qh1W0Szqcc0xvg-x1kmBS4odyH3q232n-elnAr-EqZBf8n4FFQNqGyza3q-nxowgcKkhWo";
	// 唯一appId
	public static String appId = "wx5950970145118999";
	// 唯一appScret
	public static String appScret = "333c9d0287c88a8c9aad6a2c55364925";*/
	// 全局TOKEN
	public static String accessToken = "gMxFp6Q7MazjDgEJoQhM8xCoBLfVszp_uF4Yqcp2-5U4gn42SCXIulkMiS_1aKai5wRvUTb98EiGLCKibY2k3FVEwx5DxpDUShennPlb_o8";
	// 唯一appId
	public static String appId = "wxac6476894b5e59ed";
	// 唯一appScret
	public static String appScret = "949bf0fde2c3eda035ca3f6c4eb96b59";
	// jsapi_ticket
	public static String jsTicket = "";
	
	final static Logger logger = Logger.getLogger(WXKeys.class);


	/**
	 * accessToken
	 * 
	 * @return
	 */
	public static void getAccessToken() {
		String uri = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appId + "&secret=" + appScret;
		try {
			String result = HttpUtil.getInstance().execGet(uri);
			JSONObject obj = JSONObject.fromObject(result);
			if (obj.containsKey("access_token")) {
				accessToken = obj.getString("access_token");
				System.out.println(accessToken + "*******");
			}
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
	/**
     * 获取jsapi_ticket
     * @param accesstoken
     * @return
     */
    public static void getjsTicket(String accesstoken) {
    	
        String jsapi_ticketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
        String url = jsapi_ticketUrl.replace("ACCESS_TOKEN", accesstoken);
        System.out.println("查看js_url:" + url);
       
        try {
        	if(jsTicket.equals("")){
        		String result = HttpUtil.getInstance().execGet(url);
        		logger.debug("result==" + result);
        		
        		JSONObject obj = JSONObject.fromObject(result);
        		
        		if (obj.containsKey("ticket")) {
        			jsTicket = obj.get("ticket").toString();
        			System.out.println("ticket====" + obj.get("ticket"));
        		}else{
        			getAccessToken();
        			getjsTicket(accessToken);
        			return;
        		}
        	}else{
        		
        	}
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
    
    
	/**
	 * 认证
	 * 
	 * @author Administrator
	 * 
	 */
	public static class Oauth {

		private static String URI_ONE = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId + "&redirect_uri=";
		private static String URI_THREE = "&response_type=code&scope=snsapi_base&state=jiushop#wechat_redirect";

		// 微商城 主页
		public static String getOathUri() {
			// 回调页面URLENCODE
			String redrectUri = "";
			try {
				//redrectUri = URLEncoder.encode(Parameters2.WXS + "home.htm", "utf-8");
				redrectUri = URLEncoder.encode(Parameters2.WXS + "vote/index.htm", "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return Parameters2.WXS + "vote/index.htm?refTel=";
//			return URI_ONE + redrectUri + URI_THREE;
		}

		// 微商城 订单
		public static String getOrdUri() {
			// 回调页面URLENCODE
			String redrectUri = "";
			try {
				redrectUri = URLEncoder.encode(Parameters2.WXS + "shopOrd.htm", "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return URI_ONE + redrectUri + URI_THREE;
		}

		// 微商城 签到
		public static String getSignUri() {
			// 回调页面URLENCODE
			String redrectUri = "";
			try {
				redrectUri = URLEncoder.encode(Parameters2.WXS + "shopSign.htm", "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return URI_ONE + redrectUri + URI_THREE;
		}

		// 微商城 注册
		public static String getRegisterUri() {
			// 回调页面URLENCODE
			String redrectUri = "";
			try {
				redrectUri = URLEncoder.encode(Parameters2.WXS + "menuRegister.htm", "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			return URI_ONE + redrectUri + URI_THREE;
		}

		// 请求授权..微商城主页
		// public static final String oauthUri = + redrectUri + ;
		/********************************/
		// 订单回调页面
		// private static final String redrectOrdUri =
		// "http%3A%2F%2Fwx.jydapp.com%2Fwx%2FshopOrd.htm";
		// 请求授权..微商订单
		// public static final String shopOrdUri =
		// "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId
		// + "&redirect_uri=" + redrectOrdUri +
		// "&response_type=code&scope=snsapi_base&state=jiushop#wechat_redirect";
		/********************************/
		// 签到回调页面
		// private static final String redrectSignUri =
		// "http%3A%2F%2Fwx.jydapp.com%2Fwx%2FshopSign.htm";
		// // 请求授权..微商城签到
		// public static final String shopSignUri =
		// "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId
		// + "&redirect_uri=" + redrectSignUri +
		// "&response_type=code&scope=snsapi_base&state=jiushop#wechat_redirect";
		// /*************************************/
		// // 注册回调页面
		// private static final String redrectRegisterUri =
		// "http%3A%2F%2Fwx.jydapp.com%2Fwx%2FmenuRegister.htm";
		// // 请求授权..微商城签到
		// public static final String shopRegisterUri =
		// "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + appId
		// + "&redirect_uri=" + redrectRegisterUri +
		// "&response_type=code&scope=snsapi_base&state=jiushop#wechat_redirect";
		/********************************/
		// 根据CODE 拿到 局部授权TOKEN，不同于全局TOKEN
		public static String tokenByCodeUri = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + appId + "&secret=" + appScret + "&grant_type=authorization_code&code=";
	}

	
	
}