package com.ipl.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ipl.bean.UserBean;
import com.ipl.bean.StaticData.MatchFixturesBean;
import com.ipl.bean.StaticData.StaticDataBean;
import com.ipl.bean.StaticData.TeamBean;
import com.ipl.service.AdminService;

@Controller
public class AdminController
{
    
    @Autowired
    private AdminService adminService;
    
    StaticDataBean staticDataBean;

    private static final Logger logger = Logger.getLogger(AdminController.class);
    
    
    @RequestMapping(value = "/adminDashboard")
    public String displayAdmin(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        
        if (null != request.getSession().getAttribute("user"))
        {
            UserBean userBean = new UserBean();
            userBean = (UserBean) request.getSession().getAttribute("user");
            logger.info("Method :: displayAdmin() :: Start");
            
            
            if(!userBean.getIsAdmin())
                return "redirect:/dashboard";

                staticDataBean = StaticDataController.getStaticDataBean();
                model.addAttribute(staticDataBean);
                return ".ipl.admin.home";
        }
        return "redirect:/";

    }
    
    @RequestMapping(value = "/showMatchDetailsForUpdate", method = RequestMethod.POST)
    public String showMatchDetailsForUpdate(@RequestParam String matchId, HttpServletRequest request,
            HttpServletResponse response, Model model)
    {
        String message = null;
        
        MatchFixturesBean matchFixturesBean = null;
        TeamBean teamOne = null; 
        TeamBean teamTwo = null; 
        
        staticDataBean = StaticDataController.getStaticDataBean();
                
        for(MatchFixturesBean matchFixtureBean : staticDataBean.getMatchFixturesBean()){
            
                if(Integer.parseInt(matchId)==matchFixtureBean.getMatchFixturesId()){
                    matchFixturesBean = matchFixtureBean;
                    break;
                }
        }
        
        for(TeamBean teamBean : staticDataBean.getTeamBean()){
            if(teamBean.getTeamId()==matchFixturesBean.getTeamOneId())
                teamOne = teamBean;
            if(teamBean.getTeamId()==matchFixturesBean.getTeamTwoId())
                teamTwo = teamBean;
        }
        

        //message = userService.forgotPassword(email);
        model.addAttribute("matchId",matchId);
        model.addAttribute("teamOne",teamOne);
        model.addAttribute("teamTwo",teamTwo);
        model.addAttribute("matchFixturesBean",matchFixturesBean);
        model.addAttribute(staticDataBean);
        return ".ipl.admin.home";

    }
    
    
    @RequestMapping(value = "/updatePlayerStats", method = RequestMethod.POST)

    public @ResponseBody String updatePlayerStats(@RequestParam String matchId,@RequestParam String playerId,@RequestParam String runs,@RequestParam String wickets,@RequestParam String runOuts,@RequestParam String catches, HttpServletRequest request,
            HttpServletResponse response)
    {
        String message = null;
        
        message = adminService.insertPlayerStat(matchId,playerId,runs,wickets,runOuts,catches);
        
        //message = userService.forgotPassword(email);

        return message;

    }
    
    @RequestMapping(value = "/updateManOftheMatch", method = RequestMethod.POST)

    public @ResponseBody String updateManOftheMatch(@RequestParam String matchIdMom,@RequestParam String playerId, HttpServletRequest request,
            HttpServletResponse response)
    {
        String message = null;
        
        message = adminService.updateManOftheMatch(matchIdMom,playerId);
        
        //message = userService.forgotPassword(email);

        return message;

    }
    
    @RequestMapping(value = "/updateMatchWinner", method = RequestMethod.POST)

    public @ResponseBody String updateMatchWinner(@RequestParam String matchIdWin,@RequestParam String teamId, HttpServletRequest request,
            HttpServletResponse response)
    {
        String message = null;
        
        message = adminService.updateMatchWinner(matchIdWin,teamId);
        
        //message = userService.forgotPassword(email);

        return message;

    }
    
    
    @RequestMapping(value = "/404")
    public String displayEror404(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        logger.info("Method :: displayEror404() :: Start");
        return ".ipl.error404";

    }
    
    @RequestMapping(value = "/approvals")
    public String displayApprovals(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        if (null != request.getSession().getAttribute("user"))
        {
            UserBean userBean = new UserBean();
            userBean = (UserBean) request.getSession().getAttribute("user");
            if(userBean.getIsAdmin()){
        logger.info("Method :: displayApprovals() :: Start");
        ArrayList<UserBean> userBeanList = new ArrayList<>();
        userBeanList = adminService.getPendingUserListForApproval();
        model.addAttribute("userBeanList",userBeanList);
        
        return ".ipl.admin.approvals";
            }
            return "redirect:/dashboard";
        }
        return "redirect:/";

    }
    
    @RequestMapping(value = "/approveUser", method = RequestMethod.POST)

    public @ResponseBody String approveUser(@RequestParam String userId, HttpServletRequest request,
            HttpServletResponse response)
    { 
        
        String message = null;
        
        message = adminService.approveUser(userId);
        
        //message = userService.forgotPassword(email);

        return message;

    }
    
    @RequestMapping(value = "/launchMissile", method = RequestMethod.POST)

    public String launchMissile(@RequestParam String matchId, HttpServletRequest request,
            HttpServletResponse response)
    {
        String message = null;
        
        message = adminService.launchMissile(matchId);
        
        return "redirect:/updateStaticData";

    }
    
    
    
    @RequestMapping(value = "/generateUserFixture", method = RequestMethod.POST)

    public @ResponseBody String generateUserFixture(@RequestParam String matchId, HttpServletRequest request,
            HttpServletResponse response)
    {
        String message = null;
        
        message = adminService.generateUserFixture(matchId);
        
        return message;

    }
    
    @RequestMapping(value = "/getMatchResult", method = RequestMethod.POST)

    public @ResponseBody String getMatchResult(@RequestParam String matchId, HttpServletRequest request,
            HttpServletResponse response)
    {
        String message = null;
        
        message = adminService.getMatchResult(matchId);
        
        return message;

    }
    
    @RequestMapping(value = "/updateDashBoardMsg", method = RequestMethod.POST)
    public @ResponseBody String updateDashBoardMsg(@RequestParam String dashBoardMsg, HttpServletRequest request,
            HttpServletResponse response)
    {
        String message = null;
        
        message = adminService.updateDashBoardMsg(dashBoardMsg);
        
        return message;

    }

}
