package com.ipl.bean;

import java.util.ArrayList;

import com.ipl.bean.StaticData.PlayerBean;

public class UserSelectionBean
{

    private int userId;

    private int matchId;

    private int playerMomId;

    private int winTeamId;

    private String selectedPlayersIds;

    private ArrayList<PlayerBean> selectedPlayerBeanList;
    
    private int isAutoVote;

    public int getUserId()
    {
        return userId;
    }

    public void setUserId(int userId)
    {
        this.userId = userId;
    }

    public int getMatchId()
    {
        return matchId;
    }

    public void setMatchId(int matchId)
    {
        this.matchId = matchId;
    }

    public int getPlayerMomId()
    {
        return playerMomId;
    }

    public void setPlayerMomId(int playerMomId)
    {
        this.playerMomId = playerMomId;
    }

    public int getWinTeamId()
    {
        return winTeamId;
    }

    public void setWinTeamId(int winTeamId)
    {
        this.winTeamId = winTeamId;
    }

    public String getSelectedPlayersIds()
    {
        return selectedPlayersIds;
    }

    public void setSelectedPlayersIds(String selectedPlayersIds)
    {
        this.selectedPlayersIds = selectedPlayersIds;
    }

    public ArrayList<PlayerBean> getSelectedPlayerBeanList()
    {
        return selectedPlayerBeanList;
    }

    public void setSelectedPlayerBeanList(ArrayList<PlayerBean> selectedPlayerBeanList)
    {
        this.selectedPlayerBeanList = selectedPlayerBeanList;
    }

	public int getIsAutoVote() {
		return isAutoVote;
	}

	public void setIsAutoVote(int isAutoVote) {
		this.isAutoVote = isAutoVote;
	}

    

}
