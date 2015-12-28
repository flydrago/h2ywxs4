package com.h2y.wxs.tool;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.LinkedList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

public class HttpUtil {

	// 连接
	private static final int CONNECTION_TIMEOUT = 1000 * 60;
	// 读取超时
	private static final int SO_TIMEOUT = 1000 * 60;
	// 连接配置
	private static RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(SO_TIMEOUT).setConnectTimeout(CONNECTION_TIMEOUT).build();
	private static HttpClient httpClient = HttpClients.custom().setDefaultRequestConfig(requestConfig).build();
	private static HttpUtil httpUtil;

	/**
	 * 获取实例
	 * 
	 * @return
	 */
	public static HttpUtil getInstance() {
		if (httpUtil == null) {
			httpUtil = new HttpUtil();
		}
		
		return httpUtil;
	}

	/**
	 * 执行POST
	 * 
	 * @param uri
	 * @param params
	 * @return
	 * @throws IOException
	 * @throws ParseException
	 */
	public String execPost(String uri, String params[]) throws ParseException, IOException {
		HttpResponse response = null;
		HttpPost postMethod = null;
		try {
			postMethod = getPostMethod(uri, buildPairs(params));
			response = httpClient.execute(postMethod);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (postMethod != null)
				postMethod.releaseConnection();
		}
		return handResponse(response);
	}

	public String execPost(String uri, String params) throws ParseException, IOException {
		HttpResponse response = null;
		HttpPost postMethod = null;
		try {
			postMethod = getPostMethod(uri, params);
			response = httpClient.execute(postMethod);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (postMethod != null)
				postMethod.releaseConnection();
		}
		return handResponse(response);
	}

	/**
	 * 执行GET
	 * 
	 * @param uri
	 * @return
	 * @throws IOException
	 * @throws ClientProtocolException
	 */
	public String execGet(String uri) throws ClientProtocolException, IOException {
		HttpGet getMethod = getGetMethod(uri);
		HttpResponse response = httpClient.execute(getMethod);
		getMethod.releaseConnection();
		return handResponse(response);
	}

	/**
	 * 操作返回结果
	 * 
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws ParseException
	 */
	private String handResponse(HttpResponse response) throws ParseException, IOException {
		if (response != null) {
			if (response.getStatusLine().getStatusCode() == 200) {
				return EntityUtils.toString(response.getEntity(), "utf-8");
			} else {
				System.out.println("handResponse" + response.getStatusLine().getStatusCode());
			}
		}

		return null;
	}

	private List<BasicNameValuePair> buildPairs(String params[]) {
		if (params != null && params.length > 1) {
			List<BasicNameValuePair> list = new LinkedList<BasicNameValuePair>();
			for (int i = 0; i < params.length - 1; i = i + 2) {
				BasicNameValuePair nameValuePair = new BasicNameValuePair(params[i], params[i + 1]);
				list.add(nameValuePair);
			}
			return list;
		}
		return null;
	}

	/**
	 * POST方法
	 * 
	 * @param uri
	 * @param params
	 * @return
	 */
	private HttpPost getPostMethod(String uri, List<BasicNameValuePair> list) {
		HttpPost post = new HttpPost(uri);
		post.setConfig(RequestConfig.copy(requestConfig).build());
		try {
			if (list != null)
				post.setEntity(new UrlEncodedFormEntity(list));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return post;
	}

	private HttpPost getPostMethod(String uri, String params) {
		HttpPost post = new HttpPost(uri);
		post.setConfig(RequestConfig.copy(requestConfig).build());
		post.setEntity(new StringEntity(params, "utf-8"));

		return post;
	}

	/**
	 * get
	 * 
	 * @param uri
	 * @return
	 */
	private HttpGet getGetMethod(String uri) {

		HttpGet get = new HttpGet(uri);
		get.setConfig(RequestConfig.copy(requestConfig).build());

		return get;
	}
}
