package com.life.pc.service;

import java.util.List;

import com.life.pc.model.LifeUserModel;
import com.life.pc.model.MenuCustomModel;

public interface LifeUserService {

	public LifeUserModel checkEnterCode(String code);

	public LifeUserModel checkEnterName(String name);

	public LifeUserModel checkEnterNameAndPassword(String name, String password);

	List<LifeUserModel> getAll();

	void add(LifeUserModel lifeUserModel);

	void update(LifeUserModel lifeUserModel);
	
	void addMenus();
	
	List<MenuCustomModel> getMenus(String code);
	
	List<MenuCustomModel> getAllMenus(String code);
	
	void toMove(String moveType,String code,String id);
	
	void updateMenu(MenuCustomModel menuCustomModel);
}
