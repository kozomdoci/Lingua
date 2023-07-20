package com.lgy.lingua.command;

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

	@Autowired private SqlSession sqlSession;
	
	// 사용자 정보조회(활용: 로그인 처리, 이메일 중복확인)
	@Override
	public UserDto login(HashMap<String, String> params) {
		log.debug("UserCommandImpl ===> login");
		
		// sqlSession 객체를 통해 UserDao와 매핑
		UserDao dao = sqlSession.getMapper(UserDao.class);
		
		// 매핑된 dao 객체를 통해 XML 의 쿼리 실행
		UserDto dto = dao.login(params);
		
		return dto;
	}
	
	
	
	
	
	
	
}









