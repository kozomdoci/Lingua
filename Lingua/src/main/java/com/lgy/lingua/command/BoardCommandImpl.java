package com.lgy.lingua.command;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.lingua.dao.BoardDao;
import com.lgy.lingua.dto.BoardCriteria;
import com.lgy.lingua.dto.BoardDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BoardCommandImpl implements BoardCommand {
	
	@Autowired private SqlSession sqlSession;
	
	// 게시판 전체 게시글 조회(활용: 게시판 조회)
	@Override
	public ArrayList<BoardDto> list() {
		log.debug("BoardCommandImpl ===> list");
		
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		ArrayList<BoardDto> boardList = dao.list();
		
		return boardList;
	}
	
	// 게시판 전체 게시글 조회 => 페이징 처리 추가(활용: 게시판 조회)
	@Override
	public ArrayList<BoardDto> list(BoardCriteria cri) {
		log.debug("BoardCommandImpl ===> list(cri)");
		
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		ArrayList<BoardDto> boardList = dao.listWithPaging(cri);
		
		return boardList;
	}
	
	// 게시판 전체 게시글 개수 조회 => 페이징 시 전체 게시글 수를 실시간으로 적용하기 위해
	@Override
	public int getTotalBoard() {
		log.debug("BoardCommandImpl ===> getTotalBoard");
		
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		int total = dao.getTotalBoard();
		
		return total;
	}


	
	// 게시글 쓰기(활용: 글쓰기)
	@Override
	public void write(HashMap<String, String> params) {
		log.debug("BoardCommandImpl ===> write");
		
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.write(params);
	}

	// 지정한 게시글 보기(활용: 글보기)
	@Override
	public BoardDto contentView(HashMap<String, String> params) {
		log.debug("BoardCommandImpl ===> contentView");
		
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		BoardDto dto = dao.contentView(params);
		
		return dto;
	}

	// 게시글 내용 수정(활용: 글수정)
	@Override
	public void edit(HashMap<String, String> params) {
		log.debug("BoardCommandImpl ===> edit");
		
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.edit(params);
	}

	// 게시글 삭제(활용: 글삭제)
	@Override
	public void delete(HashMap<String, String> params) {
		log.debug("BoardCommandImpl ===> delete");
		
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.delete(params);
	}


	
	
	
	
	
	
}
