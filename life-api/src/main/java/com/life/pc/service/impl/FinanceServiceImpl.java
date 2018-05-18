package com.life.pc.service.impl;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.pc.dao.FinanceFixedDao;
import com.life.pc.dao.FinanceRecordsDao;
import com.life.pc.model.FinanceFixedModel;
import com.life.pc.model.FinanceRecordsModel;
import com.life.pc.model.InParamModel;
import com.life.pc.model.SumModel;
import com.life.pc.service.FinanceService;

@Service("financeService")
public class FinanceServiceImpl implements FinanceService {

	@Autowired
	private FinanceRecordsDao financeRecordsDao;

	@Autowired
	private FinanceFixedDao financeFixedDao;

	@Override
	public void addRecord(FinanceRecordsModel recordsModel) {
		try {
			String financeday = recordsModel.getFinanceday();
			String financetype = recordsModel.getFinancetype();
			if (financetype.equals("支出")) {
				recordsModel.setFinancemoney(recordsModel.getFinancemoney() * -1);
			}
			recordsModel.setFinancemonth(DateUtil.getMonth(financeday));
			recordsModel.setFinancequarter(DateUtil.getQuarter(financeday));
			recordsModel.setFinanceyear(DateUtil.getYear(financeday));
			recordsModel.setFinancetime(DateUtil.getNow());
			recordsModel.setFinanceweek(DateUtil.getWeekDay(financeday));

			recordsModel.setId(Util.getUUId16());
			recordsModel.setFinancetime(DateUtil.getNow());
			financeRecordsDao.insertSelective(recordsModel);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateRecord(FinanceRecordsModel recordsModel) {
		financeRecordsDao.updateByPrimaryKeySelective(recordsModel);
	}

	@Override
	public List<FinanceRecordsModel> getList(InParamModel model) {
		List<FinanceRecordsModel> list = financeRecordsDao.getList(model);
		return list;
	}

	@Override
	public FinanceRecordsModel getRow(String id) {
		return financeRecordsDao.selectByPrimaryKey(id);
	}

	@Override
	public void addFiexd(FinanceFixedModel financeFixedModel) {
		financeFixedModel.setCreatetime(DateUtil.getNow());
		financeFixedModel.setId(Util.getUUId16());
		financeFixedDao.insertSelective(financeFixedModel);
	}

	@Override
	public List<SumModel> getSum(InParamModel model) {
		return financeRecordsDao.getSum(model);
	}

	@Override
	public List<SumModel> getDaySum(InParamModel model) {
		return financeRecordsDao.getDaySum(model);
	}

	@Override
	public List<FinanceFixedModel> getList(String usercode) {
		List<FinanceFixedModel> list = financeFixedDao.getList(usercode);
		return list;
	}

	@Override
	public FinanceFixedModel getRowFiexd(String id) {
		return financeFixedDao.selectByPrimaryKey(id);
	}

	@Override
	public void delete(String id, String type) {
		if ("0".equals(type)) {
			financeRecordsDao.deleteByPrimaryKey(id);
		}

		if ("6".equals(type)) {
			financeFixedDao.deleteByPrimaryKey(id);
		}

	}

	@Override
	public void updateFixed(FinanceFixedModel financeFixedModel) {
		financeFixedDao.updateByPrimaryKeySelective(financeFixedModel);		
	}

}
