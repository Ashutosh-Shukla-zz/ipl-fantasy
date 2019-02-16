package com.ipl.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.TimeZone;

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
import com.ipl.bean.UserFixtureBean;
import com.ipl.bean.UserSelectionBean;
import com.ipl.bean.StaticData.PlayerBean;
import com.ipl.bean.StaticData.StaticDataBean;
import com.ipl.bean.StaticData.TeamBean;
import com.ipl.service.MatchService;

@Controller
public class MatchController
{

    @Autowired
    private MatchService matchService;

    private static final Logger logger = Logger.getLogger(MatchController.class);

    @RequestMapping(value = "/dashboard")
    public String displayDashboard(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        if (null != request.getSession().getAttribute("user"))
        {
            logger.info("Method :: displayDashboard() :: Start");

            UserBean userBean = new UserBean();
            userBean = (UserBean)request.getSession().getAttribute("user");

            String messageToDisplay = "";
            int matchId = 0;
            StaticDataBean staticDataBean = new StaticDataBean();
            staticDataBean = StaticDataController.getStaticDataBean();
            messageToDisplay = (String)request.getSession().getAttribute("messageToDisplay");
            request.getSession().removeAttribute("messageToDisplay");

            model.addAttribute("messageToDisplay", messageToDisplay);
            request.getSession().setAttribute("staticDataBean", staticDataBean);
            request.getSession().setAttribute("userPointDetails", matchService.userPointDetails(userBean.getUserId()));
            model.addAttribute("systemParametersMap", matchService.getSystemParametes());
            model.addAttribute("topScorerlist", matchService.getTopScorer());
            
            Date currentDate = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            sdf.setTimeZone(TimeZone.getTimeZone("IST"));
            String currentDateIST = sdf.format(currentDate);
            
            request.getSession().setAttribute("userTwoSelectionDetailList",
                    matchService.getSecondUserVoteDetailsList(userBean.getUserId(), currentDateIST));
            
            request.getSession().setAttribute("userSelectionDetailList",
                    matchService.userVoteDetailsList(userBean.getUserId(), currentDateIST));

            return ".ipl.dashboard";
        }
        return "redirect:/";

    }

    @RequestMapping(value = "/fixtures")
    public String displayFixtures(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        if (null != request.getSession().getAttribute("user"))
        {
            logger.info("Method :: displayFixtures() :: Start");

            UserBean userBean = new UserBean();
            userBean = (UserBean)request.getSession().getAttribute("user");
            
            String messageToDisplay = (String)request.getSession().getAttribute("messageToDisplay");

            request.getSession().removeAttribute("messageToDisplay");
            model.addAttribute("messageToDisplay", messageToDisplay);
            
            request.getSession().setAttribute("staticDataBean", StaticDataController.getStaticDataBean());
            model.addAttribute("userFixtureIdVoteList", matchService.userFixtureVote(userBean.getUserId()));

            return ".ipl.fixtures";
        }
        return "redirect:/";

    }

/*    @RequestMapping(value = "/standings")
    public String displayStandings(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        if (null != request.getSession().getAttribute("user"))
        {
            logger.info("Method :: displayStandings() :: Start");
            return ".ipl.standings";
        }
        return "redirect:/home";

    }*/

    @RequestMapping(value = "/history")
    public String displayHistory(@RequestParam String userId, HttpServletRequest request, HttpServletResponse response,
            Model model)
    {
        if (null != request.getSession().getAttribute("user"))
        {
            logger.info("Method :: displayHistory() :: Start");

            ArrayList<UserFixtureBean> userFixtureBeanList = new ArrayList<>();

            userFixtureBeanList = matchService.getUserFixtureHistory(userId);
            model.addAttribute("userId", userId);
            for (UserFixtureBean userFixture : userFixtureBeanList)
            {
                if (null != userFixture && Integer.parseInt(userId) == userFixture.getUserOneId())
                    model.addAttribute("userName", userFixture.getUserOneName());
                else
                    model.addAttribute("userName", userFixture.getUserTwoName());
            }
            model.addAttribute("userFixtureBeanList", userFixtureBeanList);
            model.addAttribute("staticDataBean", StaticDataController.getStaticDataBean());
            return ".ipl.history";
        }
        return "redirect:/";

    }

