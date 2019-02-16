package com.ipl.util;

public class JsonPlayerMap
{

    private int playerId;

    private String playerName;

    private int runs=0;

    private int wickets=0;

    private int runOuts=0;

    private int catches=0;
    
    private int stumping=0;

    private Boolean isMom=Boolean.FALSE;

    public int getPlayerId()
    {
        return playerId;
    }

    public void setPlayerId(int playerId)
    {
        this.playerId = playerId;
    }

    public Boolean getIsMom()
    {
        return isMom;
    }

    public void setIsMom(Boolean isMom)
    {
        this.isMom = isMom;
    }

    public String getPlayerName()
    {
        return playerName;
    }

    public void setPlayerName(String playerName)
    {
        this.playerName = playerName;
    }

    public int getRuns()
    {
        return runs;
    }

    public void setRuns(int runs)
    {
        this.runs = runs;
    }

    public int getWickets()
    {
        return wickets;
    }

    public void setWickets(int wickets)
    {
        this.wickets = wickets;
    }

    public int getRunOuts()
    {
        return runOuts;
    }

    public void setRunOuts(int runOuts)
    {
        this.runOuts = runOuts;
    }

    public int getCatches()
    {
        return catches;
    }

    public void setCatches(int catches)
    {
        this.catches = catches;
    }

	public int getStumping() {
		return stumping;
	}

	public void setStumping(int stumping) {
		this.stumping = stumping;
	}

}
