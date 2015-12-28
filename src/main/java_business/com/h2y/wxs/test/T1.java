package com.h2y.wxs.test;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class T1 {

	public static void main(String args[]) {
		m2();
	}

	public void m1() {
		System.out.println(this.getClass().getResource("/wx.properties").getPath());
	}

	static void m2() {
		String str = "http://wx.jydapp.com/wx/home.htm";
		String str1 = "";
		try {
			str1 = URLEncoder.encode(str, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		System.out.println(str1);
	}
}
