<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- MIDDLE -->
<section id="middle">


	<!-- page title -->
	<!-- <header id="page-header">
		<h1>Blank Page</h1>
		<ol class="breadcrumb">
			<li><a href="#">Pages</a></li>
			<li class="active">Blank Page</li>
		</ol>
	</header> -->
	<!-- /page title -->
	
	 
	<c:if test="${not empty messageToDisplay}">
	<a style="display: none" href="#" id="message-lnk" class="btn btn-default toastr-notify" data-progressBar="true" data-position="top-right" data-notifyType="success" data-message="${messageToDisplay}"></a>
	</c:if>
	<div id="content" class="padding-20">
	<form action="doChangePassword" method="post" class="sky-form boxed">
					<header><i class="fa fa-users"></i> Change Password</header>
					
					
					<!--
					<div class="alert alert-danger noborder text-center weight-400 nomargin noradius">
						Invalid Email or Password!
					</div>

					<div class="alert alert-warning noborder text-center weight-400 nomargin noradius">
						Account Inactive!
					</div>

					<div class="alert alert-default noborder text-center weight-400 nomargin noradius">
						<strong>Too many failures!</strong> <br />
						Please wait: <span class="inlineCountdown" data-seconds="180"></span>
					</div>
					-->

					<fieldset>	
					
						<section>
							<label class="label">Old Password</label>
							<label class="input">
								<i class="icon-append fa fa-envelope"></i>
								<input type="password" id="oldPassword" required="required" name="oldPassword">
								<span class="tooltip tooltip-top-right">Old Password</span>
							</label>
						</section>
						
						<section>
							<label class="label">Password</label>
							<label class="input">
								<i class="icon-append fa fa-lock"></i>
								<input type="password" required="required" id="newPassword" name="newPassword">
								<b class="tooltip tooltip-top-right">Type your Password</b>
							</label>
						</section>
						
						<section>
							<label class="label">Confirm Password</label>
							<label class="input">
								<i class="icon-append fa fa-lock"></i>
								<input type="password" required="required" id="confirm-new-password">
								<b class="tooltip tooltip-top-right">Type your Password</b>
							</label>
						</section>

					</fieldset>

					<footer>
						<button onclick="validatePassword();" class="btn btn-primary pull-right">Change Password</button>
					</footer>
				</form>
	
	</div>
</section>
<!-- /MIDDLE -->

</div>

<script>
$(window).load(function() {
	
	var message = '${messageToDisplay}';
	
	if(message!='' || message!=undefined){
		document.getElementById("message-lnk").click()
	}
});



function validatePassword(){
	var password = document.getElementById("newPassword")
	, confirm_password = document.getElementById("confirm-new-password");
	
if(document.getElementById("oldPassword").value=='' || document.getElementById("oldPassword").value==undefined){
	
	//_toastr("Old password is required","top-right","success",false);
	document.getElementById("oldPassword").focus();
	return false;
}
if(password.value=='' || password.value==undefined){
	
	//_toastr("New password is required","top-right","success",false);
	password.focus();
	return false;
}
if(confirm_password.value=='' || confirm_password.value==undefined){
	
	//_toastr("Confirm password is required","top-right","success",false);
	confirm_password.focus();
	return false;
}
	
	
if(password.value != confirm_password.value) {
  confirm_password.setCustomValidity("Passwords Don't Match");
  confirm_password.focus();
  return false;
} else {
  confirm_password.setCustomValidity('');
	document.forms.submit();  
}
}



</script>