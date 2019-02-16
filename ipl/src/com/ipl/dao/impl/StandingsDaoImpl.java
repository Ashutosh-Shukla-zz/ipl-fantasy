package com.ipl.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.UserPointsBean;
import com.ipl.dao.StandingsDao;

@Component( value = "standingsDao" )
public class StandingsDaoImpl implements StandingsDao
{
    
    @Autowired
    DataSource dataSource;

    private static final Logger logger = Logger.getLogger(StandingsDaoImpl.class);

    private static final String allUsersPointsDetailQuery = "select ut.user_master_tbl_id userId, concat(first_name, ' ', last_name) userName, "
    		+ " sum(IF(st.user_points IS NULL,0,st.user_points)) userPoints, (select count(1) from match_fixtures_tbl where match_status = 1) played, (select GROUP_CONCAT(result order by user_selection_tbl_id desc SEPARATOR ',') "
    		+ " from user_selection_tbl tbl where tbl.user_id = ut.user_master_tbl_id) result from user_master_tbl ut LEFT JOIN user_selection_tbl st on"
    		+ " ut.user_master_tbl_id = st.user_id where ut.is_active = 1 GROUP BY ut.user_master_tbl_id  ORDER BY userPoints desc ";
    
    public ArrayList<UserPointsBean> getAllStandings() {
    	logger.info("Method :: getAllStandings() :: Start");
    	    	
    	ArrayList<UserPointsBean> pointsList = new ArrayList<UserPointsBean>();
    	UserPointsBean userPointsBean = null;
    			
        PreparedStatement pstmt = null;
    	Connection con = null;
    	ResultSet resultSet = null;
    	try {
    	    con = dataSource.getConnection();
    	    pstmt = con.prepareStatement(allUsersPointsDetailQuery);
    	    logger.info("Query to get user Points Details :: " + pstmt.toString());
    	    resultSet = pstmt.executeQuery();

    	    while (resultSet.next()) {
    	    	List<String> results = new ArrayList<String>(Arrays.asList(resultSet.getString("result")== null? "".split(",") :resultSet.getString("result").split(",")));
    	            	
    	    	userPointsBean = new UserPointsBean();    	            	
    	    	userPointsBean.setUserId(resultSet.getInt("userId"));
    	    	userPointsBean.setUserName(resultSet.getString("userName"));
    	    	userPointsBean.setPlayed(resultSet.getInt("played"));
    	    	userPointsBean.setUserPoints(resultSet.getInt("userPoints"));
    	    	userPointsBean.setWonCount(Collections.frequency(results, "Won"));
    	    	userPointsBean.setLostCount(Collections.frequency(results, "Lost"));
    	    	userPointsBean.setDrawCount(Collections.frequency(results, "Draw"));
    	    	
    	    	pointsList.add(userPointsBean);
    	    }
        }
        catch (SQLException e) {
        	e.printStackTrace();
    	    logger.error("Error :: getAllStandings() :: " + e.getMessage());
    	}
    	finally {
    		try {
    			logger.info("Error :: getAllStandings() :: finally");
    			pstmt.close();
    			con.close();
    		}
    		catch (SQLException e) {
    			e.printStackTrace();
    			logger.error("Error :: getAllStandings() :: " + e.getMessage());
    		}
    	}
    	logger.info("Method :: getAllStandings() :: End");
    	    	
    	return pointsList;
    }
    
}
