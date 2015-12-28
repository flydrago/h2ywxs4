package com.h2y.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

/**
 * 

 * 作者：段晓刚

 * 时间：2012-8-16 上午09:10:13

 * 电子邮件：duanxg@hwttnet.com

 * QQ：2410960521

 * Gmail :
 */
public class CilentTool{
	@SuppressWarnings("unused")
	private static Logger log = Logger.getLogger(CilentTool.class);
	private HttpServletRequest request;
	private String headerUserAgent;
	private CilentTool (HttpServletRequest request){
		this.request=request;
		headerUserAgent=request.getHeader("user-agent");
		//log.debug(headerUserAgent);
	}
	public static CilentTool getInstance(HttpServletRequest request){
		return new CilentTool(request);
	}
	public String getJson(){
		
		return "'browser':'"+getBrowser()+"','os':'"+getOs()+"','referer':'"+getReferer()+"'";
	}
	
	public  String getBrowser() {
		String browserVersion = "";
		if (headerUserAgent==null) {
			return "";
		}
		
		if (headerUserAgent.indexOf("MSIE") > 0) {
			browserVersion = "IE";
		} else if (headerUserAgent.indexOf("Firefox") > 0) {
			browserVersion = "Firefox";
		} else if (headerUserAgent.indexOf("Chrome") > 0) {
			browserVersion = "Chrome";
		} else if (headerUserAgent.indexOf("Opera") > 0) {
			browserVersion = "Opera";
		}else if (headerUserAgent.indexOf("Safari") > 0) {
			browserVersion = "Safari";
		} else if (headerUserAgent.indexOf("Camino") > 0) {
			browserVersion = "Camino";
		} else if (headerUserAgent.indexOf("Konqueror") > 0) {
			browserVersion = "Konqueror";
		} else if (headerUserAgent.indexOf("MQQBrowser") > 0) {
			browserVersion = "MQQBrowser";
		} else if (headerUserAgent.indexOf("UCBrowser") > 0) {
			browserVersion = "UCBrowser";
		} else if (headerUserAgent.indexOf("MicroMessenger") > 0) {
			browserVersion = "MicroMessenger";//微信内置浏览器
		} else if (headerUserAgent.indexOf("QQ/") > 0) {
			browserVersion = "QQ/";//qq内置浏览器
		}else if(headerUserAgent.indexOf("Gecko")>0 && headerUserAgent.indexOf("rv:11.0")>0){
			   return "IE11";
		  }
		String [] headerArry = headerUserAgent.split(" ");
		for(String temp : headerArry){
			if(temp.indexOf(browserVersion)>-1){
				if(browserVersion.equals("")){
					browserVersion = "default:IE";
				}else{
					browserVersion = temp;
				}
				
				break;
			}
		}
		//log.debug("Customer browser：" + browserVersion);
		return browserVersion;
	}
	public String getReferer(){
		String referer=request.getHeader("Referer");
		//log.debug("Customer Referer ：" + referer);
		return referer;
	}
	public  String getOs() {
		
		String systenInfo = null;
		if (headerUserAgent==null) {
			return "";
		}
		// 得到用户的操作系统
		String headerSubStr = headerUserAgent.substring(headerUserAgent.indexOf("("), headerUserAgent.indexOf(")"));
		if (headerSubStr.indexOf("NT 6.0") > 0) {
			systenInfo = "Windows Vista/Server 2008";
		} else if (headerSubStr.indexOf("NT 5.2") > 0) {
			systenInfo = "Windows Server 2003";
		} else if (headerSubStr.indexOf("NT 5.1") > 0) {
			systenInfo = "Windows XP";
		} else if (headerSubStr.indexOf("NT 6.0") > 0) {
			systenInfo = "Windows Vista";
		} else if (headerSubStr.indexOf("NT 6.1") > 0) {
			systenInfo = "Windows 7";
		} else if (headerSubStr.indexOf("NT 6.2") > 0) {
			systenInfo = "Windows Slate";
		} else if (headerSubStr.indexOf("NT 6.3") > 0) {
			systenInfo = "Windows 9";
		} else if (headerSubStr.indexOf("NT 5") > 0) {
			systenInfo = "Windows 2000";
		} else if (headerSubStr.indexOf("NT 4") > 0) {
			systenInfo = "Windows NT4";
		} else if (headerSubStr.indexOf("Me") > 0) {
			systenInfo = "Windows Me";
		} else if (headerSubStr.indexOf("98") > 0) {
			systenInfo = "Windows 98";
		} else if (headerSubStr.indexOf("95") > 0) {
			systenInfo = "Windows 95";
		} else if (headerSubStr.indexOf("Mac") > 0) {
			if(headerSubStr.indexOf("iphone")>-1){
				systenInfo = "iPhone";
			}else if(headerSubStr.indexOf("ipad")>-1){
				systenInfo = "iPad";
			}else if(headerSubStr.indexOf("Macintosh")>-1){
				systenInfo = "Macintosh";
			}else{
				systenInfo = "Mac";
			}
			systenInfo = systenInfo + headerSubStr + ")";
		} else if (headerUserAgent.indexOf("Unix") > 0) {
			systenInfo = "UNIX";
		} else if (headerUserAgent.indexOf("Linux") > 0) {
			if(headerUserAgent.indexOf("Android") >-1){
				systenInfo = "Android";
				String [] headerArry = headerUserAgent.substring(headerUserAgent.indexOf("("), headerUserAgent.indexOf(")")).split(";");
				for(String temp : headerArry){
					if(temp.indexOf(systenInfo)>-1){
						systenInfo = temp;
						break;
					}
				}
				systenInfo = systenInfo + headerSubStr.split(systenInfo)[1];
				System.out.println(systenInfo);
			}else{
				systenInfo = "Linux";
			}
		} else if (headerUserAgent.indexOf("SunOS") > 0) {
			systenInfo = "SunOS";
		}
		
		return systenInfo;
	}
	
	
	public String getIpAddr(HttpServletRequest request) { 
		
		String ip = request.getHeader("X-Forwarded-For");
		 
	    if ((ip == null) || (ip.length() == 0) || ("unknown".equalsIgnoreCase(ip))) {
	      ip = request.getHeader("Proxy-Client-IP");
	    }
	    if ((ip == null) || (ip.length() == 0) || ("unknown".equalsIgnoreCase(ip))) {
	      ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if ((ip == null) || (ip.length() == 0) || ("unknown".equalsIgnoreCase(ip))) {
	      ip = request.getHeader("HTTP_CLIENT_IP");
	    }
	    if ((ip == null) || (ip.length() == 0) || ("unknown".equalsIgnoreCase(ip))) {
	      ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	    }
	    if ((ip == null) || (ip.length() == 0) || ("unknown".equalsIgnoreCase(ip))) {
	      ip = request.getRemoteAddr();
	    }
        return ip; 
     } 
}
