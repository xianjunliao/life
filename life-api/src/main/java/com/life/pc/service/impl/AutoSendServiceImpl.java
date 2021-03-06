package com.life.pc.service.impl;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.life.common.Str;
import com.life.common.Util;
import com.life.common.memo.MailUtils;
import com.life.common.memo.SMSUtils;
import com.life.common.time.DateUtil;
import com.life.pc.dao.FinanceFixedDao;
import com.life.pc.dao.FinanceRecordsDao;
import com.life.pc.dao.LearnEnglishDao;
import com.life.pc.dao.LifeUserDao;
import com.life.pc.dao.MemosDao;
import com.life.pc.model.FinanceFixedModel;
import com.life.pc.model.FinanceRecordsModel;
import com.life.pc.model.LearnEnglishModel;
import com.life.pc.model.LifeUserModel;
import com.life.pc.model.MemosModel;
import com.life.pc.service.AutoSendService;

@Component("autoSendService")
public class AutoSendServiceImpl implements AutoSendService {

	private final static Logger log = LoggerFactory.getLogger(AutoSendServiceImpl.class);

	@Autowired
	private MemosDao memosDao;
	@Autowired
	private LearnEnglishDao learnEnglishDao;
	@Autowired
	private LifeUserDao lifeUserDao;
	@Autowired
	private FinanceRecordsDao financeRecordsDao;
	@Autowired
	private FinanceFixedDao financeFixedDao;

	@Scheduled(cron = "0/15 * * * * ? ")
	@Override
	public void autoSendTask() {
		log.debug("开始发送备忘录短信或邮件。。。。。。");
		try {
			List<MemosModel> selectByExecuteResult = memosDao.selectByExecuteResult();
			log.debug("未处理邮件数量：{}，返回结果集：{}", selectByExecuteResult.size(), selectByExecuteResult);
			for (MemosModel memosModel : selectByExecuteResult) {
				String emailno = memosModel.getEmailno();
				String phoneno = memosModel.getPhoneno();
				String nowStr = DateUtil.formatDate(new Date(), DateUtil.YYYYMMDDHH);
				Date parse1 = DateUtil.parse(memosModel.getSendtime(), DateUtil.YYYYMMDDHH);
				Date parse2 = DateUtil.parse(nowStr, DateUtil.YYYYMMDDHH);
				if (parse1.getTime() == parse2.getTime()) {
					if (!Str.isEmpty(phoneno)) {
						SMSUtils.sendShortMessage(phoneno, memosModel.getSendtime(), "www.liaoxianjun.com/login");
						log.debug("开始发送备忘录短信。。。。。。");
						memosModel.setExecuteresult("1,");
						memosModel.setUpdatetime(DateUtil.getNow());
						memosDao.update(memosModel);
					}
					if (!Str.isEmpty(emailno)) {
						MailUtils.sendMail(emailno, memosModel.getSubject(), memosModel.getContent());
						log.debug("开始发送备忘录邮件。。。。。。");
						memosModel.setExecuteresult(memosModel.getExecuteresult() + "2");
						memosModel.setUpdatetime(DateUtil.getNow());
						memosDao.update(memosModel);
					}

				}

			}
		} catch (ParseException e) {
			log.error("开始发送备忘录邮件或短信失败。。。。。。");
			e.printStackTrace();
		}

	}

	@Scheduled(cron = "0 0 2 * * ?")
	@Override
	public void autoAddLearnLine() {
		List<LifeUserModel> all = lifeUserDao.getAll();
		for (LifeUserModel lifeUserModel : all) {
			String now4 = DateUtil.getNow4();
			String usercode = lifeUserModel.getUsercode();
			LearnEnglishModel selectByTimeClass = learnEnglishDao.selectByTimeClass(now4, usercode);
			if (selectByTimeClass == null) {
				LearnEnglishModel learnEnglishModel = new LearnEnglishModel();
				learnEnglishModel.setId(Util.getUUId16());
				learnEnglishModel.setDiary(DateUtil.getNow());
				learnEnglishModel.setTimeclass(now4);
				learnEnglishModel.setHeadline(DateUtil.getNow6());
				learnEnglishModel.setUsercode(usercode);
				learnEnglishDao.insertSelective(learnEnglishModel);
			}

		}

	}

	@Scheduled(cron = "0/10 * * * * ? ")
	@Override
	public void autoAddFinance() {
		List<LifeUserModel> all = lifeUserDao.getAll();
		for (LifeUserModel lifeUserModel : all) {
			String usercode = lifeUserModel.getUsercode();

			List<FinanceFixedModel> list = financeFixedDao.getList(usercode);
			for (FinanceFixedModel financeFixedModel : list) {

				getToday(financeFixedModel);
			}

		}
	}

	private void getToday(FinanceFixedModel financeFixedModel) {
		String usercode = financeFixedModel.getUsercode();
		String financename = financeFixedModel.getFinancename();
		List<FinanceRecordsModel> toDay = financeRecordsDao.getToDay(usercode, financename, DateUtil.getNow5());
		if (toDay.size() == 0) {
			FinanceRecordsModel financeRecordsModel = createRecord(financeFixedModel);
			financeRecordsDao.insertSelective(financeRecordsModel);
		}
	}

	private FinanceRecordsModel createRecord(FinanceFixedModel financeFixedModel) {
		FinanceRecordsModel financeRecordsModel = new FinanceRecordsModel();
		financeRecordsModel.setFinancemonth(DateUtil.getMonth());
		financeRecordsModel.setFinancequarter(DateUtil.getQuarter());
		financeRecordsModel.setFinanceyear(DateUtil.getYear());
		financeRecordsModel.setFinancetime(DateUtil.getNow());
		financeRecordsModel.setFinancename(financeFixedModel.getFinancename());
		String financetype = financeFixedModel.getFinancetype();
		financeRecordsModel.setFinancetype(financetype);
		financeRecordsModel.setFinancemoney(financeFixedModel.getFinancemoney());
		if (financetype.equals("支出")) {
			financeRecordsModel.setFinancemoney(financeRecordsModel.getFinancemoney() * -1);
		}
		financeRecordsModel.setFinancemode(financeFixedModel.getFinancemode());
		financeRecordsModel.setFinanceremarks("固定消费记录，系统自动生成的。");
		financeRecordsModel.setUsercode(financeFixedModel.getUsercode());
		financeRecordsModel.setId(Util.getUUId16());
		financeRecordsModel.setFinanceweek(DateUtil.getWeekDay());
		financeRecordsModel.setFinanceday(DateUtil.getNow5());
		financeRecordsModel.setFinancetime(DateUtil.getNow());
		return financeRecordsModel;
	}

}
