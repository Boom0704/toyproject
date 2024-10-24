package com.pro.my.influencer.controller;

import com.pro.my.influencer.service.InfluencerPostService;
import com.pro.my.influencer.vo.InfluencerPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/influencer-posts")
public class InfluencerPostController {

    @Autowired
    private InfluencerPostService influencerPostService;

    @GetMapping
    public List<InfluencerPostVO> getAllInfluencerPosts() {
        return influencerPostService.getAllInfluencerPosts();
    }

    @PostMapping
    public void addInfluencerPost(@RequestBody InfluencerPostVO influencerPost) {
        influencerPostService.addInfluencerPost(influencerPost);
    }

    @DeleteMapping("/{influencerId}/{postId}")
    public void removeInfluencerPost(@PathVariable int influencerId, @PathVariable int postId) {
        influencerPostService.removeInfluencerPost(influencerId, postId);
    }
}
