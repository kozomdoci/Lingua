package com.lgy.lingua.command;

import java.util.HashMap;

import com.lgy.lingua.dto.UserDto;

public interface UserCommand {
	public UserDto login(HashMap<String, String> params);
}



