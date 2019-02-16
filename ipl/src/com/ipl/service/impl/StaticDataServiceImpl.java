package com.ipl.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.StaticData.MatchFixturesBean;
import com.ipl.bean.StaticData.PlayerBean;
import com.ipl.bean.StaticData.StaticDataBean;
import com.ipl.bean.StaticData.TeamBean;
import com.ipl.dao.StaticDataDao;
import com.ipl.service.StaticDataService;

@Component(value = "staticDataService")
public class StaticDataServiceImpl implements StaticDataService
{
	  private static final Logger logger = Logger.getLogger(UserServiceImpl.class);

	@Autowired
	StaticDataDao staticDataDao;

	public StaticDataBean populateStaticData() {
		// TODO Auto-generated method stub
		
		logger.info("Method :: populateStaticData() : StaticDataServiceImpl");
		
		 Map<Integer, MatchFixturesBean> matchFixturesBeanMap = new HashMap<Integer, MatchFixturesBean>();
		 Map<Integer, TeamBean> teamMap= new HashMap<Integer, TeamBean>();
		 Map<Integer, PlayerBean> playerMap= null;
		
		StaticDataBean  staticDataBean = new StaticDataBean();
		
		staticDataBean = staticDataDao.getStaticData();
			
			 for(TeamBean teamBeanList : staticDataBean.teamBean){
				 playerMap = new HashMap<Integer, PlayerBean>();
				 for(PlayerBean playerBeanList : teamBeanList.getPlayerBean()){
					 playerMap.put(playerBeanList.getPlayerId(), playerBeanList);
				 }
				 teamBeanList.setPlayerBeanMap(playerMap);
				 teamMap.put(teamBeanList.getTeamId() , teamBeanList);
			    }
			 
			 
			 for(MatchFixturesBean matchFixturesBeanList : staticDataBean.matchFixturesBean){
				 matchFixturesBeanMap.put(matchFixturesBeanList.getMatchFixturesId(),matchFixturesBeanList)	;
			 }
			 
			 staticDataBean.setTeamBeanMap(teamMap);
			 staticDataBean.setMatchFixturesBeanMap(matchFixturesBeanMap);
			return staticDataBean;
			
	}
}
