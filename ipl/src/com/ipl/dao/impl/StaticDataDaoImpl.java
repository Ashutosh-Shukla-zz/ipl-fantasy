package com.ipl.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.UserBean;
import com.ipl.bean.StaticData.MatchFixturesBean;
import com.ipl.bean.StaticData.PlayerBean;
import com.ipl.bean.StaticData.StaticDataBean;
import com.ipl.bean.StaticData.TeamBean;
import com.ipl.dao.StaticDataDao;
import com.ipl.dao.UserDao;
import com.ipl.util.BCrypt;

@Component(value = "staticDataDao")
public class StaticDataDaoImpl implements StaticDataDao
{
    
    private static final Logger logger = Logger.getLogger(UserDao.class);
    
    private static final String matchFixtureQuery = "SELECT match_fixtures_tbl_id matchFixturesId, team_one_id teamOneId , get_team_code(team_one_id) teamOneCode, team_two_id teamTwoId, "
    											  + "get_team_code(team_two_id) teamTwoCode, team_winner_id teamWinId, get_team_code(team_winner_id) teamWinCode,  match_datetime matchDateTime, venue_id venueId, "
    											  + "(select venue_name from venue_tbl where venue_tbl_id = m.venue_id) venueName, "
    											  + "(select venue_city from venue_tbl where venue_tbl_id = m.venue_id) venueCity, match_status matchStatus FROM ipl.match_fixtures_tbl m order by match_status asc, match_datetime ";
    
    private static final String playerDetailsQuery = "SELECT player_tbl_id playerId, first_name firstName, last_name lastName, player_category_id categoryId, "
    											   + "(select player_category from player_category_tbl where player_category_tbl_id = player_category_id) category, "
    											   + "player_role_id roleId, (select player_role from player_role_tbl where player_role_tbl_id = player_role_id) role"
    											   + " FROM ipl.player_tbl where player_team_id = ? order by player_role_id, first_name asc ";
    
    private static final String teamsDetailQuery = "SELECT teams_tbl_id teamId, team_code teamCode, team_name teamName, is_active isActive FROM ipl.teams_tbl";
    
    private static final String userDetailQuery = "select user_master_tbl_id,first_name, last_name, email_id, mobile_number, is_admin, is_active from user_master_tbl";
    
    @Autowired
    DataSource dataSource;

    public StaticDataBean getStaticData()
    {
        logger.info("Method :: getStaticData() :: Start");
        
        StaticDataBean staticDataBean = new StaticDataBean();
        
        try
        {
        	staticDataBean.setTeamBean(getTeamDetails());
        	staticDataBean.setMatchFixturesBean(getMatchFixturesDetails());
        	staticDataBean.setUserBeanMap(getUserDetails());
        	
        }
        catch (Exception e)
        {
            e.printStackTrace();
            logger.error("Error :: getStaticData() :: " + e.getMessage());
        }
        // TODO Auto-generated method stub
        return staticDataBean;
    }
    
    private ArrayList<TeamBean> getTeamDetails() {
    	
    	logger.info("Method :: getTeamDetails() :: Start");
    	
    	TeamBean teamBean;
    	ArrayList<TeamBean> teamArrayList = new ArrayList<TeamBean>();
    	
        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(teamsDetailQuery);

            logger.info("Query to get Team Details :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();

            while (resultSet.next())
            {
            	teamBean = new TeamBean();
            	
            	teamBean.setTeamId(resultSet.getInt("teamId"));
            	teamBean.setTeamCode(resultSet.getString("teamCode"));
            	teamBean.setTeamName(resultSet.getString("teamName"));
            	teamBean.setIsActive(resultSet.getBoolean("isActive"));
            	teamBean.setPlayerBean(getplayerDetails(resultSet.getInt("teamId")));
            	teamArrayList.add(teamBean);
            }


        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: login() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: login() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: login() :: " + e.getMessage());
            }
        }
        logger.info("Method :: login() :: End");
    	
		return teamArrayList;
		
	}
    
private ArrayList<PlayerBean> getplayerDetails(int teamId) {
    	
    	logger.info("Method :: getplayerDetails() :: Start");
    	
    	PlayerBean playerBean;
    	ArrayList<PlayerBean> playerArrayList = new ArrayList<PlayerBean>();
    	
        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(playerDetailsQuery);
            pstmt.setInt(1, teamId);

            logger.info("Query to get Player Details :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();

            while (resultSet.next())
            {
            	playerBean = new PlayerBean();
            	playerBean.setPlayerId(resultSet.getInt("playerId"));
            	playerBean.setFirstName(resultSet.getString("firstName"));
            	playerBean.setLastName(resultSet.getString("lastName"));
            	playerBean.setCategoryId(resultSet.getInt("categoryId"));
            	playerBean.setCategory(resultSet.getString("category"));
            	playerBean.setRoleId(resultSet.getInt("roleId"));
            	playerBean.setRole(resultSet.getString("role"));
            	
            	playerArrayList.add(playerBean);
            }


        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getplayerDetails() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: getplayerDetails() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: getplayerDetails() :: " + e.getMessage());
            }
        }
        logger.info("Method :: getplayerDetails() :: End");
    	
		return playerArrayList;
		
	}

