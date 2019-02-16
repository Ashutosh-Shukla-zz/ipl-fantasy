package com.ipl.service;

import java.util.ArrayList;
import java.util.Map;

import com.ipl.bean.PlayerStatsBean;
import com.ipl.bean.TopScorerBean;
import com.ipl.bean.UserFixtureBean;
import com.ipl.bean.UserPointsBean;
import com.ipl.bean.UserSelectionBean;

public interface MatchService
{
    public UserPointsBean userPointDetails(int userId);

    public UserSelectionBean userVoteDetails(int userId, int matchId);

    public ArrayList<UserSelectionBean> userVoteDetailsList(int userId, String date);

    public String votePlayers(UserSelectionBean userSelectionBean);

    public ArrayList<Integer> userFixtureVote(int userId);

    public ArrayList<UserFixtureBean> getUserFixtureHistory(String userId);

    public UserFixtureBean getHistoryDetail(UserFixtureBean userFixtureBean);
    
    public ArrayList<UserSelectionBean> getSecondUserVoteDetailsList(int userId, String date);
    
    public Map<String, String> getSystemParametes();
    
    public Map<String, ArrayList<String>> getPlayingXI(int matchId);
    
    public Map<String, ArrayList<PlayerStatsBean>> getPlayerStats();
    
    public ArrayList<TopScorerBean> getTopScorer();
    
}
