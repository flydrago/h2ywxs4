package com.h2y.wxshop.controller2;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.h2y.util.DataRequestUtil;
import com.h2y.util.HttpTookit;
import com.h2y.wxs.basic.BaseController;
import com.h2y.wxshop.Util.Parameters2;

/**
 * 订单
 * 
 * @author Administrator
 * 
 */
@Controller
@Scope("prototype")
public class Ord2Controller extends BaseController {

	final Logger logger = Logger.getLogger(Ord2Controller.class);

	
	/**
	 * 购物车所到的订单页面
	 */
	@RequestMapping(value = "/goToMyOrderSubmit")
	public String goToMyOrderSubmit() {
		
		String data = request.getParameter("paraJson");
		String totalMoney = request.getParameter("totalMoney");
		
		/*final String uri = Parameters2.ServerPath + Parameters2.Orders.getOrderParams;

		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));
		if (result == null || result.equals("")){ // \r\n
			request.setAttribute("orderParams", "{}");
		}else{
			request.setAttribute("orderParams", JSONObject.fromObject(result));
		}*/
		request.setAttribute("paraJson", JSONObject.fromObject(data));
		request.setAttribute("totalMoney", totalMoney);
		
		return "business2/goodsOrders";
	}
		
	
	/**
	 * 提交订单
	 */
	@RequestMapping(value = "/submitOrder")
	public void submitOrder() {
		
		String data = request.getParameter("paraJson");

		final String uri = Parameters2.ServerPath + Parameters2.Orders.submitOrder;

		String result = HttpTookit.doPost(uri, DataRequestUtil.getRequestData(data));

		if (result == null || result.equals("\r\n")){
			out("{}");
			return;
		}
		out(result);
		
	}
	
	/**
	 * 我的订单列表界面
	 */
	@RequestMapping(value = "/goToMyOrderListInterface")
	public String goToMyOrderListInterface() {
		
		return "business2/myOrderList";
	}
	
	
	/**
	 * 订单跟踪界面
	 */
	@RequestMapping(value = "/goToMyOrderTraceInterface")
	public String goToMyOrderTraceInterface(String orderId) {
		request.setAttribute("currOrderId",orderId);
		return "business2/myOrderTrace";
	}
	
	
	/**
	 * 我的订单列表界面
	 */
	@RequestMapping(value = "/goToOrderDetailInterface")
	public String goToOrderDetailInterface() {
		
		String data = request.getParameter("paraJson");
		final String url = Parameters2.ServerPath + Parameters2.Orders.orderDetail;
		String result = HttpTookit.doPost(url, DataRequestUtil.getRequestData(data));
		
		request.setAttribute("orderDetail", JSONObject.fromObject(result));
		return "business2/myOrderDetail";
	}
	
}
