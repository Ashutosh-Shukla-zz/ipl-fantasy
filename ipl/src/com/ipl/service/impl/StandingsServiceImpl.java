package com.ipl.service.impl;

import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ipl.bean.UserPointsBean;
import com.ipl.dao.StandingsDao;
import com.ipl.service.StandingsService;

@Component(value="standingsService")
public class StandingsServiceImpl implements StandingsService
{
	 
	private static final Logger logger = Logger.getLogger(StandingsServiceImpl.class);
	 
    @Autowired
    StandingsDao standingsDao;
    
    public ArrayList<UserPointsBean> getPointsTable() {
    	ArrayList<UserPointsBean> pointsList = new ArrayList<UserPointsBean>();
    	pointsList = standingsDao.getAllStandings();
    	return pointsList;
    }
}
