<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  
<!DOCTYPE html>
<html>
<head>

<link href="bootstrap-5.1.0-dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap-5.1.0-dist/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/1fa32a33c8.js" crossorigin="anonymous"></script>

<link rel="stylesheet" href="css/main.css">


<meta charset="ISO-8859-1">
<title>FLyAway|| Online FLight Booking service|| Roam Around the World!!</title>
</head>
<body>
 <nav class="py-2 navbar-dark fixed-top bg-light border-bottom">
     <div class="container d-flex flex-wrap">
     <a class="navbar-brand" href="Home.jsp">
    <img src="images/logo.png" width="50" height="45" class="d-inline-block align-top" alt="">
   <span class="text-info ">FlyAway</span>
  </a>
      <ul class="nav me-auto">
        <li class="nav-item"><a href="Home.jsp" class="nav-link px-2 nav-link active" aria-current="page">Home</a></li>
        <li class="nav-item"><a href="SearchFlight.jsp" class="nav-link link-dark px-2">BookFlight</a></li>
        <li class="nav-item"><a href="FlightStatus.jsp" class="nav-link link-dark px-2">Flight Status</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">Webcheck-in</a></li>
        <li class="nav-item"><a href="#" class="nav-link link-dark px-2">About</a></li>
      </ul>
      <ul class="nav">
      <%
      if (session.getAttribute("fname") != null ) {
    	  out.println("<li class='nav-item'><a href='Logout.jsp' class='nav-link link-dark px-2'><i class='fa fa-sign-out' style='margin-right:.3rem'></i>Logout</a></li>");
          out.println("<li class='nav-item'><a href='User_Profile.jsp' class='nav-link link-dark px-2'><i class='fa fa-user' style='margin-right:.3rem'></i>Profile</a></li>");           
      }
      else if (session.getAttribute("name") != null ) {
    	  out.println("<li class='nav-item'><a href='Logout.jsp' class='nav-link link-dark px-2 btn-info'><i class='fa fa-sign-out' style='margin-right:.3rem'></i>Logout</a></li>");
          out.println("<li class='nav-item'><a href='#' data-bs-toggle='modal' data-bs-target='#exampleModal' class='nav-link link-dark px-2 btn-warning'><i class='fa fa-key' style='margin-right:.3rem'></i>ChangePassword</a></li>");           
      }
      else
      {    	  
    	  out.println("<li class='nav-item'><a href='Login.jsp' class='nav-link link-dark px-2'><i class='fa fa-sign-in' style='margin-right:.3rem'></i>Login</a></li>");
          out.println("<li class='nav-item'><a href='Register.jsp' class='nav-link link-dark px-2'><i class='fa fa-user-plus' style='margin-right:.3rem'></i>Register</a></li>");
      }
      %>
        
      </ul>
    </div>
  </nav>
  <header class="py-3 mb-4">
    <div class="container d-flex flex-wrap justify-content-center">
      <a href="/" class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
        <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
      </a>      
    </div>
  </header> 

<main role="main" class="container">

<!-- Admin Change Password Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Change Admin Password</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       <form class ='form' >
          <input type="password" class='form-control' name="oldPassword" placeholder="Old Password"/>
           <input type="password" class='form-control' name="Password" placeholder="New Password"/>
            <input type="password" class='form-control' name="rePassword" placeholder="Re enter Password"/>
          </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
