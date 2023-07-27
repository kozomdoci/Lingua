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

	
	
	
	
}





