package com.lgy.lingua.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.lingua.dto.UserDto;

public interface UserDao {
	public ArrayList<UserDto> login(HashMap<String, String> params);
}



