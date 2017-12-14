package com.life.util;

import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * Author:youqiang.li Time:2017-10-06 文件上传，下载工具类
 */
public class FileUtils {

	private static Logger log = Logger.getLogger(FileUtils.class);

	/**
	 * private constructor method that make class can not be instantiation
	 */
	private FileUtils() {
		throw new Error("The class Cannot be instance !");
	}

	/**
	 * spring mvc files Upload method (transferTo method) MultipartFile use
	 * TransferTo method upload
	 *
	 * @param request
	 *            HttpServletRequest
	 * @param multipartFile
	 *            MultipartFile(spring)
	 * @param filePath
	 *            filePath example "/files/Upload"
	 * @return
	 */
	public static String FilesUpload_transferTo_spring(HttpServletRequest request, MultipartFile multipartFile,
			String filePath) {
		if (multipartFile != null) {
			// get files suffix
			String suffix = multipartFile.getOriginalFilename()
					.substring(multipartFile.getOriginalFilename().lastIndexOf("."));
			// filePath+fileName the complex file Name
			String absolutePath = getAndSetAbsolutePath(request, filePath, suffix);
			// return relative Path
			String relativePath = getRelativePath(filePath, suffix);
			try {
				// save file
				multipartFile.transferTo(new File(absolutePath));
				// return relative Path
				return relativePath;
			} catch (IOException e) {
				e.printStackTrace();
				return null;
			}
		} else
			return null;
	}

