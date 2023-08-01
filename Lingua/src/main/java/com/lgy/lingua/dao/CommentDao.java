package com.lgy.lingua.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.lingua.dto.CommentDto;

// XML 의 id 와 매칭되는 쿼리 호출
public interface CommentDao {
	
	// 지정한 게시글에 연결된 전체 댓글 조회(select)
	public ArrayList<CommentDto> listComment(HashMap<String, String> params);
	
	// 댓글 쓰기(insert)
	public void writeComment(HashMap<String, String> params);
	
	// 댓글 번호에 따른 댓글 정보(select)
	public CommentDto getCommentDetail(HashMap<String, String> params);
	
	// 댓글 수정(update)
	public void editComment(HashMap<String, String> params);
	
	// 댓글 삭제(delete)
	public void deleteComment(HashMap<String, String> params);
	
}
