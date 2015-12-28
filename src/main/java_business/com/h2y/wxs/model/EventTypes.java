package com.h2y.wxs.model;

/**
 * 事件类型
 * 
 * @author Administrator
 * 
 */
public enum EventTypes {

	EVENT_CLICK, EVENT_VIEW, EVENT_SUBSCRIBE, EVENT_UNSUBSCRIBE, NO_VALUE;

	public static EventTypes getEventType(String type) {
		if (type.equalsIgnoreCase("click"))
			return EVENT_CLICK;
		if (type.equalsIgnoreCase("view"))
			return EVENT_VIEW;
		if (type.equalsIgnoreCase("subscribe"))
			return EVENT_SUBSCRIBE;
		if (type.equalsIgnoreCase("unsubscribe"))
			return EVENT_UNSUBSCRIBE;

		return NO_VALUE;
	}
}
