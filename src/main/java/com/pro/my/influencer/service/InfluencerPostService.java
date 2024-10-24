package com.pro.my.influencer.service;

import com.pro.my.board.vo.BoardVO;
import com.pro.my.influencer.dao.IInfluencerPostDAO;
import com.pro.my.influencer.vo.InfluencerPostVO;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InfluencerPostService {

	@Autowired
    private IInfluencerPostDAO influencerPostDAO;

    public List<InfluencerPostVO> getAllInfluencerPosts() {
        return influencerPostDAO.selectAllInfluencerPosts();
    }

    public void addInfluencerPost(InfluencerPostVO influencerPost) {
        influencerPostDAO.insertInfluencerPost(influencerPost);
    }

    public void removeInfluencerPost(int influencerId, int postId) {
        influencerPostDAO.deleteInfluencerPost(influencerId, postId);
    }

	public List<BoardVO> getInfluencerById(int id) {
		 return influencerPostDAO.getPostsByInfluencerId(id);
	}
}
