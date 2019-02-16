package com.ipl.dao;

import com.ipl.bean.UserBean;

public interface UserDao
{

    String insertUser(UserBean userBean);

    UserBean login(UserBean userBean);

    int checkEmailExists(String email);

    String updateAutoPassword(String hashpw, int userId);

    String checkPassword(int userId, String password);

    String changePassword(int userId, String newPassword);

}
