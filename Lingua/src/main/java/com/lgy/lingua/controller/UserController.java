package com.lgy.lingua.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.lingua.command.UserCommand;
import com.lgy.lingua.dto.UserDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {
	
	@Autowired
	private UserCommand command;
	
	// 로그인 화면 JSP 이동
	@GetMapping("/login")
	public String login() {
		log.debug("UserController ===> @GetMapping(\"/login\")");
		return "/user/login";
	}
	
	// 회원정보 화면 JSP 이동
	@GetMapping("/user")
	public String user() {
		log.debug("UserController ===> @GetMapping(\"/user\")");
		return "/user/user";
	}
	
	// 아이디 & 비밀번호 입력 후 로그인 처리
	@PostMapping("/login")
	public String login(@RequestParam HashMap<String, String> params) {
		log.debug("UserController ===> @PostMapping(\"/login\")");
		String result;
		int re = command.login(params);
		log.debug("UserController ===> re ===> " + re);
		
		if(re == 1) {
			result = "success";
		}else if(re == 0) {
			result = "wrong password";
		}else {
			result = "email not found";
		}
		return result;
	}
	

	
	
	
}
