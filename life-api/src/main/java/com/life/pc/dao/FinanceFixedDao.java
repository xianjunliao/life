package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.FinanceFixedModel;

public interface FinanceFixedDao {

	int deleteByPrimaryKey(String id);

	int insertSelective(FinanceFixedModel record);

	FinanceFixedModel selectByPrimaryKey(String id);
	
	List<FinanceFixedModel> getList(@Param("usercode")String usercode);

	int updateByPrimaryKeySelective(FinanceFixedModel record);

}