package com.h2y.wxshop.controller2;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h2y.util.DataRequestUtil;
import com.h2y.util.HttpTookit;
import com.h2y.util.JSONUtil;
import com.h2y.wxs.basic.BaseController;
import com.h2y.wxshop.Util.Parameters2;

@Controller
@Scope("prototype")
public class Goods2Controller extends BaseController {

	final Logger logger = Logger.getLogger(Goods2Controller.class);

	/**
	 * 进入列表页
	 * @return
	 */
	@RequestMapping(value = "/mGoodsList")
	public String mGoodsList(){
		
		String data  = request.getParameter("paraJson");
		
		String goodsTypeId = JSONUtil.getMap(data).get("goodsTypeId").toString();
		String markId = JSONUtil.getMap(data).get("markId")+"";
		String markInfoId = JSONUtil.getMap(data).get("markInfoId")+"";
		String keyWords = JSONUtil.getMap(data).get("keyWords")+"";
		if(!markId.equals("null") && !markInfoId.equals("null") && !keyWords.equals("null")){
			request.setAttribute("markId", markId);
			request.setAttribute("markInfoId", markInfoId);
			request.setAttribute("keyWords", keyWords);
		}
		request.setAttribute("goodsTypeId", goodsTypeId);
		return "business2/goodsList";
	}
	
	/**
	 * 获取列表数据
	 */
	@RequestMapping(value = "/mGetGoodsListData")
	public void mGetGoodsListData(){
		
		String paraJson = request.getParameter("paraJson");

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("paraJson", paraJson);
		
		final String uri = Parameters2.ServerPath + Parameters2.Goods.allList;
		String result = HttpTookit.doPost(uri, params);
		if (result == null || result.equals("")) {
			result = "{}";
		}
		out(result);
	}
	
	/**
	 * 秒杀页面
	 */
	@RequestMapping(value = "/mSecKillGoodsInterface")
	public String mSecKillGoodsInterface(){
		return "business2/secKillGoodsList";
	}
	
	
	/**
	 * 商品详情页面
	 * @return
	 */
	@RequestMapping(value = "/mGoodsDetail")
	public String mGoodsDetail(){
		
		String data = request.getParameter("paraJson");
		
		final String uri = Parameters2.ServerPath + Parameters2.Goods.getDetail;
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		if (result == null || result.equals("")) {
			request.setAttribute("goodsDetail", "{}");
			//request.setAttribute("goodsDetail", JSONUtil.getMap(result));
		}else{
			request.setAttribute("goodsDetail", JSONObject.fromObject(result));
		}
		return "business2/goodsDetail";
	}

	
	/**
	 * 关注商品
	 */
	@RequestMapping(value = "/goAddCareGoods")
	public void goAddCareGoods(){
		
		String paraJson = request.getParameter("paraJson");
		
		final String uri = Parameters2.ServerPath + Parameters2.Goods.setGoodsCare;
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(paraJson));
		
		if (result == null || result.equals("")) {
			result = "{}";
		}
		out(result);
	}
	
	
	/**
	 * 取消关注商品
	 */
	@RequestMapping(value = "/goCancelCareGoods")
	public void goCancelCareGoods(){
		
		String paraJson = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Goods.cancelGoodsCare;
		String result = HttpTookit.doPost(uri,DataRequestUtil.getRequestData(paraJson));
		
		if (result == null || result.equals("")) {
			result = "{}";
		}
		out(result);
	}
	/**
	 * 进入商品搜索页面
	 * @return
	 */
	@RequestMapping(value = "/mGoodsSearch")
	public String mGoodsSearch(){
		
		return "business2/goodsSearch";
	}
	
	/**
	 * 热门搜索列表
	 */
	@RequestMapping(value = "/getHotSearchList")
	public void getHotList(){
		
		String paraJson = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Goods.getDictDetailList;
		String result = HttpTookit.doPost(uri,DataRequestUtil.getRequestData(paraJson));
		
		if (result == null || result.equals("\r\n")) {
			result = "{}";
		}
		out(result);
	}
}
