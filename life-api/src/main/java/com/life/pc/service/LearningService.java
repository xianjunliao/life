package com.life.pc.service;

import java.util.List;
import java.util.Map;

import com.life.pc.model.LearnEnglishInterpretayionModel;
import com.life.pc.model.LearnEnglishModel;
import com.life.pc.model.LearnEnglishWordsModel;
import com.life.pc.model.LearnParamModel;
import com.life.pc.model.SystemDataModel;

public interface LearningService {

	public Map<String, Object> getWords(String usercode, int number);

	public void addLearnRecord(LearnParamModel learnParamModel);

	public List<SystemDataModel> getSystemData(String indexes);

	public Map<String, Object> getLearns(String usercode);

	public LearnEnglishWordsModel getLearnEnglishWordsModel(String id);

	public void addLearnTime(LearnEnglishModel learnEnglishModel);

	public void deleteItv(String id);

	public void deletelvv(String lid, String wid);

	public void updateWord(LearnEnglishWordsModel learnEnglishWordsModel);

	public void updateInterpretayion(LearnEnglishInterpretayionModel learnEnglishInterpretayionModel);

	List<LearnEnglishModel> getCountByUser(String usercode);
	
	List<LearnEnglishModel> getLearnsByUserAndNumber(String usercode, int number);
	
	List<LearnEnglishWordsModel> getWordsByUser(String usercode, int number);
	
	List<LearnEnglishWordsModel> getWordsByLearnId(String id);
	
	int getWordsCountByUser(String usercode, int number);
	
	Map<LearnEnglishModel, String> getDayLearns(String usercode, int pageSize,int pageCount);
	
	LearnEnglishModel getLearnEnglishModelById(String id);
	
	public List<LearnEnglishWordsModel> getWordsByLearn(String learnId,String type);
	
	public LearnEnglishWordsModel getWordInfo(String word);
	
    List<LearnEnglishModel> getDaysByUser(String usercode, int number);
    
    List<LearnEnglishInterpretayionModel> selectBywordId(String wordId);
	
}
