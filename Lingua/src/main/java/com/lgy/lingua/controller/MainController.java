package com.lgy.lingua.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lgy.lingua.collective.MethodCollection;
import com.lgy.lingua.dto.UserDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/main")
@Slf4j
public class MainController {
	
	@Autowired private MethodCollection methods;
	
	// 홈 화면 JSP 이동
	@GetMapping("/home")
	public String home(Model model, HttpSession session) {
		log.debug("MainController ===> @GetMapping(\"/home\")");
		UserDto userInfo = methods.getUserInfo(session);
		
		if(userInfo != null) {
			model.addAttribute("userInfo", userInfo);
		}
		
		return "/main/home";
	}
	
	// 게시판 화면 JSP 이동
	@GetMapping("/board")
	public String board(Model model, HttpSession session) {
		log.debug("MainController ===> @GetMapping(\"/board\")");
		UserDto userInfo = methods.getUserInfo(session);
		
		if(userInfo != null) {
			model.addAttribute("userInfo", userInfo);
		}
		
		return "/main/board";
	}
	
	
}



