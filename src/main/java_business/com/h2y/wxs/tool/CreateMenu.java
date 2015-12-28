package com.h2y.wxs.tool;

import java.io.IOException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.ParseException;

import com.h2y.wxs.model.EventKeys;

public class CreateMenu {

	String URL_CREATE = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=";

	String URL_DELETE = "";

	public static void main(String args[]) {

		CreateMenu cm = new CreateMenu();
		cm.create();
	}

	/**
	 * 创建菜单方法
	 */
	private void create() {
		if (WXKeys.accessToken.equals(""))
			WXKeys.getAccessToken();

		try {
			String result = HttpUtil.getInstance().execPost(URL_CREATE + WXKeys.accessToken, buildCreateJson());
			System.out.println("CreateMenu" + result);
			if (result != null) {
				JSONObject obj = JSONObject.fromObject(result);
				if (obj.containsKey("errcode")) {
					String errCode = obj.getString("errcode");
					if (errCode.equalsIgnoreCase("40014") || errCode.equalsIgnoreCase("41001") || errCode.equalsIgnoreCase("42001")) {
						WXKeys.getAccessToken();
						//HttpUtil.getInstance().execPost(URL_CREATE + WXKeys.accessToken, buildCreateJson());
						create();
					}
				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 删除菜单方法
	 */
	@SuppressWarnings("unused")
	private void delete() {

		try {
			HttpUtil.getInstance().execPost(URL_DELETE, buildCreateJson());
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 创建菜单JSON,作为POST参数发送给微信服务器
	 * 
	 * @return
	 */
	private String buildCreateJson() {

		// String json =
		// "{ \"button\":[{\"type\":\"click\",\"name\":\"Music\",\"key\":\"V1001_TODAY_MUSIC\"},{\"name\":\"Menu\",\"sub_button\":[{\"type\":\"view\",\"name\":\"Search\",\"url\":\"http://www.soso.com\"},{\"type\":\"view\",\"name\":\"Vedio\",\"url\":\"http://v.qq.com\"},{\"type\":\"click\",\"name\":\"Good\",\"key\":\"V1001_GOOD\"}]}]}";

		// 顶级对象
		JSONObject menuRoot = new JSONObject();

		// 菜单数组
		JSONArray menuBtns = new JSONArray();

		// 第一个一级菜单
		JSONObject btnOne = JSONObject.fromObject("{\"name\":\"个人中心\"}");
		// 子菜单集合
		JSONArray subOneBtns = new JSONArray();
		// 添加子级
		subOneBtns.add(0, JSONObject.fromObject("{\"type\":\"click\",\"name\":\"电话订酒\",\"key\":\"" + EventKeys.MENU_ONE_SUB_ONE + "\"}"));
		subOneBtns.add(1, JSONObject.fromObject("{\"type\":\"click\",\"name\":\"欢乐互动\",\"key\":\"" + EventKeys.MENU_ONE_SUB_TWO + "\"}"));
		subOneBtns.add(2, JSONObject.fromObject("{\"type\":\"view\",\"name\":\"我的订单\",\"url\":\"" + WXKeys.Oauth.getOrdUri() + "\"}"));
		subOneBtns.add(3, JSONObject.fromObject("{\"type\":\"view\",\"name\":\"今日签到\",\"url\":\"" + WXKeys.Oauth.getSignUri() + "\"}"));
		subOneBtns.add(4, JSONObject.fromObject("{\"type\":\"view\",\"name\":\"立即注册\",\"url\":\"" + WXKeys.Oauth.getRegisterUri() + "\"}"));
		btnOne.put("sub_button", subOneBtns);

		// 添加第一个一级菜单
		menuBtns.add(btnOne);

		// 第二个一级菜单
		JSONObject btnTwo = JSONObject.fromObject("{\"name\":\"招商加盟\"}");
		// 子菜单集合
		JSONArray subTwoBtns = new JSONArray();
		// 添加子级
		subTwoBtns.add(0, JSONObject.fromObject("{\"type\":\"view\",\"name\":\"微商城dfasd\",\"url\":\"" + WXKeys.Oauth.getOathUri() + "\"}"));
		//subTwoBtns.add(1, JSONObject.fromObject("{\"type\":\"click\",\"name\":\"全国招商\",\"key\":\"" + EventKeys.MENU_TWO_SUB_ONE + "\"}"));

		btnTwo.put("sub_button", subTwoBtns);

		// 添加第二个一级菜单
		menuBtns.add(btnTwo);

		// 第三个一级菜单
		JSONObject btnThree = JSONObject.fromObject("{\"name\": \"优惠活动\"}");
		// 子菜单集合
		JSONArray subThreeBtns = new JSONArray();
		// 添加子级
		subThreeBtns.add(0, JSONObject.fromObject("{\"type\":\"click\",\"name\":\"红包派送\",\"key\":\"" + EventKeys.MENU_THREE_SUB_ONE + "\"}"));
		subThreeBtns.add(1, JSONObject.fromObject("{\"type\":\"click\",\"name\":\"促销活动\",\"key\":\"" + EventKeys.MENU_THREE_SUB_TWO + "\"}"));
		btnThree.put("sub_button", subThreeBtns);

		// 添加第三个一级菜单
		menuBtns.add(btnThree);

		// 添加顶级菜单
		menuRoot.put("button", menuBtns);

		return menuRoot.toString();
	}
}
