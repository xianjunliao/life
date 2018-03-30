package com.life.pc.dao;

import com.life.pc.model.SetingModel;

public interface SetingDao {


    int deleteByPrimaryKey(String id);


    int insertSelective(SetingModel record);


    SetingModel selectByPrimaryKey(String id);


    int updateByPrimaryKeySelective(SetingModel record);

}