package com.ipl.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.UserBean;
import com.ipl.dao.UserDao;
import com.ipl.util.BCrypt;

@Component(value = "userDao")
public class UserDaoImpl implements UserDao
{
    
    private static final Logger logger = Logger.getLogger(UserDao.class);

    @Autowired
    DataSource dataSource;

    @Override
    public String insertUser(UserBean userBean)
    {
        logger.info("Method :: insertUser() :: Start");
        Connection con = null;
        int result = 0;
        int checkEmailExists = 0;
        String status=null;
        String query="insert into user_master_tbl(first_name, last_name, email_id, mobile_number, is_admin, is_active) "
                + " values(?,?,?,?,?,?) ";
        String queryForPassword = "insert into password_manager_tbl(user_master_id,password,is_change_request)"
                + " values((SELECT MAX(user_master_tbl_id) FROM user_master_tbl),?,?)";
        
        checkEmailExists = checkEmailExists(userBean.getEmail());
        if(checkEmailExists != 0){
        	   status = "Email ID already exists";
        }
        else{
        try
        {
            con = dataSource.getConnection();
        
        con.setAutoCommit(false);

        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, userBean.getFirstName());
        pstmt.setString(2, userBean.getLastName());
        pstmt.setString(3, userBean.getEmail());
        pstmt.setString(4, userBean.getMobile());
        pstmt.setBoolean(5, Boolean.FALSE);
        pstmt.setBoolean(6, Boolean.FALSE);
        
        logger.info("queryForUserMaster :: " + pstmt.toString());
        pstmt.executeUpdate();
        
        pstmt = con.prepareStatement(queryForPassword);
        pstmt.setString(1, userBean.getPassword());
        pstmt.setBoolean(2, Boolean.FALSE);
        logger.info("queryForUserMaster :: " + pstmt.toString());
        result =  pstmt.executeUpdate();
        
        if (result == 1)
        {
            status = "Registration Complete, please login to continue";
            con.setAutoCommit(true);
        }
        else
        {
            status = "An error occurred, please try again or contact the administrator";
        }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        }
        return status;
    }

    @Override
    public UserBean login(UserBean userBean)
    {
        logger.info("Method :: login() :: Start");
        String query = "Select u.user_master_tbl_id,p.password AS password from user_master_tbl u , password_manager_tbl p where u.email_id = ? AND u.user_master_tbl_id = p.user_master_id";
        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);

            pstmt.setString(1, userBean.getEmail());
            logger.info("query for login :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();

            if (resultSet.next())
            {
                if (BCrypt.checkpw(userBean.getPassword(), resultSet.getString("password")))
                {
                    userBean.setUserId(resultSet.getInt("user_master_tbl_id"));
                    // change the calling to get user details on login
                    userBean = getUserDetailById(userBean.getUserId());
                }
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
        return userBean;
    }

    private UserBean getUserDetailById(int userId)
    {
        logger.info("Method :: getUserDetailById() :: Start");
        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        UserBean userBean = new UserBean();
        
        
        String query = "select first_name, last_name, email_id, mobile_number, is_admin, is_active from user_master_tbl where user_master_tbl_id=?";
        
        
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);

            pstmt.setInt(1, userId);
            resultSet=pstmt.executeQuery();
            userBean.setUserId(userId);
            while(resultSet.next()){
                userBean.setFirstName(resultSet.getString("first_name"));
                userBean.setLastName(resultSet.getString("last_name"));
                userBean.setEmail(resultSet.getString("email_id"));
                userBean.setMobile(resultSet.getString("mobile_number"));
                userBean.setIsAdmin(resultSet.getBoolean("is_admin"));
                userBean.setIsActive(resultSet.getBoolean("is_active"));
            }
            
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: getUserDetailById() :: " + e.getMessage());
        }
        // TODO Auto-generated method stub
        return userBean;
    }

    @Override
    public int checkEmailExists(String email)
    {

        logger.info("Method :: checkEmailExists() :: Start");
        String query = "Select user_master_tbl_id from user_master_tbl where email_id = ?";
        PreparedStatement pstmt = null;
        Connection con = null;
        int userId = 0;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);

            pstmt.setString(1, email);
            logger.info("query for checkEmailExists :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();
            while (resultSet.next())
            {
                userId = resultSet.getInt("user_master_tbl_id");
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: checkEmailExists() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: checkEmailExists() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: checkEmailExists() :: " + e.getMessage());
            }
        }
        logger.info("Method :: checkEmailExists() :: End");
        return userId;
    }
    
    @Override
    public String updateAutoPassword(String newPassword, int userId)
    {
        logger.info("Method :: updateAutoPassword() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        int rs = 0;
        String query = "update password_manager_tbl" + " set password_manager_tbl.password = ?,"
                + " password_manager_tbl.is_change_request = ?"
                + " where password_manager_tbl.user_master_id = ?";
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);

            pstmt.setString(1, newPassword);
            pstmt.setBoolean(2, Boolean.TRUE);
            pstmt.setInt(3, userId);
            logger.info("query for updateAutoPassword :: " + pstmt.toString());
            rs = pstmt.executeUpdate();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: updateAutoPassword() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: updateAutoPassword() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: updateAutoPassword() :: " + e.getMessage());
            }
        }
        logger.info("Method :: updateAutoPassword() :: End");

        return rs > 0 ? "true" : "A problem occurred";
    }
    
    @Override
    public String checkPassword(int userId, String password)
    {

        logger.info("Method :: checkPassword() :: Start");
        String query = "Select password from password_manager_tbl where user_master_id = ?", oldPassword = null, status = null;
        PreparedStatement pstmt = null;
        Connection con = null;
        ResultSet resultSet = null;
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);

            pstmt.setInt(1, userId);
            logger.info("query for login :: " + pstmt.toString());
            resultSet = pstmt.executeQuery();
            while (resultSet.next())
            {
                oldPassword = resultSet.getString("password");
            }
            if (BCrypt.checkpw(password, oldPassword))
            {
                status = "Password Matched";
            }
            else
                status = "Given Password do not match";

        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: checkPassword() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: checkPassword() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: checkPassword() :: " + e.getMessage());
            }
        }
        logger.info("Method :: checkPassword() :: End");

        return status;

    }

    @Override
    public String changePassword(int userId, String password)
    {

        logger.info("Method :: changePassword() :: Start");

        PreparedStatement pstmt = null;
        Connection con = null;
        int rs = 0;
        String query = "update password_manager_tbl set password = ?,"
                + " is_change_request= ?"
                + " where user_master_id = ?";
        try
        {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);

            pstmt.setString(1, password);
            pstmt.setBoolean(2, Boolean.FALSE);
            pstmt.setInt(3, userId);
            logger.info("query for changePassword :: " + pstmt.toString());
            rs = pstmt.executeUpdate();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            logger.error("Error :: changePassword() :: " + e.getMessage());
        }
        finally
        {
            try
            {
                logger.info("Error :: changePassword() :: finally");
                pstmt.close();
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
                logger.error("Error :: changePassword() :: " + e.getMessage());
            }
        }
        logger.info("Method :: changePassword() :: End");
        return rs > 0 ? "Password updated successfuly"
                : "An Error Occured, Please try again or contact the administrator";
    }

}
