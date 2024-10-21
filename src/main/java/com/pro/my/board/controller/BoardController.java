package com.pro.my.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	@RequestMapping("/boardView")
	public String boardView() {
		return "board/boardView";
	}
	
	@RequestMapping("/boardWriteView")
	public String boardWriteView() {
		return "board/boardWriteView";
	}
	
	@RequestMapping("/boardDetailView")
	public String boardDetailView() {
		return "board/boardDetailView";
	}
}
