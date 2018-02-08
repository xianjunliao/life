package com.life.pc.dao;

import java.util.List;

import com.life.pc.model.MemosModel;

public interface MemosDao {
	
	public MemosModel selectById(String id);
	
	public void deleteById(String id);
	
	public void save(MemosModel memosModel);
	
	public void update(MemosModel memosModel);
	
	public List<MemosModel> selectByUserCode(String userCode);
	
	public List<MemosModel>  selectByExecuteResult();
	
	public Long selectCount(String userCode);
	
}