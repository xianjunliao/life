package com.life.pc.dao;

import com.life.pc.model.FinanceRecordsModel;

public interface FinanceRecordsDao {

	int deleteByPrimaryKey(String id);

	int insertSelective(FinanceRecordsModel record);

	FinanceRecordsModel selectByPrimaryKey(String id);

	int updateByPrimaryKeySelective(FinanceRecordsModel record);
}