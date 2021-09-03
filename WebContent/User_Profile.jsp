<%@page import="com.dto.User"%>
<%@page import="java.util.List"%>
<%@page import="com.dao.UserDaoImpl"%>
<%@page import="com.dao.UserDAO"%>
<%@ include file="header.jsp" %>
<%
if (session.getAttribute("fname") == null) {
	response.sendRedirect("Login.jsp");
}
%>
    <style>
.card-img-top {
    width: 100%;
    height: 12vw;

}
</style>

<style>
#add {
  display:block;
  }
</style>
<script type="text/javascript">
function HideForm() {
	  var x = document.getElementById("frmAdd");
	  
	  if (x.style.display === "block") {
	    x.style.display = "none";
	  }
	}
function EditUser(el)
{
	var activeRow=el.parentNode.parentNode.rowIndex;
	var tab=document.getElementById("userTable").rows[activeRow];
	var id=tab.getElementsByTagName("TD")[0].innerText;
	var fname=tab.getElementsByTagName("TD")[1].innerText;
	var lname=tab.getElementsByTagName("TD")[2].innerText;
	var gender=tab.getElementsByTagName("TD")[3].innerText;
	var city=tab.getElementsByTagName("TD")[4].innerText;
	var country=tab.getElementsByTagName("TD")[5].innerText;
	var email=tab.getElementsByTagName("TD")[6].innerText;
	var phone=tab.getElementsByTagName("TD")[7].innerText;
	
	document.getElementById("fname").value=fname;
	document.getElementById("lname").value=lname;
	document.getElementById("gender").value=gender;
	document.getElementById("city").value=city;
	document.getElementById("country").value=country;
	document.getElementById("email").value=email;
	document.getElementById("phone").value=phone;
	document.getElementById("operation").value="OWN_PROFILE_UPDATE";
	document.getElementById("btnSubmit").value="UPDATE";
	
	var input = document.createElement("input");
	input.setAttribute("type", "hidden");
	input.setAttribute("name", "id");
	input.setAttribute("value", id);
	
	//append to form element id as a hidden field .
	document.getElementById("frmAdd").appendChild(input);
	var x = document.getElementById("frmAdd");	  
	  if (x.style.display === "none") {
	    x.style.display = "block";	   
	  } 		
	}
	
function viewUser(){
	//$("#exampleModalToggle").modal('show');
}
	</script>
	
  <div class="container py-4">
    <header class="pb-3 mb-4 border-bottom">
      <a href="/" class="d-flex align-items-center text-dark text-decoration-none">
        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="32" class="me-2" viewBox="0 0 118 94" role="img"><title>Bootstrap</title><path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z" fill="currentColor"></path></svg>
        <span class="fs-4"><%
	out.println("Welcome to Fly Away <b>" +session.getAttribute("fname")+" "+session.getAttribute("lname")+"</b>");
	%></span>
      </a>
    </header>
	


    <div class="p-5 mb-4 bg-light rounded-3">
      <div class="container-fluid py-5">
      
      <table class="table table-hover" id="userTable">
   <%
   
   			int user_id=0;		
			HttpSession session1 = request.getSession(true);
			if (session1.getAttribute("userId") != null ) {
				 user_id= (int) session.getAttribute("userId");           
		      }
   
   	UserDAO userDao=new UserDaoImpl();
   	User user =userDao.getUserById(user_id);
   	 		out.print("<thead><tr><th>Id</th><th>First Name</th><th>Last Name</th><th>Sex</th><th>City</th><th>Country</th><th>Email</th><th>Phone</th><th>Edit</th><th>View</th></tr></thead>");
   		out.print("<tbody>");
   		
   			out.print("<tr>");
   			out.print("<td>"+user.getId()+"</td>");
   			out.print("<td>"+user.getFname()+"</td>");
   			out.print("<td>"+user.getLname()+"</td>");
   			out.print("<td>"+user.getGender()+"</td>");
   			out.print("<td>"+user.getCity()+"</td>");
   			out.print("<td>"+user.getCountry()+"</td>");
   			out.print("<td>"+user.getEmail()+"</td>");
   			out.print("<td>"+user.getPhone()+"</td>");
   			out.print("<td><input type='button' value='Edit' name='edit'onclick='EditUser(this)'/></td>");
   			out.print("<td><input type='button' value='View' name='view'onclick='viewUser("+user.getId()+")'/></td>");
   			out.print("</tr>");   		
   		out.print("</tbody>");
    	
    String ID=request.getParameter("ID");
    if(ID!=null)
    {
    	out.print("<div class='alert alert-success' role='alert'>A Record has been added with the id: "+ID+"</div>");
    }
   %>
   
  </table>
    <hr/>
  
  <form id="frmAdd" class="form" action="Register" method="post" style="display: 'none'" >
  <div class="row">
              <div class="col-md-2">
                <div class="form-group">
                  <input type="text" class="form-control" name="fname" id="fname" placeholder="First Name">
                </div>
              </div>
              <div class="col-md-2">
                <div class="form-group">
                  <input type="text" class="form-control" name="lname" id="lname" placeholder="Last Name">
                </div>
              </div>
              <div class="col-md-1">
                <div class="form-group">
                  <input type="text" class="form-control" name="gender" id="gender" placeholder="Gender">
                </div>
              </div>
              <div class="col-md-2">
                <div class="form-group">
                  <input type="text" class="form-control" name="city" id="city" placeholder="City">
                </div>
              </div>
              <div class="col-md-1">
                <div class="form-group">
                  <input type="text" name="country" class="form-control" id="country" placeholder="Country">
                </div>
              </div>
              <div class="col-md-2">
                <div class="form-group">
                  <input type="text" name= "email" id="email" class="form-control" placeholder="Email">
                </div>
              </div>
              <div class="col-md-2">
                <div class="form-group">
                  <input type="text" class="form-control" name="phone" id="phone" placeholder="Phone">
                </div>
              </div>
              <div>
                <div class="form-group">
                  <input type="hidden" name= "operation" id="operation" class="form-control"  value="UPDATE">
                </div>
              </div>
              <hr/>
              <div>
              	<div class="form-group">
                  <input type="Submit" name= "btnUpdate" id="btnSubmit" class="btn btn-primary" value="SAVE" onClick="HideForm()">
                </div>
              </div>
      </div>
  
  </form>
    
      
           
  </div> 
  </div>
    <div class="row align-items-md-stretch">
      <div class="col-md-6">
        <div class="h-100 p-5 text-white bg-dark rounded-3">
          <h2>Covid Guidelines</h2>
          <p>Swap the background-color utility and add a `.text-*` color utility to mix up the jumbotron look. Then, mix and match with additional component themes and more.</p>
          <button class="btn btn-outline-light" type="button">Example button</button>
        </div>
      </div>
      <div class="col-md-6">
        <div class="h-100 p-5 bg-light border rounded-3">
          <h2>Website Settings</h2>
          <p>Or, keep it light and add a border for some added definition to the boundaries of your content. Be sure to look under the hood at the source HTML here as we've adjusted the alignment and sizing of both column's content for equal-height.</p>
          <button class="btn btn-outline-secondary" type="button">Example button</button>
        </div>
      </div>
    </div>

    <footer class="pt-3 mt-4 text-muted border-top">
      &copy; 2021
    </footer>
  </div>
</main>
	
</body>
</html>