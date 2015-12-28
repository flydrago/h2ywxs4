package com.h2y.wxs.service;

import org.jdom2.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.h2y.wxs.model.EventTypes;
import com.h2y.wxs.model.MsgTypes;
import com.h2y.wxs.tool.DocumentTool;

/**
 * 消息解析适配
 * 
 * @author Administrator
 * 
 */
@Service(value="msgAdapter")
public class MsgAdapter {

	// 消息监听处理
	@Autowired
	private IMsgListener msgListener;

	// 事件监听处理
	@Autowired
	private IEventListener eventListener;

	// 文档
	private Document doc;

	/**
	 * 分发消息处理
	 * 
	 * @param doc
	 * @return
	 */
	public String dispatchMsg(Document doc) {
		if (doc != null) {
			this.doc = doc;
			System.out.println("doc= " + DocumentTool.Doc2String(doc));

			if (msgListener != null) {
				MsgTypes msgType = getMsgType();

				// 响应文本信息
				if (msgType == MsgTypes.MSG_TEXT)
					return msgListener.onTextMsg(doc);

				// 响应图片信息
				if (msgType == MsgTypes.MSG_IMAGE)
					return msgListener.onImageMsg(doc);

				// 响应图文信息
				if (msgType == MsgTypes.MSG_NEWS)
					return msgListener.onNewsMsg(doc);

				// 响应音频信息
				if (msgType == MsgTypes.MSG_VOICE)
					return msgListener.onVoiceMsg(doc);

				// 响应视频信息
				if (msgType == MsgTypes.MSG_VEDIO)
					return msgListener.onVedioMsg(doc);

				// 响应事件信息
				if (msgType == MsgTypes.MSG_EVENT) {
					if (eventListener != null) {
						EventTypes eventType = getEventType();

						// 响应点击事件
						if (eventType == EventTypes.EVENT_CLICK)
							return eventListener.onClickEvent(doc);

						// 响应跳转事件
						if (eventType == EventTypes.EVENT_VIEW)
							return eventListener.onViewkEvent(doc);
					}
				}

				return null;
			}
		}

		return null;
	}

	/**
	 * 设置消息监听
	 * 
	 * @param msgListener
	 */
	public void setMsgListener(IMsgListener msgListener) {
		this.msgListener = msgListener;
	}

	/**
	 * 设置事件监听
	 * 
	 * @param eventListener
	 */
	public void setEventListener(IEventListener eventListener) {
		this.eventListener = eventListener;
	}

	/**
	 * 获取消息类型
	 * 
	 * @return
	 */
	private MsgTypes getMsgType() {
		return MsgTypes.getType(getElementValue("MsgType"));
	}

	/**
	 * 获取事件类型
	 * 
	 * @return
	 */
	private EventTypes getEventType() {
		return EventTypes.getEventType(getElementValue("Event"));
	}

	/**
	 * 返回节点文本值
	 * 
	 * @param tagName
	 * @return
	 */
	private String getElementValue(String tagName) {
		return doc.getRootElement().getChildText(tagName);
	}
}
