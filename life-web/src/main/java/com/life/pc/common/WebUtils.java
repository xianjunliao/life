package com.life.pc.common;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.life.common.Str;
import com.life.common.SystemGet;
import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.pc.model.LearnEnglishModel;
import com.life.pc.model.LifeUserModel;
import com.life.pc.model.TreeModel;

public class WebUtils {

	/**
	 * 默认的一级菜单
	 * 
	 * @param code
	 * @return
	 */
	public static TreeModel getDefalutTreeLevel1(String code) {
		TreeModel treeModel = new TreeModel();
		treeModel.setIconCls("life-1");
		treeModel.setSortNo("0");
		treeModel.setLevel("1");
		treeModel.setText("我的收藏");
		treeModel.setUserCode(code);
		String pid = Util.getUUId16();
		treeModel.setId(pid);
		treeModel.setPid("0");
		treeModel.setStatus("0");
		treeModel.setCreateTime(DateUtil.getNow());
		return treeModel;
	}

	/**
	 * 默认的二级菜单
	 * 
	 * @param code
	 * @return
	 */
	public static TreeModel getDefalutTreeLevel2(String code, String pid, HttpServletRequest request) {
		TreeModel treeModel2 = new TreeModel();
		treeModel2.setIconCls("tree-listen");
		treeModel2.setSortNo("0");
		treeModel2.setLevel("2");
		treeModel2.setText("树状网址导航");
		treeModel2.setUserCode(code);
		treeModel2.setUrl(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/house");
		treeModel2.setId(Util.getUUId16());
		treeModel2.setPid(pid);
		treeModel2.setStatus("0");
		treeModel2.setCreateTime(DateUtil.getNow());
		treeModel2.setReadMode("web");
		return treeModel2;
	}

	/**
	 * 获取缓存的用户信息
	 * 
	 * @param request
	 * @return
	 */
	public static LifeUserModel getUserInfo(HttpServletRequest request) {
		Object attribute2 = request.getSession().getAttribute("lifeUserModel");
		if (null != attribute2) {
			return (LifeUserModel) attribute2;
		}
		return null;
	}

	/**
	 * 获取缓存的用户信息
	 * 
	 * @param request
	 * @return
	 */
	public static LifeUserModel getUserInfo(String sessionName, HttpServletRequest request) {
		Object obejct = null;
		if (Str.isEmpty(sessionName)) {
			obejct = request.getSession().getAttribute("lifeUserModel");
		} else {
			obejct = request.getSession().getAttribute(sessionName);
		}
		if (null != obejct) {
			return (LifeUserModel) obejct;
		}
		return null;
	}

	/**
	 * 获取缓存的身份编码
	 * 
	 * @param request
	 * @return
	 */
	public static String getUserCode(HttpServletRequest request) {
		LifeUserModel userInfo = getUserInfo(request);
		if (null != userInfo) {
			return userInfo.getUsercode();
		}
		return null;
	}

	/**
	 * 获取缓存的身份编码
	 * 
	 * @param request
	 * @return
	 */
	public static String getUserCode(String sessionName, HttpServletRequest request) {
		LifeUserModel userInfo = getUserInfo(sessionName, request);
		if (null != userInfo) {
			return userInfo.getUsercode();
		}
		return null;
	}

	/**
	 * 创建一个用户信息session
	 * 
	 * @param lifeUserModel
	 * @param request
	 */
	public static void newSession(LifeUserModel lifeUserModel, HttpServletRequest request) {
		request.getSession().setAttribute("lifeUserModel", lifeUserModel);
		request.getSession().setAttribute("ips", SystemGet.getNowIp());
		request.getSession().setMaxInactiveInterval(7200 * 12);

	}

	/**
	 * 创建身份编码cookie
	 */
	public static void newCookie(String usercode, HttpServletResponse response) {
		Cookie cookie = new Cookie("usercode", usercode); // 新建Cookie
		cookie.setMaxAge(7200 * 12 * 10); // 设置生命周期为MAX_VALUE
		response.addCookie(cookie);
	}

	/**
	 * 删除份编码cookie
	 */
	public static void deleteCookie(HttpServletResponse response) {
		Cookie cookie = new Cookie("usercode", null); // 新建Cookie
		cookie.setMaxAge(0); // 设置生命周期为MAX_VALUE
		response.addCookie(cookie);
	}

	/**
	 * 创建一个用户信息session
	 * 
	 * @param lifeUserModel
	 * @param request
	 */
	public static void newSession(String sessionName, LifeUserModel lifeUserModel, HttpServletRequest request) {
		if (Str.isEmpty(sessionName)) {
			newSession(lifeUserModel, request);
		} else {
			request.getSession().setAttribute(sessionName, lifeUserModel);
			request.getSession().setMaxInactiveInterval(1800);
		}
	}

	/**
	 * 删除用户信息session
	 * 
	 * @param lifeUserModel
	 * @param request
	 */
	public static void deleteSession(HttpServletRequest request) {
		request.getSession().removeAttribute("lifeUserModel");
	}

	/**
	 * 删除用户信息session
	 * 
	 * @param lifeUserModel
	 * @param request
	 */
	public static void deleteSession(String sessionName, HttpServletRequest request) {
		if (Str.isEmpty(sessionName)) {
			deleteSession(request);
		} else {
			request.getSession().removeAttribute(sessionName);
		}
	}

	/**
	 * 获取默认词汇线
	 * 
	 * @param code
	 * @return
	 */
	public static LearnEnglishModel getDefalutTimeClass(String code) {
		LearnEnglishModel learnEnglishModel = new LearnEnglishModel();
		learnEnglishModel.setHeadline(DateUtil.getNow6());
		learnEnglishModel.setUsercode(code);
		return learnEnglishModel;
	}
}
