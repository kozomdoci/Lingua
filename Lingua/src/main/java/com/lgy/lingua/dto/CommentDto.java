package com.lgy.lingua.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentDto {
	private int idComment;
	private int idBoard;
	private String writer;
	private String writer_nickname;
	private String language;
	private String content;
	private Timestamp created;
	private Timestamp modified;
}




