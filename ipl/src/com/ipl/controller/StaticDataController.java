package com.ipl.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ipl.bean.StaticData.StaticDataBean;
import com.ipl.service.StaticDataService;

@Controller
public class StaticDataController
{
    @Autowired
    private StaticDataService staticDataService;
    
    private static StaticDataBean staticDataBean = null;

    private static final Logger logger = Logger.getLogger(StaticDataController.class);
    
    @RequestMapping(value = "/staticData")    
    public String getStaticData (HttpServletRequest request, HttpServletResponse response)
    {
    	if(staticDataBean == null){
    		
    		staticDataBean = new StaticDataBean();
    		
    		 staticDataBean = staticDataService.populateStaticData();
    	} 
    	
    	//request.getSession().setAttribute("staticDataBean", staticDataBean);
    	
    	return "redirect:/home";

    }
    
    public static StaticDataBean getStaticDataBean() {
    	
    	return staticDataBean;
		
	}
    
    @RequestMapping(value = "/updateStaticData")  
    public String updateStaticDataBean() {
    	
    	staticDataBean = staticDataService.populateStaticData();
    	return "redirect:/";
		
	}

}
