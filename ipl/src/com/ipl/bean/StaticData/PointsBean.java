package com.ipl.bean.StaticData;

public class PointsBean
{
    private int matchId;

    private int wickets;

    private int runs;

    private int runOuts;

    private Boolean manOftheMatch;

    private int catches;

    private int totalScore;

    public int getTotalScore()
    {
        return totalScore;
    }

    public void setTotalScore(int totalScore)
    {
        this.totalScore = totalScore;
    }

    public int getMatchId()
    {
        return matchId;
    }

    public void setMatchId(int matchId)
    {
        this.matchId = matchId;
    }

    public int getWickets()
    {
        return wickets;
    }

    public void setWickets(int wickets)
    {
        this.wickets = wickets;
    }

    public int getRuns()
    {
        return runs;
    }

    public void setRuns(int runs)
    {
        this.runs = runs;
    }

    public int getRunOuts()
    {
        return runOuts;
    }

    public void setRunOuts(int runOuts)
    {
        this.runOuts = runOuts;
    }

    public Boolean getManOftheMatch()
    {
        return manOftheMatch;
    }

    public void setManOftheMatch(Boolean manOftheMatch)
    {
        this.manOftheMatch = manOftheMatch;
    }

    public int getCatches()
    {
        return catches;
    }

    public void setCatches(int catches)
    {
        this.catches = catches;
    }

}
