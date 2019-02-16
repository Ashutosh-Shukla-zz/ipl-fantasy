package com.ipl.service;

import java.util.ArrayList;

import com.ipl.bean.UserBean;

public interface AdminService
{

    String insertPlayerStat(String matchId, String playerId, String runs, String wickets, String runOuts, String catches);

    String updateManOftheMatch(String matchIdMom, String playerId);

    String updateMatchWinner(String matchIdWin, String teamId);

    ArrayList<UserBean> getPendingUserListForApproval();

    String approveUser(String userId);
    
    String launchMissile(String matchId);
    
    String generateUserFixture(String matchId);
    
    String getMatchResult(String matchId);
    
    String updateDashBoardMsg(String dashBoardMsg);

}
