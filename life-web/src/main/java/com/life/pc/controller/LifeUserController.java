package com.life.pc.controller;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.life.common.ResponseMessage;
import com.life.common.Str;
import com.life.common.SystemGet;
import com.life.common.Util;
import com.life.common.time.DateUtil;
import com.life.common.util.DESUtil;
import com.life.pc.common.WebUtils;
import com.life.pc.model.FileUserModel;
import com.life.pc.model.LearnEnglishModel;
import com.life.pc.model.LifeUserModel;
import com.life.pc.model.TreeModel;
import com.life.pc.service.FileUserService;
import com.life.pc.service.LearningService;
import com.life.pc.service.LifeUserService;
import com.life.pc.service.TreeService;

@Controller
public class LifeUserController {

	@Resource(name = "lifeUserService")
	private LifeUserService lifeUserService;

	@Autowired
	private TreeService treeService;

	@Autowired
	private FileUserService fileUserService;

	@Autowired
	private LearningService learningService;
	/**
	 * 模板存放目录
	 */
	private final static String FTL_DIR = "/";

	@ResponseBody
	@RequestMapping("enterCode")
	public LifeUserModel enterCode(String code, HttpServletRequest request, HttpServletResponse response) throws Exception {
		code = DESUtil.encryptDES(code);
		LifeUserModel lifeUserModel = lifeUserService.checkEnterCode(code);
		WebUtils.newSession(lifeUserModel, request);
		return lifeUserModel;
	}

