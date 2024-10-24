package com.pro.my.influencer.dao;

import com.pro.my.board.vo.BoardVO;
import com.pro.my.influencer.vo.InfluencerPostVO;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IInfluencerPostDAO {
    List<InfluencerPostVO> selectAllInfluencerPosts();
    void insertInfluencerPost(InfluencerPostVO influencerPost);
    void deleteInfluencerPost(int influencerId, int postId);
    List<BoardVO> getPostsByInfluencerId(int influencerId);
}
