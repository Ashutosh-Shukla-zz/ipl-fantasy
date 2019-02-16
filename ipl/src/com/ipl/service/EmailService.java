package com.ipl.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.ipl.dao.UserDao;

@Component(value = "emailService")
public class EmailService
{

    @Autowired
    //private MailSender mailSender;
    private JavaMailSender mailSender;

    private static final Logger logger = Logger.getLogger(EmailService.class);
    
    public void sendEmail(String to, String from, String sub, String msgBody)
    {
        logger.info("Method :: sendEmail() :: Start");
         try{
             
        MimeMessage mimeMessage =mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
        mimeMessage.setFrom(from);
        helper.setTo(to);
        mimeMessage.setSubject(sub);
        mimeMessage.setContent(msgBody,"text/html");
       // helper.setText(msgBody);
        mailSender.send(mimeMessage);

         }
         catch (Exception e) {
             
             logger.fatal("Method :: sendEmail()  ::"  + e.getMessage());
        }
       /* SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
        message.setTo(to);
        message.setSubject(sub);
        message.setText(msgBody);
        mailSender.send(message);*/
    }
}