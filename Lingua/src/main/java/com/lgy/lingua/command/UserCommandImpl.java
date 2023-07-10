package com.lgy.lingua.command;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.lingua.dao.UserDao;
import com.lgy.lingua.dto.UserDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserCommandImpl implements UserCommand {

	@Autowired
	private SqlSession sqlSession;
	
	// 로그인 처리 (아이디 조회, 비밀번호 확인)
	@Override
	public int login(HashMap<String, String> params) {
		log.debug("UserCommandImpl ===> login");
		log.debug("UserCommandImpl ===> email ===> " + params.get("email"));
		log.debug("UserCommandImpl ===> password ===> " + params.get("password"));
		int re = -1;	// 기본값: 사용자 정보 없음
		UserDao dao = sqlSession.getMapper(UserDao.class);
		ArrayList<UserDto> dtos = dao.login(params);
		
		log.debug("UserCommandImpl ===> dtos ===> " + dtos);
		
		if(dtos != null) {
			UserDto dto = dtos.get(0);
			log.debug("UserCommandImpl ===> dto ===> " + dto);

			String passwordFromUser = params.get("password");
			log.debug("UserCommandImpl ===> passwordFromUser ===> " + passwordFromUser);
			
			String passwordFromDb = dto.getPassword();
			log.debug("UserCommandImpl ===> passwordFromDb ===> " + passwordFromDb);
			
			if(passwordFromUser.equals(passwordFromDb)) {
				re = 1;	// 사용자 정보 있고, 비밀번호 일치
			}else {
				re = 0; // 사용자 정보는 있으나, 비밀번호 불일치
			}
		}
		return re;
	}
	
	
	
	
	
	
	
}









