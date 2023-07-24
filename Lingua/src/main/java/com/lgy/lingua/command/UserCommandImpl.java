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
	
	// 사용자 정보조회(활용: 로그인 처리, 이메일 중복확인, 비밀번호 찾기 시도 시 이메일 가입 여부 확인)
	@Override
	public UserDto login(HashMap<String, String> params) {
		log.debug("UserCommandImpl ===> login");
		
		// sqlSession 객체를 통해 UserDao와 매핑
		UserDao dao = sqlSession.getMapper(UserDao.class);
		
		// 매핑된 dao 객체를 통해 XML 의 쿼리 실행
		UserDto dto = dao.login(params);
		
		return dto;
	}

	// 회원정보 삽입(활용: 회원가입)
	@Override
	public void register(HashMap<String, String> params) {
		log.debug("UserCommandImpl ===> register");
		UserDao dao = sqlSession.getMapper(UserDao.class);
		dao.register(params);
		
	}

	// 회원정보 수정(활용: 정보수정)
	@Override
	public void update(HashMap<String, String> params) {
		log.debug("UserCommandImpl ===> update");
		UserDao dao = sqlSession.getMapper(UserDao.class);
		dao.update(params);
	}

	// 임시비밀번호로 비밀번호 업데이트(활용: 비밀번호 찾기 요청에 따른 임시비밀번호 발급)
	@Override
	public void updateTemPwd(HashMap<String, String> params) {
		log.debug("UserCommandImpl ===> updateTemPwd");
		UserDao dao = sqlSession.getMapper(UserDao.class);
		dao.updateTemPwd(params);
	}

	
	// 회원정보 삭제(활용: 회원탈퇴)
	@Override
	public void delete(HashMap<String, String> params) {
		log.debug("UserCommandImpl ===> delete");
		UserDao dao = sqlSession.getMapper(UserDao.class);
		dao.delete(params);
		
	}
	
	
	
	
	
	
}









