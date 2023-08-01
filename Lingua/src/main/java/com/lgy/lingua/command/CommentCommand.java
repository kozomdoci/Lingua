package com.lgy.lingua.command;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.lingua.dto.CommentDto;

public interface CommentCommand {
	
	ArrayList<CommentDto> listComment(HashMap<String, String> params);
	void writeComment(HashMap<String, String> params);
	CommentDto getCommentDetail(HashMap<String, String> params);
	void editComment(HashMap<String, String> params);
	void deleteComment(HashMap<String, String> params);
	
}
