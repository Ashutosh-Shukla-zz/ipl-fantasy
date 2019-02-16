package com.ipl.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.PlayerStatsBean;
import com.ipl.bean.TopScorerBean;
import com.ipl.bean.UserFixtureBean;
import com.ipl.bean.UserPointsBean;
import com.ipl.bean.UserSelectionBean;
import com.ipl.bean.StaticData.PlayerBean;
import com.ipl.bean.StaticData.PointsBean;
import com.ipl.dao.MatchDao;
import com.ipl.dao.UserDao;

@Component(value = "matchDao")
public class MatchDaoImpl implements MatchDao
{

    private static final Logger logger = Logger.getLogger(UserDao.class);

    private static final String userPointDetailsQuery = "SELECT sum(user_points) userPoints, count(tt.match_fixture_id) played, "
            + " ( GROUP_CONCAT(tt.result order by user_selection_tbl_id desc SEPARATOR ',')) result, "
            + " (GROUP_CONCAT(user_points SEPARATOR ',') ) ind_points,  (GROUP_CONCAT(match_fixture_id SEPARATOR ',') ) ind_match FROM ipl.user_selection_tbl tt, ipl.match_fixtures_tbl mf where "
            + " tt.match_fixture_id = mf.match_fixtures_tbl_id and mf.match_status = 1 and tt.user_id = ? group by tt.user_id";

    private static final String userVoteDetailsQuery = "SELECT ust.user_mom_selection_id momPlayerId, ust.user_team_selection_id selectedTeamId, "
            + "(select GROUP_CONCAT(pst.player_selection_id order by pst.player_selection_id SEPARATOR '|') "
            + "from user_player_selection_tbl pst where pst.user_selection_tbl_id = ust.user_selection_tbl_id) playerSelectionIds , is_auto_vote "
            + "FROM ipl.user_selection_tbl ust where ust.user_id = ? and ust.match_fixture_id = ?";

    private static final String insertUpdateVotePlayers = "{call prc_players_selection(?,?,?,?,?,?)}";

    private static final String userFixtureVoteDetailsQuery = "SELECT match_fixture_id fixtureId FROM ipl.user_selection_tbl where user_id = ?";

    private static final String getUserHistoryList = "SELECT f.match_id, f.user_one_id, f.user_two_id, f.user_one_team_player_points, f.user_two_team_player_points, f.user_one_total_points, f.user_two_total_points, f.user_winner_id, "
            + " (Select concat(first_name,' ', last_name) from user_master_tbl where user_master_tbl_id = f.user_one_id)  as UserOneName, (Select concat(first_name,' ', last_name) "
            + " from user_master_tbl where user_master_tbl_id = f.user_two_id) as UserTwoName from user_fixtures_tbl f where f.user_one_id = ? or f.user_two_id = ? order by f.match_id desc";

    private static final String getUserPlayerPointDetails = "select pst.player_selection_id , p.total_points, runs, catches, run_outs, wickets, is_mom,  ust.user_id from user_selection_tbl ust, "
            + "user_player_selection_tbl pst, player_individual_score_tbl p where ust.user_selection_tbl_id = pst.user_selection_tbl_id"
            + " and pst.player_selection_id = p.player_id and ust.user_id in (?,? ) and ust.match_fixture_id = ? and  p.match_fixture_id =ust.match_fixture_id";
    
    private static final String getSystemParam = "SELECT system_parameter_name paramName, system_parameter_value paramValue FROM ipl.system_parameter_tbl;";
    
    private static final String getPlayerStatistics = "SELECT concat(p.first_name,' ',p.last_name) playerName, (select team_name from teams_tbl where "
    		+ "teams_tbl_id  = p.player_team_id) teamName, get_team_code(player_team_id) teamCode, (select player_role from player_role_tbl where "
    		+ "player_role_tbl_id = p.player_role_id ) playerRole, sum(pi.total_points) totalPoints FROM ipl.player_individual_score_tbl pi, player_tbl p where "
    		+ "pi.player_id = p.player_tbl_id group by playerName, teamName, teamCode, playerRole order by teamCode, totalPoints DESC"; 
    
