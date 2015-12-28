package com.h2y.wxshop.controller2;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h2y.util.DataRequestUtil;
import com.h2y.util.HttpTookit;
import com.h2y.util.JSONUtil;
import com.h2y.wxs.basic.BaseController;
import com.h2y.wxshop.Util.Parameters2;

/**
 * 收获地址维护
 * 
 * @author Administrator
 * 
 */
@Controller
@Scope("prototype")
public class Address2Controller extends BaseController {

	final Logger logger = Logger.getLogger(Address2Controller.class);

	/**
	 * 进入地址显示页面
	 */
	@RequestMapping(value = "/goAddrManageInterface")
	public String goAddrManageInterface() {
		String data = request.getParameter("fromFlag");
		request.setAttribute("fromFlag", data == null ? "2" : data);
		
		return "business2/addressManage";
	}
	/**
	 * 新建收货地址页面
	 */
	@RequestMapping(value = "/goNewAddrInterface")
	public String goNewAddrInterface() {
		
		return "business2/newAddress";
	}
	
	/**修改地址页面**/
	@RequestMapping(value = "/goModifyAddrInterface")
	public String goModifyAddrInterface(String addrID,Model model){
		
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("id", addrID);
		
		final String uri = Parameters2.CMBS + Parameters2.Address.getAddrByID;
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(postMap));
		Map<String, Object> resMap = JSONUtil.getMap(result);
		
		model.addAttribute("addrInfo", resMap);
		return "business2/modAddr";
	}
	
	/**添加地址时进入地址选择页面**/
	@RequestMapping("/chooseCityPage")
	public String chooseCityPage(String paraJson,Model model){
//		Map<String,Object> paraMap = JSONUtil.getMap(paraJson);
//		session.setAttribute("newAddrTempMap",paraMap);
//		model.addAttribute("operateType", 0);
		return "business2/chooseCity";
	}
	
	/**地址选择完成**/
	/*
	@RequestMapping("/confirmChosenAddr")
	public String confirmChosenAddr(String chosenAddr,Model model){
		@SuppressWarnings("unchecked")
		Map<String,Object> paraMap = (Map<String, Object>) session.getAttribute("newAddrTempMap");
		paraMap.put("cusAddr", chosenAddr);
		model.addAttribute("addrInfo", paraMap);
		return "business2/newAddress";
	}*/
	
	
	/**
	 * 调取百度地图
	 */
	@RequestMapping(value = "/goBaiDuInterface")
	public String goBaiDuInterface() {
		
		return "business2/baiduMap";
	}
	
}

