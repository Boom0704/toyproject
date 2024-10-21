package com.pro.my.catmap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CatmapController {
	@RequestMapping("/catmapView")
	public String catmapView() {
		return "map/catmapView";
	}
}
