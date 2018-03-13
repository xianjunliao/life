package com.life.pc.controller;

import java.io.IOException;
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
import com.life.common.baidu.BaiduTranslate;
import com.life.common.baidu.BaiduVoice;
import com.life.common.file.FileUtils;
import com.life.common.shanbei.WordUtils;
import com.life.common.util.DESUtil;
import com.life.pc.common.WebUtils;
import com.life.pc.model.LearnEnglishInterpretayionModel;
import com.life.pc.model.LearnEnglishModel;
import com.life.pc.model.LearnEnglishWordsModel;
import com.life.pc.model.LearnParamModel;
import com.life.pc.model.LifeUserModel;
import com.life.pc.model.SystemDataModel;
import com.life.pc.service.LearningService;

@Controller
@RequestMapping("learn")
public class LearningController {
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "learn/";

	@Autowired
	private LearningService learningService;

	@SuppressWarnings("unchecked")
	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request) throws ServletException, IOException {
		try {
			
			Map<String, Object> words = learningService.getWords(WebUtils.getUserCode(request),5);
			List<SystemDataModel> systemDataModels = (List<SystemDataModel>) words.get("wordTypes");
			Map<LearnEnglishModel, Map<SystemDataModel, List<LearnEnglishWordsModel>>> learns = (Map<LearnEnglishModel, Map<SystemDataModel, List<LearnEnglishWordsModel>>>) words.get("learnEnglish");
			Map<String, List<LearnEnglishInterpretayionModel>> interpretayion = (Map<String, List<LearnEnglishInterpretayionModel>>) words.get("interpretayion");
			Map<LearnEnglishModel, Integer>  learnEnglishModels = (Map<LearnEnglishModel, Integer>) words.get("learns");
			List<SystemDataModel> partOfSpeech = learningService.getSystemData("PARTOFSPEECH");
			model.put("wordTypes", systemDataModels);
			model.put("learns", learns);
			model.put("partOfSpeech", partOfSpeech);
			model.put("timeClass", learnEnglishModels);
			model.put("interpretayion", interpretayion);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + pageName + ".jsp";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/showNow")
	public String showNow(int number,ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, Object> words = learningService.getWords(WebUtils.getUserCode(request),number);
		List<SystemDataModel> systemDataModels = (List<SystemDataModel>) words.get("wordTypes");
		Map<LearnEnglishModel, Map<SystemDataModel, List<LearnEnglishWordsModel>>> learns = (Map<LearnEnglishModel, Map<SystemDataModel, List<LearnEnglishWordsModel>>>) words.get("learnEnglish");
		Map<String, List<LearnEnglishInterpretayionModel>> interpretayion = (Map<String, List<LearnEnglishInterpretayionModel>>) words.get("interpretayion");
		Map<LearnEnglishModel, Integer>  learnEnglishModels = (Map<LearnEnglishModel, Integer>) words.get("learns");
		List<SystemDataModel> partOfSpeech = learningService.getSystemData("PARTOFSPEECH");
		model.put("wordTypes", systemDataModels);
		model.put("learns", learns);
		model.put("partOfSpeech", partOfSpeech);
		model.put("timeClass", learnEnglishModels);
		model.put("interpretayion", interpretayion);
		return FTL_DIR+"ENG_listen.jsp";
	}
	@RequestMapping(path = { "/getVoice" }, method = { RequestMethod.GET })
	public void getVoice(String id,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			LearnEnglishWordsModel learnEnglishWordsModel = learningService.getLearnEnglishWordsModel(id);
			String fileName = learnEnglishWordsModel.getType()+"_"+BaiduVoice.replaceFilesStr(learnEnglishWordsModel.getWord())+".mp3";
			FileUtils.FilesDownload_stream(request, response, fileName, learnEnglishWordsModel.getMp3path(), "audio/mp3");
		} catch (Exception e) {

		}
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
	public ResponseMessage<LearnEnglishModel> deletelvv(String lid,String wid, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
	public ResponseMessage<LearnEnglishModel> updateWord(String id,String text, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
	public ResponseMessage<LearnEnglishModel> updateItv(String id,String text, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
	public ResponseMessage<String> translate(String type,String text, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			String translateAfter=text;
			if(type.equals("bd")){
			translateAfter = BaiduTranslate.getBaiduTranslateZh(text);
			}else if (type.equals("sb")) {
				translateAfter=WordUtils.getWordMap(text).get("definition");
			}
			outMSG.setData(translateAfter);
			outMSG.setCode("200");
		} catch (Exception e) {
			outMSG.setCode("209");
		}
		return outMSG;
	}
}
