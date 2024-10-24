package com.pro.my.influencer.service;

import com.pro.my.influencer.dao.IInfluencerDAO;
import com.pro.my.influencer.vo.InfluencerVO;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InfluencerService {
    
    @Autowired
    private IInfluencerDAO influencerDAO;

    // Get all influencers
    public List<InfluencerVO> getAllInfluencers() {
        return influencerDAO.selectAllInfluencers();
    }

    // Get influencer by ID
    public InfluencerVO getInfluencerById(int id) {
        return influencerDAO.selectInfluencerById(id);
    }

    // Add a new influencer
    public void addInfluencer(InfluencerVO influencer) {
        influencerDAO.insertInfluencer(influencer);
    }

    // Update an influencer
    public void updateInfluencer(InfluencerVO influencer) {
        influencerDAO.updateInfluencer(influencer);
    }

    // Remove an influencer
    public void removeInfluencer(int id) {
        influencerDAO.deleteInfluencer(id);
    }
}
