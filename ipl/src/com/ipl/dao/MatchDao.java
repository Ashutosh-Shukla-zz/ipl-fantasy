package com.ipl.dao;

import java.util.ArrayList;
import java.util.Map;

import com.ipl.bean.PlayerStatsBean;
import com.ipl.bean.TopScorerBean;
import com.ipl.bean.UserFixtureBean;
import com.ipl.bean.UserPointsBean;
import com.ipl.bean.UserSelectionBean;

public interface MatchDao
{
    public UserPointsBean getUserPointDetails(int userId);

    public Map<String, String> getUserVoteDetails(int userId, int matchId);

    public String insertUpdateVotePlayers(UserSelectionBean userSelectionBean);

    public ArrayList<Integer> getFixtureVotedetails(int userId);

    public ArrayList<UserFixtureBean> getUserFixtureHistory(String userId);

    public UserFixtureBean getUserPlayerPoints(UserFixtureBean userFixtureBean);
    
    public int getOponnentId(int userId, int matchFixturesId);
    
    public Map<String, String> getSystemParametes();
    
    public Map<String, ArrayList<PlayerStatsBean>> getPlayerStatistics();
    
    public ArrayList<TopScorerBean> getTopScorer();
}
