package com.lgy.lingua.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.lingua.command.CommentCommand;
import com.lgy.lingua.dto.CommentDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board/comment")
@Slf4j
public class CommentController {
	
	@Autowired private CommentCommand command;
	
	// 지정한 게시글에 연결된 댓글 조회
	@GetMapping("/listComment")
	public ResponseEntity<ArrayList<CommentDto>> listComment(@RequestParam HashMap<String, String> params) {
		log.debug("CommentController ===> @GetMapping(\"/listComment\")");
		log.debug("idBoard : " +params.get("idBoard"));
		
		ArrayList<CommentDto> commentList = command.listComment(params);
		
		return ResponseEntity.ok().body(commentList);
	}
	
	// 지정한 게시글(idBoard) 등과 함께 파라미터를 가져와서 댓글 생성
	@PostMapping("/writeComment")
	public ResponseEntity<String> writeComment(@RequestParam HashMap<String, String> params) {
		log.debug("CommentController ===> @PostMapping(\"writeComment\")");
		
		// 게시글의 정보 : 게시글 번호, 언어
		log.debug("idBoard : " + params.get("idBoard"));
		log.debug("language : " + params.get("language"));
		
		// 사용자가 입력한 댓글 내용
		log.debug("content : " + params.get("content"));
		
		// 실제 로그인하여 댓글을 쓰는 사용자의 이메일과 닉네임
		log.debug("writer : " + params.get("writer"));
		log.debug("writer_nickname : " + params.get("writer_nickname"));
		
		command.writeComment(params);
		
		return ResponseEntity.ok().body("comment insert success");
	}
	
	@PostMapping("/editComment")
	public ResponseEntity<String> editComment(@RequestParam HashMap<String, String> params) {
		log.debug("CommentController ===> @PostMapping(\"editComment\")");
		log.debug("idComment : " + params.get("idComment"));
		log.debug("content : " + params.get("content"));
		
		command.editComment(params);
		
		return ResponseEntity.ok().body("comment update success");
	}
}










