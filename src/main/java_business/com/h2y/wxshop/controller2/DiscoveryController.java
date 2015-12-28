package com.h2y.wxshop.controller2;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h2y.util.JSONUtil;
import com.h2y.wxs.basic.BaseController;

@Controller
public class DiscoveryController extends BaseController{

//	Logger logger = Logger.getLogger(DiscoveryController.class);
	
	/**大转盘页面**/
	@RequestMapping("/luckyDrawPage")
	public String luckyDrawPage(){
		return "business2/luckyDraw";
	}
	
	/**酒爱页面**/
	@RequestMapping("/loveWinePage")
	public String loveWinePage(){
		return "business2/loveWine";
	}
	
	/**活动页面**/
	@RequestMapping("/specialOfferPage")
	public String specialOfferPage(){
		return "business2/specialOffer";
	}
	/**统一url跳转**/
	@RequestMapping("/unifyUrlJump")
	public String unifyUrlJump(){
		try {
			String data = request.getParameter("paraJson");
			Map<String,Object> map = JSONUtil.getMap(data);
			String title = map.get("title")+"";
			String url = map.get("url") + "";
			url = url.replaceAll("\\*@\\*", "&");
			request.setAttribute("title", title);
			request.setAttribute("url", url);
			return "business2/unifyUrlJump";
		} catch (Exception e) {
			//logger.error(e.getMessage(), e);
			return "business2/unifyUrlJump";
		}
	
	}
}

