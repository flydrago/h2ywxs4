package com.h2y.wxs.service;

import org.jdom2.Document;
import org.jdom2.Element;
import org.springframework.stereotype.Service;

import com.h2y.wxs.tool.DocumentTool;
@Service(value = "msgListener")
public class MsgListenerImpl implements IMsgListener {

	public String onImageMsg(Document doc) {
		return null;
	}

	public String onNewsMsg(Document doc) {
		return null;
	}

	public String onTextMsg(Document doc) {

		Element root = DocumentTool.buildMsgHeader(doc);
		root = DocumentTool.buildMsgType("text", root);
		root = DocumentTool.buildMsgContent("自动回复!", root);

		return DocumentTool.Doc2String(new Document(root));
	}

	public String onVedioMsg(Document doc) {
		return null;
	}

	public String onVoiceMsg(Document doc) {
		return null;
	}

}
