<%@ page import="com.util.*"%>
<%@ include file="header.jsp"%>

<%
   SendEmail sm=new SendEmail();

      // Now set the actual message      
      String to=request.getParameter("email");
      String userName=request.getParameter("userName");
      String Password=request.getParameter("pwd");
      String msg=("Hi "+userName+"! <br> Welcome to <b>FlyWay!</b></br> your new account has been added successfully.<br/> Kindly note the Credential for future reference:<br/>" +"User Name: "+userName+"<br/> Password: "+Password+"<br/> Thank you & Regards<br/> Mohammad Azaz");
     boolean result=sm.composeMessage(msg, to);
%>

<div class="container py-4">
    <header class="pb-3 mb-4 border-bottom">
      <p class="d-flex align-items-center text-dark text-decoration-none">
      <% 
         	if(result)
         	{
         		out.println("<p>Congratulations!! Your Account is Created Successfully! <p>");
         	}
         	else {
         		out.print("<p> Registration Failed!</a>");
         	}
         %>
             
      </p>
    </header>

    <div class="p-5 mb-4 bg-light rounded-3">
      <div class="container-fluid py-5">
      <%
      if(result)
   	{
   		out.println("<p class='col-md-8 fs-4'><p>An Email has been sent to your registered email "+to+" which contains your Id and Password<p>");
   		out.println ("<a href='Login.jsp'></div><button class='btn btn-primary btn-lg' type='button'>Login Now</button></a>");
   	}
      else {
    	  out.println("<p class='col-md-8 fs-4'><p>Email Couldn't sent to your registered email <p>");
     		out.println ("<a href='Register.jsp'></div><button class='btn btn-primary btn-lg' type='button'>Try Again</button></a>");
      }
      %>
         
        
      </div>
    </div>	

</body>
</html>