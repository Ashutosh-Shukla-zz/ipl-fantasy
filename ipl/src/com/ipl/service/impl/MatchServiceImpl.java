package com.ipl.service.impl;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.PlayerStatsBean;
import com.ipl.bean.TopScorerBean;
import com.ipl.bean.UserFixtureBean;
import com.ipl.bean.UserPointsBean;
import com.ipl.bean.UserSelectionBean;
import com.ipl.bean.StaticData.MatchFixturesBean;
import com.ipl.bean.StaticData.PlayerBean;
import com.ipl.bean.StaticData.StaticDataBean;
import com.ipl.controller.StaticDataController;
import com.ipl.dao.MatchDao;
import com.ipl.service.MatchService;
import com.ipl.util.JsonPlayerMap;
import com.ipl.util.MatchResultData;

@Component(value="matchService")
public class MatchServiceImpl implements MatchService
{
	 
	private static final Logger logger = Logger.getLogger(UserServiceImpl.class);
	 
    @Autowired
    MatchDao matchDao;
    private static StaticDataBean staticDataBean = null;
    
    public UserPointsBean userPointDetails(int userId){
    	
    	logger.info("Method :: registerUser() : UserService :");
    	
		return matchDao.getUserPointDetails(userId);
    	
    }

    @Override
    public UserSelectionBean userVoteDetails(int userId, int matchId) {
        // TODO Auto-generated method stub
        logger.info("Method :: registerUser() : UserService :");
        
        UserSelectionBean userSelectionBean = new UserSelectionBean();
        Map<String, String> userVoteDetails = new HashMap<>();
        ArrayList<PlayerBean> selectedPlayerBeanList = new ArrayList<PlayerBean>();     
        staticDataBean = new StaticDataBean();
        
        userVoteDetails = matchDao.getUserVoteDetails(userId , matchId);
        
        userSelectionBean.setUserId(userId);
        userSelectionBean.setMatchId(matchId);
        
        if(userVoteDetails !=null){
            
            userSelectionBean.setPlayerMomId(Integer.parseInt(userVoteDetails.get("momPlayerId") == null ? "0" : userVoteDetails.get("momPlayerId").toString()));
            userSelectionBean.setWinTeamId(Integer.parseInt(userVoteDetails.get("selectedTeamId") == null ? "0" : userVoteDetails.get("selectedTeamId").toString()));
            userSelectionBean.setSelectedPlayersIds(userVoteDetails.get("playerSelectionIds") == null ? "" : userVoteDetails.get("playerSelectionIds").toString());
            userSelectionBean.setIsAutoVote(userVoteDetails.get("isAutoVote") == null ? 0 : Integer.parseInt(userVoteDetails.get("isAutoVote")));
            
            staticDataBean = StaticDataController.getStaticDataBean();
            int teamOneId = staticDataBean.getMatchFixturesBeanMap().get(matchId).getTeamOneId();
            int teamTwoId = staticDataBean.getMatchFixturesBeanMap().get(matchId).getTeamTwoId();
            
            StringTokenizer st=new StringTokenizer(userVoteDetails.get("playerSelectionIds"), "|");
            while(st.hasMoreTokens()){
                
                int playerId = Integer.parseInt(st.nextToken().toString());
                if(staticDataBean.getTeamBeanMap().get(teamOneId).getPlayerBeanMap().containsKey(playerId)){
                    selectedPlayerBeanList.add(staticDataBean.getTeamBeanMap().get(teamOneId).getPlayerBeanMap().get(playerId));
                }
                if(staticDataBean.getTeamBeanMap().get(teamTwoId).getPlayerBeanMap().containsKey(playerId)){
                    selectedPlayerBeanList.add(staticDataBean.getTeamBeanMap().get(teamTwoId).getPlayerBeanMap().get(playerId));
                }
            }
            userSelectionBean.setSelectedPlayerBeanList(selectedPlayerBeanList);
        }
        return userSelectionBean;
    }


    @Override
    public ArrayList<UserSelectionBean> userVoteDetailsList(int userId, String date){
        
        logger.info("Method :: userVoteDetailsList() : Get user vote details lists for particular date :");
        
        List<UserSelectionBean> userSelectionBeanList = new ArrayList<UserSelectionBean>();
        SimpleDateFormat fixtureFormatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); //2017-04-05 20:00:00
        SimpleDateFormat currentDateFormatter = new SimpleDateFormat("dd/MM/yyyy"); 

        staticDataBean =  StaticDataController.getStaticDataBean();

        
        for(MatchFixturesBean fixture : staticDataBean.matchFixturesBean){
            
            String matchFixtureDate = fixture.getMatchDateTime();
            
            try {
                Date fixtureDate = fixtureFormatter.parse(matchFixtureDate);
                if(date.equals(currentDateFormatter.format(fixtureDate))){
                    System.out.println(fixture.getMatchFixturesId());
                    userSelectionBeanList.add(userVoteDetails(userId,fixture.getMatchFixturesId()));    
                }
            } catch (ParseException e) {
            
                e.printStackTrace();
                logger.error("Error :: userVoteDetailsList() :: " + e.getMessage());
            }
            
        }
        
