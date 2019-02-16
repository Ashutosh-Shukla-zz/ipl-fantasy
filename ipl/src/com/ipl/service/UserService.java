package com.ipl.service;

import com.ipl.bean.UserBean;

public interface UserService
{

    String registerUser(UserBean userBean);

    UserBean login(UserBean userBean);

    String forgotPassword(String email);

    String changePassword(int userId, String oldPassword, String newPassword);

    String checkEmailExists(String emailId);

}
