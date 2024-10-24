package com.pro.my.influencer.dao;

import com.pro.my.influencer.vo.InfluencerVO;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IInfluencerDAO {
    List<InfluencerVO> selectAllInfluencers();
    InfluencerVO selectInfluencerById(int id);
    void insertInfluencer(InfluencerVO influencer);
    void updateInfluencer(InfluencerVO influencer);
    void deleteInfluencer(int id);
}