private ArrayList<MatchFixturesBean> getMatchFixturesDetails() {
	
	logger.info("Method :: getMatchFixturesDetails() :: Start");
	
	MatchFixturesBean matchFixturesBean;
	ArrayList<MatchFixturesBean> matchFixturesArrayList = new ArrayList<MatchFixturesBean>();
	
    PreparedStatement pstmt = null;
    Connection con = null;
    ResultSet resultSet = null;
    try
    {
        con = dataSource.getConnection();
        pstmt = con.prepareStatement(matchFixtureQuery);

        logger.info("Query to get Team Details :: " + pstmt.toString());
        resultSet = pstmt.executeQuery();

        while (resultSet.next())
        {
        	matchFixturesBean = new MatchFixturesBean();
        	
        	matchFixturesBean.setMatchFixturesId(resultSet.getInt("matchFixturesId"));
        	matchFixturesBean.setTeamOneId(resultSet.getInt("teamOneId"));
        	matchFixturesBean.setTeamOneCode(resultSet.getString("teamOneCode"));
        	matchFixturesBean.setTeamTwoId(resultSet.getInt("teamTwoId"));
        	matchFixturesBean.setTeamTwoCode(resultSet.getString("teamTwoCode"));
        	matchFixturesBean.setTeamWinId(resultSet.getInt("teamWinId"));
        	matchFixturesBean.setTeamWinCode(resultSet.getString("teamWinCode"));
        	matchFixturesBean.setMatchDateTime(resultSet.getString("matchDateTime"));
        	matchFixturesBean.setVenueId(resultSet.getInt("venueId"));
        	matchFixturesBean.setVenueName(resultSet.getString("venueName"));
        	matchFixturesBean.setVenueCity(resultSet.getString("venueCity"));
        	matchFixturesBean.setMatchStatus(resultSet.getString("matchStatus"));
        	
        	matchFixturesArrayList.add(matchFixturesBean);
        }


    }
    catch (SQLException e)
    {
        e.printStackTrace();
        logger.error("Error :: getMatchFixturesDetails() :: " + e.getMessage());
    }
    finally
    {
        try
        {
            logger.info("Error :: getMatchFixturesDetails() :: finally");
            pstmt.close();
            con.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getMatchFixturesDetails() :: " + e.getMessage());
        }
    }
    logger.info("Method :: getMatchFixturesDetails() :: End");
	
	return matchFixturesArrayList;
	
}

private Map<Integer, UserBean> getUserDetails(){
    
logger.info("Method :: getUserDetails() :: Start");
    
    Map<Integer, UserBean> userBeanMap= new HashMap<Integer, UserBean>();
    UserBean userBean;
    
    ArrayList<MatchFixturesBean> matchFixturesArrayList = new ArrayList<MatchFixturesBean>();
    
    PreparedStatement pstmt = null;
    Connection con = null;
    ResultSet resultSet = null;
    try
    {
        con = dataSource.getConnection();
        pstmt = con.prepareStatement(userDetailQuery);

        logger.info("Query to get getUserDetails :: " + pstmt.toString());
        resultSet = pstmt.executeQuery();

        while (resultSet.next())
        {
            userBean = new  UserBean();
            
                userBean.setUserId(resultSet.getInt("user_master_tbl_id"));
                userBean.setFirstName(resultSet.getString("first_name"));
                userBean.setLastName(resultSet.getString("last_name"));
                userBean.setEmail(resultSet.getString("email_id"));
                userBean.setMobile(resultSet.getString("mobile_number"));
                userBean.setIsAdmin(resultSet.getBoolean("is_admin"));
                userBean.setIsActive(resultSet.getBoolean("is_active"));
                //userBeanList.add(userBean);
                userBeanMap.put(resultSet.getInt("user_master_tbl_id"), userBean);
        }


    }
    catch (SQLException e)
    {
        e.printStackTrace();
        logger.error("Error :: getUserDetails() :: " + e.getMessage());
    }
    finally
    {
        try
        {
            logger.info("Error :: getUserDetails() :: finally");
            pstmt.close();
            con.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getUserDetails() :: " + e.getMessage());
        }
    }
    logger.info("Method :: getUserDetails() :: End");
    
    return userBeanMap;
    
    
}

}
