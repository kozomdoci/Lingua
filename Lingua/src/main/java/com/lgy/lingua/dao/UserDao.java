package com.lgy.lingua.dao;

import java.util.HashMap;

import com.lgy.lingua.dto.UserDto;

// XML 의 id 와 매칭되는 쿼리 호출
public interface UserDao {
	
	// 이메일을 전달하여 해당 유저 정보 가져오기(select)
	public UserDto login(HashMap<String, String> params);
	
	// 회원가입 화면의 폼 데이터 입력받아 회원정보 삽입하기(insert)
	public void register(HashMap<String, String> params);
	
	// 회원정보 수정화면의 폼 데이터를 입력받아 회원정보 수정하기(update)
	public void update(HashMap<String, String> params);
	
	// 비밀번호 찾기 요청 시 임시비밀번호 발급 후 발급한 임시번호로 비밀번호 수정하기(update)
	public void updateTemPwd(HashMap<String, String> params);
	
	// 회원정보 수정화면에서 회원탈퇴 버튼 클릭 시 회원 정보 삭제하기(delete)
	public void delete(HashMap<String, String> params);
}