	/**
	 * user stream type save files
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @param multipartFile
	 *            MultipartFile support CommonsMultipartFile file
	 * @param filePath
	 *            filePath example "/files/Upload"
	 * @return
	 */
	public static String FilesUpload_stream(HttpServletRequest request, MultipartFile multipartFile, String filePath) {
		if (multipartFile != null) {
			// get files suffix
			String suffix = multipartFile.getOriginalFilename()
					.substring(multipartFile.getOriginalFilename().lastIndexOf("."));
			// filePath+fileName the complex file Name
			String absolutePath = getAndSetAbsolutePath(request, filePath, suffix);
			// return relative Path
			String relativePath = getRelativePath(filePath, suffix);
			try {
				InputStream inputStream = multipartFile.getInputStream();
				FileOutputStream fileOutputStream = new FileOutputStream(absolutePath);
				byte buffer[] = new byte[4096]; // create a buffer
				long fileSize = multipartFile.getSize();
				if (fileSize <= buffer.length) {// if fileSize < buffer
					buffer = new byte[(int) fileSize];
				}
				int line = 0;
				while ((line = inputStream.read(buffer)) > 0) {
					fileOutputStream.write(buffer, 0, line);
				}
				fileOutputStream.close();
				inputStream.close();
				return relativePath;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else
			return null;
		return null;
	}

	/**
	 * user stream type save files
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @param multipartFile
	 *            MultipartFile support CommonsMultipartFile file
	 * @param filePath
	 *            filePath example "/files/Upload"
	 * @return
	 */
	public static String FilesUpload_stream(MultipartFile multipartFile, String filePath) {
		if (multipartFile != null) {
			// get files suffix
			String suffix = multipartFile.getOriginalFilename()
					.substring(multipartFile.getOriginalFilename().lastIndexOf("."));
			// filePath+fileName the complex file Name
			String savePath = filePath + File.separator + getDataPath() + File.separator;// example:F:/qixiao/files/Upload/20160912/
			checkDirs(savePath);// check if the path has exist if not create it
			String absolutePath = savePath + getUUIDName(suffix);
			// return relative Path
			String relativePath = getRelativePath(filePath, suffix);
			try {
				InputStream inputStream = multipartFile.getInputStream();
				FileOutputStream fileOutputStream = new FileOutputStream(absolutePath);
				byte buffer[] = new byte[4096]; // create a buffer
				long fileSize = multipartFile.getSize();
				if (fileSize <= buffer.length) {// if fileSize < buffer
					buffer = new byte[(int) fileSize];
				}
				int line = 0;
				while ((line = inputStream.read(buffer)) > 0) {
					fileOutputStream.write(buffer, 0, line);
				}
				fileOutputStream.close();
				inputStream.close();
				return relativePath;
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else
			return null;
		return null;
	}

	/**
	 * @param request
	 *            HttpServletRequest
	 * @param response
	 *            HttpServletResponse
	 * @param filePath
	 *            文件的相对路径
	 * @return
	 */
	public static void FilesDownload_stream(HttpServletRequest request, HttpServletResponse response, String filePath) {
		File file = new File(filePath);
		String filenames = file.getName();
		InputStream inputStream;
		try {
			inputStream = new BufferedInputStream(new FileInputStream(file));
			byte[] buffer = new byte[inputStream.available()];
			inputStream.read(buffer);
			inputStream.close();
			response.reset();
			// 先去掉文件名称中的空格,然后转换编码格式为utf-8,保证不出现乱码,这个文件名称用于浏览器的下载框中自动显示的文件名
			response.addHeader("Content-Disposition",
					"attachment;filename=" + new String(filenames.replaceAll(" ", "").getBytes("utf-8"), "iso8859-1"));
			response.addHeader("Content-Length", "" + file.length());
			OutputStream os = new BufferedOutputStream(response.getOutputStream());
			response.setContentType("application/octet-stream");
			os.write(buffer);// 输出文件
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据地址获得数据的字节流
	 * 
	 * @param strUrl
	 *            网络连接地址
	 * @return
	 */
	public static void getImageFromNetByUrl(HttpServletResponse response, String strUrl, String fileName) {
		try {
			URL url = new URL(strUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setConnectTimeout(5 * 1000);
			conn.setRequestProperty("Accept",
					"image/gif, image/jpeg, image/pjpeg, image/pjpeg, "
							+ "application/x-shockwave-flash, application/xaml+xml, "
							+ "application/vnd.ms-xpsdocument, application/x-ms-xbap, "
							+ "application/x-ms-application, application/vnd.ms-excel, "
							+ "application/vnd.ms-powerpoint, application/msword, */*");
			conn.setRequestProperty("Accept-Language", "zh-CN");
			conn.setRequestProperty("Charset", "UTF-8");
			InputStream inStream = conn.getInputStream();// 通过输入流获取图片数据
			byte[] btImg = readInputStream(inStream);// 得到图片的二进制数据
			response.setHeader("Content-Type", "application/octet-stream");
			response.setHeader("Content-Disposition",
					"attachment;filename=" + new String(fileName.getBytes("gb2312"), "ISO8859-1"));
			response.getOutputStream().write(btImg);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获取文件大小
	 * 
	 * @param strUrl
	 * @return
	 */
	public static int getImgSize(String strUrl) {

		try {
			URL url = new URL(strUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			InputStream inStream = conn.getInputStream();
			inStream.close();
			return conn.getContentLength();
		} catch (MalformedURLException e) {
			return 0;
		} catch (IOException e) {
			return 0;
		}
	}

	/**
	 * 从输入流中获取数据
	 * 
	 * @param inStream
	 *            输入流
	 * @return
	 * @throws Exception
	 */
	public static byte[] readInputStream(InputStream inStream) throws Exception {
		ByteArrayOutputStream outStream = new ByteArrayOutputStream();
		byte[] buffer = new byte[1024];
		int len = 0;
		while ((len = inStream.read(buffer)) != -1) {
			outStream.write(buffer, 0, len);
		}
		inStream.close();
		return outStream.toByteArray();
	}

	// -------------------------------------------------------------------------------
	// return server absolute path（real path）
	public static String getServerPath(HttpServletRequest request, String filePath) {
		return request.getSession().getServletContext().getRealPath(filePath);
	}

	// return a dir that named date of today ; example:20160912
	public static String getDataPath() {
		return new SimpleDateFormat("yyyyMMdd").format(new Date());
	}

	// check if the path has exist if not create it
	public static void checkDir(String savePath) {
		File dir = new File(savePath);
		if (!dir.exists() || !dir.isDirectory()) {
			dir.mkdir();
		}
	}

	// check if the path has exist if not create it
	public static void checkDirs(String savePath) {
		File dir = new File(savePath);
		if (!dir.exists() || !dir.isDirectory()) {
			dir.mkdirs();
		}
	}

	// return an UUID Name parameter (suffix cover '.') example： ".jpg"、".txt"
	public static String getUUIDName(String suffix) {
		return UUID.randomUUID().toString() + suffix;// make new file name
	}

	// return server absolute path（real path） the style is “server absolute
	// path/DataPath/UUIDName”filePath example "/files/Upload"
	public static String getAndSetAbsolutePath(HttpServletRequest request, String filePath, String suffix) {
		String savePath = getServerPath(request, filePath) + File.separator + getDataPath() + File.separator;// example:F:/qixiao/files/Upload/20160912/
		checkDir(savePath);// check if the path has exist if not create it
		return savePath + getUUIDName(suffix);
	}

	// get the relative path of files style is
	// “/filePath/DataPath/UUIDName”filePath example "/files/Upload"
	public static String getRelativePath(String filePath, String suffix) {
		return filePath + File.separator + getDataPath() + File.separator + getUUIDName(suffix);// example:/files/Upload/20160912/
	}

	/**
	 * 创建目录
	 */
	public static boolean createDirecroty(String fileDir) throws IOException {
		String directory = fileDir.substring(0, fileDir.lastIndexOf("/") + 1);
		// 如果目录不存在，则递归创建目录
		String locationDir = new File("").getAbsolutePath();
		if (!directory.equalsIgnoreCase("/")) {
			String[] directoryArray = directory.split("/");
			String path;
			for (String subDirectory : directoryArray) {
				if (StringUtil.isNotBlank(subDirectory)) {
					path = subDirectory + File.separator;
					File file = new File(subDirectory);
					// 文件 或目录是否存在
					if (locationDir.contains(path)) {
						continue;
					}
					if (file.exists()) {
						// 判断是否为文件
						if (file.isFile()) { // 为文件时调用删除文件方法
							file.delete();
							log.info("删除已有文件：" + path);
						}
						log.info(path + "目录已存在");
					} else {
						file.mkdir();
						if (file.exists()) {
							log.info("创建目录或文件成功：" + path);
						} else {
							return false;
						}
						log.info("创建目录：" + path);
					}
				} else {
					log.info("目录或文件名为空,无法创建");
				}
			}
		} else {
			log.info(directory + "，目录已存在");
		}
		return true;
	}

}
