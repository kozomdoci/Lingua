package com.lgy.lingua.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {
	private String email;
	private String nickname;
	private String password;
	private String imgPath;
	private String authority;
	
	/*
	email VARCHAR(100)
	nickname VARCHAR(100)
	password VARCHAR(100)
	imgPath LONGTEXT
	authority ENUM('user','admin')
	*/
}




