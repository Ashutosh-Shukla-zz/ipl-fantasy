package com.ipl.bean.StaticData;

import java.util.ArrayList;
import java.util.Map;

public class TeamBean
{
    private int teamId;

    private String teamName;

    private String teamCode;

    private Boolean isActive;
    
    private ArrayList<PlayerBean> playerBean;
    
    private Map<Integer, PlayerBean> playerBeanMap;

	public int getTeamId() {
		return teamId;
	}

	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getTeamCode() {
		return teamCode;
	}

	public void setTeamCode(String teamCode) {
		this.teamCode = teamCode;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public ArrayList<PlayerBean> getPlayerBean() {
		return playerBean;
	}

	public void setPlayerBean(ArrayList<PlayerBean> playerBean) {
		this.playerBean = playerBean;
	}

	public Map<Integer, PlayerBean> getPlayerBeanMap() {
		return playerBeanMap;
	}

	public void setPlayerBeanMap(Map<Integer, PlayerBean> playerBeanMap) {
		this.playerBeanMap = playerBeanMap;
	}
	
	
 
}
