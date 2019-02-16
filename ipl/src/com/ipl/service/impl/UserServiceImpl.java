package com.ipl.service.impl;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.UserBean;
import com.ipl.controller.StaticDataController;
import com.ipl.dao.UserDao;
import com.ipl.service.EmailService;
import com.ipl.service.UserService;
import com.ipl.util.BCrypt;

@Component(value = "userService")
public class UserServiceImpl implements UserService
{

    private static final Logger logger = Logger.getLogger(UserServiceImpl.class);

    @Autowired
    UserDao userDao;
    
    @Autowired
    EmailService emailService;

    
    @Override
    public String registerUser(UserBean userBean)
    {
        
        logger.info("Method :: registerUser() : UserService :");
        userBean.setPassword(BCrypt.hashpw(userBean.getPassword(), BCrypt.gensalt()));
        String status = userDao.insertUser(userBean);
        
        return status;
    }


    @Override
    public UserBean login(UserBean userBean)
    {
        logger.info("Method :: login() : UserService :");
        return userDao.login(userBean);
    }


    @Override
    public String forgotPassword(String email)
    {

        logger.info("Method :: forgotPassword() : UserService :");
        int userId = userDao.checkEmailExists(email);
        if (userId < 1)
            return "This is not the registered email-id.";
        if (userId > 0)
        {
            String newPassword = RandomStringUtils.randomAlphanumeric(8).toUpperCase();
            String status = userDao.updateAutoPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()), userId);
            if (status.equalsIgnoreCase("true"))
            {
                logger.info("Method :: forgotPassword() : Password for user :" + email + newPassword);
                String toAddr = email;
                String fromAddr = "iplfantasy@india.com";
                String subject = "Forgot Password: IPL Fantasy League";
                String body = getForgotPasswordHtml(newPassword);
                emailService.sendEmail(toAddr, fromAddr, subject, body);
                return "<font style=color:#02113a;><b> An email has been sent to your registered email-id, kindly check.</b></font>";
            }

        }
        return "An error occured while resetting your password, kindly try again after some time.";

    }
    
    private String getForgotPasswordHtml(String newPassword)
    {
        String welcomeMessage=
                "<html><body><div style=\"Margin:0px;Padding:0px\"><div class=\"adM\">"+
                        "  </div><table width=\"100%\" align=\"center\" style=\"Margin:0px;Padding:0px;border-collapse:collapse;background-color:rgb(255,255,255)\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
                        "    <tbody>"+
                        "      <tr>"+
                        "        <td align=\"center\" valign=\"top\">"+
                        "          <table width=\"100%\" align=\"center\" style=\"Margin:0px;Padding:0px;border-collapse:collapse;background-color:rgb(255,255,255);max-width:600px;border:8px solid #e5e5e5\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
                        "            <tbody>"+
                        "              <tr>"+
                        "                <td align=\"center\" valign=\"top\">"+
                        "                  <table width=\"100%\" align=\"center\" style=\"Margin:0px auto;Padding:0px;border-collapse:collapse;background-color:rgb(255,255,255);max-width:600px;line-height:9px\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
                        "                    <tbody>"+
                        "                      <tr>"+
                        "                        <td align=\"center\" valign=\"top\">"+
                        "                          <a href=\"#m_-9011601442144715454_\" style=\"text-decoration:none\">"+
                        "                            <img width=\"600\" src=\"https://ci4.googleusercontent.com/proxy/g6471qXS10qUeZ4ODvtYPyIQ4iSSKR150G4ADrDodvUT6u3DNtgA4aPd_3Mdkruea-iL-whd8QsrFczubn_ba-2HPt-MgESsPJAHT7QYdjFduJJMlxw1vIKSA1CEU-_n6MBWCJCpaHV4Dg=s0-d-e1-ft#https://s3-ap-southeast-1.amazonaws.com/images-fantasy-iplt20/emailer/Welcome(1).png\" class=\"CToWUd\">"+
                        "                          </a>"+
                        "                        </td>"+
                        "                      </tr>"+
                        "                    </tbody>"+
                        "                  </table>"+
                        "                  <table width=\"100%\" align=\"center\" style=\"Margin:0px;Padding:0px;border-collapse:collapse;background-color:rgb(255,255,255);max-width:600px;line-height:9px\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
                        "                    <tbody>"+
                        "                      <tr>"+
                        "                        <td align=\"center\" valign=\"top\" style=\"padding:60px 30px\">"+
                        "                          <table width=\"100%\" align=\"left\" style=\"Margin:0px auto;Padding:0px;border-collapse:collapse;background-color:rgb(255,255,255);max-width:600px;line-height:9px\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
                        "                            <tbody>"+
                        "                              <tr>"+
                        "                                <td align=\"left\" valign=\"top\">"+
                        "                                  <p style=\"font-family:sans-serif;font-size:18px;color:#002157;font-weight:bold;line-height:27px;margin:0px;letter-spacing:1px\">Dear Fantasy IPL Owner</p>"+
                        "                                </td>"+
                        "                              </tr>"+
                        "                            </tbody>"+
                        "                          </table>"+
                        "                          <table width=\"100%\" align=\"left\" style=\"margin-top:30px;Padding:0px;border-collapse:collapse;background-color:rgb(255,255,255);max-width:600px;line-height:9px\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
                        "                            <tbody>"+
                        "                              <tr>"+
                        "                                <td align=\"left\" valign=\"top\">"+
                        "                                  <p style=\"font-family:sans-serif;font-size:14px;color:#002157;Line-height:24px;margin:0px;letter-spacing:1px;width:498px\"> Your auto generated Password is "+ newPassword+
                        "                                    Please change once you login "+
                        "                                    Safety is important."+
                        "                                  </p>"+
                        "                                  </td>"+
                        "                                </tr>"+
                        "                              </tbody>"+
                        "                            </table>"+
                        "                           "+
                        "                            <table width=\"100%\" align=\"left\" style=\"margin-top:30px;Padding:0px;border-collapse:collapse;background-color:rgb(255,255,255);max-width:600px;line-height:9px\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">"+
                        "                              <tbody>"+
                        "                                <tr>"+
                        "                                  <td align=\"left\" valign=\"top\">"+
                        "                                    <p style=\"font-family:sans-serif;font-size:14px;color:#002157;line-height:27px;margin:0px;letter-spacing:1px;width:482px\"> Have Fun and Good luck,"+
                        ""+
                        "                                    </p>"+
                        "                                    <p style=\"font-family:sans-serif;font-size:14px;color:#002157;line-height:27px;margin:0px;letter-spacing:1px;width:482px\"> Thanks,"+
                        ""+
                        "                                    </p>"+
                        "                                    <p style=\"font-family:sans-serif;font-size:14px;color:#002157;line-height:27px;margin:0px;letter-spacing:1px;width:482px\">"+
                        "                                      IPL fantasy 2018 "+
                        "                                    </p>"+
                        "                                  </td>"+
                        "                                </tr>"+
                        "                              </tbody>"+
                        "                            </table>"+
                        "                          </td>"+
                        "                        </tr>"+
                        "                      </tbody>"+
                        "                    </table>"+
                        "                  </td>"+
                        "                </tr>"+
                        "              </tbody>"+
                        "            </table>"+
                        "          </td>"+
                        "        </tr>"+
                        "      </tbody>"+
                        "    </table><div class=\"yj6qo\"></div><div class=\"adL\">"+
                        "  </div></div><div class=\"adL\">"+
                        "  </div></div></div></body></html>";
        return welcomeMessage;
    }


    @Override
    public String changePassword(int userId, String oldPassword, String newPassword)
    {
        logger.info("Method :: changePassword() : UserService :");
        String passwordStatus = userDao.checkPassword(userId, oldPassword);
        if (null != passwordStatus && passwordStatus.equalsIgnoreCase("Password Matched"))
        {
            newPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            passwordStatus = userDao.changePassword(userId, newPassword);
        }
        return passwordStatus;
    }


    @Override
    public String checkEmailExists(String emailId)
    {
        return userDao.checkEmailExists(emailId)>0?"true":"false";
    }


}
