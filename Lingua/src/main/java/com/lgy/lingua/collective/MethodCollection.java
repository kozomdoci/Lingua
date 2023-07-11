package com.lgy.lingua.collective;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MethodCollection {
	
	// 사용자가 입력한 비밀번호를 매개변수로 전달하여 암호화된 비밀번호로 리턴
	public String passwordEncoder(String inputPassword) {
		return new BCryptPasswordEncoder().encode(inputPassword);
	}
	
	// 사용자가 입력한 비밀번호가 DB에 저장된 비밀번호와 일치하는지 여부를 리턴
	public boolean passwordMatches(String inputPassword, String dbPassword) {
		return new BCryptPasswordEncoder().matches(inputPassword, dbPassword);
	}
}





