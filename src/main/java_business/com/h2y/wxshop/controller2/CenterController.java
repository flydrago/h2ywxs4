package com.h2y.wxshop.controller2;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h2y.util.HttpTookit;
import com.h2y.wxs.basic.BaseController;

/**
 * 项目名称：h2ycmbs2 Maven Webapp  
 * 类名称：CenterController  
 * 类描述：核心转发服务类  
 * 创建人：侯飞龙  
 * 创建时间：2015年4月23日 上午11:58:10  
 * 修改人：侯飞龙
 * 修改时间：2015年4月23日 上午11:58:10  
 * 修改备注：  
 * @version
 */
@Controller
@Scope("prototype")
@RequestMapping(value="/cmbs/{moduleName}")
public class CenterController extends BaseController{
	
	@RequestMapping(value="/{methodName}")
	public void getList(@PathVariable(value="moduleName") String moduleName,@PathVariable(value="methodName") String methodName){
		
		out(HttpTookit.doServicePost(moduleName, methodName, request));
	}
}
