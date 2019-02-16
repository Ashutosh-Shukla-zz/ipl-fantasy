package com.ipl.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.UserBean;
import com.ipl.dao.AdminDao;
import com.ipl.util.JsonPlayerMap;

@Component( value = "adminDao" )
public class AdminDaoImpl implements AdminDao
{
    
    @Autowired
    DataSource dataSource;

    private static final Logger logger = Logger.getLogger(AdminDaoImpl.class);
    
    private static final String prc_launch_missile = "{call prc_launch_missile(?,?)}";
    
    private static final String prc_user_fixture = "{call prc_user_fixture(?,?)}";
    
    private static final String playerScoreUpdate = " update player_individual_score_tbl set runs = ?, wickets = ?, catches=?, run_outs=?, is_mom = ?, stumps = ?"
                                                       + " where player_id=? and match_fixture_id = ?";
    
    private static final String updateDashBoardMsgQuery = "update ipl.system_parameter_tbl set system_parameter_value = ? where system_parameter_name = 'dashboard_message'";

    @Override
    public String insertPlayerStat(String matchId, String playerId, String runs, String wickets, String runOuts,
            String catches)
    {
        logger.info("Method :: insertPlayerStat() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        int rs = 0;
        String query ;
        
        if(playerStatExists(matchId,playerId))
            query = "update player_individual_score_tbl set "
                    + "runs=?, wickets=?, catches=?, run_outs=? "
                    + " where player_id= ? and match_fixture_id = ?";
        else
        query = "insert into player_individual_score_tbl ( runs, wickets, catches, run_outs ,player_id, match_fixture_id)"
                + "values (?,?,?,?,?,?)";
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, Integer.parseInt(""==runs?"0":runs));
            pstmt.setInt(2, Integer.parseInt(""==wickets?"0":wickets));
            pstmt.setInt(3, Integer.parseInt(""==catches?"0":catches));
            pstmt.setInt(4, Integer.parseInt(""==runOuts?"0":runOuts));
            pstmt.setInt(5, Integer.parseInt(playerId));
            pstmt.setInt(6, Integer.parseInt(matchId));
           
            logger.info("query for insertPlayerStat() :: " + pstmt.toString());
            rs = pstmt.executeUpdate();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: insertPlayerStat() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: insertPlayerStat() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: insertPlayerStat() :: " + e.getMessage());
            }
        }
        logger.info("Method :: insertPlayerStat() :: End");

        return rs > 0 ? "true" : "A problem occurred";
    }

    private boolean playerStatExists(String matchId, String playerId)
    {

        logger.info("Method :: playerStatExists() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet rs ;
        String query ="select * from player_individual_score_tbl  where player_id= ? and match_fixture_id = ? ";
        Boolean status=Boolean.FALSE;
        
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, Integer.parseInt(playerId));
            pstmt.setInt(2, Integer.parseInt(matchId));
           
            logger.info("query for playerStatExists() :: " + pstmt.toString());
            rs = pstmt.executeQuery();
            
            while(rs.next()){
                status=Boolean.TRUE;
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: playerStatExists() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: playerStatExists() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: playerStatExists() :: " + e.getMessage());
            }
        }
        logger.info("Method :: playerStatExists() :: End");

        
        return status;
    }

    @Override
    public String updateManOftheMatch(String matchIdMom, String playerId)
    {
        logger.info("Method :: updateManOftheMatch() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        int rs = 0;
        String query ="update player_individual_score_tbl set is_mom =? where match_fixture_id = ? and player_id = ?";
        
        String queryResetMom = "update player_individual_score_tbl set is_mom =? where match_fixture_id = ? and player_id != ?";
        
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setBoolean(1, Boolean.TRUE);
            pstmt.setInt(2, Integer.parseInt(matchIdMom));
            pstmt.setInt(3, Integer.parseInt(playerId));
           
            logger.info("query for queryResetMom() :: " + pstmt.toString());
            rs = pstmt.executeUpdate();
            
            pstmt = con.prepareStatement(queryResetMom);
            pstmt.setBoolean(1, Boolean.FALSE);
            pstmt.setInt(2, Integer.parseInt(matchIdMom));
            pstmt.setInt(3, Integer.parseInt(playerId));
            logger.info("query for updateManOftheMatch() :: " + pstmt.toString());
            rs = rs+ pstmt.executeUpdate();
            
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: updateManOftheMatch() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: updateManOftheMatch() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: updateManOftheMatch() :: " + e.getMessage());
            }
        }
        logger.info("Method :: updateManOftheMatch() :: End");

        
        return rs > 0 ? "true" : "A problem occurred";
    }

    @Override
    public String updateMatchWinner(String matchIdWin, String teamId)
    {
        logger.info("Method :: updateMatchWinner() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        int rs = 0;
        String query ="update match_fixtures_tbl set team_winner_id =? where match_fixtures_tbl_id = ?";
        
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setInt(1, Integer.parseInt(teamId));
            pstmt.setInt(2, Integer.parseInt(matchIdWin));
           
            logger.info("query for updateMatchWinner() :: " + pstmt.toString());
            rs = pstmt.executeUpdate();
            
            
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: updateMatchWinner() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: updateMatchWinner() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: updateMatchWinner() :: " + e.getMessage());
            }
        }
        logger.info("Method :: updateMatchWinner() :: End");

        
        return rs > 0 ? "true" : "A problem occurred";
    }

    @Override
    public ArrayList<UserBean> getPendingUserListForApproval()
    {
        logger.info("Method :: getPendingUserListForApproval() :: Start");

        ArrayList<UserBean> userBeanList = new ArrayList<>();
        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        String query ="select user_master_tbl_id, first_name, last_name, email_id, mobile_number, is_admin, is_active from user_master_tbl where is_active=? ";
        
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setBoolean(1, Boolean.FALSE);
           
            logger.info("query for getPendingUserListForApproval() :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();
            
            while(resultSet.next()){
                UserBean userBean = new UserBean();
                userBean.setUserId(resultSet.getInt("user_master_tbl_id"));
                userBean.setFirstName(resultSet.getString("first_name"));
                userBean.setLastName(resultSet.getString("last_name"));
                userBean.setEmail(resultSet.getString("email_id"));
                userBean.setMobile(resultSet.getString("mobile_number"));
                userBean.setIsAdmin(resultSet.getBoolean("is_admin"));
                userBean.setIsActive(resultSet.getBoolean("is_active"));
                userBeanList.add(userBean);
            }
            
            
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getPendingUserListForApproval() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: getPendingUserListForApproval() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: getPendingUserListForApproval() :: " + e.getMessage());
            }
        }
        logger.info("Method :: getPendingUserListForApproval() :: End");

        
        return userBeanList;
    }

    @Override
    public String approveUser(String userId)
    {
        logger.info("Method :: approveUser() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        int rs = 0;
        String query ="update user_master_tbl set is_active =? where user_master_tbl_id = ?";
        
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);
            
            pstmt.setBoolean(1, Boolean.TRUE);
            pstmt.setInt(2, Integer.parseInt(userId));
           
            logger.info("query for approveUser() :: " + pstmt.toString());
            rs = pstmt.executeUpdate();
            
            
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: approveUser() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: approveUser() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: approveUser() :: " + e.getMessage());
            }
        }
        logger.info("Method :: approveUser() :: End");

        
        return rs > 0 ? "true" : "A problem occurred";
    }

	@Override
	public String launchMissile(String matchId) {
		// TODO Auto-generated method stub
		logger.info("Method :: launchMissile() :: Start");

        String outParamMessage = null;

        CallableStatement cstmt = null;
        Connection con = null;

        try
        {
            con = dataSource.getConnection();
            cstmt = con.prepareCall(prc_launch_missile);

            cstmt.setInt("matchId", Integer.parseInt(matchId));

            cstmt.registerOutParameter("outParam", java.sql.Types.VARCHAR);

            logger.info("call prc_launch_missile :: with parameters :: userID: " + matchId);

            cstmt.executeUpdate();

            if (cstmt.getString("outParam").equalsIgnoreCase("success"))
            {
                outParamMessage = "Missile Launched Successfully";
            }
            else
            {
                outParamMessage = "error";
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: launchMissile() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: launchMissile() :: finally");
                cstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: launchMissile() :: " + e.getMessage());
            }
        }
        logger.info("Method :: launchMissile() :: End");

        return outParamMessage;
	}
	
	
	@Override
	public String generateUserFixture(String matchId) {
		// TODO Auto-generated method stub
		logger.info("Method :: generateUserFixture() :: Start");

        String outParamMessage = null;

        CallableStatement cstmt = null;
        Connection con = null;

        try
        {
            con = dataSource.getConnection();
            cstmt = con.prepareCall(prc_user_fixture);

            cstmt.setInt("matchId", Integer.parseInt(matchId));

            cstmt.registerOutParameter("outParam", java.sql.Types.VARCHAR);

            logger.info("call prc_user_fixture :: with parameters :: matchId: " + matchId);

            cstmt.executeUpdate();

            /*if (cstmt.getString("outParam").equalsIgnoreCase("success"))
            {
                outParamMessage = "done";
            }
            else
            {
                outParamMessage = "error";
            }*/
            outParamMessage = cstmt.getString("outParam");
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: generateUserFixture() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: generateUserFixture() :: finally");
                cstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: generateUserFixture() :: " + e.getMessage());
            }
        }
        logger.info("Method :: generateUserFixture() :: End");

        return outParamMessage;
	}
	

    @Override
    public String updatePlayerScore(String matchId, HashMap<String, JsonPlayerMap> playerScoreMap)
    {
        
        logger.info("Method :: approveUser() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        int[] rs = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(playerScoreUpdate);
            
            for(Entry<String, JsonPlayerMap> playerMap : playerScoreMap.entrySet()){
                pstmt.setInt(1, playerMap.getValue().getRuns());
                pstmt.setInt(2, playerMap.getValue().getWickets());
                pstmt.setInt(3,playerMap.getValue().getCatches());
                pstmt.setInt(4, playerMap.getValue().getRunOuts());
                pstmt.setBoolean(5, playerMap.getValue().getIsMom());
                pstmt.setInt(6, playerMap.getValue().getStumping());
                pstmt.setInt(7, playerMap.getValue().getPlayerId());
                pstmt.setInt(8, Integer.parseInt(matchId));
                
                pstmt.addBatch();
            }
            rs = pstmt.executeBatch();
            
        }catch (Exception e) {
            e.printStackTrace();
        }
        
        return rs.length>1?"done":"fisshh";
    }

	@Override
	public String updateDashBoardMsg(String dashBoardMsg) {
		// TODO Auto-generated method stub
		logger.info("Method :: updateDashBoardMsg() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        int rs = 0;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(updateDashBoardMsgQuery);
            pstmt.setString(1, dashBoardMsg);
            
            logger.info("Update Dashboard Messgae ::" + pstmt.toString());
            
            rs = pstmt.executeUpdate();
            
        }catch (Exception e) {
        	logger.error("Error :: updateDashBoardMsg() :: " + e.getMessage());
            e.printStackTrace();
        }
        finally
        {
            try
            {
                logger.info("Error :: updateDashBoardMsg() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: updateDashBoardMsg() :: " + e.getMessage());
            }
        }
        
        return rs>1?"fisshh":"done";
	}

    
}
