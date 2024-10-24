package com.pro.my.influencer.controller;

import com.pro.my.board.vo.BoardVO;
import com.pro.my.influencer.service.InfluencerPostService;
import com.pro.my.influencer.service.InfluencerService;
import com.pro.my.influencer.vo.InfluencerVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller // RestController가 아닌 일반 Controller로 변경
@RequestMapping("/influencers")
public class InfluencerController {

    @Autowired
    private InfluencerService influencerService;
    @Autowired
    private InfluencerPostService influencerPostService;

    @RequestMapping("/{id}")
    public String influencerView(@PathVariable("id") int id, Model model) {
        InfluencerVO vo = influencerService.getInfluencerById(id);
        List<BoardVO> boardList = influencerPostService.getInfluencerById(id);

        // boardList를 for문과 System.out.println으로 출력
        for (BoardVO board : boardList) {
            System.out.println(board);
        }

        model.addAttribute("influencer", vo);
        model.addAttribute("boardList", boardList);

        return "influencer/influencerView"; // JSP 페이지 반환
    }

    @GetMapping("/data/{id}")
    @ResponseBody
    public InfluencerVO getInfluencerById(@PathVariable int id) {
        return influencerService.getInfluencerById(id);
    }

    @GetMapping
    @ResponseBody
    public List<InfluencerVO> getAllInfluencers() {
        return influencerService.getAllInfluencers();
    }

    @PostMapping
    @ResponseBody
    public void addInfluencer(@RequestBody InfluencerVO influencer) {
        influencerService.addInfluencer(influencer);
    }

    @PutMapping("/{id}")
    @ResponseBody
    public void updateInfluencer(@PathVariable int id, @RequestBody InfluencerVO influencer) {
        influencer.setId(id);
        influencerService.updateInfluencer(influencer);
    }

    @DeleteMapping("/{id}")
    @ResponseBody
    public void deleteInfluencer(@PathVariable int id) {
        influencerService.removeInfluencer(id);
    }
}
