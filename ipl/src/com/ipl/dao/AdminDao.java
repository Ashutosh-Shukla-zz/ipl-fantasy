package com.ipl.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.ipl.bean.UserBean;
import com.ipl.util.JsonPlayerMap;

public interface AdminDao
{

    String insertPlayerStat(String matchId, String playerId, String runs, String wickets, String runOuts,
            String catches);

    String updateManOftheMatch(String matchIdMom, String playerId);

    String updateMatchWinner(String matchIdWin, String teamId);

    ArrayList<UserBean> getPendingUserListForApproval();

    String approveUser(String userId);
    
    String launchMissile(String matchId);
    
    String generateUserFixture(String matchId);

    String updatePlayerScore(String matchId, HashMap<String, JsonPlayerMap> playerScoreMap);
    
    String updateDashBoardMsg(String dashBoardMsg);

}
