package com.lgy.lingua.command;

import java.util.HashMap;

import com.lgy.lingua.dto.UserDto;

public interface UserCommand {
	UserDto login(HashMap<String, String> params);
	void register(HashMap<String, String> params);
	void update(HashMap<String, String> params);
	void updateTemPwd(HashMap<String, String> params);
	void delete(HashMap<String, String> params);
}





