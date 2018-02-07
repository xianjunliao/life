package com.life.pc.service;

import com.life.pc.model.MemosModel;

public interface MemosService {
	
	public MemosModel selectById(String id);
	
	public void deleteById(String id);
	
	public void save(MemosModel memosModel);
	
	public void update(MemosModel memosModel);
	
}