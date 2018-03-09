package com.life.pc.service.impl;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.life.common.PinyinUtils;
import com.life.common.Util;
import com.life.common.baidu.BaiduVoice;
import com.life.common.time.DateUtil;
import com.life.common.util.SpringWebUtil;
import com.life.pc.dao.LearnEnglishDao;
import com.life.pc.dao.LearnEnglishInterpretayionDao;
import com.life.pc.dao.LearnEnglishWordsDao;
import com.life.pc.dao.LearnRelationDao;
import com.life.pc.dao.SystemDataDao;
import com.life.pc.model.LearnEnglishInterpretayionModel;
import com.life.pc.model.LearnEnglishModel;
import com.life.pc.model.LearnEnglishWordsModel;
import com.life.pc.model.LearnParamModel;
import com.life.pc.model.LearnRelationModel;
import com.life.pc.model.SystemDataModel;
import com.life.pc.service.LearningService;

@Service("learningService")
public class LearningServiceImpl implements LearningService {

	@Autowired
	private LearnEnglishDao learnEnglishDao;

	@Autowired
	private LearnEnglishInterpretayionDao learnEnglishInterpretayionDao;

	@Autowired
	private LearnEnglishWordsDao learnEnglishWordsDao;

	@Autowired
	private LearnRelationDao learnRelationDao;

	@Autowired
	private SystemDataDao systemDataDao;

	@Override
	public Map<String, Object> getWords(String usercode) {
		List<LearnEnglishModel> learns = learnEnglishDao.selectListByUser(usercode);
		Map<LearnEnglishModel, Integer> mapp = new TreeMap<>(new Comparator<LearnEnglishModel>() {

			@Override
			public int compare(LearnEnglishModel o1, LearnEnglishModel o2) {
				return o1.getDiary().compareTo(o2.getDiary());
			}
		});
		for (LearnEnglishModel learnEnglishModel : learns) {
			String id = learnEnglishModel.getId();
			mapp.put(learnEnglishModel, learnRelationDao.countBylearnid(id));
		}
		List<SystemDataModel> systemDataModels = getSystemData("WORDTYPE");
		List<LearnRelationModel> relationModels = learnRelationDao.selectByuser(usercode);// 学习关联
		List<LearnEnglishModel> learnEnglishModels = new ArrayList<>();// 学习记录表

		Map<String, List<LearnRelationModel>> map = new HashMap<>();
		Map<String, List<LearnEnglishWordsModel>> map2 = new HashMap<>();
		Map<String, List<LearnEnglishInterpretayionModel>> map3 = new HashMap<>();
		for (LearnRelationModel learnRelationModel : relationModels) {
			LearnEnglishModel learnEnglishModel = learnEnglishDao.selectByPrimaryKey(learnRelationModel.getLearnid());
			learnEnglishModels.add(learnEnglishModel);
			List<LearnEnglishInterpretayionModel> selectBywordId = learnEnglishInterpretayionDao.selectBywordId(learnRelationModel.getWordid());
			map3.put(learnRelationModel.getWordid(), selectBywordId);
		}
		for (LearnEnglishModel learnEnglishModel : learnEnglishModels) {
			String learnId = learnEnglishModel.getId();
			List<LearnRelationModel> learnRelationModels = learnRelationDao.selectBylearnid(learnId);
			map.put(learnId, learnRelationModels);
		}
		for (Map.Entry<String, List<LearnRelationModel>> entry : map.entrySet()) {
			List<LearnRelationModel> value = entry.getValue();
			List<LearnEnglishWordsModel> learnEnglishWordsModels = new ArrayList<>();// 英文表
			for (LearnRelationModel learnRelationModel : value) {
				LearnEnglishWordsModel learnEnglishWordsModel = learnEnglishWordsDao.selectByPrimaryKey(learnRelationModel.getWordid());
				if (!learnEnglishWordsModels.contains(learnEnglishWordsModel)) {
					learnEnglishWordsModels.add(learnEnglishWordsModel);
				}
			}

			String learnId = entry.getKey();
			map2.put(learnId, learnEnglishWordsModels);
		}

		Map<LearnEnglishModel, Map<SystemDataModel, List<LearnEnglishWordsModel>>> map5 = new HashMap<>();
		for (Map.Entry<String, List<LearnEnglishWordsModel>> entry : map2.entrySet()) {
			List<LearnEnglishWordsModel> value = entry.getValue();
			Map<SystemDataModel, List<LearnEnglishWordsModel>> map4 = new TreeMap<>(new Comparator<SystemDataModel>() {
				@Override
				public int compare(SystemDataModel o1, SystemDataModel o2) {
					return o1.getCreatetime().compareTo(o2.getCreatetime());
				}
			});
			for (SystemDataModel systemDataModel : systemDataModels) {
				List<LearnEnglishWordsModel> models = new ArrayList<>();
				for (LearnEnglishWordsModel learnEnglishWordsModel : value) {
					if (systemDataModel.getItemNo().equals(learnEnglishWordsModel.getType())) {
						models.add(learnEnglishWordsModel);
					}
				}
				map4.put(systemDataModel, models);
			}

			String key = entry.getKey();
			map5.put(learnEnglishDao.selectByPrimaryKey(key), map4);
		}
		Map<String, Object> finalyMap = new HashMap<>();
		finalyMap.put("wordTypes", systemDataModels);
		finalyMap.put("learnEnglish", map5);
		finalyMap.put("interpretayion", map3);
		finalyMap.put("learns", mapp);
		return finalyMap;
	}