    @RequestMapping(value = "/historyDetails", method = RequestMethod.POST)

    public @ResponseBody String historyDetails(@RequestParam String matchId, @RequestParam String userOneId,
            @RequestParam String userTwoId, @RequestParam String userWinnerId, @RequestParam String userOnePoints,
            @RequestParam String userTwoPoints, @RequestParam String userOneName, @RequestParam String userTwoName,
            @RequestParam String userOneTeamPlayerPoints, @RequestParam String userTwoTeamPlayerPoints,
            HttpServletRequest request, HttpServletResponse response)
    {
        String message = null;
        UserFixtureBean userFixtureBean = new UserFixtureBean();
        userFixtureBean.setMatchId(Integer.parseInt(matchId));
        userFixtureBean.setUserOneId(Integer.parseInt(userOneId));
        userFixtureBean.setUserTwoId(Integer.parseInt(userTwoId));
        userFixtureBean.setUserWinnerId(Integer.parseInt(userWinnerId));
        userFixtureBean.setUserOneName(userOneName);
        userFixtureBean.setUserTwoName(userTwoName);
        userFixtureBean.setUserOnePoints(Integer.parseInt(userOnePoints));
        userFixtureBean.setUserTwoPoints(Integer.parseInt(userTwoPoints));
        userFixtureBean.setUserOneTeamPlayerPoints(Integer.parseInt(userOneTeamPlayerPoints));
        userFixtureBean.setUserTwoTeamPlayerPoints(Integer.parseInt(userTwoTeamPlayerPoints));
        userFixtureBean = matchService.getHistoryDetail(userFixtureBean);
        // JsonWriter.objectToJson(userFixtureBean);
        message = getAjaxResponse(userFixtureBean);

        return message;

    }

