package com.life.pc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.life.common.ResponseMessage;
import com.life.common.Str;
import com.life.common.baidu.BaiduTranslate;
import com.life.common.baidu.BaiduVoice;
import com.life.common.file.FileUtils;
import com.life.common.shanbei.WordUtils;
import com.life.pc.common.WebUtils;
import com.life.pc.model.LearnEnglishInterpretayionModel;
import com.life.pc.model.LearnEnglishModel;
import com.life.pc.model.LearnEnglishWordsModel;
import com.life.pc.model.LearnParamModel;
import com.life.pc.model.LifeUserModel;
import com.life.pc.model.SystemDataModel;
import com.life.pc.service.LearningService;
import com.life.pc.service.LifeUserService;

@Controller
@RequestMapping("learn")
public class LearningController {
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "learn/";

	@Autowired
	private LearningService learningService;

	@Autowired
	private LifeUserService lifeUserService;

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request) throws ServletException, IOException {
		try {
			List<SystemDataModel> systemDataModels = learningService.getSystemData("WORDTYPE");
			List<SystemDataModel> partOfSpeech = learningService.getSystemData("PARTOFSPEECH");
			model.put("partOfSpeech", partOfSpeech);
			model.put("wordTypes", systemDataModels);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + pageName + ".jsp";
	}

	@RequestMapping("/mob")
	public String mob(Integer idx, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userCode = WebUtils.getUserCode(request);
		LifeUserModel checkEnterCode = lifeUserService.checkEnterCode(userCode);
		int dailyLearnRow = Str.isEmpty(checkEnterCode.getDailyLearnRow()) ? 365 * 3 : Integer.parseInt(checkEnterCode.getDailyLearnRow());
		List<LearnEnglishModel> learnsByUserAndNumber = learningService.getDaysByUser(userCode, dailyLearnRow);
		List<SystemDataModel> systemDataModels = learningService.getSystemData("WORDTYPE");
		model.put("dayLearns", learnsByUserAndNumber);
		model.put("wordTypes", systemDataModels);
		LifeUserModel userModel = lifeUserService.checkEnterCode(userCode);
		model.put("userInfo", userModel);
		if (idx == null) {
			idx = 0;
		}
		model.put("idx", idx);
		return "MOBIndex.jsp";
	}

	@RequestMapping("/dayLearns")
	public String dayLearns(String id,String tabIndex, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<SystemDataModel> systemDataModels = learningService.getSystemData("WORDTYPE");
		LearnEnglishModel learnEnglishModelById = learningService.getLearnEnglishModelById(id);
		List<LearnEnglishWordsModel> wordsByLearn = learningService.getWordsByLearn(id);
		model.put("wordTypes", systemDataModels);
		model.put("learn", learnEnglishModelById);
		model.put("words", wordsByLearn);
		Map<String, Integer> wordsByType = getWordsByType(wordsByLearn);
		model.put("word", wordsByType.get("word"));
		model.put("phrase", wordsByType.get("phrase"));
		model.put("sentence", wordsByType.get("sentence"));
		model.put("article", wordsByType.get("article"));
		return "mobile/dayLearns.jsp";
	}

	private Map<String, Integer> getWordsByType(List<LearnEnglishWordsModel> list) {
		Map<String, Integer> map = new HashMap<>();
		int word = 0, phrase = 0, sentence = 0, article = 0;
		for (LearnEnglishWordsModel learnEnglishWordsModel : list) {
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
		map.put("word", word);
		map.put("phrase", phrase);
		map.put("sentence", sentence);
		map.put("article", article);
		return map;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/showNow")
	public String showNow(int number, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userCode = WebUtils.getUserCode(request);
		Map<String, Object> words = learningService.getWords(WebUtils.getUserCode(request), number);
		List<SystemDataModel> systemDataModels = (List<SystemDataModel>) words.get("wordTypes");
		Map<LearnEnglishModel, Map<SystemDataModel, List<LearnEnglishWordsModel>>> learns = (Map<LearnEnglishModel, Map<SystemDataModel, List<LearnEnglishWordsModel>>>) words.get("learnEnglish");
		Map<String, List<LearnEnglishInterpretayionModel>> interpretayion = (Map<String, List<LearnEnglishInterpretayionModel>>) words.get("interpretayion");
		Map<LearnEnglishModel, Integer> learnEnglishModels = (Map<LearnEnglishModel, Integer>) words.get("learns");
		List<SystemDataModel> partOfSpeech = learningService.getSystemData("PARTOFSPEECH");
		List<LearnEnglishModel> countByUser = learningService.getCountByUser(userCode);
		model.put("wordTypes", systemDataModels);
		model.put("learns", learns);
		model.put("partOfSpeech", partOfSpeech);
		model.put("timeClass", learnEnglishModels);
		model.put("interpretayion", interpretayion);
		model.put("countClass", countByUser);
		return FTL_DIR + "ENG_listen.jsp";
	}

	@RequestMapping("/wordShorthand")
	public String wordShorthand(int number, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userCode = WebUtils.getUserCode(request);
		List<LearnEnglishWordsModel> learnEnglishWordsModels = learningService.getWordsByUser(userCode, number);
		model.put("words", learnEnglishWordsModels);
		return FTL_DIR + "ENG_read.jsp";
	}

	@RequestMapping("/wordFast")
	public String wordFast(String id, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<LearnEnglishWordsModel> learnEnglishWordsModels = learningService.getWordsByLearnId(id);
		model.put("words", learnEnglishWordsModels);
		return FTL_DIR + "ENG_read.jsp";
	}

	@RequestMapping(path = { "/getVoice" }, method = { RequestMethod.GET })
	public void getVoice(String id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			LearnEnglishWordsModel learnEnglishWordsModel = learningService.getLearnEnglishWordsModel(id);
			String fileName = learnEnglishWordsModel.getType() + "_" + BaiduVoice.replaceFilesStr(learnEnglishWordsModel.getWord()) + ".mp3";
			FileUtils.FilesDownload_stream(request, response, fileName, learnEnglishWordsModel.getMp3path(), "audio/mp3");
		} catch (Exception e) {

		}
	}

	@ResponseBody
	@RequestMapping("getWordCount")
	public ResponseMessage<Integer> getWordCount(int number, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<Integer> outMSG = new ResponseMessage<>();
		try {
			int wordsCountByUser = learningService.getWordsCountByUser(WebUtils.getUserCode(request), number);
			outMSG.setCode("200");
			outMSG.setData(wordsCountByUser);
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("getWordInfo")
	public ResponseMessage<LearnEnglishWordsModel> getWordInfo(String word, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LearnEnglishWordsModel> outMSG = new ResponseMessage<>();
		try {
			LearnEnglishWordsModel wordInfo = learningService.getWordInfo(word);
			outMSG.setData(wordInfo);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("getDays")
	public ResponseMessage<List<LearnEnglishModel>> getDays(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<List<LearnEnglishModel>> outMSG = new ResponseMessage<>();
		try {
			String usercode = WebUtils.getUserCode(request);
			LifeUserModel checkEnterCode = lifeUserService.checkEnterCode(usercode);
			int dailyLearnRow = Str.isEmpty(checkEnterCode.getDailyLearnRow()) ? 365 * 3 : Integer.parseInt(checkEnterCode.getDailyLearnRow());
			List<LearnEnglishModel> learnsByUserAndNumber = learningService.getDaysByUser(usercode, dailyLearnRow);
			outMSG.setData(learnsByUserAndNumber);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("getWords")
	public ResponseMessage<List<LearnEnglishWordsModel>> getWords(String id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<List<LearnEnglishWordsModel>> outMSG = new ResponseMessage<>();
		try {
			List<LearnEnglishWordsModel> wordsByLearn = learningService.getWordsByLearn(id);
			outMSG.setData(wordsByLearn);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("getInts")
	public ResponseMessage<List<LearnEnglishInterpretayionModel>> getInts(String id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<List<LearnEnglishInterpretayionModel>> outMSG = new ResponseMessage<>();
		try {
			List<LearnEnglishInterpretayionModel> selectBywordId = learningService.selectBywordId(id);
			outMSG.setData(selectBywordId);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("addLearn")
	public ResponseMessage<LearnParamModel> addLearn(LearnParamModel learnParamModel, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LearnParamModel> outMSG = new ResponseMessage<>();
		try {
			learnParamModel.setUsercode(WebUtils.getUserCode(request));
			learningService.addLearnRecord(learnParamModel);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("getTimeClass")
	public List<LearnEnglishModel> getTimeClass(int number, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<LearnEnglishModel> learnEnglishModels = new ArrayList<>();
		try {
			learnEnglishModels = learningService.getLearnsByUserAndNumber(WebUtils.getUserCode(request), number);
		} catch (Exception e) {

		}
		return learnEnglishModels;
	}

	@ResponseBody
	@RequestMapping("addLearnTime")
	public ResponseMessage<LearnEnglishModel> addLearnTime(LearnEnglishModel learnEnglishModel, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LearnEnglishModel> outMSG = new ResponseMessage<>();
		try {
			learnEnglishModel.setUsercode(WebUtils.getUserCode(request));
			learningService.addLearnTime(learnEnglishModel);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("deleteItv")
	public ResponseMessage<LearnEnglishModel> deleteItv(String id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LearnEnglishModel> outMSG = new ResponseMessage<>();
		try {
			learningService.deleteItv(id);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("deletelvv")
	public ResponseMessage<LearnEnglishModel> deletelvv(String lid, String wid, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LearnEnglishModel> outMSG = new ResponseMessage<>();
		try {
			learningService.deletelvv(lid, wid);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("updateWord")
	public ResponseMessage<LearnEnglishModel> updateWord(String id, String text, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LearnEnglishModel> outMSG = new ResponseMessage<>();
		try {
			LearnEnglishWordsModel learnEnglishWordsModel = new LearnEnglishWordsModel();
			learnEnglishWordsModel.setId(id);
			learnEnglishWordsModel.setWord(text);
			learnEnglishWordsModel.setAdduser(WebUtils.getUserCode(request));
			learningService.updateWord(learnEnglishWordsModel);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("updateItv")
	public ResponseMessage<LearnEnglishModel> updateItv(String id, String text, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LearnEnglishModel> outMSG = new ResponseMessage<>();
		try {
			LearnEnglishInterpretayionModel learnEnglishInterpretayionModel = new LearnEnglishInterpretayionModel();
			learnEnglishInterpretayionModel.setId(id);
			learnEnglishInterpretayionModel.setWordinterpretation(text);
			learningService.updateInterpretayion(learnEnglishInterpretayionModel);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("translate")
	public ResponseMessage<String> translate(String type, String text, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			String translateAfter = text;
			if (type.equals("bd")) {
				translateAfter = BaiduTranslate.getBaiduTranslateZh(text);
			} else if (type.equals("CN")) {
				translateAfter = BaiduTranslate.getBaiduTranslateZh(text);
			} else if (type.equals("EN")) {
				translateAfter = BaiduTranslate.getBaiduTranslateEn(text);
			} else if (type.equals("SB")) {
				translateAfter = WordUtils.getWordMap(text).get("definition");
			}
			outMSG.setData(translateAfter);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}
}
