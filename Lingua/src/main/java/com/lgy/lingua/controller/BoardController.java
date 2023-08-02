package com.lgy.lingua.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lgy.lingua.collective.MethodCollection;
import com.lgy.lingua.command.BoardCommand;
import com.lgy.lingua.dto.BoardCriteria;
import com.lgy.lingua.dto.BoardDto;
import com.lgy.lingua.dto.BoardPage;
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

		// 현재 전체 게시글 개수 조회하여 변수에 저장
//		int total = command.getTotalBoard();
		int total = command.getTotalBoard(cri);
		
		// 총 게시글 수(실시간으로 조회한 결과값)와 cri 객체(현재 머무르는 페이지 번호와 한 페이지당 출력되는 게시글 개수를 가짐)를 생성자 매개변수로 전달하여 BoardPage 객체 생성
		BoardPage boardPageDto = new BoardPage(total, cri);
		model.addAttribute("pageMaker", boardPageDto);
		
		return "/board/list";
	}
	
	
	

	// 게시글 쓰기 버튼 클릭하면 세션 확인하기 (세션 있으면 write 로 이동)
	@GetMapping("/checkSession")
	public ResponseEntity<String> checkSession(@RequestParam HashMap<String, String> params, Model model, HttpSession session) {
		log.debug("BoardController ===> @GetMapping(\"/checkSession\")");
		log.debug("pageNum : " + params.get("pageNum"));
		log.debug("amount : " + params.get("amount"));
		model.addAttribute("pageNum", params.get("pageNum"));
		model.addAttribute("amount", params.get("amount"));
		
		UserDto userInfo = methods.getUserInfo(session);
		
		if(userInfo != null) {
			model.addAttribute("userInfo", userInfo);
			
			return ResponseEntity.ok().body("session found");
		}
		return ResponseEntity.ok().body("session not found");
	}
	
	// 게시글 쓰기 화면 JSP 이동
	@GetMapping("/write")
	public String write(@RequestParam HashMap<String, String> params, Model model, HttpSession session) {
		log.debug("BoardController ===> @GetMapping(\"/write\")");
		log.debug("pageNum : " + params.get("pageNum"));
		log.debug("amount : " + params.get("amount"));
		
		UserDto userInfo = methods.getUserInfo(session);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("pageMaker", params);
		
		return "/board/write";
	}
	
	// 게시글 쓰기 폼 데이터를 받아서 DB에 새글 생성(insert)
	@PostMapping("/write")
	public ResponseEntity<String> write(@RequestParam HashMap<String, String> params, Model model) {
		log.debug("BoardController ===> @PostMapping(\"/write\")");
		log.debug("pageNum : " + params.get("pageNum"));
		log.debug("amount : " + params.get("amount"));
		
		model.addAttribute("pageMaker", params);
		
		command.write(params);
		
		return ResponseEntity.ok().body("insert success");
	}
	
	// 게시글 상세보기 화면 JSP 이동 및 게시글 조회 처리(select) @@@ 페이징 처리를 위해 모델 객체 추가
	@GetMapping("/contentView")
	public String contentView(@RequestParam HashMap<String, String> params, Model model, HttpSession session) {
		log.debug("BoardController ===> @GetMapping(\"/contentView\")");
		UserDto userInfo = methods.getUserInfo(session);
		
		if(userInfo != null) {
			model.addAttribute("userInfo", userInfo);
		}
		
		BoardDto dto = command.contentView(params);
		model.addAttribute("board", dto);
		
		// 뷰(list.jsp)에서 전달 받은 추가 파라미터(pageNum 과 amount) 도 별도로 모델 객체에 담아서 뷰(contentView.jsp) 로 보내기
		model.addAttribute("pageMaker", params);
		
		return "/board/contentView";
	}

	// 뷰에서 전달받은 idBoard 값으로 해당 게시글 조회(select)해서 model 객체에 추가 후 게시글 수정화면 JSP 이동 @@@ 페이징 처리를 위해 모델 객체 추가
	@GetMapping("/edit")
	public String edit(@RequestParam HashMap<String, String> params, Model model) {
		log.debug("BoardController ===> @GetMapping(\"/edit\")");
		
		BoardDto dto = command.contentView(params);
		model.addAttribute("board", dto);
		
		// 뷰(contentView.jsp)에서 전달 받은 추가 파라미터(pageNum 과 amount) 도 별도로 모델 객체에 담아서 뷰(edit.jsp) 로 보내기
		model.addAttribute("pageMaker", params);
		
		return "/board/edit";
	}
	
	// 게시글 내용 수정 처리(update)
	@PostMapping("/edit")
	public ResponseEntity<String> edit(@RequestParam HashMap<String, String> params) {
		log.debug("BoardController ===> @PostMapping(\"/edit\")");
		command.edit(params);
		
		return ResponseEntity.ok().body("update success");
	}
	
	// 게시글 삭제 처리(delete) @@@ 페이징 처리를 위해 모델 객체 추가
	@GetMapping("/delete")
	public String delete(@RequestParam HashMap<String, String> params, @ModelAttribute("cri") BoardCriteria cri, RedirectAttributes rttr) {
		log.debug("BoardController ===> @GetMapping(\"/delete\")");
		command.delete(params);
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:list";
	}
	
	
	
}



