package com.ipl.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.UserBean;
import com.ipl.dao.AdminDao;
import com.ipl.service.AdminService;
import com.ipl.util.JsonPlayerMap;
import com.ipl.util.MatchResultData;

@Component(value="adminService")
public class AdminServiceImpl implements AdminService
{
    
    @Autowired
    AdminDao adminDao;

    @Override
    public String insertPlayerStat(String matchId, String playerId, String runs, String wickets, String runOuts,
            String catches)
    {
        return adminDao.insertPlayerStat(matchId,playerId,runs,wickets,runOuts,catches);
        
    }

    @Override
    public String updateManOftheMatch(String matchIdMom, String playerId)
    {
        // TODO Auto-generated method stub
        return adminDao.updateManOftheMatch(matchIdMom,playerId);
    }

    @Override
    public String updateMatchWinner(String matchIdWin, String teamId)
    {
        // TODO Auto-generated method stub
        return adminDao.updateMatchWinner(matchIdWin, teamId);
    }

    @Override
    public ArrayList<UserBean> getPendingUserListForApproval()
    {
        return adminDao.getPendingUserListForApproval();
    }

    @Override
    public String approveUser(String userId)
    {
        // TODO Auto-generated method stub
        return adminDao.approveUser(userId);
    }

	@Override
	public String launchMissile(String matchId) {
		// TODO Auto-generated method stub
		return adminDao.launchMissile(matchId);
	}
	
	@Override
	public String generateUserFixture(String matchId) {
		// TODO Auto-generated method stub
		return adminDao.generateUserFixture(matchId);
	}
	
    @Override
    public String getMatchResult(String matchId)
    {
        MatchResultData mrd = new MatchResultData();
        HashMap<String, JsonPlayerMap> playerScoreMap = new HashMap<>();
        try
        {
            playerScoreMap=   mrd.getMatchResultData(matchId);
        }
        catch (IOException | JSONException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        String message = adminDao.updatePlayerScore(matchId,playerScoreMap);
        //getPlayerScoreUpdateQuery(playerScoreMap);
        
        return message;
    }

	@Override
	public String updateDashBoardMsg(String dashBoardMsg) {
		// TODO Auto-generated method stub
		return adminDao.updateDashBoardMsg(dashBoardMsg);
	}

}
