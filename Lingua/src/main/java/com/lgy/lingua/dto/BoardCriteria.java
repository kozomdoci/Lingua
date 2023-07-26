package com.lgy.lingua.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class BoardCriteria {
	private int pageNum;	// 현재 머무르고 있는 페이지 번호
	private int amount;		// 한 페이지당 출력되는 게시글의 개수
	
	public BoardCriteria() {
		this(1, 10);		// 기본 생성자 => 기본값 설정 (현재 페이지 번호는 1이고, 게시글 10개씩 출력)
	}
	
}




