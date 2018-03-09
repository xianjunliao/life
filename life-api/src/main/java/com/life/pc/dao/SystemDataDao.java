package com.life.pc.dao;

import java.util.List;

import com.life.pc.model.SystemDataModel;

public interface SystemDataDao {

	List<SystemDataModel> selectByKey(String indexes);

}