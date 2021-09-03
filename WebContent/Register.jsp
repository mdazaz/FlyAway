<%@ include file="header.jsp" %> 
<%if (session.getAttribute("fname") != null) {
					response.sendRedirect("Home.jsp");
				}
%>
<<script type="text/javascript">

function ValidateRegInput()
{
	$('#regForm input, #regForm select').each(
			// do your validation here ...    		   
			function(index) {
				var input = $(this);
				var x = document.getElementById("errors");
				x.style.display === "none";
				//alert('Type: ' + input.attr('type') + 'Name: ' + input.attr('name') + 'Value: ' + input.val());        
				if (input.val() == '') {
					$(input).addClass('error');
					//alert("Please enter value of " + input.attr('name'))
					//var node = document.createElement("LI");
	  				//var textnode = document.createTextNode("For " +input.attr('name') + "the vlaue ="+ input.val()+" is invalid");
	  				//node.appendChild(textnode);
	  				//x.appendChild(node);
					validationFailed = true;				 
					  if (x.style.display === "none") {
					    x.style.display = "block";
					  }
				}
				else{
					$(input).addClass('is-valid');
				}
			});
}
</script>
 <section class="contact-from pt-4">
 
    <div class="row mt-5">
      <div class="col-md-7 mx-auto">
        <div class="form-wrapper">       
				<div class='row'>
				<div id="errors" style="display:none" class='alert alert-danger'>
					One or more error present in the form.field highlighted in red.
				</div>
          <div class="row">
            <div class="col-md-12">
              <h4>Registration form</h4>
            </div>
          </div>
          <form action="Register" method="post" id="regForm">
            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                  <input type="text" class="form-control" name="fname" placeholder="First name">
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <input type="text" class="form-control" name="lname" placeholder="Last name">
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <input type="email" name="email" class="form-control" placeholder="Email" required>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <input type="text" name= "phone" class="form-control" placeholder="Phone number" required >
                </div>
              </div>
              <div class="col-md-12">
                <div class="form-group">

                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" id="inlineRadio1" value="M">
                    <label class="form-check-label" for="inlineRadio1">Male</label>
                  </div>
                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" id="inlineRadio2" value="F">
                    <label class="form-check-label" for="inlineRadio1">Female</label>
                  </div>
                </div>
              </div>
                            

              <div class="col-md-6">
                <select name="country" class="form-select" id="country">
                  <option>Select country</option>
                  <option>India</option>
                  <option>USA</option>
                  <option>France</option>
                  <option>China</option>
                  <option>Japan</option>
                </select>
              </div>
			   <div class="col-md-6">
                <select name="city" class="form-select" id="city">
                  <option>Select City</option>
                  <option>New Delhi</option>
                  <option>Mumbai</option>
                  <option>Bangalore</option>
                  <option>Lukhnow</option>
                  <option>Chennai</option>
                </select>
              </div>

           
			<div class="col-md-12">
                <div class="form-group">
                  <input type="text" name= "userName" class="form-control" placeholder="User Name" required>
                </div>
              </div>
			  <div class="col-md-6">
                <div class="form-group">
                  <input type="password" name= "password" class="form-control" placeholder="Enter Password" required>
                </div>
              </div>
			  
			  <div class="col-md-6">
                <div class="form-group">
                  <input type="password" name= "rePassword" class="form-control" placeholder="Confirm Password" required>
                </div>
              </div>
               </div>
              <div class="col-12">
    <div class="form-check">
      <input class="form-check-input" type="checkbox" value="" id="invalidCheck" required>
      <label class="form-check-label" for="invalidCheck">
        Agree to terms and conditions
      </label>
      <div class="invalid-feedback">
        You must agree before submitting.
      </div>
    </div>
  </div>
  <div>
                <div class="form-group">
                  <input type="hidden" name= "operation" id="operation" class="form-control"  value="ADD">
                </div>
              </div>
            <div class="mt-3">
              <button type="submit" class="btn btn-primary" id="btnRegister" onClick="return ValidateRegInput()">Register</button>
            </div>
          </form>
        </div>
      </div>
    </div>

</section>
</body>
</html>