    private String getAjaxResponse(UserFixtureBean userFixtureBean)
    {

        String message = "<div class=\"col-md-6 col-sm-6 col-xs-6\" style=\"padding : 5px;\">";

        if (userFixtureBean.getUserWinnerId() == userFixtureBean.getUserOneId())
        {
            message += "<div class=\"pricing-table popular\" style=\"border-color : #006400 !important\"><div class=\"plan-title\" style=\"background-color : #006400\">"
                    + userFixtureBean.getUserOneName() + "</div>";
        }
        else
            message += "<div class=\"pricing-table\"><div class=\"plan-title\">" + userFixtureBean.getUserOneName()
                    + "</div>";

        message += "<div class=\"table-responsive margin-bottom-0\">";
        if (userFixtureBean.getUserWinnerId() == userFixtureBean.getUserOneId())
            message += "<div class=\"win-badge\"></div>";
        message += "<table id=\"userOneTbl\" class=\"table  table-condensed nomargin text-center\">" + "<thead>" + "  <tr>"
                + "     <th align=\"left\"><strong >Selected Team </strong> </th><th><span class=\"label label-danger\" style=\"float:right\">"
                + StaticDataController.getStaticDataBean().getTeamBeanMap()
                        .get(Integer.valueOf(userFixtureBean.getUserOneBeanSelectionBean().getWinTeamId()))
                        .getTeamCode();

        message += "</span></th>";

        if (StaticDataController.getStaticDataBean().getTeamBeanMap()
                .get(Integer.valueOf(userFixtureBean.getUserOneBeanSelectionBean().getWinTeamId()))
                .getTeamId() == StaticDataController.getStaticDataBean().getMatchFixturesBeanMap()
                        .get(userFixtureBean.getMatchId()).getTeamWinId())
            message += "<th style=\"text-align : center\">10</th>";
        else
            message += "<th style=\"text-align : center\">0</th>";
        message += "</tr>" + "</thead>" + "<tbody>";

        int momOnePoint = 0;
        String isAutoVoteOneMsg = "&nbsp;";
        int rowOneId = -1;
        for (PlayerBean playerBean : userFixtureBean.getUserOneBeanSelectionBean().getSelectedPlayerBeanList())
        {
        	rowOneId++;
            message += "<tr class=\"rowId"+rowOneId +" rowColor\"> <td align=\"left\" >" + playerBean.getFirstName().substring(0, 1) + " "
                    + playerBean.getLastName();
            
            //message += 	"<span class=\"label label-danger\">"+StaticDataController.getStaticDataBean().getTeamBeanMap() .get(playerBean.getPlayerId()).getTeamCode()+"</span>";
            //added for Power PLayer
            if(userFixtureBean.getMatchId() > 12 && playerBean.getPlayerId() == userFixtureBean.getUserOneBeanSelectionBean().getPlayerMomId()){
            	 message += "<span class=\"label label-danger\">P</span>";
                 //if (null!= playerBean.getPointsBean() && playerBean.getPointsBean().getManOftheMatch()) // check if
                                                                    // the
                                                                    // selected
                                                                    // player is
                                                                    // MOM.
                     momOnePoint = playerBean.getPointsBean().getTotalScore();
            }
            else if (playerBean.getPlayerId() == userFixtureBean.getUserOneBeanSelectionBean().getPlayerMomId())
            {
                message += "<span class=\"label label-danger\">M</span>";
                if (null!= playerBean.getPointsBean() && playerBean.getPointsBean().getManOftheMatch()) // check if
                                                                   // the
                                                                   // selected
                                                                   // player is
                                                                   // MOM.
                    momOnePoint = playerBean.getPointsBean().getTotalScore();

            }
            message += "</td>";
            Iterator it = StaticDataController.getStaticDataBean().getTeamBeanMap().entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry pair = (Map.Entry)it.next();
                System.out.println(pair.getKey() + " = " + pair.getValue());
                //it.remove(); // avoids a ConcurrentModificationException
                
                TeamBean teamBean = (TeamBean) pair.getValue();
                PlayerBean currentPlayerBean = (PlayerBean) teamBean.getPlayerBeanMap().get(playerBean.getPlayerId());
                if(null != currentPlayerBean)
                	message += 	"<td><span class=\"label label-default\" style=\"float:right\">"+ teamBean.getTeamCode() +"</span></td>";
            }
            
            message+= "<td>" + playerBean.getPointsBean().getTotalScore() + "</td>" + "</tr>";
        }
        if(userFixtureBean.getMatchId() > 12){
        	 message += "<tr style=\"background-color: #ebebeb;\">" + "<td align=\"left\" colspan=\"2\"><strong >Power Player</strong></td>" + "<td>" + momOnePoint + "</td>"
                     + "</tr>";
        }
        else{
        	 message += "<tr style=\"background-color: #ebebeb;\">" + "<td align=\"left\" colspan=\"2\"><strong >MOM Points </strong></td>" + "<td>" + momOnePoint + "</td>"
                     + "</tr>";
        }
       
        message += "<tr style=\"background-color: #ebebeb;\">" + "<td colspan=2 align=\"left\"><strong >Player Incentives</strong></td>" + "<td>" + userFixtureBean.getUserOneTeamPlayerPoints() + "</td>"
                + "</tr>";
        
        message += "<tr style=\"color:red\">" + "<td align=\"left\" colspan=\"2\"><strong >Total </strong></td>" + "<td>"
                + userFixtureBean.getUserOnePoints() + "</td>" + "</tr>";
        
        if(1 == userFixtureBean.getUserOneBeanSelectionBean().getIsAutoVote()){
        	
        	isAutoVoteOneMsg = "Not voted : Auto selected";
        }
        message += "<tr>" + "<td align=\"center\" colspan=\"3\"><strong style=\"color:red;font-size:10px\"> " + isAutoVoteOneMsg + " </strong></td></tr>"

