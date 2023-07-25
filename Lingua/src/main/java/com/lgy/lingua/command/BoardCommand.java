package com.lgy.lingua.command;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.lingua.dto.BoardDto;

public interface BoardCommand {
	ArrayList<BoardDto> list();
	void write(HashMap<String, String> params);
	BoardDto contentView(HashMap<String, String> params);
	void edit(HashMap<String, String> params);
}
