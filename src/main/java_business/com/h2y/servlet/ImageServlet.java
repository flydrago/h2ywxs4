package com.h2y.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * 图片解析
 * 
 * @author：段晓刚
 * 
 * @update：2014年10月26日 下午6:02:11
 * 
 * @Email：
 */
public class ImageServlet extends HttpServlet {

	/**
	 * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	 */
	private Logger logger = Logger.getLogger(ImageServlet.class);

	private static final long serialVersionUID = 1L;

	private static final String GIF = "image/gif;charset=GB2312";
	// 设定输出的类型
	private static final String JPG = "image/jpeg;charset=GB2312";

	private static final String PNG = "image/png;charset=GB2312";

	private static final String BMP = "image/bmp;charset=GB2312";

	@SuppressWarnings("unused")
	private static String projectPath = "D:/hwttnet/upload";

	/**
	 * Constructor of the object.
	 */
	public ImageServlet() {
		super();
		logger.debug("初始化图片处理Servlet参数");
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 测试url
		// http://192.168.4.120:8080/whWebService/servlet/WbsImageServlet?URLPATH=view.do?urId=496298
		// ApplicationContext ctx =
		// WebApplicationContextUtils.getWebApplicationContext(getServletContext());

		String path = request.getParameter("path");

		logger.debug("\n path" + path);
		long fileSize = -1l;

		FileInputStream fis = null;
		BufferedInputStream bis = null;
		String imageName = "";

		if (path.startsWith("http:")) {
			URL url = new URL(path);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			// 此连接的 URL 引用的资源的内容长度，或者如果内容长度未知，则返回 -1。
			fileSize = connection.getContentLength();
			try {
				bis = new BufferedInputStream(connection.getInputStream());

				URL url2 = connection.getURL();
				String path2 = url2.getPath();
				imageName = connection.getHeaderField(path2.substring(path2.lastIndexOf("/") + 1));
			} catch (Exception e) {
				e.printStackTrace();
				return;
			}
		} else {
			File file = new File(path);
			if (!file.exists())
				return;
			fis = new FileInputStream(file);
			bis = new BufferedInputStream(fis);
			fileSize = file.length();
			imageName = file.getName();
		}

		// 在浏览器界面展示图片
		printImage(response, bis, fileSize, imageName);
		fis.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

	/**
	 * 展示图片
	 * 
	 * @param is
	 * @param fis
	 * @param response
	 * @param imagePath
	 * @param imageName
	 * @param fileSize
	 * @throws IOException
	 */
	private void printImage(HttpServletResponse response, BufferedInputStream bis, long fileSize, String imageName) throws IOException {

		if (bis != null) {
			logger.debug("image print begin");
			// 输出图片的类型的标志　　　　
			// 得到输出流
			OutputStream output = response.getOutputStream();
			// 使用编码处理文件流的情况：
			String imp = imageName.toLowerCase();

			// 设定输出的类型
			if (imp.endsWith(".jpg") || imp.endsWith(".jpeg")) {
				// 设定输出的类型
				response.setContentType(JPG);
			} else if (imp.endsWith(".gif")) {
				response.setContentType(GIF);
			} else if (imp.endsWith(".png")) {
				response.setContentType(PNG);
			} else if (imp.endsWith(".bmp")) {
				response.setContentType(BMP);
			} else {
				response.setContentType(JPG);
			}

			response.setHeader("fileName", imageName);
			response.addHeader("fileLength", fileSize + "");// 设置大小

			// 输入缓冲流
			BufferedOutputStream bos = new BufferedOutputStream(output);
			// 输出缓冲流
			byte data[] = new byte[4096];
			// 缓冲字节数
			int size = 0;
			size = bis.read(data);
			while (size != -1) {
				bos.write(data, 0, size);
				size = bis.read(data);
			}

			if (bis != null)
				bis.close();
			// 清空输出缓冲流
			bos.flush();

			if (bos != null)
				bos.close();

			// 关闭文件流
			if (bis != null)
				bis.close();
			if (output != null)
				output.close();
			logger.debug("print file end");
		}
	}
}
