package com.pro.my.board.controller;

import com.pro.my.board.service.LikesService;
import com.pro.my.board.vo.LikesVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/likes")
public class LikesController {

    @Autowired
    private LikesService likesService;

    // 좋아요 추가
    @PostMapping("/add")
    public ResponseEntity<String> addLike(@RequestBody LikesVO likeVo) {
        System.out.println(likeVo.getPostId());
        System.out.println(likeVo.getMemId());
        System.out.println("좋아요 추가 요청 처리");

        likesService.addLike(likeVo.getPostId(), likeVo.getMemId());
        return ResponseEntity.ok("Like added successfully");
    }

    // 좋아요 삭제
    @DeleteMapping("/remove")
    public ResponseEntity<String> removeLike(@RequestBody LikesVO likeVo) {
        likesService.removeLike(likeVo.getPostId(), likeVo.getMemId());
        return ResponseEntity.ok("Like removed successfully");
    }

    // 좋아요 여부 확인
    @GetMapping("/check")
    public ResponseEntity<Boolean> checkLike(@RequestParam int postId, @RequestParam String memId) {
        boolean isLiked = likesService.isLiked(postId, memId);
        return ResponseEntity.ok(isLiked);
    }
}
