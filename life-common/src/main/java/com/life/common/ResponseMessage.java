package com.life.common;

import java.io.Serializable;

/**
 * 响应信息
 * 
 * @author xiangxin.zou
 * @since JDK1.7
 * @version 1.0
 */
public class ResponseMessage<T> implements Serializable {
	private static final long serialVersionUID = 45388464217247707L;

	/**
	 * 结果码
	 */
	private String code;
	/**
	 * 详细信息
	 */
	private String message;
	/**
	 * 响应结果
	 */
	private T data;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

}
