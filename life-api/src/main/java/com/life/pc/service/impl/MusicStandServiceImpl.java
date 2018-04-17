package com.life.pc.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.life.common.Util;
import com.life.common.file.FileUtils;
import com.life.common.time.DateUtil;
import com.life.common.util.SpringWebUtil;
import com.life.pc.dao.MusicStandDao;
import com.life.pc.model.MusicStandModel;
import com.life.pc.service.MusicStandService;

@Service("musicStandService")
public class MusicStandServiceImpl implements MusicStandService {

	@Autowired
	private MusicStandDao musicStandDao;

	@Override
	public int deleteByPrimaryKey(String id) {
		return 0;
	}

	@Override
	public int insertSelective(MultipartFile file, MusicStandModel record) {
		try {
			String musicname = record.getMusicname();
			List<MusicStandModel> models = musicStandDao.selectByName(musicname);
			int i = models.size()+1;
			String filePath = Util.getPathBySys()+"score/";
			String id = Util.getUUId16();
			record.setId(id);
			record.setFilename(musicname+"_"+i);
			record.setPagenumber(i+"");
			record.setCreatetime(DateUtil.getNow());
			record.setFilesize(Util.getKB((double) file.getSize()) +"KB");
			String fileType = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
			String filesUpload_stream = FileUtils.FilesUpload_stream(file, filePath, record.getUsercode(),fileType, record.getFilename());
			record.setFilepath(filesUpload_stream);
			HttpServletRequest request = SpringWebUtil.getRequest();
			record.setUrl(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/" + "music/score?id=" + id);
			musicStandDao.insertSelective(record);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public MusicStandModel selectByPrimaryKey(String id) {
		return null;
	}

	@Override
	public int updateByPrimaryKeySelective(MusicStandModel record) {
		return 0;
	}

	@Override
	public int updateByPrimaryKey(MusicStandModel record) {
		return 0;
	}

	@Override
	public List<MusicStandModel> selectByName(String musicname) {
		// TODO Auto-generated method stub
		return null;
	}

}
