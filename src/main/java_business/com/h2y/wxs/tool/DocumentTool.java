package com.h2y.wxs.tool;

import java.util.Calendar;
import java.util.List;

import org.jdom2.CDATA;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.XMLOutputter;

import com.h2y.wxs.model.ArticleItem;

public class DocumentTool {

	/**
	 * 建立消息头部，包括两个用户和创建时间
	 * 
	 * @param doc
	 * @return
	 */
	public static Element buildMsgHeader(Document doc) {

		Element _root = doc.getRootElement();

		String _toUser = _root.getChildText("ToUserName");
		String _fromUser = _root.getChildText("FromUserName");

		Element root = new Element("xml");
		root.addContent("\n");

		Element toUser = new Element("ToUserName");
		CDATA toName = new CDATA(_fromUser);
		toUser.addContent(toName);
		root.addContent(toUser);
		root.addContent("\n");

		Element fromUser = new Element("FromUserName");
		CDATA fromName = new CDATA(_toUser);
		fromUser.addContent(fromName);
		root.addContent(fromUser);
		root.addContent("\n");

		Element time = new Element("CreateTime");
		time.addContent(Calendar.getInstance().getTimeInMillis() + "");
		root.addContent(time);
		root.addContent("\n");

		return root;
	}

	/**
	 * 建立消息类型
	 * 
	 * @param type
	 * @param root
	 * @return
	 */
	public static Element buildMsgType(String type, Element root) {
		Element typeName = new Element("MsgType");
		CDATA typeValue = new CDATA(type);
		typeName.addContent(typeValue);
		root.addContent(typeName);
		root.addContent("\n");

		return root;
	}

	/**
	 * 建立消息体
	 * 
	 * @param content
	 * @param root
	 * @return
	 */
	public static Element buildMsgContent(String content, Element root) {
		Element contentName = new Element("Content");
		CDATA contentValue = new CDATA(content);
		contentName.addContent(contentValue);
		root.addContent(contentName);
		root.addContent("\n");

		return root;
	}

	/**
	 * 用于图文消息添加文章
	 * 
	 * @param root
	 * @param arts
	 * @return
	 */
	public static Element buildMsgArticles(Element root, List<ArticleItem> arts) {
		Element artCount = new Element("ArticleCount").addContent("1");
		root.addContent(artCount).addContent("\n");

		Element articles = new Element("Articles").addContent("\n");

		for (ArticleItem art : arts) {
			Element item1 = new Element("item").addContent("\n")
					.addContent(new Element("Title").addContent(new CDATA(art.title))).addContent("\n")
					.addContent(new Element("Description").addContent(new CDATA(art.describe))).addContent("\n")
					.addContent(new Element("PicUrl").addContent(new CDATA(art.picUrl))).addContent("\n")
					.addContent(new Element("Url").addContent(new CDATA(art.url))).addContent("\n");

			articles.addContent(item1).addContent("\n");
		}

		return root.addContent(articles).addContent("\n");
	}

	/**
	 * 输出doc
	 * 
	 * @param doc
	 * @return
	 */
	public static String Doc2String(Document doc) {

		return new XMLOutputter().outputString(doc);
	}
}
