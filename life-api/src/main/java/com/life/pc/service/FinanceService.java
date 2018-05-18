package com.life.pc.service;

import java.util.List;

import com.life.pc.model.FinanceFixedModel;
import com.life.pc.model.FinanceRecordsModel;
import com.life.pc.model.InParamModel;
import com.life.pc.model.SumModel;

public interface FinanceService {

	public void addRecord(FinanceRecordsModel recordsModel);

	public void updateRecord(FinanceRecordsModel recordsModel);
	
	public void updateFixed(FinanceFixedModel financeFixedModel);

	public List<FinanceRecordsModel> getList(InParamModel model);
	
	public List<FinanceFixedModel> getList(String usercode);
	
	FinanceRecordsModel getRow(String id);
	
	FinanceFixedModel getRowFiexd(String id);
	
	void addFiexd(FinanceFixedModel financeFixedModel);
	
	List<SumModel> getSum(InParamModel model);
	
	List<SumModel> getDaySum(InParamModel model);
	
	void delete(String id,String type);
	
}
