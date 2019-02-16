package com.ipl.controller;

import java.io.PrintWriter;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

@ControllerAdvice
public class GlobalExceptionController
{

    private static final Logger logger = Logger.getLogger(GlobalExceptionController.class);

    @ExceptionHandler(Exception.class)
    public String handleAllException(HttpServletRequest req, Exception ex)
    {
        String messageToDisplay = "An error occurred, Please contact the administrator ";
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        ex.printStackTrace(pw);

        logger.fatal("Request: " + req.getRequestURL() + " raised " + sw.toString());

        req.getSession().setAttribute("messageToDisplay", messageToDisplay);
        return ".ipl.error";

    }
    
    

}