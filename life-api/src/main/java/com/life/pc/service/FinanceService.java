package com.life.pc.service;

import java.util.List;

import com.life.pc.model.FinanceFixedModel;
import com.life.pc.model.FinanceRecordsModel;
import com.life.pc.model.InParamModel;
import com.life.pc.model.SumModel;

public interface FinanceService {

	public void addRecord(FinanceRecordsModel recordsModel);

	public void updateRecord(FinanceRecordsModel recordsModel);

	public List<FinanceRecordsModel> getList(InParamModel model);
	
	FinanceRecordsModel getRow(String id);
	
	void addFiexd(FinanceFixedModel financeFixedModel);
	
	List<SumModel> getSum(String usercode);
	
	List<SumModel> getDaySum(String usercode);
}
