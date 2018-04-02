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

import com.life.common.Str;
import com.life.common.Util;
import com.life.common.baidu.BaiduTranslate;
import com.life.common.baidu.BaiduVoice;
import com.life.common.shanbei.WordUtils;
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
	public Map<String, Object> getWords(String usercode, int number) {
		List<LearnEnglishModel> learns = learnEnglishDao.selectListByUser(usercode, number);
		Map<LearnEnglishModel, Integer> mapp = new TreeMap<>(new Comparator<LearnEnglishModel>() {

			@Override
			public int compare(LearnEnglishModel o1, LearnEnglishModel o2) {
				return o2.getDiary().compareTo(o1.getDiary());
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
			String usercode = learnParamModel.getUsercode();
			LearnEnglishModel learnEnglishModel = learnEnglishDao.selectByPrimaryKey(timeclass);
			learnId = learnEnglishModel.getId();
			wordId = doWords(learnParamModel, wordId, usercode);
			String wordInterpretayion = learnParamModel.getWordInterpretayion();
			if (learnParamModel.getWordType().equals("word")) {
				Map<String, String> wordMap = WordUtils.getWordMap(learnParamModel.getWord());
				if (Str.isEmpty(wordInterpretayion)) {
					wordInterpretayion = wordMap.get("definition").replace(" ", "");
				}
			} else {
				wordInterpretayion = BaiduTranslate.getBaiduTranslateZh(learnParamModel.getWord());
			}
			String[] split = wordInterpretayion.split("\n");
			for (int i = 0; i < split.length; i++) {
				String strFor = split[i];
				if (!Str.isEmpty(strFor)) {
					String InterpretayionId = Util.getUUId16();
					learnParamModel.setWordInterpretayion(strFor);
					InterpretayionId = doInterpretayion(learnParamModel, wordId, InterpretayionId);
					LearnRelationModel learnRelationModel = new LearnRelationModel();
					learnRelationModel.setLearnid(learnId);
					learnRelationModel.setWordid(wordId);
					learnRelationModel.setInterpertayionid(InterpretayionId);
					learnRelationModel.setUsercode(usercode);
					long selectByAll = learnRelationDao.selectByAll(learnRelationModel);
					if (selectByAll == 0) {

						learnRelationDao.insert(learnRelationModel);
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String doInterpretayion(LearnParamModel learnParamModel, String wordId, String InterpretayionId) {
		List<SystemDataModel> systemDataModels = getSystemData("PARTOFSPEECH");
		String wordInterpretayion2 = learnParamModel.getWordInterpretayion();
		String wordInterpretayion = toClean(wordInterpretayion2, systemDataModels);
		LearnEnglishInterpretayionModel selectBywordIdAndWordType = learnEnglishInterpretayionDao.selectBywordInterpretation(wordId, wordInterpretayion);
		if (selectBywordIdAndWordType == null) {
			LearnEnglishInterpretayionModel englishInterpretayionModel = new LearnEnglishInterpretayionModel();
			englishInterpretayionModel.setId(InterpretayionId);

			if (learnParamModel.getWordType().equals("word")) {
				String wordType = getWordType(wordInterpretayion2, systemDataModels);
				englishInterpretayionModel.setWordtype(wordType);
			}
			englishInterpretayionModel.setWordinterpretation(wordInterpretayion);
			englishInterpretayionModel.setWordid(wordId);
			englishInterpretayionModel.setDefinition(wordInterpretayion2);
			learnEnglishInterpretayionDao.insertSelective(englishInterpretayionModel);
		} else {
			InterpretayionId = selectBywordIdAndWordType.getId();
		}
		return InterpretayionId;
	}

	private String doWords(LearnParamModel learnParamModel, String wordId, String usercode) {
		String word = learnParamModel.getWord();
		LearnEnglishWordsModel selectByWord = learnEnglishWordsDao.selectByWord(word.toLowerCase());
		if (null == selectByWord) {
			LearnEnglishWordsModel learnEnglishWordsModel = new LearnEnglishWordsModel();
			learnEnglishWordsModel.setId(wordId);
			learnEnglishWordsModel.setAddtime(DateUtil.getNow());
			learnEnglishWordsModel.setAdduser(usercode);
			learnEnglishWordsModel.setWord(word);
			learnEnglishWordsModel.setType(learnParamModel.getWordType());
			learnEnglishWordsModel.setDefinition(BaiduTranslate.getBaiduTranslateZh(word));
			Map<String, String> baiduVoice = BaiduVoice.getBaiduVoice(wordId, word, usercode, learnParamModel.getWordType());
			String path = baiduVoice.get("path");
			learnEnglishWordsModel.setMp3path(path);
			if (learnParamModel.getWordType().equals("word")) {
				Map<String, String> wordMap = WordUtils.getWordMap(word);
				String usAudio = wordMap.get("usAudio");
				String ukAudio = wordMap.get("ukAudio");
				String ukPronunciations = wordMap.get("ukPronunciations");
				String usPronunciations = wordMap.get("usPronunciations");
				String definition = wordMap.get("definition");
				learnEnglishWordsModel.setUsAudio(usAudio);
				learnEnglishWordsModel.setUkAudio(ukAudio);
				learnEnglishWordsModel.setUkPronunciation(ukPronunciations);
				learnEnglishWordsModel.setUsPronunciation(usPronunciations);
				learnEnglishWordsModel.setDefinition(definition);
			}
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
			String now4 = DateUtil.getNow4();
			String usercode = learnEnglishModel.getUsercode();
			LearnEnglishModel selectByTimeClass = learnEnglishDao.selectByTimeClass(now4, usercode);
			if (selectByTimeClass == null) {
				learnEnglishModel.setId(Util.getUUId16());
				learnEnglishModel.setDiary(DateUtil.getNow());
				learnEnglishModel.setTimeclass(now4);
				learnEnglishModel.setHeadline(DateUtil.getNow6());
				learnEnglishModel.setUsercode(usercode);
				learnEnglishDao.insertSelective(learnEnglishModel);
			}

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

	@Override
	public void updateWord(LearnEnglishWordsModel learnEnglishWordsModel) {
		try {
			String id = learnEnglishWordsModel.getId();
			LearnEnglishWordsModel old = learnEnglishWordsDao.selectByPrimaryKey(id);
			String word = learnEnglishWordsModel.getWord();
			Map<String, String> baiduVoice = BaiduVoice.getBaiduVoice(id, word, learnEnglishWordsModel.getAdduser(), old.getType());
			String path = baiduVoice.get("path");
			learnEnglishWordsModel.setMp3path(path);
			HttpServletRequest request = SpringWebUtil.getRequest();
			learnEnglishWordsModel.setDefinition(BaiduTranslate.getBaiduTranslateZh(word));
			learnEnglishWordsModel.setMp3url(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/" + "learn/getVoice?id=" + id);
			if (old.getType().equals("word")) {
				Map<String, String> wordMap = WordUtils.getWordMap(word);
				String usAudio = wordMap.get("usAudio");
				String ukAudio = wordMap.get("ukAudio");
				String ukPronunciations = wordMap.get("ukPronunciations");
				String usPronunciations = wordMap.get("usPronunciations");
				String definition = wordMap.get("definition");
				learnEnglishWordsModel.setUsAudio(usAudio);
				learnEnglishWordsModel.setUkAudio(ukAudio);
				learnEnglishWordsModel.setUsPronunciation(usPronunciations);
				learnEnglishWordsModel.setUkPronunciation(ukPronunciations);
				learnEnglishWordsModel.setDefinition(definition);
			}
			learnEnglishWordsDao.updateByPrimaryKeySelective(learnEnglishWordsModel);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void updateInterpretayion(LearnEnglishInterpretayionModel learnEnglishInterpretayionModel) {
		try {
			List<SystemDataModel> systemDataModels = getSystemData("PARTOFSPEECH");
			String wordInterpretayion = toClean(learnEnglishInterpretayionModel.getWordinterpretation(), systemDataModels);
			learnEnglishInterpretayionModel.setWordinterpretation(wordInterpretayion);
			learnEnglishInterpretayionDao.updateByPrimaryKeySelective(learnEnglishInterpretayionModel);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<LearnEnglishModel> getCountByUser(String usercode) {
		return learnEnglishDao.getCountByUser(usercode);
	}

	@Override
	public List<LearnEnglishModel> getLearnsByUserAndNumber(String usercode, int number) {
		return learnEnglishDao.selectListByUser(usercode, number);
	}

	@Override
	public List<LearnEnglishWordsModel> getWordsByUser(String usercode, int number) {

		List<String> ids = new ArrayList<>();
		List<LearnEnglishModel> learns = learnEnglishDao.selectListByUser(usercode, number);
		for (LearnEnglishModel learnEnglishModel : learns) {
			List<LearnRelationModel> selectBylearnid = learnRelationDao.selectBylearnid(learnEnglishModel.getId());
			for (LearnRelationModel learnRelationModel : selectBylearnid) {
				ids.add(learnRelationModel.getWordid());
			}
		}
		return getWords(ids);
	}

	private List<LearnEnglishWordsModel> getWords(List<String> ids) {
		List<LearnEnglishWordsModel> newLearnEnglishWordsModels = new ArrayList<>();
		if (ids.size() == 0) {
			return newLearnEnglishWordsModels;
		}
		List<LearnEnglishWordsModel> learnEnglishWordsModels = new ArrayList<>();

		learnEnglishWordsModels.addAll(learnEnglishWordsDao.selectByIds(ids));
		for (LearnEnglishWordsModel learnEnglishWordsModel : learnEnglishWordsModels) {
			StringBuffer buffer = new StringBuffer();
			int j = 1;
			List<LearnEnglishInterpretayionModel> interpretayionModels = learnEnglishInterpretayionDao.selectBywordId(learnEnglishWordsModel.getId());
			for (LearnEnglishInterpretayionModel model : interpretayionModels) {
				String wordinterpretation = model.getWordinterpretation();
				if (!Str.isEmpty(model.getWordtype())) {
					buffer.append("<span style='margin-bottom: 10px;'><b style='color: #666'>" + model.getWordtype() + "&nbsp;&nbsp;</b><span style='color: #333'>" + wordinterpretation + "</span></span><br>");
				} else {
					buffer.append("<span style='margin-bottom: 10px;margin-left: 30px;'><b style='color: #666'>" + j + ".&nbsp;&nbsp;</b><span style='color: #333'>" + wordinterpretation + "</span></span><br>");
					j++;
				}
			}
			learnEnglishWordsModel.setDefinition(buffer.toString());
			newLearnEnglishWordsModels.add(learnEnglishWordsModel);
		}
		return newLearnEnglishWordsModels;
	}

	@Override
	public int getWordsCountByUser(String usercode, int number) {
		List<String> ids = new ArrayList<>();
		List<LearnEnglishModel> learns = learnEnglishDao.selectListByUser(usercode, number);
		for (LearnEnglishModel learnEnglishModel : learns) {
			List<LearnRelationModel> selectBylearnid = learnRelationDao.selectBylearnid(learnEnglishModel.getId());
			for (LearnRelationModel learnRelationModel : selectBylearnid) {
				ids.add(learnRelationModel.getWordid());
			}
		}
		return ids.size();
	}

	private String toClean(String str, List<SystemDataModel> systemData) {
		str = str.replace(" ", "");
		if (str.contains("adv.")) {
			str = str.replace("adv.", "");
			return str;
		}
		if (str.contains("pron.")) {
			str = str.replace("pron.", "");
			return str;
		}
		if (str.contains("vt.&vi.")) {
			str = str.replace("vt.&vi.", "");
			return str;
		}
		for (SystemDataModel systemDataModel : systemData) {
			String itemNo = systemDataModel.getItemNo();
			if (str.contains(itemNo)) {

				str = str.replace(itemNo, "");
			}
		}
		return str;
	}

	private String getWordType(String str, List<SystemDataModel> systemData) {
		str = str.replace(" ", "");
		if (str.contains("adv.")) {
			str = "adv.";
			return str;
		} else if (str.contains("pron.")) {
			str = "pron.";
			return str;
		}
		if (str.contains("vt.&vi.")) {
			str = "vt.&vi.";
			return str;
		}
		for (SystemDataModel systemDataModel : systemData) {
			String itemNo = systemDataModel.getItemNo();
			if (str.contains(itemNo)) {
				str = itemNo;
			}
		}
		return str;
	}

	@Override
	public Map<LearnEnglishModel, String> getDayLearns(String usercode, int pageSize, int pageCount) {
		int number = pageSize * pageCount;

		Map<LearnEnglishModel, String> map = new TreeMap<LearnEnglishModel, String>(new Comparator<LearnEnglishModel>() {

			@Override
			public int compare(LearnEnglishModel o1, LearnEnglishModel o2) {
				return o2.getDiary().compareTo(o1.getDiary());
			}
		});
		List<LearnEnglishModel> selectListByUser = learnEnglishDao.selectListByUser(usercode, number);
		for (LearnEnglishModel learnEnglishModel : selectListByUser) {
			List<String> ids = new ArrayList<>();
			int word = 0, phrase = 0, sentence = 0, article = 0;
			List<LearnRelationModel> selectBylearnid = learnRelationDao.selectBylearnid(learnEnglishModel.getId());
			for (LearnRelationModel learnRelationModel : selectBylearnid) {
				if (!ids.contains(learnRelationModel.getWordid())) {
					ids.add(learnRelationModel.getWordid());
				}
			}
			if (ids.size() == 0) {
				map.put(learnEnglishModel, "单词<b>" + word + "</b>个，" + "词组<b>" + phrase + "</b>个，" + "句子<b>" + sentence + "</b>个，文章<b>" + article + "</b>篇。");

			} else {

				List<LearnEnglishWordsModel> selectByIdsAll = learnEnglishWordsDao.selectByIdsAll(ids);
				for (LearnEnglishWordsModel learnEnglishWordsModel : selectByIdsAll) {
					if (learnEnglishWordsModel.getType().equals("word")) {
						word++;
					}
					if (learnEnglishWordsModel.getType().equals("phrase")) {
						phrase++;
					}
					if (learnEnglishWordsModel.getType().equals("sentence")) {
						sentence++;
					}
					if (learnEnglishWordsModel.getType().equals("article")) {
						article++;
					}
				}

			}
			map.put(learnEnglishModel, "单词<b>" + word + "</b>个，" + "词组<b>" + phrase + "</b>个，" + "句子<b>" + sentence + "</b>个，文章<b>" + article + "</b>篇。");
		}
		return map;
	}

	@Override
	public LearnEnglishModel getLearnEnglishModelById(String id) {
		return learnEnglishDao.selectByPrimaryKey(id);
	}

	@Override
	public List<LearnEnglishWordsModel> getWordsByLearn(String learnId) {
		List<LearnRelationModel> selectBylearnid = learnRelationDao.selectBylearnid(learnId);
		List<String> ids = new ArrayList<>();
		for (LearnRelationModel learnRelationModel : selectBylearnid) {
			if (!ids.contains(learnRelationModel.getWordid())) {
				ids.add(learnRelationModel.getWordid());
			}
		}
		if (ids.size() == 0) {
			return new ArrayList<>();
		}
		List<LearnEnglishWordsModel> selectByIdsAll = learnEnglishWordsDao.selectByIdsAll(ids);
		return selectByIdsAll;
	}

	@Override
	public LearnEnglishWordsModel getWordInfo(String word) {
		LearnEnglishWordsModel learnEnglishWordsModel = learnEnglishWordsDao.selectByWord(word);
		List<LearnEnglishInterpretayionModel> interpretayionModels = learnEnglishInterpretayionDao.selectBywordId(learnEnglishWordsModel.getId());
		StringBuffer buffer = new StringBuffer();
		int j = 1;
		for (LearnEnglishInterpretayionModel learnEnglishInterpretayionModel : interpretayionModels) {
			String wordinterpretation = learnEnglishInterpretayionModel.getWordinterpretation();
			if (!Str.isEmpty(learnEnglishInterpretayionModel.getWordtype())) {
				buffer.append("<span style='margin-bottom: 10px;'><b style='color: #666'>" + learnEnglishInterpretayionModel.getWordtype() + "&nbsp;&nbsp;</b><span style='color: #333'>" + wordinterpretation + "</span></span><br>");
			} else {
				buffer.append("<span style='margin-bottom: 10px;margin-left: 30px;'><b style='color: #666'>" + j + ".&nbsp;&nbsp;</b><span style='color: #333'>" + wordinterpretation + "</span></span><br>");
				j++;
			}
		}
		learnEnglishWordsModel.setDefinition(buffer.toString());
		return learnEnglishWordsModel;
	}

	@Override
	public List<LearnEnglishModel> getDaysByUser(String usercode, int number) {
		return learnEnglishDao.getDaysByUser(usercode, number);
	}

	@Override
	public List<LearnEnglishWordsModel> getWordsByLearnId(String id) {
		List<String> ids = new ArrayList<>();
		List<LearnRelationModel> selectBylearnid = learnRelationDao.selectBylearnid(id);
		for (LearnRelationModel learnRelationModel : selectBylearnid) {
			ids.add(learnRelationModel.getWordid());
		}
		return getWords(ids);
	}

}
