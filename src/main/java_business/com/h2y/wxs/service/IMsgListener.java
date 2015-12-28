package com.h2y.wxs.service;

import org.jdom2.Document;

/**
 * 消息监听
 * 
 * @author Administrator
 * 
 */
public interface IMsgListener {

	// 文本消息
	public String onTextMsg(Document doc);

	// 图片消息
	public String onImageMsg(Document doc);

	// 声音消息
	public String onVoiceMsg(Document doc);

	// 视频消息
	public String onVedioMsg(Document doc);

	// 图文消息
	public String onNewsMsg(Document doc);

}
