package com.life.pc.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.common.util.SpringWebUtil;
import com.life.pc.dao.LifeUserDao;
import com.life.pc.dao.MenuCustomDao;
import com.life.pc.model.LifeUserModel;
import com.life.pc.model.MenuCustomModel;
import com.life.pc.service.LifeUserService;

@Service("lifeUserService")
public class LifeUserServiceImpl implements LifeUserService {

	@Resource(name = "lifeUserDao")
	private LifeUserDao lifeUserDao;

	@Autowired
	private MenuCustomDao menuCustomDao;

	@Override
	public LifeUserModel checkEnterCode(String code) {
		return lifeUserDao.checkEnterCode(code);
	}

	@Override
	public List<LifeUserModel> getAll() {
		return lifeUserDao.getAll();
	}

	@Override
	public void add(LifeUserModel lifeUserModel) {
		lifeUserDao.save(lifeUserModel);
	}

	@Override
	public void update(LifeUserModel lifeUserModel) {
		lifeUserDao.update(lifeUserModel);
	}

	@Override
	public LifeUserModel checkEnterName(String name) {

		return lifeUserDao.checkEnterName(name);
	}

	@Override
	public LifeUserModel checkEnterNameAndPassword(String name, String password) {
		return lifeUserDao.checkEnterNameAndPassword(name, password);
	}

	@Override
	public void addMenus() {
		try {
			List<LifeUserModel> all = lifeUserDao.getAll();
			HttpServletRequest request = SpringWebUtil.getRequest();
			String htt = request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/";
			for (LifeUserModel lifeUserModel : all) {
				String usercode = lifeUserModel.getUsercode();
				List<MenuCustomModel> models = menuCustomDao.getMenuAllByUsercode(usercode);
				if (models.isEmpty()) {
					createModel("网站导航", htt + "tree/getAllUri", usercode, "1");
					createModel("每日英语", htt + "learn/ENG_chooce", usercode, "2");
					createModel("精达细算", htt + "finance/main", usercode, "3");
					createModel("自由云", htt + "file/upLoad", usercode, "4");
					createModel("备忘录", htt + "memos", usercode, "5");
					createModel("编程技能要点", htt + "learn/IT_index", usercode, "6");
					createModel("乐谱谱架", htt + "music/music_stand", usercode, "7");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void createModel(String name, String url, String usercode, String order) {
		MenuCustomModel menuCustomModel = new MenuCustomModel();
		menuCustomModel.setId(Util.getUUId16());
		menuCustomModel.setMenuname(name);
		menuCustomModel.setMenuurl(url);
		menuCustomModel.setUsercode(usercode);
		menuCustomModel.setMenustatus("0");
		menuCustomModel.setMenuorder(order);
		menuCustomModel.setCreatetime(DateUtil.getNow());
		menuCustomDao.insertSelective(menuCustomModel);
	}

	@Override
	public List<MenuCustomModel> getMenus(String code) {
		List<MenuCustomModel> models = menuCustomDao.getMenus(code);
		return models;
	}

	@Override
	public List<MenuCustomModel> getAllMenus(String code) {
		return menuCustomDao.getMenuAllByUsercode(code);
	}

	@Override
	public void toMove(String moveType, String code, String id) {
		MenuCustomModel model = menuCustomDao.getMenuById(id);
		Integer oldOrder = Integer.parseInt(model.getMenuorder());
		Integer newOrder = 0;
		if (moveType.equals("down")) {
			newOrder = oldOrder + 1;
		} else {
			newOrder = oldOrder - 1;
		}
		model.setMenuorder(newOrder.toString());
		MenuCustomModel order = menuCustomDao.getOrder(code, newOrder.toString());
		order.setMenuorder(oldOrder.toString());
		menuCustomDao.updateByExampleSelective(order);
		menuCustomDao.updateByExampleSelective(model);
	}

	@Override
	public void updateMenu(MenuCustomModel menuCustomModel) {
		menuCustomDao.updateByExampleSelective(menuCustomModel);
	}
}