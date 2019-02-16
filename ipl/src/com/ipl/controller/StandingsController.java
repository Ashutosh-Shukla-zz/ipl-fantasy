package com.ipl.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ipl.bean.UserPointsBean;
import com.ipl.service.StandingsService;

@Controller
public class StandingsController
{
    
    @Autowired
    private StandingsService standingsService;

    private static final Logger logger = Logger.getLogger(StandingsController.class);
    
    @RequestMapping(value = "/standings")
    public String displayStandings(HttpServletRequest request, HttpServletResponse response, Model model)
    {
        if (null != request.getSession().getAttribute("user"))
        {
        	ArrayList<UserPointsBean> pointsList = new ArrayList<UserPointsBean>();
        	pointsList = standingsService.getPointsTable();
        	model.addAttribute("pointsList", pointsList);
        	logger.info("Method :: displayStandings() :: Start");
        	return ".ipl.standings";
        }
        return "redirect:/home";

    }
}
