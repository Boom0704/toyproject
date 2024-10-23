package com.pro.my.board.controller;

import com.pro.my.board.service.FavoriteService;
import com.pro.my.board.vo.FavoriteVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/favorites")
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

    // 즐겨찾기 추가
    @PostMapping("/add")
    public ResponseEntity<String> addFavorite(@RequestBody FavoriteVO favoriteVo) {
        System.out.println(favoriteVo.getPostId());
        System.out.println(favoriteVo.getMemId());
        System.out.println("즐겨찾기 추가 요청 처리");

        favoriteService.addFavorite(favoriteVo.getPostId(), favoriteVo.getMemId());
        return ResponseEntity.ok("Favorite added successfully");
    }

    // 즐겨찾기 삭제
    @DeleteMapping("/remove")
    public ResponseEntity<String> removeFavorite(@RequestBody FavoriteVO favoriteVo) {
        favoriteService.removeFavorite(favoriteVo.getPostId(), favoriteVo.getMemId());
        return ResponseEntity.ok("Favorite removed successfully");
    }

    // 즐겨찾기 여부 확인
    @GetMapping("/check")
    public ResponseEntity<Boolean> checkFavorite(@RequestParam int postId, @RequestParam String memId) {
        boolean isFavorited = favoriteService.isFavorited(postId, memId);
        return ResponseEntity.ok(isFavorited);
    }
}
