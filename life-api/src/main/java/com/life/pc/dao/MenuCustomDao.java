package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.MenuCustomModel;

public interface MenuCustomDao {

	List<MenuCustomModel> getMenuAllByUsercode(@Param("usercode")String usercode);
	
	List<MenuCustomModel> getMenus(@Param("usercode")String usercode);
	
	MenuCustomModel getOrder(@Param("usercode")String usercode,@Param("menuorder")String menuorder);
	
    int insertSelective(MenuCustomModel record);

    int updateByExampleSelective(@Param("record")MenuCustomModel record);
    
    MenuCustomModel getMenuById(@Param("id")String id);

}