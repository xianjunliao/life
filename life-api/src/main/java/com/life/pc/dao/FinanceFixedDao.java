package com.life.pc.dao;

import com.life.pc.model.FinanceFixedModel;

public interface FinanceFixedDao {

	int deleteByPrimaryKey(String id);

	int insert(FinanceFixedModel record);

	int insertSelective(FinanceFixedModel record);

	FinanceFixedModel selectByPrimaryKey(String id);

	int updateByPrimaryKeySelective(FinanceFixedModel record);

}