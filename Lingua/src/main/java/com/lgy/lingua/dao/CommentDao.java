package com.lgy.lingua.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.lingua.dto.CommentDto;

// XML 의 id 와 매칭되는 쿼리 호출
public interface CommentDao {
	
	// 지정한 게시글에 연결된 전체 댓글 조회(select)
	public ArrayList<CommentDto> listComment(HashMap<String, String> params);
	
	
	
}
