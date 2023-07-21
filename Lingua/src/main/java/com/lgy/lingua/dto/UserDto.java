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
	
	private String korean;
	private String english;
	private String japanese;
	private String polish;
}




