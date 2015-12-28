package com.h2y.wxshop.Util;

import com.h2y.util.PropertiesUtil;

/**
 * 参数
 * 
 * @author Administrator
 * 
 */
public class Parameters2 {
	
	/**  普通列表每页显示数量  */ 
	public static final int PAGESIZE = 10;
	
	// 主服务器地址
	public static String ServerPath = "";

	public static String FP = "";

	public static String WXS = "";
	
	public static String CMBS = "";

	static {
		PropertiesUtil mPropertiesUtil = PropertiesUtil.getInstance("/config.properties");

		if (mPropertiesUtil != null) {
			if (mPropertiesUtil.getValueByKey("wxs.cmbs") != null){
				ServerPath = mPropertiesUtil.getValueByKey("wxs.cmbs");
				CMBS = mPropertiesUtil.getValueByKey("wxs.cmbs");
			}
			if (mPropertiesUtil.getValueByKey("wxs.fp") != null){
				FP = mPropertiesUtil.getValueByKey("wxs.fp");
			}
			if (mPropertiesUtil.getValueByKey("wxs.wxs") != null){
				WXS = mPropertiesUtil.getValueByKey("wxs.wxs");
			}
		}
	}
	
	
	/**
	 * 索引页
	 */
	public static class Index{
		
		public static String isBinding = "user/isBound.htm";
	}
	
	/**
	 * 首页
	 */
	public static class Home{
		
		/** 获取当前位置区域码 */
		public static String getZoneCode = "zone/getZoneCode.htm";
		
		/** 获取区域列表 */
		public static String getZoneList = "zone/checkZoneList.htm";
		/**获取单位信息 */
		public static String getUnitInfo = "orderParams.htm";
		
		
		/** 广告栏位 */
		public static String setBanner = "advert/getList.htm";
		
		/** 广告栏位图片对应的商品数据列表 */
		public static String getPerBannerListData = "advert/getGoodsList.htm";
		
		/** 广告栏位图片对应的商品详情页面 */
		public static String getPerBannerDetailData = "advert/getGoodsDetail.htm";
		
		
		/** 公众服务列表 ----轮播下方的分类展示 */
		public static String getPublicServiceList = "findService/getPublicServiceList.htm";
		
		/** 促销活动列表 */
		public static String getCommonActivityList = "commonactivity/getList.htm";
		/** 促销活动列表2 */
		public static String getCommonActivityList2 = "commonactivity/getList2_1.htm";
		
		/** 促销活动商品列表 */
		public static String getActivityGoodsList = "commonactivity/getGoodsList.htm";
		
		/** 促销活动商品详情 */
		public static String getActivityGoodsDetail= "commonactivity/getGoodsDetail.htm";
		
		/** 获取本地服务的数据 */
		public static String getLocalServiceShopListData = "localService/getShopListBySort.htm";
		
		/** 获取本地服务的数据2 */
		public static String getLocalServiceShopListData2 = "localService/getLifeShopList2_1.htm";
		
		/** 获取本地服务分类的数据 */
		public static String getLocalServiceSortData = "localService/getSortList.htm";
		
		/** 获取本地服务距离分类的数据 */
		public static String getLocalServicetConditionData = "localService/getConditionList2_1.htm";
		
		/** 获取本地服务商品列表的数据 */
		public static String getGoodsListByShopSortData = "localService/getGoodsListByShopId.htm";
		/** 获取本地服务商品列表的数据2*/
		public static String getGoodsListByShopSortData2 = "localService/getLifeShopGoodsList2_1.htm";
		
	}
	
	
	/**
	 * 商品
	 */
	public static class Goods{
		
		/** 获取类别下商品列表 */
		public static String allList = "goods/allList.htm";
		
		/** 商品详细 */
		public static String getDetail = "goods/getDetail.htm";
		
		/** 关注商品 */
		public static String setGoodsCare = "goods/addGoodsFocus.htm";
		
		/** 取消关注商品 */
		public static String cancelGoodsCare = "goods/cancelGoodsFocus.htm";

		/** 热门搜索列表 */
		public static String getDictDetailList = "dict/getDetailList.htm";
	}
	
	
	/**
	 * 购物车
	 */
	public static class Carts{
		
		/** 加入购物车 */
		public static String addCart = "shopingcart/add.htm";
		
		/** 批量加入购物车 */
		public static String addBatch = "shopingcart/addBatch.htm";
		
		/** 购物车列表 */
		public static String getCartList = "shopingcart/getList.htm";
		
		/** 删除购物车商品 */
		public static String deletCartGoods = "shopingcart/delete.htm";
	
		/** 减少购物车商品数量 */
		public static String reduceCartGoods = "shopingcart/reduce.htm";
		
		/** 更新购物车商品数量 */
		public static String updateCartGoods = "shopingcart/update.htm";
		
		/** 获取猜你喜欢的列表 */
		public static String getLovelist = "goodsAnalysis/getGoodsAnalysisList.htm";
		
	}
	
	
	/**
	 * 分类
	 */
	public static class Sorts{
		
		/** 获取左侧导航商品分类列表 */
		public static String getGoodsTypeList = "goods/getGoodsTypeList.htm";
		
		/** 获取商品列表 */
		public static String getGoodsList = "goods/selfList.htm";
		
		/** 获取左侧导航商品分类列表 */
		public static String getGoodsTypeList2 = "goods/getGoodsTypeList2_2.htm";
		
		/** 获取商品列表 */
		public static String getGoodsList2 = "goods/selfList2_2.htm";
	}
	
	
	/**
	 * 订单
	 */
	public static class Orders{
		
		/** 获取订单提交数据 */
		public static String getOrderParams = "order/orderParams.htm";
		
		/** 提交订单 */
		public static String submitOrder = "order/submit.htm";
		
		/** 订单详情 */
		public static String orderDetail = "order/getDetail.htm";
	}
	
	
	/**
	 * 积分
	 */
	public static class Grade{
		
		/** 获取我的积分数据  */
		public static String getGrade = "grade/getGrade.htm";
		
		/** 获取我的积分列表数据  */
		public static String getGradeDetail = "grade/gradeDetail.htm";
		
		/** 签到页面  */
		public static String sign = "grade/loadCheckIn.htm";
		/** 签到页面  */
		public static String sign2 = "grade/sign.htm";
	}
	
	/**
	 * 我的
	 */
	public static class Me{
		
		/** 提交会员信息  */
		public static String submitMemberData = "user/complete.htm";
		
		/** 获取我的关注列表  */
		public static String getGoodsFocusList = "goods/getGoodsFocusList.htm";
		
		/** 获取我的二维码  */
		public static String getQrCode = "user/createQrCode.htm";
		
		/** 获取优惠券详情  */
		public static String getCouponDetail = "coupons/getCouponsDetail.htm";
	}
	
	
	/**
	 * 收货地址
	 */
	public static class Address {
		
		//修改前查询指定ID地址信息
		public static String getAddrByID = "receiveaddress/get.htm";
	}
}
