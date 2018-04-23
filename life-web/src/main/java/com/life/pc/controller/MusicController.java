package com.life.pc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.life.common.ResponseMessage;
import com.life.common.Str;
import com.life.common.file.FileUtils;
import com.life.pc.common.WebUtils;
import com.life.pc.model.MusicStandModel;
import com.life.pc.service.MusicStandService;

@Controller
@RequestMapping("music")
public class MusicController {
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "music/";

	@Autowired
	private MusicStandService musicStandService;

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, ModelMap model, HttpServletRequest request)
			throws ServletException, IOException {
		try {
			String userCode = WebUtils.getUserCode(request);
			List<MusicStandModel> models = musicStandService.selectByTop(userCode);
			int len = models.size();
			if (len > 0) {
				model.put("musicname", models.get(0).getMusicname());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + pageName + ".jsp";
	}

	@RequestMapping("/openScore")
	public String openPage(String name, ModelMap model, HttpServletRequest request)
			throws ServletException, IOException {
		try {
			if (name.equals("top")) {
				String userCode = WebUtils.getUserCode(request);
				List<MusicStandModel> models = musicStandService.selectByTop(userCode);
				int len = models.size();
				if (len == 0) {
					name = null;
				} else {
					name = models.get(0).getMusicname();
				}
			}
			model.put("musicname", name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + "open_stand.jsp";
	}

	@RequestMapping("/printScore")
	public String printScore(String id, ModelMap model, HttpServletRequest request)
			throws ServletException, IOException {
		try {
			MusicStandModel musicStandModel = musicStandService.selectByPrimaryKey(id);
			model.put("sf", musicStandModel);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return FTL_DIR + "print_stand.jsp";
	}

	@RequestMapping(path = { "/getScore" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<List<MusicStandModel>> getScore(String name, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<List<MusicStandModel>> outMSG = new ResponseMessage<>();
		try {
			if (Str.isEmpty(name)) {
				outMSG.setCode("201");
				outMSG.setMessage("请输入乐谱名！");
				return outMSG;
			}
			String userCode = WebUtils.getUserCode(request);
			List<MusicStandModel> models = musicStandService.selectByName(name, userCode);
			if (models.size() > 0) {
				outMSG.setData(models);
				outMSG.setCode("200");
				outMSG.setMessage("【" + name + "】乐谱有" + models.size() + "张图片！");
			} else {
				outMSG.setData(models);
				outMSG.setCode("201");
				outMSG.setMessage("还没有上传过【" + name + "】乐谱！");
			}
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("查询出现异常！");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getTop" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<List<MusicStandModel>> getTop(HttpServletResponse response, HttpServletRequest request)
			throws ServletException, IOException {
		ResponseMessage<List<MusicStandModel>> outMSG = new ResponseMessage<>();
		try {

			String userCode = WebUtils.getUserCode(request);
			List<MusicStandModel> models = musicStandService.selectByTop(userCode);
			if (models.size() == 0) {
				outMSG.setData(null);
				outMSG.setCode("201");
				return outMSG;
			}
			outMSG.setData(models);
			outMSG.setCode("200");
			outMSG.setMessage("查询成功！");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("查询出现异常！");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/getAll" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<List<MusicStandModel>> getAll(HttpServletResponse response, HttpServletRequest request)
			throws ServletException, IOException {
		ResponseMessage<List<MusicStandModel>> outMSG = new ResponseMessage<>();
		try {

			String userCode = WebUtils.getUserCode(request);
			List<MusicStandModel> models = musicStandService.selectByUser(userCode);
			if (models.size() == 0) {
				outMSG.setData(null);
				outMSG.setCode("201");
				return outMSG;
			}
			outMSG.setData(models);
			outMSG.setCode("200");
			outMSG.setMessage("查询成功！");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("查询出现异常！");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/addScore" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<String[]> uploadFile(@RequestParam("file") MultipartFile file,
			MusicStandModel musicStandModel, String nextname, String index, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<String[]> outMSG = new ResponseMessage<>();
		musicStandModel.setUsercode(WebUtils.getUserCode(request));
		int insertSelective = musicStandService.insertSelective(file, musicStandModel);
		String[] data = new String[2];
		data[0] = nextname;
		data[1] = index;
		if (insertSelective == 1) {
			outMSG.setData(data);
			outMSG.setCode("200");
		} else {
			outMSG.setCode("209");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/score" }, method = { RequestMethod.GET })
	public void fileDownload(String id, HttpServletResponse response, HttpServletRequest request)
			throws ServletException, IOException {
		MusicStandModel model = musicStandService.selectByPrimaryKey(id);
		FileUtils.FilesDownload_stream(request, response, model.getFilename(), model.getFilepath(), "image/jpeg");
	}

	@RequestMapping(path = { "/toTop" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<String> toTop(String name, boolean isTo, HttpServletResponse response,
			HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			String userCode = WebUtils.getUserCode(request);
			List<MusicStandModel> models = musicStandService.selectByName(name, userCode);
			if (models.size() == 0) {
				outMSG.setCode("201");
				outMSG.setMessage("还没有上传过【" + name + "】乐谱，无法置顶！");
				return outMSG;
			}
			if (isTo) {
				musicStandService.toTopAfter(name, userCode);
				outMSG.setCode("200");
				outMSG.setMessage("置顶成功");
			}else{
				musicStandService.toTopBefore(userCode);
				outMSG.setCode("200");
				outMSG.setMessage("取消置顶成功");
			}
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("置顶出现异常！");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/delete" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<String> delete(String id, HttpServletResponse response, HttpServletRequest request)
			throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			int deleteByPrimaryKey = musicStandService.deleteByPrimaryKey(id);
			if (deleteByPrimaryKey == 0) {
				outMSG.setCode("209");
				outMSG.setMessage("删除出现异常！");
				return outMSG;
			}
			outMSG.setCode("200");
			outMSG.setMessage("删除成功!");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("删除出现异常！");
		}
		return outMSG;
	}

	@RequestMapping(path = { "/deleteByName" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<String> deleteByName(String name, HttpServletResponse response, HttpServletRequest request)
			throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			String userCode = WebUtils.getUserCode(request);
			musicStandService.deleteByName(name, userCode);
			outMSG.setCode("200");
			outMSG.setMessage("删除成功!");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("删除出现异常！");
		}
		return outMSG;
	}
}
