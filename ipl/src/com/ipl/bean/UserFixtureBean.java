package com.ipl.bean;

public class UserFixtureBean
{

    private int matchId;

    private int userOnePoints;

    private int userTwoPoints;
    
    private int userOneTeamPlayerPoints;

    private int userTwoTeamPlayerPoints;

    private int userWinnerId;

    private int userOneId;

    private int userTwoId;

    private String userOneName;

    private String userTwoName;

    private UserSelectionBean userOneBeanSelectionBean;

    private UserSelectionBean userTwoBeanSelectionBean;

    public int getUserOneId()
    {
        return userOneId;
    }

    public void setUserOneId(int userOneId)
    {
        this.userOneId = userOneId;
    }

    public int getUserTwoId()
    {
        return userTwoId;
    }

    public void setUserTwoId(int userTwoId)
    {
        this.userTwoId = userTwoId;
    }

    public String getUserOneName()
    {
        return userOneName;
    }

    public void setUserOneName(String userOneName)
    {
        this.userOneName = userOneName;
    }

    public String getUserTwoName()
    {
        return userTwoName;
    }

    public void setUserTwoName(String userTwoName)
    {
        this.userTwoName = userTwoName;
    }

    public int getMatchId()
    {
        return matchId;
    }

    public void setMatchId(int matchId)
    {
        this.matchId = matchId;
    }

    public int getUserOnePoints()
    {
        return userOnePoints;
    }

    public void setUserOnePoints(int userOnePoints)
    {
        this.userOnePoints = userOnePoints;
    }

    public int getUserTwoPoints()
    {
        return userTwoPoints;
    }

    public void setUserTwoPoints(int userTwoPoints)
    {
        this.userTwoPoints = userTwoPoints;
    }

    public int getUserWinnerId()
    {
        return userWinnerId;
    }

    public void setUserWinnerId(int userWinnerId)
    {
        this.userWinnerId = userWinnerId;
    }

    public UserSelectionBean getUserOneBeanSelectionBean()
    {
        return userOneBeanSelectionBean;
    }

    public void setUserOneBeanSelectionBean(UserSelectionBean userOneBeanSelectionBean)
    {
        this.userOneBeanSelectionBean = userOneBeanSelectionBean;
    }

    public UserSelectionBean getUserTwoBeanSelectionBean()
    {
        return userTwoBeanSelectionBean;
    }

    public void setUserTwoBeanSelectionBean(UserSelectionBean userTwoBeanSelectionBean)
    {
        this.userTwoBeanSelectionBean = userTwoBeanSelectionBean;
    }

	public int getUserOneTeamPlayerPoints() {
		return userOneTeamPlayerPoints;
	}

	public void setUserOneTeamPlayerPoints(int userOneTeamPlayerPoints) {
		this.userOneTeamPlayerPoints = userOneTeamPlayerPoints;
	}

	public int getUserTwoTeamPlayerPoints() {
		return userTwoTeamPlayerPoints;
	}

	public void setUserTwoTeamPlayerPoints(int userTwoTeamPlayerPoints) {
		this.userTwoTeamPlayerPoints = userTwoTeamPlayerPoints;
	}

    
}
