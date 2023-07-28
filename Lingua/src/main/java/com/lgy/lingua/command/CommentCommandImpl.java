package com.lgy.lingua.command;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.lingua.dao.CommentDao;
import com.lgy.lingua.dto.CommentDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CommentCommandImpl implements CommentCommand {
	
	@Autowired private SqlSession sqlSession;
	
	// 지정한 게시글에 연결된 댓글 전체 조회	
	@Override
	public ArrayList<CommentDto> listComment(HashMap<String, String> params) {
		log.debug("CommentCommandImpl ===> listComment");
		
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		ArrayList<CommentDto> commentList = dao.listComment(params);
		
		return commentList;
	}

	// 댓글 쓰기
	@Override
	public void writeComment(HashMap<String, String> params) {
		log.debug("CommentCommandImpl ===> writeComment");
		
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		dao.writeComment(params);
	}

	// 지정한 댓글 정보 조회
	@Override
	public CommentDto getCommentDetail(HashMap<String, String> params) {
		log.debug("CommentCommandImpl ===> getCommentDetail");
		
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		CommentDto dto = dao.getCommentDetail(params);
		
		return dto;
	}

	// 댓글 수정
	@Override
	public void editComment(HashMap<String, String> params) {
		log.debug("CommentCommandImpl ===> editComment");
		
		CommentDao dao = sqlSession.getMapper(CommentDao.class);
		dao.editComment(params);
	}
	
	
	

	
	
	
	
}





