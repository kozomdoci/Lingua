package com.lgy.lingua.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/main")
@Slf4j
public class MainController {
	
	// 홈 화면 JSP 이동
	@GetMapping("/home")
	public String home() {
		log.debug("MainController ===> @GetMapping(\"/home\")");
		return "/main/home";
	}
	
	// 게시판 화면 JSP 이동
	@GetMapping("/board")
	public String board() {
		log.debug("MainController ===> @GetMapping(\"/board\")");
		return "/main/board";
	}
	
	
}



