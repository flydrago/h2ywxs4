package com.h2y.wxs.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom2.Document;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.h2y.util.JSONUtil;
import com.h2y.wxs.service.MsgAdapter;
import com.h2y.wxs.tool.SignUtil;
import com.h2y.wxs.tool.WXKeys;

@Controller
@RequestMapping(value = "wxs")
@Scope("prototype")
public class WXController {

	@Autowired
	private MsgAdapter msgAdapter;

	/**
	 * 验证url和token
	 */
	@RequestMapping(value = "msg", method = RequestMethod.GET)
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 微信加密签名
		String signature = request.getParameter("signature");
		// 时间戮
		String timestamp = request.getParameter("timestamp");
		// 随机数
		String nonce = request.getParameter("nonce");
		// 随机字符串
		String echostr = request.getParameter("echostr");

		System.out.println(signature + "--" + timestamp + "--" + nonce + "--" + echostr);

		PrintWriter out = response.getWriter();
		// 通过检验 signature 对请求进行校验，若校验成功则原样返回 echostr，表示接入成功，否则接入失败\
		if (SignUtil.checkSignature(signature, timestamp, nonce)) {
			out.print(echostr);
		}

		out.close();
		out = null;
	}
	/**
	 * 验证url和token
	 */
	@RequestMapping(value = "getJsTicket", method = RequestMethod.POST)
	public void getJsTicket(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 微信加密签名
		String jsurl = request.getParameter("url");
		long timestamp = System.currentTimeMillis();
		String nonce = "Wm3WZYTPz0wzccnW";
		WXKeys.getjsTicket(WXKeys.accessToken);
		
		String jsSignature = SignUtil.getSignature(WXKeys.jsTicket, timestamp, nonce, jsurl);
		
		Map<String,Object> dataMap = new HashMap<String,Object>();
		if(!jsSignature.equals("false")){
			dataMap.put("timestamp", timestamp);
			dataMap.put("nonce",nonce);
			dataMap.put("signature", jsSignature);
			dataMap.put("appId", WXKeys.appId);
			dataMap.put("appScret", WXKeys.appScret);
		}else{
			getJsTicket(request,response);
			return;
		}
		
		
		PrintWriter out = response.getWriter();
		out.print(JSONUtil.getJson(dataMap));
		out.close();
		out = null;
	}

	/**
	 * 用户向公众平台发信息并自动返回信息
	 */
	@RequestMapping(value = "msg", method = RequestMethod.POST)
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		InputStream is = request.getInputStream();

		// 来源消息实体
		Document fromDoc = getDoc(is);
		is.close();

		// 根据来源消息得到处理结果
		String outStr = msgAdapter.dispatchMsg(fromDoc);

		System.out.println("outStr= " + outStr);

		outStr = outStr == null ? "" : outStr;

		response.setCharacterEncoding("utf-8");
		response.getWriter().write(outStr);
	}

	/**
	 * 获取消息实体
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	private Document getDoc(InputStream is) throws IOException {
		// 获取输入流 用于构建DOM文档
		SAXBuilder builder = new SAXBuilder();

		Document doc = null;
		try {
			doc = builder.build(is);
		} catch (JDOMException e) {
			e.printStackTrace();
		}

		return doc;
	}
}