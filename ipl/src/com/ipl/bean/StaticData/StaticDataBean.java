package com.ipl.bean.StaticData;

import java.util.ArrayList;
import java.util.Map;

import com.ipl.bean.UserBean;

public class StaticDataBean
{

    public ArrayList<TeamBean> teamBean;

    public ArrayList<MatchFixturesBean> matchFixturesBean;

    public Map<Integer, TeamBean> teamBeanMap;

    public Map<Integer, MatchFixturesBean> matchFixturesBeanMap;

    public Map<Integer, UserBean> userBeanMap;

    public ArrayList<TeamBean> getTeamBean()
    {
        return teamBean;
    }

    public void setTeamBean(ArrayList<TeamBean> teamBean)
    {
        this.teamBean = teamBean;
    }

    public ArrayList<MatchFixturesBean> getMatchFixturesBean()
    {
        return matchFixturesBean;
    }

    public void setMatchFixturesBean(ArrayList<MatchFixturesBean> matchFixturesBean)
    {
        this.matchFixturesBean = matchFixturesBean;
    }

    public Map<Integer, TeamBean> getTeamBeanMap()
    {
        return teamBeanMap;
    }

    public void setTeamBeanMap(Map<Integer, TeamBean> teamBeanMap)
    {
        this.teamBeanMap = teamBeanMap;
    }

    public Map<Integer, MatchFixturesBean> getMatchFixturesBeanMap()
    {
        return matchFixturesBeanMap;
    }

    public void setMatchFixturesBeanMap(Map<Integer, MatchFixturesBean> matchFixturesBeanMap)
    {
        this.matchFixturesBeanMap = matchFixturesBeanMap;
    }

    public Map<Integer, UserBean> getUserBeanMap()
    {
        return userBeanMap;
    }

    public void setUserBeanMap(Map<Integer, UserBean> userBeanMap)
    {
        this.userBeanMap = userBeanMap;
    }

}
