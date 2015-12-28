package com.h2y.wxs.basic;

/**
 * 常用参数处理
 * 
 * @author：段晓刚
 * 
 * @update：2015年4月3日 上午11:39:23
 * 
 * @Email：
 */
public class WbsKeys {

	/**
	 * 服务端调用参数
	 * 
	 * @author：段晓刚
	 * 
	 * @update：2015年3月27日 上午9:12:27
	 * 
	 * @Email：
	 */
	public enum SInvokeKeys {

		// 配合skey使用进行安全验证
		slock("slock"),
		// 配合slock使用
		skey("skey"),
		// 请求发出后的唯一标示
		sid("sid"),
		// 操作系统
		os("os"),
		// 系统操作类型
		osv("osv"),
		// app版本号
		appv("appv"),
		// userKey版本号
		userKey("userKey"),
		// 参数头部
		paramData("paramData"),
		// 业务参数
		postData("postData"),
		// 返回结果标示
		resultFlag("resultFlag"),
		// 返回结果信息
		resultMsg("resultMsg"),
		// 返回的业务逻辑
		resultData("resultData");

		private String _value;

		SInvokeKeys(String value) {
			_value = value;
		}

		public String value() {
			return _value;
		}
	}
}