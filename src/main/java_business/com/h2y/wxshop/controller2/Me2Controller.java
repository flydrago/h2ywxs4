package com.h2y.wxshop.controller2;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.h2y.util.DataRequestUtil;
import com.h2y.util.HttpTookit;
import com.h2y.wxs.basic.BaseController;
import com.h2y.wxshop.Util.JsonUtil;
import com.h2y.wxshop.Util.Parameters2;

@Controller
@Scope("prototype")
public class Me2Controller extends BaseController {

	final Logger logger = Logger.getLogger(Me2Controller.class);

	@Autowired
	protected JdbcTemplate jdbcTemplate;
	
	/**
	 * 进入我的酒运达页面
	 * @return
	 */
	@RequestMapping(value = "/meJYD")
	public String meJYD(){
		
		return "business2/me";
	}
	
	
	/**
	 * 进入更多页面
	 * @return
	 */
	@RequestMapping(value = "/goMeMoreInterface")
	public String goMeMoreInterface(){
		
		return "business2/meMore";
	}
	
	
	/**
	 * 进入登录页面
	 * @return
	 */
	@RequestMapping(value = "/goLoginInterface")
	public String goLoginInterface(){
		
		return "business2/login";
	}
	
	/**
	 * 进入密码登录页面
	 * @return
	 */
	@RequestMapping(value = "/goToMyPwdLoginInterface")
	public String goToMyPwdLoginInterface(){
		
		return "business2/login2";
	}
	
	
	/**
	 * 进入找回密码页面
	 * @return
	 */
	@RequestMapping(value = "/goToRegisterInterface")
	public String goToRegisterInterface(){
		
		return "business2/register";
	}
	
	/**
	 * 进入服务条款页面
	 * @return
	 */
	@RequestMapping(value = "/serviceRule")
	public String serviceRule(){
		
		return "business2/serviceRule";
	}
	

	/**
	 * 进入关于页面
	 * @return
	 */
	@RequestMapping(value = "/goAboutInterface")
	public String goAboutInterface(){
		
		return "business2/about";
	}
	
	/**
	 * 进入注册页面
	 * @return
	 */
	@RequestMapping(value = "/goFindPwdInterface")
	public String goFindPwdInterface(){
		
		return "business2/resetPwd";
	}
	
	
	/**
	 * 进入修改密码页面
	 * @return
	 */
	@RequestMapping(value = "/goChangePwdInterface")
	public String goChangePwdInterface(){
		
		return "business2/changePwd";
	}
	
	/**
	 * 进入个人资料编辑页面
	 * @return
	 */
	@RequestMapping(value = "/goEditMemberDataInterface")
	public String goEditMemberDataInterface(){
		
		return "business2/editMemberData";
	}
	
	/**
	 * 进入优惠券页面
	 * @return
	 */
	@RequestMapping(value = "/goCouponInterface")
	public String goCouponInterface(){
		
		return "business2/coupon";
	}
	
	
	/**
	 * 进入优惠券详情
	 * @return
	 */
	@RequestMapping(value = "/mCouponDetail")
	public String mCouponDetail(){
		String data = request.getParameter("paraJson");
		String shortName = request.getParameter("shortName");
		String remainDay = request.getParameter("remainDay");
		String url = Parameters2.CMBS + Parameters2.Me.getCouponDetail;
		String result = HttpTookit.doPost(url, DataRequestUtil.getRequestData(data));
		request.setAttribute("result", result);
		request.setAttribute("shortName", shortName);
		request.setAttribute("remainDay", remainDay);
		return "business2/couponDetail";
	}
	
	/**
	 * 进入领券广场
	 * @return
	 */
	@RequestMapping(value = "/goGetCouponInterface")
	public String goGetCouponInterface(){
		
		return "business2/getCoupon";
	}
	
	/**
	 * 进入我的收益页面
	 * @return
	 */
	@RequestMapping(value = "/lookMyIncomeList")
	public String lookMyIncomeList(){
		
		return "business2/myIncome";
	}
	
	
	/**
	 * 我的酒运达页面的达人豆达人币
	 * @return
	 */
	@RequestMapping(value = "/getMyIncomeData")
	
	public void getMyIncomeData(){
		String data = request.getParameter("paraJson");
		
		final String url = Parameters2.CMBS + Parameters2.Grade.getGrade;
		
		String result = HttpTookit.doPost(url, DataRequestUtil.getRequestData(data));
		
		if (result == null || result.equals("\r\n")) {
			out("{}");
		}else{
			out(result);
		}
		
	}
	
	
	/**
	 * 获取我的收益列表数据
	 * @return
	 */
	@RequestMapping(value = "/getMyIncomeListData")
	
	public void getMyIncomeListData(){
		
		String data = request.getParameter("paraJson");
		
		final String url = Parameters2.CMBS + Parameters2.Grade.getGradeDetail;
		
		String result = HttpTookit.doPost(url, DataRequestUtil.getRequestData(data));
		
		if (result == null || result.equals("\r\n")) {
			result = "{}";
		}
		out(result);
	}
	
	
	
	/**进入我的关注页面*/ 
	@RequestMapping(value = "/lookMyCareList")
	public String lookMyCareList(){
		
		return "business2/myCare";
	}
	
	
	/**
	 * 获取我的关注数据
	 * @return
	 */
	@RequestMapping(value = "/getMyCareData")
	public void getMyCareData(String postParam){
		
//		JSONObject paramJo = JSONObject.fromObject(postParam);
		final String uri =  Parameters2.CMBS + Parameters2.Me.getGoodsFocusList; 
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(postParam));

		if (result == null || result.equals("\r\n")) {
			result = "{}";
		}
		out(result);
	}
	
	/**
	 * 进入签到页面
	 * @return
	 */
	@RequestMapping(value = "/goSignInterface")
	public String goSignInterface(){
		
		return "business2/sign2";
	}
	
	/**
	 * 进入签到页面
	 * @return
	 */
	@RequestMapping(value = "/goSignInterface2")
	public void goSignInterface2(String paraJson){
		
		final String uri =  Parameters2.CMBS + Parameters2.Grade.sign; 
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(paraJson));
		
		if (result == null || result.equals("\r\n")) {
			result = "{}";
		}
		out(result);
	}
	
		
	
	/**注销账户**/
	@RequestMapping(value="/logoutAccount",method = RequestMethod.POST)
	@ResponseBody
	public String logOutAccount(){
		session.invalidate();
		return JsonUtil.htmlEncode("1");
	}
	
	
	/**
	 * 二维码
	 */
	@RequestMapping(value = "/lookQrCode")
	public void lookQrCode(){
		
		String data = request.getParameter("paraJson");
		
		final String uri = Parameters2.CMBS + Parameters2.Me.getQrCode;;
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if (result == null || result.equals("\r\n")) {
			result = "{}";
		}
		
		out(result);
	}
	
	
	/**
	 * 进入我的好J友界面
	 */
	@RequestMapping(value = "/goToMyJFriendsInterface")
	public String goToMyJFriendsInterface(){ 
		
		return "business2/myJFriends";
	}
	
	
	/**
	 * 完善个人资料
	 */
	@RequestMapping(value = "/editMemberData")
	public void editMemberData(){
		
		String data = request.getParameter("paraJson");
		
		final String uri = Parameters2.CMBS + Parameters2.Me.submitMemberData;
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if(result == null || result.equals("\r\n")){
			out("{}");
		}else{
			out(result);
		}
	}
	
}

