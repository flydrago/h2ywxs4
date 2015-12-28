package com.h2y.wxshop.controller2;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h2y.util.DataRequestUtil;
import com.h2y.util.HttpTookit;
import com.h2y.util.JSONUtil;
import com.h2y.wxs.basic.BaseController;
import com.h2y.wxs.tool.WXKeys;
import com.h2y.wxs.tool.WXUtil;
import com.h2y.wxshop.Util.Parameters2;

import net.sf.json.JSONObject;

@Controller
@Scope("prototype")
public class Home2Controller extends BaseController {

	final Logger logger = Logger.getLogger(Home2Controller.class);

	@RequestMapping("/home")
	public String home(HttpServletRequest requet) throws IOException {
		//链接上带的区域的参数
		String zoneCode = request.getParameter("zoneCode");
		// 微信端传过来的参数
		String code = requet.getParameter("code");
		String openId = requet.getParameter("openId");
		// code="2";
		// 如果code不为空 就是从微信端跳转过来的,表示用户允许授权
		final String uri = Parameters2.ServerPath + Parameters2.Home.getZoneCode; 
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("zoneCode", zoneCode);
		String result =  HttpTookit.doPost(uri, DataRequestUtil.getRequestData(map));
		Map<String,Object> map2 = JSONUtil.getMap(result);
		String resultFlag = map2.get("resultFlag").toString();
		String appId = null;
		String appSecret = null;
		if("1".equals(resultFlag)){
			appId = ((Map<String,Object>)map2.get("resultData")).get("s3ucode").toString();
			appSecret = ((Map<String,Object>)map2.get("resultData")).get("s3uname").toString();
		}
		WXKeys.appId = appId;
		WXKeys.appScret = appSecret;
		if (code != null && !code.equals("")) {
			openId = WXUtil.getOauth(code);
			requet.setAttribute("errcode", "0");
			String wxId = requet.getParameter("state");
			requet.setAttribute("wxId", wxId);
		} else {
			// Code为空 用户禁止授权
			requet.setAttribute("errcode", "1000");
			logger.error("用户禁止授权 no code");
		}
		// 这种情况是站内跳转
		if (openId != null && !openId.equals("")) {
			// 用于前台流转,其实已不需要
			requet.setAttribute("openId", openId);
		}
		request.setAttribute("zoneCode", zoneCode);
		return "business2/index";
	}
	
	/**
	 * 去home主页面
	 * @param requet
	 * @return
	 */
	@RequestMapping("/indexHome")
	public String goToIndexHome(HttpServletRequest requet){
		return "business2/home2";
	}
		
	/**
	 * 广告栏位
	 */
	@RequestMapping("/setBanners")
	public void setBanners(){
		
		String data = request.getParameter("paraJson");
		
		final String uri = Parameters2.ServerPath + Parameters2.Home.setBanner;
		Map<String, Object> postData = new HashMap<String, Object>();
		postData.put("zoneCode", JSONUtil.getMap(data).get("zoneCode").toString());
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(postData));
		
		if (result == null || result.equals("")){
			out("{}");
			return;
		}
		
