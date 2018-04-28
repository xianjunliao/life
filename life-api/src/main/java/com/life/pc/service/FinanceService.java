package com.life.pc.service;

import java.util.List;

import com.life.pc.model.FinanceRecordsModel;

public interface FinanceService {

	public void addRecord(FinanceRecordsModel recordsModel);

	public void updateRecord(FinanceRecordsModel recordsModel);

	public List<FinanceRecordsModel> getList(String usercode);
	
	FinanceRecordsModel getRow(String id);
}
