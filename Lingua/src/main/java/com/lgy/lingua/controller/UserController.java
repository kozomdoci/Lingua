package com.lgy.lingua.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.lingua.collective.MethodCollection;
import com.lgy.lingua.command.UserCommand;
import com.lgy.lingua.dto.UserDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {
	
	@Autowired private UserCommand command;
	@Autowired private MethodCollection methods;
	
	// 회원가입 화면 JSP 이동
	@GetMapping("register")
	public String register() {
		log.debug("UserController ===> @GetMapping(\"/register\")");
		return "/user/register";
	}
	
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
	
	// 로그인 처리 (아이디 조회, 비밀번호 일치여부 확인)
	@PostMapping("/login")
	public ResponseEntity<String> login(@RequestParam HashMap<String, String> params, HttpSession session) {
		log.debug("UserController ===> @PostMapping(\"/login\")");
		
		// UserCommandImpl 의 login 메소드 호출하여 사용자 정보 가져오기
		UserDto dto = command.login(params);
		
		if(dto != null) {
			
			// 사용자 정보에 저장된 비밀번호 (DB에 저장된 암호화된 비밀번호) 가져오기
			String dbPassword = dto.getPassword();
			log.debug("UserCommandImpl ===> dbPassword ===> " + dbPassword);
			
			// 사용자가 로그인 화면에서 입력한 비밀번호 가져오기
			String inputPassword = params.get("password");
			log.debug("UserCommandImpl ===> inputPassword ===> " + inputPassword);
			
			// 사용자 입력값과 DB비밀번호의 일치여부 확인
			boolean passwordMatches = methods.passwordMatches(inputPassword, dbPassword);
			
			if(passwordMatches) {
				// 사용자 정보 있고, 비밀번호 일치
				
				session.setAttribute("userInfo", dto);
				session.setMaxInactiveInterval(1800);
				
				return ResponseEntity.ok().body("success");
				
			}else {
				// 사용자 정보는 있으나, 비밀번호 불일치
				return ResponseEntity.ok().body("wrong password");
			}
		}else {
			// 사용자 정보 없음
			return ResponseEntity.ok().body("email not found");
		}
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
	
	
	

	
	
	
	
	
}
