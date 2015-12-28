package com.h2y.wxs.basic;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.h2y.util.JSONUtil;
import com.h2y.util.PropertiesUtil;

/**
 * 基础Controller 作者：段晓刚 时间：2014-3-8 下午3:11:48 电子邮件：851751942@qq.com Gmail :
 */
@Controller
public class BaseController {

	protected DecimalFormat format = new DecimalFormat("0.00");
	protected HttpServletResponse response;
	protected HttpServletRequest request;
	protected HttpSession session;

	// url通知
	private Map<String, String> urlMap = new HashMap<String, String>();

	protected Charset utf_8 = Charset.forName("UTF-8");

	/**
	 * 获取用户信息
	 * 
	 * @return
	 */
	protected Map<String, Object> getCurrentUser() {

		return null;
	}

	/**
	 * 获取URL配置信息
	 * 
	 * @return
	 * @throws java.io.IOException
	 * @update：2014年8月4日 下午8:42:09
	 */
	protected Map<String, String> getURLConfing() throws IOException {

		if (urlMap == null || urlMap.isEmpty())
			urlMap = PropertiesUtil.getInstance("/webconfig.properties").getMap();
		return urlMap;
	}

	/**
	 * @ModelAttribute放置在方法上面：表示请求该类的每个Action前都会首先执行它， 你可以将一些准备数据的操作放置在该方法里面
	 */
	@ModelAttribute
	public void setReqAndResp(HttpServletResponse response, HttpServletRequest request) {
		this.response = response;
		this.request = request;
		this.session = request.getSession();
	}

	protected void outJson(Object obj) {
		out(JSONUtil.getJson(obj));
	}

	/**
	 * 输出数据
	 * 
	 * @param value
	 */
	protected void out(String value) {
		PrintWriter out = null;
		try {
			response.setContentType("text/html;charset=UTF-8");
			out = response.getWriter();
			out.println(value);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	/**
	 * 得到当前用户的单位Id
	 * 
	 * @return
	 */
	protected long getLoginUnitsId() {

		return 1;
	}

	/**
	 * 得到登录用户的Id
	 * 
	 * @return
	 */
	protected long getLoginUserId() {

		return 1;
	}

	/**
	 * 得到登录用户对象
	 * 
	 * @return
	 */
	protected long getLoginUser() {

		return 1;
	}
}