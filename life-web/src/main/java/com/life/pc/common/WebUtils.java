package com.life.pc.common;

import javax.servlet.http.HttpServletRequest;

import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.pc.model.TreeModel;

public class WebUtils {

	/**
	 * 默认的一级菜单
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
	 * @param code
	 * @return
	 */
	public static TreeModel getDefalutTreeLevel2(String code,String pid, HttpServletRequest request) {
		TreeModel treeModel2 = new TreeModel();
		treeModel2.setIconCls("tree-listen");
		treeModel2.setSortNo("0");
		treeModel2.setLevel("2");
		treeModel2.setText("我的菜单");
		treeModel2.setUserCode(code);
		treeModel2.setUrl(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/myMeun");
		treeModel2.setId(Util.getUUId16());
		treeModel2.setPid(pid);
		treeModel2.setStatus("0");
		treeModel2.setCreateTime(DateUtil.getNow());
		treeModel2.setReadMode("web");
		return treeModel2;
	}
}
