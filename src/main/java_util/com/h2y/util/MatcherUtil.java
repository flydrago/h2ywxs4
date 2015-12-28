package com.h2y.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 正则验证工具类

 * 作者：段晓刚

 * 时间：2014年2月27日 上午10:54:43

 * 电子邮件：851751942@qq.com

 * QQ：851751942

 * Gmail :
 */
public class MatcherUtil {

	/**
	 * 判断手机格式是否正确
	 * @param mobiles
	 * @return
	 */
	public static boolean isMobileNO(String mobiles) {

		Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");

		Matcher m = p.matcher(mobiles);

		return m.matches();
	}

	/**
	 * 判断email格式是否正确
	 * @param email
	 * @return
	 */
	public static boolean isEmail(String email) {

		String str = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";

		Pattern p = Pattern.compile(str);

		Matcher m = p.matcher(email);

		return m.matches();
	}
}