        return (ArrayList<UserSelectionBean>) userSelectionBeanList;    
        
    }

    @Override
    public ArrayList<Integer> userFixtureVote(int userId) {
        // TODO Auto-generated method stub
        logger.info("Method :: userFixtureVote() :");
        
        return matchDao.getFixtureVotedetails(userId);
    }


	@Override
	public String votePlayers(UserSelectionBean userSelectionBean) {
		// TODO Auto-generated method stub
		logger.info("Method :: registerUser() : UserService :");
    	
		return matchDao.insertUpdateVotePlayers(userSelectionBean);
	}

    @Override
    public ArrayList<UserFixtureBean> getUserFixtureHistory(String userId)
    {
        
        return matchDao.getUserFixtureHistory(userId);
    }

    @Override
    public UserFixtureBean getHistoryDetail(UserFixtureBean userFixtureBean)
    {
        userFixtureBean.setUserOneBeanSelectionBean(userVoteDetails(userFixtureBean.getUserOneId(), userFixtureBean.getMatchId()));
        userFixtureBean.setUserTwoBeanSelectionBean(userVoteDetails(userFixtureBean.getUserTwoId(), userFixtureBean.getMatchId()));
        userFixtureBean =  matchDao.getUserPlayerPoints(userFixtureBean);
       return userFixtureBean;
    }
    
    @Override
    public ArrayList<UserSelectionBean> getSecondUserVoteDetailsList(int userId, String date)
    {
        logger.info("Method :: getSecondUserVoteDetailsList() : Get user vote details lists for particular date :");
        
        List<UserSelectionBean> userOpponnentSelectionBeanList = new ArrayList<UserSelectionBean>();
        SimpleDateFormat fixtureFormatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); //2017-04-05 20:00:00
        SimpleDateFormat currentDateFormatter = new SimpleDateFormat("dd/MM/yyyy"); 

        staticDataBean =  StaticDataController.getStaticDataBean();

        int opponnentId=0;
        for(MatchFixturesBean fixture : staticDataBean.matchFixturesBean){
            
            String matchFixtureDate = fixture.getMatchDateTime();
            
            try {
                Date fixtureDate = fixtureFormatter.parse(matchFixtureDate);
                if(date.equals(currentDateFormatter.format(fixtureDate))){
                    //System.out.println(fixture.getMatchFixturesId());
                    opponnentId =  matchDao.getOponnentId(userId,fixture.getMatchFixturesId());
                    
                    userOpponnentSelectionBeanList.add(userVoteDetails(opponnentId,fixture.getMatchFixturesId()));    
                }
            } catch (ParseException e) {
            
                e.printStackTrace();
                logger.error("Error :: getSecondUserVoteDetailsList() :: " + e.getMessage());
            }
        }
        
        return (ArrayList<UserSelectionBean>) userOpponnentSelectionBeanList;
    }
    
	@Override
	public Map<String, String> getSystemParametes() {
		// TODO Auto-generated method stub
		return matchDao.getSystemParametes();
	}
	
	@Override
	public Map<String, ArrayList<String>> getPlayingXI(int matchId) {
		// TODO Auto-generated method stub
		NumberFormat formatter = new DecimalFormat("00");  
		String matchNo = formatter.format(matchId);
		
		HashMap<String, ArrayList<String>> playingXIMap = new HashMap<String, ArrayList<String>>();
		
		ArrayList<String> playingXIPlayerList =null;
		 
		try {
			JSONObject json = MatchResultData.readJsonFromUrl("http://datacdn.iplt20.com/dynamic/data/core/cricket/2012/ipl2018/ipl2018-"+matchNo+"/scoring.js");
			
			JSONArray teamsArray =  json.getJSONObject("matchInfo").getJSONArray("teams");
			
			for(int i=0;i< teamsArray.length();i++){
				
				playingXIPlayerList = new ArrayList<String>();
				
				JSONArray playerArray = teamsArray.getJSONObject(i).getJSONArray("players");
				
				for(int j=0; j< playerArray.length(); j++){
					playingXIPlayerList.add(playerArray.getJSONObject(j).getString("fullName").replace("'", " "));
				}
				
				//Ghanda Code likha hai....just ignore
				if(!json.getJSONObject("matchInfo").getJSONObject("additionalInfo").isNull("toss.elected")){
					ArrayList<String> tossList = new ArrayList<>();
					tossList.add(json.getJSONObject("matchInfo").getJSONObject("additionalInfo").getString("toss.elected"));
					playingXIMap.put("Toss", tossList );
				}
				playingXIMap.put(teamsArray.getJSONObject(i).getJSONObject("team").getString("abbreviation"), playingXIPlayerList);
								
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return playingXIMap;
	}

	@Override
	public Map<String, ArrayList<PlayerStatsBean>> getPlayerStats() {
		// TODO Auto-generated method stub
		return matchDao.getPlayerStatistics();
	}

	@Override
	public ArrayList<TopScorerBean> getTopScorer() {
		// TODO Auto-generated method stub
		return matchDao.getTopScorer();
	}

}
