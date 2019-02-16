package com.ipl.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ipl.bean.UserBean;
import com.ipl.service.EmailService;
import com.ipl.service.UserService;

@Controller
public class UserController
{
    @Autowired
    private UserService userService;
    
    @Autowired
    EmailService emailService;


    private static final Logger logger = Logger.getLogger(UserController.class);

    @RequestMapping(value = "/home")
    public String displayLogin(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        String messageToDisplay = null;
        logger.info("Method :: displayLogin() :: Start");
        if (null != request.getSession().getAttribute("messageToDisplay"))
            messageToDisplay = (String)request.getSession().getAttribute("messageToDisplay");
        request.getSession().removeAttribute("messageToDisplay");
        model.addAttribute("messageToDisplay", messageToDisplay);
        return ".ipl.login";

    }

    @RequestMapping(value = "/login")
    public String login(HttpServletRequest request, HttpServletResponse response)
    {
        String messageToDisplay = null;
        UserBean userBean = new UserBean();
        userBean.setEmail(request.getParameter("email"));
        userBean.setPassword(request.getParameter("password"));
        userBean = userService.login(userBean);

        if (null != userBean && userBean.getUserId() != 0)
        {
            request.getSession().setAttribute("user", userBean);
            messageToDisplay = "Login Successful";
            request.getSession().setAttribute("messageToDisplay", messageToDisplay);
            if(userBean.getIsAdmin()){
                return "redirect:/adminDashboard";
            }
            return "redirect:/dashboard";
        }

        messageToDisplay = "Invalid username or password, please try again";
        request.getSession().setAttribute("messageToDisplay", messageToDisplay);
        logger.info("Method :: displayLogin() :: End");
        return "redirect:/home";

    }

    @RequestMapping(value = "/register")
    public String displayRegistration(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        logger.info("Method :: displayRegistration() :: Start");
        model.addAttribute(new UserBean());
        return ".ipl.register";

    }

    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public ModelAndView performLogoutAction(HttpServletRequest request)
    {
        logger.info("Method :: performLogoutAction() :: Start");
        request.getSession().invalidate();
        logger.info("Method :: performLogoutAction() :: End");
        return new ModelAndView("redirect:/");
    }

    
    @RequestMapping(value = "/registration")
    public String registerUser(HttpServletRequest request, HttpServletResponse response,
            @ModelAttribute("UserBean") UserBean userBean)
    {

        logger.info("Method :: registerUser() :: Start");
        String messageToDisplay = userService.registerUser(userBean);
        request.getSession().setAttribute("messageToDisplay", messageToDisplay);
        
        if(messageToDisplay.equalsIgnoreCase("Registration Complete, please login to continue")){
        String toAddr = userBean.getEmail();
        String fromAddr = "iplfantasy@india.com";
        String subject = "Welcome to IPL Fantasy 2018";
        String body = getRegistrationEmailBody();
        emailService.sendEmail(toAddr, fromAddr, subject, body);
        }
        return "redirect:/updateStaticData";

    }

    private String getRegistrationEmailBody()
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
                        "                                  <p style=\"font-family:sans-serif;font-size:14px;color:#002157;Line-height:24px;margin:0px;letter-spacing:1px;width:498px\"> Welcome, and thanks for signing up! Its time for another sensational"+
                        "                                    season of IPL Fantasy League. "+
                        "                                    Manage your team everyday."+
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

    @RequestMapping(value = "/forgotPassword", method = RequestMethod.POST)

    public @ResponseBody String forgotPassword(@RequestParam String email, HttpServletRequest request,
            HttpServletResponse response)
    {
        String message = null;

        message = userService.forgotPassword(email);

        return message;

    }

    @RequestMapping(value = "/changePassword")
    public String displayChangePassword(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        if (null != request.getSession().getAttribute("user"))
        {
            String messageToDisplay = "";
            logger.info("Method :: displayRegistration() :: Start");
            messageToDisplay = (String)request.getSession().getAttribute("messageToDisplay");
            request.getSession().removeAttribute("messageToDisplay");
            model.addAttribute("messageToDisplay", messageToDisplay);
            return ".ipl.changePassword";
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/doChangePassword")
    public String changePassword(@RequestParam String oldPassword, @RequestParam String newPassword,
            HttpServletRequest request, HttpServletResponse response)
    {
        logger.info("Method :: displayRegistration() :: Start");

        String messageToDisplay = null;
        UserBean userBean = new UserBean();
        // JSONObject obj = new JSONObject(data);

        if (null != request.getSession().getAttribute("user"))
            userBean = (UserBean)request.getSession().getAttribute("user");

        if (userBean.getUserId() != 0)
            messageToDisplay = userService.changePassword(userBean.getUserId(), oldPassword, newPassword);
        request.getSession().setAttribute("messageToDisplay", messageToDisplay);
        return "redirect:/changePassword";

    }
    
    @RequestMapping(value = "/checkEmailExists", method = RequestMethod.POST)

    public @ResponseBody String checkEmailExists(@RequestParam String emailId, HttpServletRequest request,
            HttpServletResponse response)
    {
        String result = null;

        result = userService.checkEmailExists(emailId);

        return result;

    }
    
    @RequestMapping(value = "/rules")
    public String displayRules(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        
        return ".ipl.rules";
    }

}
