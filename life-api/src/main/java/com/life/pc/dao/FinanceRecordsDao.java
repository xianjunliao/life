package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.FinanceRecordsModel;

public interface FinanceRecordsDao {

	int deleteByPrimaryKey(String id);

	int insertSelective(FinanceRecordsModel record);

	FinanceRecordsModel selectByPrimaryKey(String id);
	
	public List<FinanceRecordsModel> getList(@Param("usercode")String usercode);

	int updateByPrimaryKeySelective(FinanceRecordsModel record);
}