<%@page import="com.dto.Airline"%>
<%@page import="com.dao.AirlineDaoImpl"%>
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
function addAirline() {
	  var x = document.getElementById("frmAdd");
	  var btn= document.getElementById("btnAdd")
	  if (x.style.display === "none") {
	    x.style.display = "block";
	    btn.value="Hide Add Form";
	  } else {
	    x.style.display = "none";
	    btn.value="Add New Airline";
	  }
	}
function EditAirline(el)
{
	var activeRow=el.parentNode.parentNode.rowIndex;
	var tab=document.getElementById("airlineTable").rows[activeRow];
	var id=tab.getElementsByTagName("TD")[0].innerText;
	var name=tab.getElementsByTagName("TD")[1].innerText;
	var logo=tab.getElementsByTagName("TD")[2].innerText;
	var status=tab.getElementsByTagName("TD")[3].innerText;
	
	
	document.getElementById("name").value=name;
	document.getElementById("logo").value=logo;
	document.getElementById("status").value=status;
	document.getElementById("operation").value="UPDATE";
	document.getElementById("btnSubmit").value="UPDATE";
	
	var input = document.createElement("input");
	input.setAttribute("type", "hidden");
	input.setAttribute("name", "id");
	input.setAttribute("value", id);
	
	//append to form element id as a hidden field .
	document.getElementById("frmAdd").appendChild(input);
	
		
	}
	
function deleteAirline(id){
	var result = confirm("Want to delete?");
	if (result) {
		window.location.href="AirlineManagement?id="+id+"&operation=DEL";
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
  <h2 style="padding-top:20px;color:#002bff">Airline List</h2>
  <br/>           
   <table class="table table-hover table-sm table-bordered" id="airlineTable">
   <%
    	AirlineDaoImpl airlineDao=new AirlineDaoImpl();
   	List <Airline> airlines=airlineDao.listAirlines();
   	
   	if (airlines.size()>0)
   	{
   		out.print("<thead class='thead-dark'><tr><th>Id</th><th>Name</th><th>Logo Path</th><th>Status</th><th>Edit</th><th>Delete</th></tr></thead>");
   		out.print("<tbody>");
   		for (Airline x:airlines){
   			out.print("<tr>");
   			out.print("<td>"+x.getId()+"</td>");
   			out.print("<td>"+x.getName()+"</td>");
   			out.print("<td>"+x.getLogo()+"</td>");
   			out.print("<td>"+x.getStatus()+"</td>");
   			
   			out.print("<td><input type='button' value='Edit' name='edit'onclick='EditAirline(this)'/></td>");
   			out.print("<td><input type='button' value='Delete' name='delete'onclick='deleteAirline("+x.getId()+")'/></td>");
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
  <input type="button" id="btnAdd" value="Add New Airline" onclick="addAirline();"/>
  <hr/>
  
  <form id="frmAdd" class="form" action="AirlineManagement" method="post" >
  <div class="row">
              <div class="col-md-3">
                <div class="form-group">
                  <input type="text" class="form-control" name="name" id="name" placeholder="Airline Name">
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <input type="text" class="form-control" name="logo" id="logo" placeholder="Logo">
                </div>
              </div>
              <div class="col-md-3">
                <div class="form-group">
                  <input type="text" name="status" class="form-control" id="status" placeholder="Status">
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