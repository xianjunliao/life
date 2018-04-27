package com.life.pc.service;

import com.life.pc.model.FinanceRecordsModel;

public interface FinanceService {

	public void addRecord(FinanceRecordsModel recordsModel);
	
	public void updateRecord(FinanceRecordsModel recordsModel);
}