		out(result);
	}

	/**
	 * 去广告栏位对应的商品详情页面
	 * @param requet
	 * @return
	 */
	@RequestMapping("/goBannerGoodsDetail")
	public String goBannerDetailInterface(HttpServletRequest requet){
		String data = request.getParameter("paraJson");
		final String uri = Parameters2.ServerPath + Parameters2.Home.getPerBannerDetailData;
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		if(result.equals("") || result == null){
			request.setAttribute("goodsDetail", "[]");
		}
		request.setAttribute("goodsDetail", JSONObject.fromObject(result));
		
		return "business2/goodsDetail";
	}
	
	/**
	 * 去广告栏位对应的商品列表页面
	 * @param requet
	 * @return
	 */
	@RequestMapping("/goToPerBannerListInterface")
	public String goToPerBannerListInterface(HttpServletRequest requet){
		String data = request.getParameter("paraJson");
		String bannerId = JSONUtil.getMap(data).get("id").toString();
		String page = JSONUtil.getMap(data).get("page").toString();
		String pageSize = Parameters2.PAGESIZE + "";
		String subjectName = JSONUtil.getMap(data).get("subjectName").toString();
		request.setAttribute("bannerId", bannerId);
		request.setAttribute("page", page);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("subjectName", subjectName);
		return "business2/adPerBannersGoodsList";
	}
	
	
	/**
	 * 获取广告栏位对应的商品列表数据
	 * @param requet
	 * @return
	 */
	@RequestMapping("/goToPerBannerListData")
	public void goToPerBannerListData(HttpServletRequest requet){
		
		String data = request.getParameter("paraJson");

		String zoneCode = JSONUtil.getMap(data).get("zoneCode").toString();
		String bannerId = JSONUtil.getMap(data).get("id").toString();
		String page = JSONUtil.getMap(data).get("page").toString();
		String pageSize = Parameters2.PAGESIZE + "";

		final String uri = Parameters2.ServerPath + Parameters2.Home.getPerBannerListData;
		
		Map<String, Object> postData = new HashMap<String, Object>();
		postData.put("zoneCode", zoneCode);
		postData.put("id", bannerId);
		postData.put("page", page);
		postData.put("pagesize", pageSize);
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(postData));
		
		if(result.equals("") || result == null){
			out("{}");
			return;
		}
		
		out(result);
	}
	
	
	/**
	 * 去广告栏位对应商品列表的商品详情页面
	 * @param requet
	 * @return
	 */
	@RequestMapping("/goToPerBannerGoodsDetail")
	public String goToPerBannerDetailInterface(HttpServletRequest requet){
		
		String data = request.getParameter("paraJson");
		
		String zoneCode = JSONUtil.getMap(data).get("zoneCode").toString();
		String bannerId = JSONUtil.getMap(data).get("id").toString();
		
		final String uri = Parameters2.ServerPath + Parameters2.Home.getPerBannerDetailData;
		
		Map<String, Object> postData = new HashMap<String, Object>();
		postData.put("zoneCode", zoneCode);
		postData.put("id", bannerId);
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(postData));
		if(result.equals("") || result == null){
			request.setAttribute("goodsDetail", "[]");
		}
		request.setAttribute("goodsDetail", JSONObject.fromObject(result));
		
		return "business2/goodsDetail";
	}
	
	/**
	 * 公共服务列表   ----分类列表
	 * @param requet
	 * @return
	 */
	@RequestMapping("/getPublicServiceList")
	public void getPublicServiceList(HttpServletRequest requet){
		
		String data = request.getParameter("paraJson");
		final String uri = Parameters2.ServerPath + Parameters2.Home.getPublicServiceList;
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
//		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestPublicServiceData(data));
		
		if(result.equals("") || result == null){
			out("{}");
		}else{
			out(result);
		}
		
		
	}
	
	
	/**
	 * 促销活动列表
	 * @param requet
	 * @return
	 */
	@RequestMapping("/getCommonActivityList")
	public void getCommonActivityList(HttpServletRequest requet){
		String data = request.getParameter("paraJson");
//		final String uri = Parameters2.ServerPath + Parameters2.Home.getCommonActivityList;
		final String uri = Parameters2.ServerPath + Parameters2.Home.getCommonActivityList2;
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if(result.equals("") || result == null){
			out("{}");
			return;
		}
		
		out(result);
	}
	
	
	/**
	 * 促销列表 或 活动列表   ----点击【更多】或【图片商品】
	 * @param requet
	 * @return
	 */
	@RequestMapping("/goToActivityGoodsList")
	public String goToActivityGoodsList(HttpServletRequest requet){
		
		String data = request.getParameter("paraJson");
		
		String dataId = JSONUtil.getMap(data).get("dataId").toString();
		String dataType = JSONUtil.getMap(data).get("dataType").toString();
		
		request.setAttribute("dataId", dataId);
		request.setAttribute("dataType", dataType);
//		request.setAttribute("jsonData", JSONObject.fromObject(data));
		
		return "business2/activityGoodsList";
	}
	
	

	/**
	 * 获取促销列表 或 活动列表数据
	 * @param requet
	 * @return
	 */
	@RequestMapping("/goToActivityGoodsListData")
	public void goToActivityGoodsListData(HttpServletRequest requet){
		
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Home.getActivityGoodsList;
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if(result.equals("") || result == null){
			out("{}");
			return;
		}
		
		out(result);
	}
	
	/**
	 * 去广告栏位对应商品列表的商品详情页面
	 * @param requet
	 * @return
	 */
	@RequestMapping("/goToActivityGoodsDetail")
	public String goToActivityGoodsDetail(HttpServletRequest requet){
		
		String data = request.getParameter("paraJson");
		
		final String uri = Parameters2.ServerPath + Parameters2.Home.getActivityGoodsDetail;
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if(result.equals("") || result == null){
			
			request.setAttribute("goodsDetail", "[]");
		}
		
		request.setAttribute("goodsDetail", JSONObject.fromObject(result));
		
		return "business2/goodsDetail";
	}
	
	
	

	/**
	 * 去分类页面
	 * @param requetj
	 * @return
	 */
	@RequestMapping("/indexSort")
	public String goToIndexSort(HttpServletRequest requet){

		return "business2/goodsSort";
	}
	

	/**
	 * 分类页面左侧商品类型导航数据
	 * @param requet
	 * @return
	 */
	@RequestMapping("/getGoodsTypeListData")
	public void getGoodsTypeListData(HttpServletRequest requet){
		
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Sorts.getGoodsTypeList;
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if(result.equals("") || result == null){
			out("{}");
			return;
		}
		
		out(result);
	}
	
	
	/**
	 * 分类页面右侧商品列表数据   ----自营商品
	 * @param requet
	 * @return
	 */
	@RequestMapping("/getSelfGoodsList")
	public void getSelfGoodsList(HttpServletRequest requet){
		
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Sorts.getGoodsList;
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if(result.equals("") || result == null){
			out("{}");
			return;
		}
		
		out(result);
	}
	
}