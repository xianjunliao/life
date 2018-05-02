package com.life.pc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.life.pc.model.FinanceRecordsModel;
import com.life.pc.model.InParamModel;
import com.life.pc.model.SumModel;

public interface FinanceRecordsDao {

	int deleteByPrimaryKey(String id);

	int insertSelective(FinanceRecordsModel record);

	FinanceRecordsModel selectByPrimaryKey(String id);

	public List<FinanceRecordsModel> getList(@Param("param") InParamModel model);

	int updateByPrimaryKeySelective(FinanceRecordsModel record);

	List<SumModel> getSum(@Param("usercode") String usercode);

	List<SumModel> getDaySum(@Param("usercode") String usercode);

	List<FinanceRecordsModel> getToDay(@Param("usercode") String usercode, @Param("financename") String financename,
			@Param("financeday") String financeday);
}