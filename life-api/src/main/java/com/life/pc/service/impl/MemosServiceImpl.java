package com.life.pc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.life.pc.dao.MemosDao;
import com.life.pc.model.MemosModel;
import com.life.pc.service.MemosService;

@Service("memosService")
public class MemosServiceImpl implements MemosService {

	@Autowired
	private MemosDao memosDao;

	@Override
	public MemosModel selectById(String id) {
		return null;
	}

	@Override
	public void deleteById(String id) {

	}

	@Override
	public void save(MemosModel memosModel) {
		memosDao.save(memosModel);
	}

	@Override
	public void update(MemosModel memosModel) {

	}

	@Override
	public List<MemosModel> selectByUserCode(String userCode) {
		return memosDao.selectByUserCode(userCode);
	}

	@Override
	public Long selectCount(String userCode) {
		return memosDao.selectCount(userCode);
	}

}