    private static final String getTopScorerQuery = "select match_fixture_id, (select get_team_code(team_one_id) from match_fixtures_tbl where match_fixtures_tbl_id = match_fixture_id ) team_one_code , "
    		+ " (select get_team_code(team_two_id) from match_fixtures_tbl where match_fixtures_tbl_id = match_fixture_id ) team_two_code, (select concat(first_name,' ',last_name) from user_master_tbl where user_master_tbl_id = user_id) full_name, "
    		+ " user_points, is_auto_vote from user_selection_tbl where match_fixture_id = (select max(match_fixtures_tbl_id) "
    		+ " from match_fixtures_tbl where match_status = 1) order by user_points desc limit 3"; 
    		
    @Autowired
    DataSource dataSource;

    @Override
    public UserPointsBean getUserPointDetails(int userId)
    {
        logger.info("Method :: getUserPointDetails() :: Start");

        UserPointsBean userPointsBean = null;

        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(userPointDetailsQuery);
            pstmt.setInt(1, userId);

            logger.info("Query to get user Points Details :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();

            while (resultSet.next())
            {
                List<String> results = new ArrayList<String>(Arrays.asList(resultSet.getString("result") == null
                        ? "".split(",") : resultSet.getString("result").split(",")));

                userPointsBean = new UserPointsBean();

                userPointsBean.setUserId(userId);
                userPointsBean.setPlayed(resultSet.getInt("played"));
                userPointsBean.setUserPoints(resultSet.getInt("userPoints"));
                userPointsBean.setWonCount(Collections.frequency(results, "Won"));
                userPointsBean.setLostCount(Collections.frequency(results, "Lost"));
                userPointsBean.setDrawCount(Collections.frequency(results, "Draw"));
                userPointsBean.setIndPoints(resultSet.getString("ind_points"));
                userPointsBean.setIndMatch(resultSet.getString("ind_match"));

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

        return userPointsBean;
    }

    @Override
    public Map<String, String> getUserVoteDetails(int userId, int matchId)
    {
        // TODO Auto-generated method stub
        logger.info("Method :: getUserPointDetails() :: Start");

        Map<String, String> userVoteMap = null;

        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(userVoteDetailsQuery);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, matchId);

            logger.info("Query to get User Vote  Details :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();

            while (resultSet.next())
            {

                userVoteMap = new HashMap<String, String>();
                userVoteMap.put("momPlayerId", String.valueOf(resultSet.getInt("momPlayerId")));
                userVoteMap.put("selectedTeamId", String.valueOf(resultSet.getInt("selectedTeamId")));
                userVoteMap.put("playerSelectionIds", resultSet.getString("playerSelectionIds"));
                userVoteMap.put("isAutoVote",String.valueOf(resultSet.getInt("is_auto_vote")));
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getUserVoteDetails() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: getUserVoteDetails() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: getUserVoteDetails() :: " + e.getMessage());
            }
        }
        logger.info("Method :: getUserVoteDetails() :: End");

        return userVoteMap;
    }

    @Override
    public String insertUpdateVotePlayers(UserSelectionBean userSelectionBean)
    {
        logger.info("Method :: insertUpdateVotePlayers() :: Start");

        String outParamMessage = null;

        CallableStatement cstmt = null;
        Connection con = null;

        try
        {
            con = dataSource.getConnection();
            cstmt = con.prepareCall(insertUpdateVotePlayers);

            cstmt.setInt("userId", userSelectionBean.getUserId());
            cstmt.setInt("matchId", userSelectionBean.getMatchId());
            cstmt.setInt("playerMomId", userSelectionBean.getPlayerMomId());
            cstmt.setInt("winTeamId", userSelectionBean.getWinTeamId());
            cstmt.setString("selectedPlayersIds", userSelectionBean.getSelectedPlayersIds());

            cstmt.registerOutParameter("outParam", java.sql.Types.VARCHAR);

            logger.info("call prc_players_selection :: with parameters :: userID: " + userSelectionBean.getUserId()+" MatchID: "+userSelectionBean.getMatchId()+" momID: "+userSelectionBean.getPlayerMomId()+" winTeamID: "+userSelectionBean.getWinTeamId()+" playersId: "+userSelectionBean.getSelectedPlayersIds());

            cstmt.executeUpdate();

            if (cstmt.getString("outParam").equalsIgnoreCase("success"))
            {
                outParamMessage = "Voting Done Successfully";
            }
            else
            {
                outParamMessage = "error";
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: insertUpdateVotePlayers() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: insertUpdateVotePlayers() :: finally");
                cstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: insertUpdateVotePlayers() :: " + e.getMessage());
            }
        }
        logger.info("Method :: getUserVoteDetails() :: End");

        return outParamMessage;
    }

    @Override
    public ArrayList<UserFixtureBean> getUserFixtureHistory(String userId)
    {
        logger.info("Method :: getUserFixtureHistory() :: Start");

        ArrayList<UserFixtureBean> userFixtureBeanList = new ArrayList<>();
        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(getUserHistoryList);
            pstmt.setInt(1, Integer.parseInt(userId));
            pstmt.setInt(2, Integer.parseInt(userId));

            logger.info("getUserFixtureHistory Query :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();

            while (resultSet.next())
            {
                UserFixtureBean userFixtureBean = new UserFixtureBean();

                userFixtureBean.setMatchId(resultSet.getInt("match_id"));
                userFixtureBean.setUserOneId(resultSet.getInt("user_one_id"));
                userFixtureBean.setUserTwoId(resultSet.getInt("user_two_id"));
                userFixtureBean.setUserOneName(resultSet.getString("UserOneName"));
                userFixtureBean.setUserTwoName(resultSet.getString("UserTwoName"));
                userFixtureBean.setUserOneTeamPlayerPoints(resultSet.getInt("user_one_team_player_points"));
                userFixtureBean.setUserTwoTeamPlayerPoints(resultSet.getInt("user_two_team_player_points"));                
                userFixtureBean.setUserOnePoints(resultSet.getInt("user_one_total_points"));
                userFixtureBean.setUserTwoPoints(resultSet.getInt("user_two_total_points"));
                userFixtureBean.setUserWinnerId(resultSet.getInt("user_winner_id"));
                userFixtureBeanList.add(userFixtureBean);
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getUserVoteDetails() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: getUserVoteDetails() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: getUserVoteDetails() :: " + e.getMessage());
            }
        }
        logger.info("Method :: getUserVoteDetails() :: End");

        return userFixtureBeanList;
    }

    @Override
    public UserFixtureBean getUserPlayerPoints(UserFixtureBean userFixtureBean)
    {
        logger.info("Method :: getUserPlayerPoints() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet rs = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(getUserPlayerPointDetails);
            pstmt.setInt(1, userFixtureBean.getUserOneId());
            pstmt.setInt(2, userFixtureBean.getUserTwoId());
            pstmt.setInt(3, userFixtureBean.getMatchId());
            logger.info("getUserPlayerPoints Query :: " + pstmt.toString());
            rs = pstmt.executeQuery();

            while (rs.next())
            {
                int playerId = rs.getInt("player_selection_id");

                for (PlayerBean playerBean : userFixtureBean.getUserOneBeanSelectionBean().getSelectedPlayerBeanList())
                {
                    if (playerBean.getPlayerId() == playerId)
                    {
                        PointsBean pointBean = new PointsBean();
                        pointBean.setTotalScore(rs.getInt("total_points"));
                        pointBean.setRuns(rs.getInt("runs"));
                        pointBean.setWickets(rs.getInt("wickets"));
                        pointBean.setRunOuts(rs.getInt("run_outs"));
                        pointBean.setCatches(rs.getInt("catches"));
                        pointBean.setManOftheMatch(rs.getBoolean("is_mom"));
                        playerBean.setPointsBean(pointBean);
                    }
                }
                
                for (PlayerBean playerBean : userFixtureBean.getUserTwoBeanSelectionBean().getSelectedPlayerBeanList())
                {
                    if (playerBean.getPlayerId() == playerId)
                    {
                        PointsBean pointBean = new PointsBean();
                        pointBean.setTotalScore(rs.getInt("total_points"));
                        pointBean.setRuns(rs.getInt("runs"));
                        pointBean.setWickets(rs.getInt("wickets"));
                        pointBean.setRunOuts(rs.getInt("run_outs"));
                        pointBean.setCatches(rs.getInt("catches"));
                        pointBean.setManOftheMatch(rs.getBoolean("is_mom"));
                        playerBean.setPointsBean(pointBean);
                    }
                }

            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getUserPlayerPoints() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: getUserPlayerPoints() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: getUserPlayerPoints() :: " + e.getMessage());
            }
        }
        logger.info("Method :: getUserPlayerPoints() :: End");

        return userFixtureBean;
    }

    @Override
    public ArrayList<Integer> getFixtureVotedetails(int userId)
    {
        // TODO Auto-generated method stub
        logger.info("Method :: getFixtureVotedetails() :: Start");

        ArrayList<Integer> userFixtureVoteList = new ArrayList<Integer>();

        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(userFixtureVoteDetailsQuery);
            pstmt.setInt(1, userId);

            logger.info("Query to get User Fixture Vote  Details :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();

            while (resultSet.next())
            {
                userFixtureVoteList.add(resultSet.getInt("fixtureId"));
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getFixtureVotedetails() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: getFixtureVotedetails() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: getFixtureVotedetails() :: " + e.getMessage());
            }
        }
        logger.info("Method :: getFixtureVotedetails() :: End");
        return userFixtureVoteList;
    }
    
    @Override
    public int getOponnentId(int userId, int matchFixturesId)
    {
        String query="select user_one_id, user_two_id from user_fixtures_tbl where match_id= ? and (user_one_id = ? or user_two_id = ?)";
        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        int opponent = 0;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, matchFixturesId);
            pstmt.setInt(2, userId);
            pstmt.setInt(3, userId);
            resultSet= pstmt.executeQuery();
             while(resultSet.next()){
                 if(resultSet.getInt("user_one_id")!=userId){
                 opponent = resultSet.getInt("user_one_id");   
                 }
                 else{
                     opponent = resultSet.getInt("user_two_id");
                 }
             }
            
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getOponnentId() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: getOponnentId() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: getOponnentId() :: " + e.getMessage());
            }
        }
        logger.info("Method :: getOponnentId() :: End");
        return opponent;
    }

    @Override
    public Map<String, String> getSystemParametes()
    {
        // TODO Auto-generated method stub
        logger.info("Method :: getSystemParametes() :: Start");

        Map<String, String> systemParamMap = new HashMap<String, String>();

        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(getSystemParam);

            logger.info("Query to get system Parameters :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();

            while (resultSet.next())
            {
            	systemParamMap.put(resultSet.getString("paramName"), resultSet.getString("paramValue"));
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getSystemParametes() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: getSystemParametes() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: getSystemParametes() :: " + e.getMessage());
            }
        }
        logger.info("Method :: getSystemParametes() :: End");
        return systemParamMap;
    }

	@Override
	public Map<String, ArrayList<PlayerStatsBean>> getPlayerStatistics() {
		// TODO Auto-generated method stub
		 logger.info("Method :: getPlayerStatistics() :: Start");

	        Map<String, ArrayList<PlayerStatsBean>> playerStatsMap = new HashMap<String, ArrayList<PlayerStatsBean>>();
	        ArrayList<PlayerStatsBean> playerStatsList = null;
	        
	        PreparedStatement pstmt = null;
	        Connection con = null;
	        ResultSet resultSet = null;
	        try
	        {
	            con = dataSource.getConnection();
	            pstmt = con.prepareStatement(getPlayerStatistics);

	            logger.info("Query to get system Parameters :: " + pstmt.toString());
	            resultSet = pstmt.executeQuery();
	            String oldTeamCode = "";
	            
	            while (resultSet.next())
	            {
	            	if(!oldTeamCode.equalsIgnoreCase(resultSet.getString("teamCode"))){
	            		oldTeamCode =resultSet.getString("teamCode");
	            		playerStatsList = new ArrayList<>();
	            	}
	            	
	            	PlayerStatsBean bean = new PlayerStatsBean();
	            	bean.setPlayerName(resultSet.getString("playerName"));
	            	bean.setPlayerRole(resultSet.getString("playerRole"));
	            	bean.setTeamName(resultSet.getString("teamName"));
	            	bean.setTeamCode(resultSet.getString("teamCode"));
	            	bean.setTotalPoints(resultSet.getInt("totalPoints"));
	            	playerStatsList.add(bean);
	            	
	            	playerStatsMap.put(resultSet.getString("teamName"),playerStatsList);
	            }

	        }
	        catch (SQLException e)
	        {
	            e.printStackTrace();
	            logger.error("Error :: getPlayerStatistics() :: " + e.getMessage());
	        }
	        finally
	        {
	            try
	            {
	                logger.info("Info :: getPlayerStatistics() :: finally");
	                pstmt.close();
	                con.close();
	            }
	            catch (SQLException e)
	            {
	                e.printStackTrace();
	                logger.error("Error :: getPlayerStatistics() :: " + e.getMessage());
	            }
	        }
	        logger.info("Method :: getSystemParametes() :: End");
		return playerStatsMap;
	}

	@Override
	public ArrayList<TopScorerBean> getTopScorer() {
		// TODO Auto-generated method stub
		
		 logger.info("Method :: getTopScorer() :: Start");

	        ArrayList<TopScorerBean> topScorerList = new ArrayList<>();
	        
	        PreparedStatement pstmt = null;
	        Connection con = null;
	        ResultSet resultSet = null;
	        try
	        {
	            con = dataSource.getConnection();
	            pstmt = con.prepareStatement(getTopScorerQuery);

	            logger.info("Query to get top scorer:: " + pstmt.toString());
	            resultSet = pstmt.executeQuery();
	            
	            while (resultSet.next())
	            {
	            	TopScorerBean bean = new TopScorerBean();
	            	bean.setMatchFixtureId(resultSet.getInt("match_fixture_id"));
	            	bean.setFullName(resultSet.getString("full_name"));
	            	bean.setTeamOne(resultSet.getString("team_one_code"));
	            	bean.setTeamTwo(resultSet.getString("team_two_code"));
	            	bean.setUserPoints(resultSet.getString("user_points"));
	            	bean.setIsAutoVote(resultSet.getBoolean("is_auto_vote"));
	            	topScorerList.add(bean);
	            }

	        }
	        catch (SQLException e)
	        {
	            e.printStackTrace();
	            logger.error("Error :: getPlayerStatistics() :: " + e.getMessage());
	        }
	        finally
	        {
	            try
	            {
	                logger.info("Info :: getPlayerStatistics() :: finally");
	                pstmt.close();
	                con.close();
	            }
	            catch (SQLException e)
	            {
	                e.printStackTrace();
	                logger.error("Error :: getPlayerStatistics() :: " + e.getMessage());
	            }
	        }
	        logger.info("Method :: getSystemParametes() :: End");

		return topScorerList;
	}

}
