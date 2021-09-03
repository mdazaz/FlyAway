<%@page import="com.dto.User"%>
<%@page import="com.dao.UserDaoImpl"%>
<%@ page import="java.util.List" %>
<%@ include file="header.jsp" %>
<%
if(null == session.getAttribute("role")){  
	  // User is not logged in.
	response.sendRedirect("LoginAdmin.jsp");
	}else{  
	  // User IS logged in. 
	  if (!session.getAttribute("role").equals("admin")) {
	response.sendRedirect("LoginAdmin.jsp");
	}
	}

%>

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
	document.getElementById("operation").value="UPDATE";
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
	
function deleteUser(id){
	var result = confirm("Want to delete?");
	if (result) {
		window.location.href="Register?id="+id+"&operation=DEL";
	}
     
}

$( document ).ready(function() {
	
    
});

$( window ).on( "load", function() {
   // console.log( "window loaded" );
});

</script>

<div class="container-md bg-light px-4">
<a href='HomeAdmin.jsp'><i class='fa fa-home fa-2x' style="float: right; margin-top:10px"></i></a>
  <h3 style="padding-top:20px;color:#002bff">User List</h3>
  <hr/>
  <br/>           
   <table class="table table-hover" id="userTable">
   <%
   	UserDaoImpl userDao=new UserDaoImpl();
   	List <User> users=userDao.listUsers();
   	
   	if (users.size()>0)
   	{
   		out.print("<thead><tr><th>Id</th><th>First Name</th><th>Last Name</th><th>Sex</th><th>City</th><th>Country</th><th>Email</th><th>Phone</th><th>Edit</th><th>Delete</th></tr></thead>");
   		out.print("<tbody>");
   		for (User x:users){
   			out.print("<tr>");
   			out.print("<td>"+x.getId()+"</td>");
   			out.print("<td>"+x.getFname()+"</td>");
   			out.print("<td>"+x.getLname()+"</td>");
   			out.print("<td>"+x.getGender()+"</td>");
   			out.print("<td>"+x.getCity()+"</td>");
   			out.print("<td>"+x.getCountry()+"</td>");
   			out.print("<td>"+x.getEmail()+"</td>");
   			out.print("<td>"+x.getPhone()+"</td>");
   			out.print("<td><input type='button' value='Edit' name='edit'onclick='EditUser(this)'/></td>");
   			out.print("<td><input type='button' value='Delete' name='delete'onclick='deleteUser("+x.getId()+")'/></td>");
   			out.print("</tr>");
   		}
   		out.print("</tbody>");
    	}
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

</body>
</html>