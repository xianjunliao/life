/******************************************************************************
* Copyright © 2014 billionscredit.com
* All Rights Reserved.
* 本软件为佰仟融资租赁有限公司开发研制。未经本公司正式书面同意，其他任何个人、团体不得使用、
* 复制、修改或发布本软件.
*****************************************************************************/

package com.life.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * 工具类
 *
 */
public class CommonUtil {
	/**
	 * 生成32位的UUID
	 *
	 * @return 32位的UUID
	 */
	public static String generateUUID() {
		String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");
		return uuid;
	}

	/**
	 * java生成流水号 14位时间戳 + 6位随机数
	 *
	 * @return
	 */
	public static String getId() {
		String id = "";
		// 获取当前时间戳
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
		String temp = sf.format(new Date());
		// 获取6位随机数
		int random = (int) ((Math.random() + 1) * 100000);
		id = temp + random;
		return id;
	}
}
