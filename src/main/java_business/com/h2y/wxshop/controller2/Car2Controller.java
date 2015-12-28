package com.h2y.wxshop.controller2;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h2y.util.DataRequestUtil;
import com.h2y.util.HttpTookit;
import com.h2y.wxs.basic.BaseController;
import com.h2y.wxshop.Util.Parameters2;

/**
 * 购物车
 * 
 * @author Administrator
 * 
 */
@Controller
@Scope("prototype")
public class Car2Controller extends BaseController {

	/**
	 * 获取购物车页面
	 */
	@RequestMapping(value = "/goodsCart")
	public String goodsCart() {
		
		return "business2/goodsCart";
	}
	
	/**
	 * 获取购物车列表
	 */
	@RequestMapping(value = "/goodsCartList")
	public void goodsCartList() {
		
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Carts.getCartList;

		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if (result == null || result.equals("")){
			out("{}");
			return;
		}
		out(result);
		
	}
	
	
	/**
	 * 添加到购物车
	 */
	@RequestMapping(value = "/addCart")
	public void addCart() {
		
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Carts.addCart;
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if (result == null || result.equals("")){
			out("{}");
			return;
		}

		out(result);
	}


	/**
	 * 删除购物车商品
	 */
	@RequestMapping(value = "/delCartGoods")
	public void delCartGoods() {
		
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Carts.deletCartGoods;

		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if (result == null || result.equals("")){
			out("{}");
			return;
		}

		out(result);
	}
	
	
	/**
	 * 减少购物车商品
	 */
	@RequestMapping(value = "/reduceCartGoods")
	public void reduceCartGoods() {
		
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Carts.reduceCartGoods;

		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if (result == null || result.equals("")){
			out("{}");
			return;
		}

		out(result);
	}
	
	/**
	 * 更新购物车商品数量
	 */
	@RequestMapping(value = "/updateCartGoodsNum")
	public void updateCartGoodsNum() {
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Carts.updateCartGoods;

		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if (result == null || result.equals("")){
			out("{}");
			return;
		}
		out(result);
	}
	
	
	/**
	 * 获取猜你喜欢列表
	 */
	@RequestMapping(value = "/getLovelist")
	public void getLovelist() {
		String data = request.getParameter("paraJson");
		
		final String uri = Parameters2.ServerPath + Parameters2.Carts.getLovelist;
		
		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		
		if (result == null || result.equals("")){
			out("{}");
			return;
		}
		out(result);
	}

	/**
	 * 批量添加
	 */
	@RequestMapping(value = "/addBatch")
	public void addBatch() {
		
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Carts.addBatch;

		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));

		if (result == null || result.equals("\r\n")){
			out("{}");
			return;
		}
		out(result);
		
	}
}