	@Override
	public void addLearnRecord(LearnParamModel learnParamModel) {

		try {
			String timeclass = learnParamModel.getTimeClass();
			String learnId = Util.getUUId16();
			String wordId = Util.getUUId16();
			String InterpretayionId = Util.getUUId16();
			String usercode = learnParamModel.getUsercode();
			LearnEnglishModel learnEnglishModel = learnEnglishDao.selectByPrimaryKey(timeclass);
			learnId = learnEnglishModel.getId();
			wordId = doWords(learnParamModel, wordId, usercode);
			InterpretayionId = doInterpretayion(learnParamModel, wordId, InterpretayionId);
			LearnRelationModel learnRelationModel = new LearnRelationModel();
			learnRelationModel.setLearnid(learnId);
			learnRelationModel.setWordid(wordId);
			learnRelationModel.setInterpertayionid(InterpretayionId);
			learnRelationModel.setUsercode(usercode);
			learnRelationDao.insert(learnRelationModel);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String doInterpretayion(LearnParamModel learnParamModel, String wordId, String InterpretayionId) {
		LearnEnglishInterpretayionModel selectBywordIdAndWordType = learnEnglishInterpretayionDao.selectBywordIdAndWordType(wordId, learnParamModel.getPartOfSpeech());
		if (selectBywordIdAndWordType == null) {
			LearnEnglishInterpretayionModel englishInterpretayionModel = new LearnEnglishInterpretayionModel();
			englishInterpretayionModel.setId(InterpretayionId);
			englishInterpretayionModel.setWordtype(learnParamModel.getPartOfSpeech());
			englishInterpretayionModel.setWordinterpretation(learnParamModel.getWordInterpretayion());
			englishInterpretayionModel.setWordid(wordId);
			learnEnglishInterpretayionDao.insertSelective(englishInterpretayionModel);
		} else {
			InterpretayionId = selectBywordIdAndWordType.getId();
		}
		return InterpretayionId;
	}

	private String doWords(LearnParamModel learnParamModel, String wordId, String usercode) {
		LearnEnglishWordsModel selectByWord = learnEnglishWordsDao.selectByWord(learnParamModel.getWord().toLowerCase());
		if (null == selectByWord) {
			LearnEnglishWordsModel learnEnglishWordsModel = new LearnEnglishWordsModel();
			learnEnglishWordsModel.setId(wordId);
			learnEnglishWordsModel.setAddtime(DateUtil.getNow());
			learnEnglishWordsModel.setAdduser(usercode);
			learnEnglishWordsModel.setWord(learnParamModel.getWord());
			learnEnglishWordsModel.setType(learnParamModel.getWordType());
			Map<String, String> baiduVoice = BaiduVoice.getBaiduVoice(wordId,learnParamModel.getWord(), usercode, learnParamModel.getWordType());
			String path = baiduVoice.get("path");
			learnEnglishWordsModel.setMp3path(path);
			HttpServletRequest request = SpringWebUtil.getRequest();
			learnEnglishWordsModel.setMp3url(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/" + "learn/getVoice?id=" + wordId);
			learnEnglishWordsDao.insertSelective(learnEnglishWordsModel);
		} else {
			wordId = selectByWord.getId();
		}
		return wordId;
	}

	@Override
	public List<SystemDataModel> getSystemData(String indexes) {
		List<SystemDataModel> selectByKey = systemDataDao.selectByKey(indexes);
		return selectByKey;
	}

	@Override
	public Map<String, Object> getLearns(String usercode) {

		return null;
	}

	@Override
	public LearnEnglishWordsModel getLearnEnglishWordsModel(String id) {
		LearnEnglishWordsModel selectByPrimaryKey = learnEnglishWordsDao.selectByPrimaryKey(id);
		return selectByPrimaryKey;
	}

	@Override
	public void addLearnTime(LearnEnglishModel learnEnglishModel) {
		try {
			learnEnglishModel.setId(Util.getUUID());
			learnEnglishModel.setTimeclass(PinyinUtils.getPingYin(learnEnglishModel.getHeadline()));
			learnEnglishModel.setDiary(DateUtil.getNow());
			learnEnglishDao.insertSelective(learnEnglishModel);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteItv(String id) {
		try {
			learnEnglishInterpretayionDao.deleteByPrimaryKey(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deletelvv(String lid, String wid) {
		try {
			learnRelationDao.deleteByLidAndWid(lid, wid);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
