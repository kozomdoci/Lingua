package com.lgy.lingua.controller;

import java.util.HashMap;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
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
	@GetMapping("/register")
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
	@GetMapping("/userInfo")
	public String user() {
		log.debug("UserController ===> @GetMapping(\"/userInfo\")");
		return "/user/userInfo";
	}
	
	// 회원가입 처리 (1) 이메일 중복확인
	@PostMapping("/isEmailAvailable")
	public ResponseEntity<String> isEmailAvailable(@RequestParam HashMap<String, String> params) {
		log.debug("UserController ===> @PostMapping(\"/isEmailAvailable\")");
		UserDto dto = command.login(params);
		log.debug("dto ===> " + dto);
		
		if(dto != null) {
			log.debug("UserController ===> 가입할 수 없는 이메일");
			return ResponseEntity.ok().body("invalid email");
		}else {
			log.debug("UserController ===> 가입할 수 있는 이메일");
			return ResponseEntity.ok().body("valid email");
		}
	}
	
	// 인증번호 검증을 위한 전역변수
	String codeStr = "";
	
	// 회원가입 처리 (2) 인증번호 발송
	@PostMapping("/sendCode")
	public ResponseEntity<String> sendCode(@RequestParam HashMap<String, String> params) throws AddressException, MessagingException {
		log.debug("UserController ===> @PostMapping(\"/sendCode\")");
		log.debug("email??? "+params.get("email"));
		log.debug("==================================================================");
		codeStr = methods.sendCodeByEmail(params.get("email"));
		log.debug("==================================================================");
		log.debug("codeStr??? "+codeStr);
		
		return ResponseEntity.ok().body(codeStr);
	}
	
	// 회원가입 처리 (3) 사용자가 입력한 인증번호 검증(true/false)
	@PostMapping("/isValidCode")
	public ResponseEntity<Boolean> isValidCode(@RequestParam HashMap<String, String> params) {
		log.debug("UserController ===> @PostMapping(\"/isValidCode\")");
	    boolean isCodeMatching = params.get("code").equals(codeStr);
	    log.debug("code??? "+params.get("code"));
	    log.debug("codeStr??? "+codeStr);
	    log.debug("isCodeMatching??? "+isCodeMatching);
	    
	    return ResponseEntity.ok().body(isCodeMatching);
	}
	
	// 회원가입 처리 (4) 폼 데이터를 받아서 DB에 회원정보 생성(insert)
	@PostMapping("/register")
	public ResponseEntity<String> register(@RequestParam HashMap<String, String> params) {
		log.debug("UserController ===> @PostMapping(\"/register\")");
		
		// 암호화된 비밀번호로 password의 값을 치환
		String encodedPassword = methods.passwordEncoder(params.get("password"));
		params.replace("password", encodedPassword);
		
		// 입력받은 언어를 파라미터 이름으로, 수준을 파라미터 값으로 추가
		params.put(params.get("language1"), params.get("level1"));
		params.put(params.get("language2"), params.get("level2"));
		params.put(params.get("language3"), params.get("level3"));
		params.put(params.get("language4"), params.get("level4"));
		
		command.register(params);
		
		return ResponseEntity.ok().body("register success");
	}
	
	// 로그인 처리 (아이디 조회 후 암호화된 비밀번호와 일치여부 확인)
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
				log.debug("UserCommandImpl ===> 사용자 정보 있고, 비밀번호 일치");
				session.setAttribute("userInfo", dto);
				session.setMaxInactiveInterval(1800);
				return ResponseEntity.ok().body("login success");
				
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