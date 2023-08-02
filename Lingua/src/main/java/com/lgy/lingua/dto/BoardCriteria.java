package com.lgy.lingua.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@ToString
public class BoardCriteria {
	private int pageNum;	// 현재 머무르고 있는 페이지 번호
	private int amount;		// 한 페이지당 출력되는 게시글의 개수
	
	private String type;		// 검색조건
	private String keyword;		// 검색어
	
	public BoardCriteria() {
		this(1, 10);		// 기본 생성자 => 기본값 설정 (현재 페이지 번호는 1이고, 게시글 10개씩 출력)
	}
	
	public BoardCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		// type 이 없으면 빈 스트링 객체(기본 목록 조회), 있으면 분리
		return type == null ? new String[] {} : type.split("");
	}
	
}




