package com.ipl.bean;

public class TopScorerBean
{

    private int matchFixtureId;
    
    private String teamOne;
    
    private String teamTwo;
    
    private String fullName;

    private Boolean isAutoVote;
    
    private String userPoints;

	public int getMatchFixtureId() {
		return matchFixtureId;
	}

	public void setMatchFixtureId(int matchFixtureId) {
		this.matchFixtureId = matchFixtureId;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public Boolean getIsAutoVote() {
		return isAutoVote;
	}

	public void setIsAutoVote(Boolean isAutoVote) {
		this.isAutoVote = isAutoVote;
	}

	public String getUserPoints() {
		return userPoints;
	}

	public void setUserPoints(String userPoints) {
		this.userPoints = userPoints;
	}

	public String getTeamOne() {
		return teamOne;
	}

	public void setTeamOne(String teamOne) {
		this.teamOne = teamOne;
	}

	public String getTeamTwo() {
		return teamTwo;
	}

	public void setTeamTwo(String teamTwo) {
		this.teamTwo = teamTwo;
	}
    
}
