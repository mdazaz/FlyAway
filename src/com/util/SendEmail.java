package com.util;

import java.util.Properties;  
import javax.mail.*;  
import javax.mail.internet.*;


public class SendEmail { 
	  String host="smtp.gmail.com";  
	  final String user="latter4u@gmail.com";//change accordingly  
	  final String password="9798231678";//change accordingly  
	  	  
	   //Get the session object  
	   Properties props = new Properties(); 
	
	public SendEmail() {  
 
   props.setProperty("mail.transport.protocol", "smtp");     
   props.setProperty("mail.host", host);  
   props.put("mail.smtp.auth", "true");  
   props.put("mail.smtp.port", "465");  
   props.put("mail.debug", "true");  
   props.put("mail.smtp.socketFactory.port", "465");  
   props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");  
   props.put("mail.smtp.socketFactory.fallback", "false"); 
       
   }
	public boolean composeMessage(String msg, String to) {
		   try { 
			   Session session = Session.getDefaultInstance(props,  
					    new javax.mail.Authenticator() {  
					      protected PasswordAuthentication getPasswordAuthentication() {  
					    return new PasswordAuthentication(user,password);  
					      }  
					    });  
					  
					   //Compose the message 
			     MimeMessage message = new MimeMessage(session);  
			     message.setFrom(new InternetAddress(user));  
			     message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
			     message.setSubject("Welcom To FlyAway");  
			     message.setContent(msg,"text/html"); //For Html Message
			     //message.setText(msg); //For Plain Message 
			       
			    //send the message  
			     Transport.send(message);  
			  
			     System.out.println("message sent successfully..."); 
			   
			     } catch (MessagingException e) {e.printStackTrace();}
		   		return true;  
			 }  
    
}  