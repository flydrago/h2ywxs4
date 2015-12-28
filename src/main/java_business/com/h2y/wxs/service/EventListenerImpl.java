package com.h2y.wxs.service;

import java.util.ArrayList;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.springframework.stereotype.Service;

import com.h2y.wxs.model.ArticleItem;
import com.h2y.wxs.model.EventKeys;
import com.h2y.wxs.tool.DocumentTool;

/**
 * 事件实现
 * 
 * @author Administrator
 * 
 */
@Service(value = "eventListener")
public class EventListenerImpl implements IEventListener {

	/**
	 * 点击菜单事件
	 */
	public String onClickEvent(Document doc) {
		Element root = DocumentTool.buildMsgHeader(doc);

		String eventKey = doc.getRootElement().getChildText("EventKey");
		if (eventKey.equalsIgnoreCase(EventKeys.MENU_ONE_SUB_ONE)) {
			root = DocumentTool.buildMsgType("text", root);
			root = DocumentTool.buildMsgContent("400-860-9519", root);
		} else if (eventKey.equalsIgnoreCase(EventKeys.MENU_ONE_SUB_TWO)) {
			root = DocumentTool.buildMsgType("news", root);

			List<ArticleItem> arts = new ArrayList<ArticleItem>();

			ArticleItem art = new ArticleItem();
			art.title = "萌萌的“酒运达”";
			art.describe = "酒运达在会展中心的宣传活动酒运达的卡通气模人在开心滴走着";
			art.picUrl = "http://mmbiz.qpic.cn/mmbiz/I52ednhY9wfm9Rudn9DQbqu6hZRqBU33CwavOicBuckzKKW4qgZcnJoaVBibdOprYria73ef7kWXyhxhwwN54E4jA/0";
			art.url = "http://mp.weixin.qq.com/s?__biz=MjM5Mjg3NDM1Nw==&mid=200557352&idx=1&sn=a066f7a70d41d8628f2257b3be4ee4b5#rd";
			arts.add(art);

			root = DocumentTool.buildMsgArticles(root, arts);

		} else if (eventKey.equalsIgnoreCase(EventKeys.MENU_TWO_SUB_ONE)) {
			root = DocumentTool.buildMsgType("news", root);

			List<ArticleItem> arts = new ArrayList<ArticleItem>();

			ArticleItem art = new ArticleItem();
			art.title = "“酒运达”全国招商";
			art.describe = "微信扫一扫即可关注“酒运达”公众号。";
			art.picUrl = "http://mmbiz.qpic.cn/mmbiz/I52ednhY9weFWrmWfskzXslBkNNtJNJHdVuAib8hI83cs1ZfxWRdkvhByN0LTZS15Hmmibxxm86bxlljiakwNteQA/0";
			art.url = "http://mp.weixin.qq.com/s?__biz=MjM5Mjg3NDM1Nw==&mid=200558672&idx=1&sn=a5c1af5a72b3cca33536b6dfc0fb29aa#rd";
			arts.add(art);

			root = DocumentTool.buildMsgArticles(root, arts);
		} else if (eventKey.equalsIgnoreCase(EventKeys.MENU_THREE_SUB_ONE)) {
			root = DocumentTool.buildMsgType("news", root);

			List<ArticleItem> arts = new ArrayList<ArticleItem>();

			ArticleItem art = new ArticleItem();
			art.title = "【抢红包了】河南“酒运达”携手滴滴打车回馈粉丝，百万红包大派送";
			art.describe = "“酒运达”携手嘀嘀打车，带你免费打车！我知道挤公交挺难受我知道你不想挤公交我知道你肯定下载了微信，进入滴滴打";
			art.picUrl = "http://mmbiz.qpic.cn/mmbiz/I52ednhY9wfm9Rudn9DQbqu6hZRqBU33e6X6YBZk8vbgR8PcZA9u3LjDEnVQicHkhGldsYfJLibLR3Ma4zf0ahgg/0";
			art.url = "http://mp.weixin.qq.com/s?__biz=MjM5Mjg3NDM1Nw==&mid=200557757&idx=1&sn=eaef0e8f887705d786dfec9f5ff3f0ce#rd";
			arts.add(art);

			root = DocumentTool.buildMsgArticles(root, arts);
		} else if (eventKey.equalsIgnoreCase(EventKeys.MENU_THREE_SUB_TWO)) {
			root = DocumentTool.buildMsgType("news", root);

			List<ArticleItem> arts = new ArrayList<ArticleItem>();

			ArticleItem art = new ArticleItem();
			art.title = "“酒运达”直供11月";
			art.describe = "“酒运达”直供11月活动，不玩虚的，给你想想不到的实惠，比比看，谁更实在。";
			art.picUrl = "http://mmbiz.qpic.cn/mmbiz/I52ednhY9wfm9Rudn9DQbqu6hZRqBU334XXnnJicanibvPkmQdgrloGMu7geGA4jnvuYHCvCLicZWceYEs4acKGJQ/0";
			art.url = "http://mp.weixin.qq.com/s?__biz=MjM5Mjg3NDM1Nw==&mid=200557753&idx=1&sn=910791c6b59a72360ab85556076d22e9#rd";
			arts.add(art);

			root = DocumentTool.buildMsgArticles(root, arts);
		}

		return DocumentTool.Doc2String(new Document(root));
	}

	/**
	 * 链接跳转事件
	 */
	public String onViewkEvent(Document doc) {

		return null;
	}

	/**
	 * 订阅事件
	 */
	public String onSubscribeEvent(Document doc) {

		return null;
	}

	/**
	 * 取消订阅事件
	 */
	public String onUnSubscribeEvent(Document doc) {

		return null;
	}
}
