package com.life.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("entrance")
public class EntranceController {
	
	
	@ResponseBody
    @RequestMapping("enterCode")
    public String enterCode(String code) throws Exception {
		
		
		return null;
    }
}