                + "</tbody>" + "</table>" + "</div>" + "</div></div>";

        // First User table ends
        // Second User table starts

        String messageTwo = "<div class=\"col-md-6 col-sm-6 col-xs-6\"  style=\"padding : 5px;\">";

        if (userFixtureBean.getUserWinnerId() == userFixtureBean.getUserTwoId())
        {
            messageTwo += "<div class=\"pricing-table popular\" style=\"border-color : #006400 !important\"><div class=\"plan-title\" style=\"background-color : #006400\">"
                    + userFixtureBean.getUserTwoName() + "</div>";
        }
        else
            messageTwo += "<div class=\"pricing-table\"><div class=\"plan-title\">" + userFixtureBean.getUserTwoName()
                    + "</div>";

       // messageTwo += "<div class=\"table-responsive\">";
        if (userFixtureBean.getUserWinnerId() == userFixtureBean.getUserTwoId())
            messageTwo += "<div class=\"win-badge\"></div>";
        messageTwo += "<div class=\"table-responsive margin-bottom-0\">"
                + "<table  id=\"userTwoTbl\"  class=\"table table-condensed nomargin text-center\">" + "<thead>" + "  <tr>"
                + "     <th align=\"left\"><strong >Selected Team </strong> </th><th><span class=\"label label-danger\" style=\"float:right\">"
                + StaticDataController.getStaticDataBean().getTeamBeanMap()
                        .get(Integer.valueOf(userFixtureBean.getUserTwoBeanSelectionBean().getWinTeamId()))
                        .getTeamCode();

        messageTwo += "</span></th>";

        if (StaticDataController.getStaticDataBean().getTeamBeanMap()
                .get(Integer.valueOf(userFixtureBean.getUserTwoBeanSelectionBean().getWinTeamId()))
                .getTeamId() == StaticDataController.getStaticDataBean().getMatchFixturesBeanMap()
                        .get(userFixtureBean.getMatchId()).getTeamWinId())
            messageTwo += "<th style=\"text-align : center\">10</th>";
        else
            messageTwo += "<th style=\"text-align : center\">0</th>";
        messageTwo += "</tr>" + "</thead>" + "<tbody>";

        int momTwoPoint = 0;
        String isAutoVoteTwoMsg = "&nbsp;";
        int rowTwoId = -1;
        for (PlayerBean playerBeantwo : userFixtureBean.getUserTwoBeanSelectionBean().getSelectedPlayerBeanList())
        {
        	rowTwoId++;
            messageTwo += "<tr class=\"rowId"+rowTwoId+" rowColor\"> <td align=\"left\" >" + playerBeantwo.getFirstName().substring(0, 1) + " "
                    + playerBeantwo.getLastName();
            
            //added for power player
            if(userFixtureBean.getMatchId() > 12 && playerBeantwo.getPlayerId() == userFixtureBean.getUserTwoBeanSelectionBean().getPlayerMomId()){
            	messageTwo += "<span class=\"label label-danger\">P</span>";
                //if (playerBeantwo.getPointsBean().getManOftheMatch()) // check
                                                                      // if the
                                                                      // selected
                                                                      // player
                                                                      // is MOM.
                    momTwoPoint = playerBeantwo.getPointsBean().getTotalScore();
            }
            else if (playerBeantwo.getPlayerId() == userFixtureBean.getUserTwoBeanSelectionBean().getPlayerMomId())
            {
                messageTwo += "<span class=\"label label-danger\">M</span>";
                if (playerBeantwo.getPointsBean().getManOftheMatch()) // check
                                                                      // if the
                                                                      // selected
                                                                      // player
                                                                      // is MOM.
                    momTwoPoint = playerBeantwo.getPointsBean().getTotalScore();

            }
            messageTwo += "</td>";
            
            Iterator it = StaticDataController.getStaticDataBean().getTeamBeanMap().entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry pair = (Map.Entry)it.next();
                System.out.println(pair.getKey() + " = " + pair.getValue());
                //it.remove(); // avoids a ConcurrentModificationException
                
                TeamBean teamBean = (TeamBean) pair.getValue();
                PlayerBean currentPlayerBean = (PlayerBean) teamBean.getPlayerBeanMap().get(playerBeantwo.getPlayerId());
                if(null != currentPlayerBean)
                	messageTwo += 	"<td><span class=\"label label-default\" style=\"float:right\">"+ teamBean.getTeamCode() +"</span></td>";
            }
            
