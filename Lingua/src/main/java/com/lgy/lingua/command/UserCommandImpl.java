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

	@Autowired private SqlSession sqlSession;
	
	// 사용자 정보조회(활용: 로그인 처리)
	@Override
	public UserDto login(HashMap<String, String> params) {
		log.debug("UserCommandImpl ===> login");
		log.debug("UserCommandImpl ===> email ===> " + params.get("email"));
		
		// sqlSession 객체를 통해 UserDao 인터페이스의 구현체를 호출(SQL매퍼 파일과 자바 인터페이스를 연결하여 DB작업 수행)
		UserDao dao = sqlSession.getMapper(UserDao.class);
		
		// 이메일을 파라미터로 전달하여 DB에서 사용자 정보 조회 (select 쿼리)
		ArrayList<UserDto> dtos = dao.login(params);
		
		// DB에서 조회된 사용자 정보(인덱스0번)에 저장된 비밀번호 호출(DB에 저장된 암호화된 비밀번호)
		UserDto dto = dtos.get(0);
		
		return dto;
	}
	
	
	
	
	
	
	
}