	@RequestMapping("/{pageName}")
	public String page(@PathVariable("pageName") String pageName, @ModelAttribute("params") LifeUserModel params, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			LifeUserModel attribute = WebUtils.getUserInfo(request);
			try {
				initData(model, attribute);
				if (pageName.contains("test")) {
					return "error/" + pageName + ".jsp";
				}
//				if (SystemGet.getNowIp().contains("10.81")) {
//					return FTL_DIR + "main-false.jsp";
//				}
				if (UUID.fromString(pageName) != null) {
					return FTL_DIR + "main.jsp";
				}
			} catch (Exception e) {
				if (SystemGet.getNowIp().contains("192.168.1.101") || SystemGet.getNowIp().contains("47.91.252.134") || SystemGet.getNowIp().contains("www.liaoxianjun.com")) {
					return FTL_DIR + pageName + ".jsp";
				}else{
					return FTL_DIR + pageName + ".jsp";
				}
			}

		} catch (Exception e) {
			return "error/500.jsp";
		}
		return FTL_DIR + pageName + ".jsp";

	}

	private void initData(ModelMap model, LifeUserModel attribute) {
		TreeModel pTreeModel = new TreeModel();
		String userCode = attribute.getUsercode();
		pTreeModel.setUserCode(userCode);
		pTreeModel.setPid("0");
		List<TreeModel> pTree = treeService.getTree(pTreeModel);
		List<TreeModel> treeByUserCode = treeService.getTreeByUserCode(userCode);
		model.put("data", pTree);
		if (pTree.size() > 0) {
			model.put("initText", pTree.get(0).getText());
		}
		model.put("trees", treeByUserCode);
		LifeUserModel userModel = lifeUserService.checkEnterCode(userCode);
		model.put("userInfo", userModel);
	}

	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return FTL_DIR + "user/login.jsp";
	}

	@RequestMapping("/mobLogin")
	public String mobLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return "mobile/login.jsp";
	}

	@RequestMapping("/update")
	public String update(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LifeUserModel userModel = WebUtils.getUserInfo(request);
		LifeUserModel checkEnterCode = lifeUserService.checkEnterCode(userModel.getUsercode());
		String password = checkEnterCode.getPassword();
		String decryptDES = DESUtil.decryptDES(password);
		checkEnterCode.setPassword(decryptDES);
		model.put("userModel", checkEnterCode);
		return FTL_DIR + "user/update.jsp";
	}

	@RequestMapping("/regSkip")
	public String register(String step, String str, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!Str.isEmpty(str)) {
			String[] user = DESUtil.decryptDES(str).split(":");
			model.put("usercode", DESUtil.encryptDES(user[0]));
			model.put("usercodeShow", user[0]);
			model.put("username", user[1]);
			model.put("password", DESUtil.encryptDES(user[2]));
			model.put("str", str);
		}
		LifeUserModel userInfo = WebUtils.getUserInfo("add", request);
		if (null != userInfo) {
			model.put("usercode", userInfo.getUsercode());
		}
		return FTL_DIR + "user/" + step + ".jsp";
	}

	@RequestMapping("/fullLogin")
	public String fullLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return FTL_DIR + "user/fullLogin.jsp";
	}

	@RequestMapping("/updateHeadImg")
	public String updateHeadImg(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LifeUserModel userInfo = WebUtils.getUserInfo(request);
		model.put("userModel", userInfo);
		return FTL_DIR + "user/updateHead.jsp";
	}

	@ResponseBody
	@RequestMapping("/enter")
	public ResponseMessage<String> enter(String code, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			code = DESUtil.encryptDES(code);
			LifeUserModel lifeUserModel = lifeUserService.checkEnterCode(code);
			if (lifeUserModel == null) {
				outMSG.setCode("202");
				outMSG.setMessage("输入的身份编码不存在，请注册！");
			} else {
				LearnEnglishModel learnEnglishModel = new LearnEnglishModel();
				learnEnglishModel.setUsercode(code);
				learningService.addLearnTime(learnEnglishModel);
				WebUtils.newSession(lifeUserModel, request);
				String decryptDES = DESUtil.decryptDES(code);
				WebUtils.newCookie(decryptDES, response);
				String data = UUID.randomUUID().toString();
				outMSG.setData(data);
				outMSG.setCode("200");
				outMSG.setMessage("验证成功！");
			}
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("验证失败！");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("user/checkUserLogin")
	public ResponseMessage<LifeUserModel> checkUserLogin(LifeUserModel lifeUserModel, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		try {
			String username = lifeUserModel.getUsername();
			String password = lifeUserModel.getPassword();
			password = DESUtil.encryptDES(password);
			LifeUserModel returnResult = lifeUserService.checkEnterNameAndPassword(username, password);
			if (returnResult == null) {
				outMSG.setCode("202");
				outMSG.setMessage("用户名或密码错误！");
			} else {
				WebUtils.newSession(returnResult, request);
				LearnEnglishModel learnEnglishModel = new LearnEnglishModel();
				learnEnglishModel.setUsercode(returnResult.getUsercode());
				learningService.addLearnTime(learnEnglishModel);
				outMSG.setCode("200");
				outMSG.setMessage("登陆成功！");
			}
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("验证失败！");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("/exit")
	public ResponseMessage<LifeUserModel> exit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		try {
			WebUtils.deleteSession(request);
			WebUtils.deleteCookie(response);
			outMSG.setCode("200");
			outMSG.setMessage("退出成功！");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("退出失败！");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("user/update")
	public ResponseMessage<LifeUserModel> update(LifeUserModel lifeUserModel, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		try {
			String username = lifeUserModel.getUsername();
			LifeUserModel checkEnterName = lifeUserService.checkEnterName(username);
			LifeUserModel userInfo = WebUtils.getUserInfo(request);
			if (username.equals(userInfo.getUsername()) && checkEnterName != null) {
				outMSG.setCode("202");
				outMSG.setMessage("用户名已经存在，请换一个！");
				return outMSG;
			}
			lifeUserModel.setPassword(DESUtil.encryptDES(lifeUserModel.getPassword()));
			lifeUserModel.setUpdatetime(DateUtil.getNow());
			lifeUserService.update(lifeUserModel);
			outMSG.setCode("200");
			outMSG.setMessage("修改成功！");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("修改失败！");
		}
		return outMSG;
	}

	@RequestMapping("user/getDES")
	@ResponseBody
	public ResponseMessage<String> getDES(String str, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<String> outMSG = new ResponseMessage<>();
		try {
			String[] userinfo = str.split(":");
			String usercode = userinfo[0];
			String username = userinfo[1];
			usercode = DESUtil.encryptDES(usercode);
			LifeUserModel checkEnterCode = lifeUserService.checkEnterCode(usercode);
			LifeUserModel checkEnterName = lifeUserService.checkEnterName(username);
			if (null != checkEnterCode) {
				outMSG.setCode("202");
				outMSG.setMessage("身份编码已经存在，不能重复注册！");
				return outMSG;
			}
			if (null != checkEnterName) {
				outMSG.setCode("203");
				outMSG.setMessage("用户名已经存在，不能重复注册！");
				return outMSG;
			}
			outMSG.setCode("200");
			str = DESUtil.encryptDES(str);
			outMSG.setData(str);
			return outMSG;

		} catch (Exception e) {
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("user/checkUser")
	public ResponseMessage<LifeUserModel> checkUserIsExist(String code, String name, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		try {
			LifeUserModel userInfo = WebUtils.getUserInfo("add", request);
			if (null == userInfo) {
				code = DESUtil.encryptDES(code);
				LifeUserModel lifeUserModel = lifeUserService.checkEnterCode(code);
				if (null == lifeUserModel) {
					outMSG.setCode("200");
				} else {
					outMSG.setCode("202");
					outMSG.setMessage("身份编码已经存在，不能重复注册！");
				}
			}
			LifeUserModel lifeUserModel = lifeUserService.checkEnterName(name);
			if (lifeUserModel == null) {
				outMSG.setCode("200");
			} else {
				outMSG.setCode("202");
				outMSG.setMessage("用户名已经存在，不能重复注册！");
			}
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("身份密码或用户名校验是否存在出现异常！");
		}
		return outMSG;
	}

	@ResponseBody
	@RequestMapping("/add")
	public ResponseMessage<LifeUserModel> addCode(String code, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		try {
			code = DESUtil.encryptDES(code);
			LifeUserModel lifeUserModel = lifeUserService.checkEnterCode(code);
			if (lifeUserModel != null) {
				outMSG.setCode("202");
				outMSG.setMessage("该身份编码已存在，请直接登录！");
			} else {
				LifeUserModel newUser = new LifeUserModel();
				newUser.setUsercode(code);
				newUser.setCreatetime(DateUtil.getNow());
				newUser.setUserrole("2");
				lifeUserService.add(newUser);
				TreeModel defalutTreeLevel1 = WebUtils.getDefalutTreeLevel1(code);
				TreeModel defalutTreeLevel2 = WebUtils.getDefalutTreeLevel2(code, defalutTreeLevel1.getId(), request);
				treeService.addTree(defalutTreeLevel1);
				treeService.addTree(defalutTreeLevel2);
				learningService.addLearnTime(WebUtils.getDefalutTimeClass(code));
				outMSG.setCode("200");
				outMSG.setMessage("新增成功！");
				WebUtils.newSession("add", newUser, request);
			}

		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("新增失败！");
		}
		return outMSG;
	}

	@RequestMapping("/test")
	public String test(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return "error/test.jsp";
	}

	@ResponseBody
	@RequestMapping("/getAll")
	public List<LifeUserModel> getAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<LifeUserModel> all = lifeUserService.getAll();
		return all;
	}

	@ResponseBody
	@RequestMapping("user/fullUser")
	public ResponseMessage<LifeUserModel> addFullInfo(LifeUserModel lifeUserModel, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResponseMessage<LifeUserModel> outMSG = new ResponseMessage<>();
		String usercode = "";

		try {
			LifeUserModel userInfo = WebUtils.getUserInfo("add", request);

			if (null == userInfo) {
				usercode = lifeUserModel.getUsercode();
				if (lifeUserModel.getRegStep().equals("1")) {
					usercode = DESUtil.encryptDES(lifeUserModel.getUsercode());
					lifeUserModel.setPassword(DESUtil.encryptDES(lifeUserModel.getPassword()));
				}
				LifeUserModel checkEnterCode = lifeUserService.checkEnterCode(usercode);
				LifeUserModel checkEnterName = lifeUserService.checkEnterName(lifeUserModel.getUsername());
				if (checkEnterCode != null) {
					outMSG.setCode("202");
					outMSG.setMessage("身份编码已存在，不能重复注册！");
					return outMSG;
				} else if (checkEnterName != null) {
					outMSG.setCode("203");
					outMSG.setMessage("用户名已存在，不能重复注册！");
					return outMSG;
				} else {
					lifeUserModel.setUsercode(usercode);
					lifeUserModel.setCreatetime(DateUtil.getNow());
					lifeUserModel.setUserrole("2");
					lifeUserService.add(lifeUserModel);
					TreeModel defalutTreeLevel1 = WebUtils.getDefalutTreeLevel1(usercode);
					TreeModel defalutTreeLevel2 = WebUtils.getDefalutTreeLevel2(usercode, defalutTreeLevel1.getId(), request);
					treeService.addTree(defalutTreeLevel1);
					treeService.addTree(defalutTreeLevel2);
					learningService.addLearnTime(WebUtils.getDefalutTimeClass(usercode));

				}
			} else {
				if (lifeUserModel.getRegStep().equals("1")) {
					lifeUserModel.setPassword(DESUtil.encryptDES(lifeUserModel.getPassword()));
				}
				usercode = userInfo.getUsercode();
				lifeUserModel.setUsercode(usercode);
				lifeUserModel.setUpdatetime(DateUtil.getNow());
				lifeUserService.update(lifeUserModel);
			}
			outMSG.setCode("200");
			outMSG.setData(lifeUserModel);
			outMSG.setMessage("注册成功！");
			WebUtils.deleteSession("add", request);
			WebUtils.newSession("addFull", lifeUserModel, request);// 用于头像上传

		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("注册失败，请重试！");
		}

		return outMSG;
	}

	@RequestMapping(path = { "user/uploadImg" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<FileUserModel> uploadFile(@RequestParam("file") MultipartFile file, HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<FileUserModel> outMSG = new ResponseMessage<>();
		try {
			if (null == file || 0 == file.getSize()) {
				outMSG.setCode("201");
				outMSG.setMessage("请选择需要上传的文件！");
				return outMSG;
			}
			String userCode = WebUtils.getUserCode("addFull", request);
			uploadFiles(file, userCode, request);
			WebUtils.deleteSession("addFull", request);
			outMSG.setCode("200");
			outMSG.setMessage("上传头像成功！");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("上传头像失败，请重试！");
		}
		return outMSG;
	}

	@RequestMapping(path = { "user/updateUploadImg" }, method = { RequestMethod.POST })
	@ResponseBody
	public ResponseMessage<FileUserModel> updateUploadImg(@RequestParam("file") MultipartFile file, HttpServletResponse response, HttpServletRequest request) throws ServletException, IOException {
		ResponseMessage<FileUserModel> outMSG = new ResponseMessage<>();
		try {
			if (null == file || 0 == file.getSize()) {
				outMSG.setCode("201");
				outMSG.setMessage("请选择需要上传的文件！");
				return outMSG;
			}
			LifeUserModel userInfo = WebUtils.getUserInfo(request);
			uploadFiles(file, userInfo.getUsercode(), request);
			outMSG.setCode("200");
			outMSG.setMessage("上传头像成功！");
		} catch (Exception e) {
			outMSG.setCode("209");
			outMSG.setMessage("上传头像失败，请重试！");
		}
		return outMSG;
	}

	private void uploadFiles(MultipartFile file, String userCode, HttpServletRequest request) {
		FileUserModel fileUserModel = new FileUserModel();
		String id = Util.getUUId16();
		String originalFilename = file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf("."));
		long oldFiles = fileUserService.getFileByName(userCode, file.getOriginalFilename());
		if (oldFiles > 0) {
			originalFilename = originalFilename + "_" + id;
		}
		fileUserModel.setFileName(originalFilename);
		fileUserModel.setFileUrl(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/" + "file/download?id=" + id);
		fileUserModel.setFileType(file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1));
		fileUserModel.setContentType(file.getContentType());
		fileUserModel.setFileOriginalFilename(file.getOriginalFilename().replace(",", " and "));
		fileUserModel.setFileSize(Util.getM((double) file.getSize()) + "");
		fileUserModel.setId(id);
		fileUserModel.setPurpose("0");
		fileUserModel.setUploadTime(DateUtil.getNow());
		fileUserModel.setUploadUser(userCode);
		fileUserService.save(file, fileUserModel);
		LifeUserModel lifeUserModel = new LifeUserModel();
		lifeUserModel.setHeadaddress(fileUserModel.getFileUrl());
		lifeUserModel.setUsercode(userCode);
		lifeUserService.update(lifeUserModel);
	}
}