            messageTwo += "<td>" + playerBeantwo.getPointsBean().getTotalScore() + "</td>" + "</tr>";
        }
        
        if(userFixtureBean.getMatchId() > 12){
        	messageTwo += "<tr style=\"background-color: #ebebeb;\"> " + "<td colspan=2 align=\"left\"><strong >Power Player</strong></td>" + "<td>" + momTwoPoint + "</td>"
                    + "</tr>";

        }
        else{
        	messageTwo += "<tr style=\"background-color: #ebebeb;\">" + "<td colspan=2 align=\"left\"><strong >MOM Points</strong></td>" + "<td>" + momTwoPoint + "</td>"
                    + "</tr>";
        	
        }
    	messageTwo += "<tr style=\"background-color: #ebebeb;\">" + "<td colspan=2 align=\"left\"><strong >Player Incentives</strong></td>" + "<td>" + userFixtureBean.getUserTwoTeamPlayerPoints() + "</td>"
                + "</tr>";
        

        messageTwo += "<tr style=\"color:red\">" + "<td colspan=2 align=\"left\"><strong >Total </strong></td>" + "<td>"
                + userFixtureBean.getUserTwoPoints() + "</td>" + "</tr>";
        
		if(1 == userFixtureBean.getUserTwoBeanSelectionBean().getIsAutoVote()){
		        	
		        	isAutoVoteTwoMsg = "Not voted : Auto selected";
		      }

        messageTwo += "<tr>" + "<td align=\"center\" colspan=\"3\"><strong style=\"color:red;font-size:10px\"> "+ isAutoVoteTwoMsg + " </strong></td></tr>"

                + "</tbody>" + "</table>" + "</div>" + "</div></div>";
        
        
        if (0 == userFixtureBean.getUserWinnerId()  && "0".equalsIgnoreCase(StaticDataController.getStaticDataBean().getMatchFixturesBeanMap().get(userFixtureBean.getMatchId()).getMatchStatus())) {
        	messageTwo += "<div class=\"col-md-12 col-xs-12 text-center\"><strong style=\"color: red;font-size: 20px;\"><b>Match in progress..</b></strong></div>";
		}
        else if(0 == userFixtureBean.getUserWinnerId() && "1".equalsIgnoreCase(StaticDataController.getStaticDataBean().getMatchFixturesBeanMap().get(userFixtureBean.getMatchId()).getMatchStatus())){
        	
        	messageTwo += "<div class=\"col-md-12 col-xs-12 text-center\"><strong style=\"color: red;font-size: 20px;\"><b> Match Drawn </b></strong></div>";
        	
        	if(1 == userFixtureBean.getUserTwoBeanSelectionBean().getIsAutoVote() && 1== userFixtureBean.getUserOneBeanSelectionBean().getIsAutoVote() && userFixtureBean.getMatchId() > 40){
        		if(userFixtureBean.getMatchId() > 58){
        			messageTwo += "<div class=\"col-md-12 col-xs-12 text-center\"><strong style=\"color: red;font-size: 20px;\"><b>Not Voted : -500 points deducted</b></strong></div>";
        		}
        		else{
        			messageTwo += "<div class=\"col-md-12 col-xs-12 text-center\"><strong style=\"color: red;font-size: 20px;\"><b>Not Voted : -50 points deducted</b></strong></div>";
        		}
            }
        }
		else {
			if (userFixtureBean.getMatchId() > 56) {
				if (userFixtureBean.getUserOnePoints() != userFixtureBean.getUserTwoPoints()) {
					int diff = Math.abs(userFixtureBean.getUserOnePoints() + userFixtureBean.getUserTwoPoints());
					messageTwo += "<div class=\"col-md-12 col-xs-12 text-center\"><strong  style=\"color: red;font-size: 20px;\"><b> Final Points : "
							+ diff + " </b></strong></div>";
				} else {
					messageTwo += "<div class=\"col-md-12 col-xs-12 text-center\"><strong style=\"color: red;font-size: 20px;\"><b> Final Points : 0 </b></strong></div>";
				}
			} else {
				int diff = Math.abs(userFixtureBean.getUserOnePoints() - userFixtureBean.getUserTwoPoints());
				messageTwo += "<div class=\"col-md-12 col-xs-12 text-center\"><strong  style=\"color: red;font-size: 20px;\"><b> Point Difference : "
						+ diff + " </b></strong></div>";
			}

		}
			
        
        return message + messageTwo;
    }

    @RequestMapping(value = "/selectPlayers")
    public String displayVoteDetails(HttpServletRequest request, HttpServletResponse response, Model model,
            @RequestParam int matchId, @RequestParam String comingFrom)
    {
        if (null != request.getSession().getAttribute("user"))
        {
            logger.info("Method :: displayVoteDetails() :: Start");

            UserBean userBean = new UserBean();
            userBean = (UserBean)request.getSession().getAttribute("user");

            model.addAttribute("matchId", matchId);
            model.addAttribute("userSelectionBean", matchService.userVoteDetails(userBean.getUserId(), matchId));
            model.addAttribute("staticDataBean", StaticDataController.getStaticDataBean());
            model.addAttribute("systemParametersMap", matchService.getSystemParametes());
            model.addAttribute("playingXIMap", matchService.getPlayingXI(matchId));
            model.addAttribute("comingFrom", comingFrom);

            return ".ipl.matchDetails";
        }

        return "redirect:/";

    }

    @RequestMapping(value = "/votePlayers")
    public String votePlayers(HttpServletRequest request, HttpServletResponse response, Model model,
            @RequestParam int matchId, @RequestParam int playerMom, @RequestParam int winTeam,
            @RequestParam String selectedPlayersIds, @RequestParam String comingFrom)
    {
        if (null != request.getSession().getAttribute("user"))
        {
            logger.info("Method :: updateVotePlayers() :: Start");

            UserBean userBean = new UserBean();
            userBean = (UserBean)request.getSession().getAttribute("user");

            UserSelectionBean userSelectionBean = new UserSelectionBean();
            userSelectionBean.setUserId(userBean.getUserId());
            userSelectionBean.setMatchId(matchId);
            userSelectionBean.setPlayerMomId(playerMom);
            userSelectionBean.setWinTeamId(winTeam);
            userSelectionBean.setSelectedPlayersIds(selectedPlayersIds);

            String message = matchService.votePlayers(userSelectionBean);

            if (message == "error")
            {
                return ".ipl.error";
            }
            else
            {
                request.getSession().setAttribute("messageToDisplay", message);

                if (null != comingFrom && "dashBoardPage".equalsIgnoreCase(comingFrom))
                {
                    return "redirect:/dashboard";
                }
                else if (null != comingFrom && "fixturePage".equalsIgnoreCase(comingFrom))
                {
                    return "redirect:/fixtures";
                }

            }

        }
        return "redirect:/";

    }
    
    @RequestMapping(value = "/statistics")
    public String displayPlayerstatistics(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        if (null != request.getSession().getAttribute("user"))
        {
            logger.info("Method :: displayPlayerstatistics() :: Start");

            UserBean userBean = new UserBean();
            userBean = (UserBean)request.getSession().getAttribute("user");

            model.addAttribute("staticDataBean", StaticDataController.getStaticDataBean());
            model.addAttribute("systemParametersMap", matchService.getSystemParametes());
            model.addAttribute("playerStatsMap", matchService.getPlayerStats());

            return ".ipl.statistics";
        }

        return "redirect:/";

    }
}
