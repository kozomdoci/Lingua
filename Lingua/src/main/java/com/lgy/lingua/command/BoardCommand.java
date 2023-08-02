package com.lgy.lingua.command;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.lingua.dto.BoardCriteria;
import com.lgy.lingua.dto.BoardDto;

public interface BoardCommand {
	
	ArrayList<BoardDto> list();
	
	// Criteria 객체를 이용해서 페이징 처리(메소드 오버로딩)
	ArrayList<BoardDto> list(BoardCriteria cri);
	
	// Criteria 객체를 이용해서 페이징 처리 - 게시글 수 조회 (메소드 오버로딩)
	int getTotalBoard(BoardCriteria cri);
	
	
	void write(HashMap<String, String> params);
	BoardDto contentView(HashMap<String, String> params);
	void edit(HashMap<String, String> params);
	void delete(HashMap<String, String> params);
}







