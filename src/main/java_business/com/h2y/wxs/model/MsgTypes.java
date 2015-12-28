package com.h2y.wxs.model;

public enum MsgTypes {

	MSG_TEXT, MSG_IMAGE, MSG_NEWS, MSG_VOICE, MSG_VEDIO, MSG_EVENT, NOVALUE;

	public static MsgTypes getType(String name) {
		if (name.equalsIgnoreCase("text"))
			return MSG_TEXT;
		if (name.equalsIgnoreCase("image"))
			return MSG_IMAGE;
		if (name.equalsIgnoreCase("news"))
			return MSG_NEWS;
		if (name.equalsIgnoreCase("voice"))
			return MSG_VOICE;
		if (name.equalsIgnoreCase("vedio"))
			return MSG_VEDIO;
		if (name.equalsIgnoreCase("event"))
			return MSG_EVENT;

		return NOVALUE;
	}
}
