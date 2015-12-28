package com.h2y.util;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import com.h2y.wxshop.Util.Parameters2;


/**
 * 模拟进行Http请求

 * @author：段晓刚

 * @update：2014年6月12日 下午6:18:34

 * @Email：Java198921@163.com
 */
public final class HttpTookit {
	
	private static final Logger logger = Logger.getLogger(HttpTookit.class);

	private static RequestConfig.Builder getRequestConfig(){

		RequestConfig.Builder config = RequestConfig.custom();
		//连接超时
		config.setConnectTimeout(30000);
		//请求超时
		config.setSocketTimeout(30000);
		return config;
	}

	/**
	 * 模拟使用get请求
	 * 多参数数据提交
	 * @param url
	 * @param params	Map中的键值作为键值使用
	 * @return
	 * @update：2014年7月24日 下午4:35:55
	 */
	public static String doGet(String url,Map<String,Object> params) {
		// TODO Auto-generated method stub
		String serverResponse = "";

		String paramstr = "";
		if(params!=null && !params.isEmpty()){
			Set<Map.Entry<String, Object>> set = params.entrySet();
			Iterator<Map.Entry<String, Object>> it = set.iterator();

			while(it.hasNext()){
				Map.Entry<String, Object> entry = it.next();
				if(paramstr.equals("")){
					paramstr = entry.getKey()+"="+entry.getValue();
				}else {
					paramstr+="&"+entry.getKey()+"="+entry.getValue();
				}
			}
		}
		// 新建HttpPost对象
		HttpGet httpGet = new HttpGet(paramstr.equals("")?url:url+"?"+paramstr);
		// 获取HttpClient对象
		HttpClient httpClient = HttpClients.createDefault();//new DefaultHttpClient();

		httpGet.setConfig(getRequestConfig().build());

		// 获取HttpResponse实例
		HttpResponse httpResp = null;
		try {
			httpResp = httpClient.execute(httpGet);
		} catch (ClientProtocolException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// 判断是够请求成功
		if (httpResp.getStatusLine().getStatusCode() == 200) {
			// 获取返回的数据
			try {
				serverResponse = EntityUtils.toString(httpResp.getEntity(), "UTF-8");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
		}

		return serverResponse;
	}

	/**
	 * 模拟使用post请求
	 * 多参数数据提交
	 * @param url
	 * @param params	Map中的键值作为键值使用
	 * @return
	 * @update：2014年7月24日 下午4:36:30
	 */
	public static String doPost(String url,Map<String,Object> params) {
		// TODO Auto-generated method stub
		String serverResponse = "";

		// 新建HttpPost对象
		HttpPost httpPost = new HttpPost(url);

		List<NameValuePair> params2 = new ArrayList<NameValuePair>();
		if(params!=null && !params.isEmpty()){
			Set<Map.Entry<String, Object>> set = params.entrySet();
			Iterator<Map.Entry<String, Object>> it = set.iterator();
			while(it.hasNext()){
				Map.Entry<String, Object> entry = it.next();
				params2.add(new BasicNameValuePair(entry.getKey(), entry.getValue()+""));
			}
		}
		// 设置字符集
		HttpEntity entity = new UrlEncodedFormEntity(params2, Charset.forName("UTF-8"));

		// 设置参数实体
		httpPost.setEntity(entity);
		// 获取HttpClient对象
		HttpClient httpClient = HttpClients.createDefault();//new DefaultHttpClient();

		httpPost.setConfig(getRequestConfig().build());

		// 获取HttpResponse实例
		HttpResponse httpResp = null;
		try {
			httpResp = httpClient.execute(httpPost);
		} catch (ClientProtocolException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		// 判断是够请求成功
		if (httpResp.getStatusLine().getStatusCode() == 200) {
			// 获取返回的数据
			try {
				serverResponse = EntityUtils.toString(httpResp.getEntity(), "UTF-8");
			} catch (ParseException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
		}

		return serverResponse;
	}
	
	
	/**
	 * 调用服务
	 * @param moduleName 模块名称 （url路径中统配的第一个变量）
	 * @param methodName url路径中统配的第二个变量
	 * @param params 访问单数
	 * @return
	 */
	public static String doServicePost(String moduleName,String methodName,HttpServletRequest request) {

		String postData = request.getParameter("postData");
//		Map<String,Object> resultMap = DataRequestUtil.getRequestPublicServiceData(postData);
		Map<String,Object> resultMap = DataRequestUtil.getRequestData(postData);
	    logger.info("获取服务数据url参数：\nurl:"+Parameters2.CMBS+moduleName+"/"+methodName);
//	    logger.info("获取服务数据url参数：\nurl:"+Parameters2.CMBS+"\nmoduleName:"+moduleName+"\nmethodName:"+methodName);
		return doPost(Parameters2.CMBS+moduleName+"/"+methodName+".htm", resultMap);
	}

//	public static void main(String[] args) {
//		Map<String,Object> params = new HashMap<String, Object>();
//		params.put("ordersPayNo", "VIP201408251131020001");
//		String  x = doPost("http://222.92.197.76/mpay/mquery/querypay.htm", params);
//		System.out.println(x);
//
////		String http = "http://192.168.10.221:9090/MoolyPay/pay/recharge.htm?userName=liuff&userPass=e10adc3949ba59abbe56e057f20f883e&totalCash=0.01&orderno=1000000001&noticeUrl=http://192.168.10.16:48746&token=5fd8f745790219b31ff4f81e07516174&timeStamp=12345678";
////
////		System.out.println(MD5Util.getMD5("12345678"));
//	}
}