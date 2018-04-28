package com.life.pc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.pc.dao.FinanceRecordsDao;
import com.life.pc.model.FinanceRecordsModel;
import com.life.pc.service.FinanceService;

@Service("financeService")
public class FinanceServiceImpl implements FinanceService {

	@Autowired
	private FinanceRecordsDao financeRecordsDao;

	@Override
	public void addRecord(FinanceRecordsModel recordsModel) {
		recordsModel.setFinancemonth(DateUtil.getNowMonth());
		recordsModel.setFinancequarter(DateUtil.getNowQuarter());
		recordsModel.setFinanceyear(DateUtil.getNowYear());
		recordsModel.setFinancetime(DateUtil.getNow());
		recordsModel.setFinanceweek(DateUtil.getWeekDay());
		recordsModel.setId(Util.getUUId16());
		recordsModel.setFinancetime(DateUtil.getNow());
		financeRecordsDao.insertSelective(recordsModel);
	}

	@Override
	public void updateRecord(FinanceRecordsModel recordsModel) {
		financeRecordsDao.updateByPrimaryKeySelective(recordsModel);
	}

	@Override
	public List<FinanceRecordsModel> getList(String usercode) {
		List<FinanceRecordsModel> list = financeRecordsDao.getList(usercode);
		return list;
	}

	@Override
	public FinanceRecordsModel getRow(String id) {
		return financeRecordsDao.selectByPrimaryKey(id);
	}

}
