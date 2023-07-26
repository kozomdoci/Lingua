package com.lgy.lingua.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.lingua.collective.MethodCollection;
import com.lgy.lingua.command.BoardCommand;
import com.lgy.lingua.dto.BoardCriteria;
import com.lgy.lingua.dto.BoardDto;
import com.lgy.lingua.dto.UserDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {
	
	@Autowired private BoardCommand command;
	@Autowired private MethodCollection methods;
	
	// 홈 화면 JSP 이동
	@GetMapping("/home")
	public String home(Model model, HttpSession session) {
		log.debug("BoardController ===> @GetMapping(\"/home\")");
		UserDto userInfo = methods.getUserInfo(session);
		if(userInfo != null) {
			model.addAttribute("userInfo", userInfo);
		}
		
		return "/board/home";
	}
	
	// 게시판 화면 JSP 이동 및 게시판 목록 조회 처리 => 페이징 처리 추가함으로써 사용하지 않는 매핑이 됨
	@GetMapping("/listBeforePaging")
	public String list(Model model, HttpSession session) {
		log.debug("BoardController ===> @GetMapping(\"/listBeforePaging\")");
		
		UserDto userInfo = methods.getUserInfo(session);
		if(userInfo != null) {
			model.addAttribute("userInfo", userInfo);
		}
		
		ArrayList<BoardDto> boardList = command.list();
		model.addAttribute("boardList", boardList);
		
		return "/board/list";
	}
	
	// 게시판 화면 JSP 이동 및 게시판 목록 조회 처리 => 페이징 처리 추가
	@GetMapping("/list")
	public String list(Model model, HttpSession session, BoardCriteria cri) {
		log.debug("BoardController ===> @GetMapping(\"/list\")");
		
		UserDto userInfo = methods.getUserInfo(session);
		if(userInfo != null) {
			model.addAttribute("userInfo", userInfo);
		}
		
		ArrayList<BoardDto> boardList = command.list(cri);
		model.addAttribute("boardList", boardList);
		
		return "/board/list";
	}
	
	
	

	// 게시글 쓰기 버튼 클릭하면 세션 확인하기 (세션 있으면 write 로 이동)
	@GetMapping("/checkSession")
	public ResponseEntity<String> checkSession(Model model, HttpSession session) {
		log.debug("BoardController ===> @GetMapping(\"/checkSession\")");
		UserDto userInfo = methods.getUserInfo(session);
		
		if(userInfo != null) {
			model.addAttribute("userInfo", userInfo);
			return ResponseEntity.ok().body("session found");
		}
		return ResponseEntity.ok().body("session not found");
	}
	
	// 게시글 쓰기 화면 JSP 이동
	@GetMapping("/write")
	public String write(Model model, HttpSession session) {
		log.debug("BoardController ===> @GetMapping(\"/write\")");
		UserDto userInfo = methods.getUserInfo(session);
		model.addAttribute("userInfo", userInfo);
		
		return "/board/write";
	}
	
	// 게시글 쓰기 폼 데이터를 받아서 DB에 새글 생성(insert)
	@PostMapping("/write")
	public ResponseEntity<String> write(@RequestParam HashMap<String, String> params) {
		log.debug("BoardController ===> @PostMapping(\"/write\")");
		command.write(params);
		
		return ResponseEntity.ok().body("insert success");
	}
	
	// 게시글 상세보기 화면 JSP 이동 및 게시글 조회 처리(select)
	@GetMapping("/contentView")
	public String contentView(@RequestParam HashMap<String, String> params, Model model, HttpSession session) {
		log.debug("BoardController ===> @GetMapping(\"/contentView\")");
		UserDto userInfo = methods.getUserInfo(session);
		
		if(userInfo != null) {
			model.addAttribute("userInfo", userInfo);
		}
		
		BoardDto dto = command.contentView(params);
		model.addAttribute("board", dto);
		
		return "/board/contentView";
	}

	// 뷰에서 전달받은 idBoard 값으로 해당 게시글 조회(select)해서 model 객체에 추가 후 게시글 수정화면 JSP 이동
	@GetMapping("/edit")
	public String edit(@RequestParam HashMap<String, String> params, Model model) {
		log.debug("BoardController ===> @GetMapping(\"/edit\")");
		
		BoardDto dto = command.contentView(params);
		model.addAttribute("board", dto);
		
		return "/board/edit";
	}
	
	// 게시글 내용 수정 처리(update)
	@PostMapping("/edit")
	public ResponseEntity<String> edit(@RequestParam HashMap<String, String> params) {
		log.debug("BoardController ===> @PostMapping(\"/edit\")");
		command.edit(params);
		return ResponseEntity.ok().body("update success");
	}
	
	// 게시글 삭제 처리(delete)
	@GetMapping("/delete")
	public String delete(@RequestParam HashMap<String, String> params) {
		log.debug("BoardController ===> @GetMapping(\"/delete\")");
		command.delete(params);
		
		return "redirect:list";
	}
	
	
	
}



