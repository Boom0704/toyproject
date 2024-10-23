package com.pro.my.catmap.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pro.my.board.service.BoardService;
import com.pro.my.board.vo.BoardVO;

@Controller
public class CatmapController {
	

    @Autowired
    private BoardService boardService;
    
	@RequestMapping("/catmapView")
	public String catmapView(Model model) {
		List<BoardVO> boardList = boardService.selectAllBoards();
	    model.addAttribute("boards", boardList);  // 모델 이름을 'boards'로 맞춤
		return "map/catmapView";
	}
}
