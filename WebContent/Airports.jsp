<%@page import="com.dto.Airport"%>
<%@page import="com.dao.AirportDaoImpl"%>
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
function addAirport() {
	  var x = document.getElementById("frmAdd");
	  var btn= document.getElementById("btnAdd")
	  if (x.style.display === "none") {
	    x.style.display = "block";
	    btn.value="Hide Add Form";
	  } else {
	    x.style.display = "none";
	    btn.value="Add New Airport";
	  }
	}
function EditAirport(el)
{
	var activeRow=el.parentNode.parentNode.rowIndex;
	var tab=document.getElementById("airportTable").rows[activeRow];
	var id=tab.getElementsByTagName("TD")[0].innerText;
	var name=tab.getElementsByTagName("TD")[1].innerText;
	var city=tab.getElementsByTagName("TD")[2].innerText;
	var country=tab.getElementsByTagName("TD")[3].innerText;
	var code=tab.getElementsByTagName("TD")[4].innerText;
	
	document.getElementById("name").value=name;
	document.getElementById("city").value=city;
	document.getElementById("country").value=country;
	document.getElementById("code").value=code;
	document.getElementById("operation").value="UPDATE";
	document.getElementById("btnSubmit").value="UPDATE";
	
	var input = document.createElement("input");
	input.setAttribute("type", "hidden");
	input.setAttribute("name", "id");
	input.setAttribute("value", id);
	
	//append to form element id as a hidden field .
	document.getElementById("frmAdd").appendChild(input);
	
		
	}
	
function deleteAirport(id){
	var result = confirm("Want to delete?");
	if (result) {
		window.location.href="AirportManagement?id="+id+"&operation=DEL";
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
  <h2 style="padding-top:20px;color:#002bff">Airport List</h2>
  <br/>           
   <table class="table table-hover editable" id="airportTable">
   <%
   	AirportDaoImpl airportDao=new AirportDaoImpl();
   	List <Airport> airports=airportDao.listAirports();
   	
   	if (airports.size()>0)
   	{
   		out.print("<thead><tr><th>Id</th><th>Name</th><th>City</th><th>Country</th><th>Code</th><th>Edit</th><th>Delete</th></tr></thead>");
   		out.print("<tbody>");
   		for (Airport x:airports){
   			out.print("<tr>");
   			out.print("<td>"+x.getId()+"</td>");
   			out.print("<td>"+x.getName()+"</td>");
   			out.print("<td>"+x.getCity()+"</td>");
   			out.print("<td>"+x.getCountry()+"</td>");
   			out.print("<td>"+x.getCode()+"</td>");
   			out.print("<td><input type='button' value='Edit' class='btn-sm btn-primary' name='edit'onclick='EditAirport(this)'/></td>");
   			out.print("<td><input type='button' value='Delete' class=' btn-sm ' name='delete'onclick='deleteAirport("+x.getId()+")'/></td>");
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
  <input type="button" id="btnAdd" value="Add New Airport" onclick="addAirport();"/>
  <hr/>
  
  <form id="frmAdd" class="form" action="AirportManagement" method="post" >
  <div class="row">
              <div class="col-md-3">
                <div class="form-group">
                  <input type="text" class="form-control" name="name" id="name" placeholder="Airport Name">
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <input type="text" class="form-control" name="city" id="city" placeholder="City">
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <input type="text" name="country" class="form-control" id="country" placeholder="Country">
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <input type="text" name= "code" id="code" class="form-control" placeholder="code">
                </div>
              </div>
              <div>
                <div class="form-group">
                  <input type="hidden" name= "operation" id="operation" class="form-control"  value="ADD">
                </div>
              </div>
              <hr/>
              <div>
              	<div class="form-group">
                  <input type="Submit" name= "btnAdd" id="btnSubmit" class="btn btn-primary" value="Add">
                </div>
              </div>
      </div>
  
  </form>
</div>

</body>
</html>