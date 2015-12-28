package com.h2y.wxs.service;

import org.jdom2.Document;

/**
 * 事件监听器
 * 
 * @author Administrator
 * 
 */
public interface IEventListener {

	// 点击事件
	public String onClickEvent(Document doc);

	// 跳转事件
	public String onViewkEvent(Document doc);

	// 订阅事件
	public String onSubscribeEvent(Document doc);

	// 取消订阅事件
	public String onUnSubscribeEvent(Document doc);
}
