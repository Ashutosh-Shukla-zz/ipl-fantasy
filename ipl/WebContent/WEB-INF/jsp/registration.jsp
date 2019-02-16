<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en-US">
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<title>Register</title>
		<meta name="description" content="" />

		<!-- mobile settings -->
		<meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />

		<!-- WEB FONTS -->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700,800&amp;subset=latin,latin-ext,cyrillic,cyrillic-ext" rel="stylesheet" type="text/css" />

		<!-- CORE CSS -->
		<link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		
		<!-- THEME CSS -->
		<link href="assets/css/essentials.css" rel="stylesheet" type="text/css" />
		<link href="assets/css/layout.css" rel="stylesheet" type="text/css" />
		<link href="assets/css/color_scheme/green.css" rel="stylesheet" type="text/css" id="color_scheme" />
		
		<style>
		html, body {
    		background: #002E6E;
		}
		</style>
	</head>
	<!--
		.boxed = boxed version
	-->
	<body>
		<center><img alt="logo" style="width:120px;margin-top: 5%" src="assets/images/logo.png">
		<h3 style="color:white;margin:10px">IPL Fantasy 2018</h3></center>

		<div class="padding-15">

			<div class="login-box"  style="margin-top: 0">

				<!--
				<div class="alert alert-danger">Complete all fields!</div>
				-->

				<!-- registration form -->
				<form:form modelAttribute="userBean" action="registration" enctype="multipart/form-data" method="post" class="sky-form boxed" novalidate="novalidate">
					<header><i class="fa fa-users"></i> Create Your Account</header>
					
					<fieldset>					
						<label class="input">
							<i class="icon-append fa fa-envelope"></i>
							<form:input type="email" path="email" placeholder="Email address"/>
							<b class="tooltip tooltip-bottom-right">Needed to verify your account</b>
							<div id="email-error" style="color:red;"></div>
						</label>
						
						<div class="c-body" id="data-response" style="display: none;">
                                <p style="color:red;">Email already exists</p>
                        </div>
					
						<label class="input">
							<i class="icon-append fa fa-lock"></i>
							<form:input type="password" id="password" path="password" placeholder="Password" />
							<b class="tooltip tooltip-bottom-right">Only latin characters and numbers</b>
							<div id="password-error" style="color:red;"></div>
						</label>
					
						<label class="input">
							<i class="icon-append fa fa-lock"></i>
							<input required="required" type="password" id="confirm-password" placeholder="Confirm password">
							<b class="tooltip tooltip-bottom-right">Only latin characters and numbers</b>
							<div id="confirm-password-error" style="color:red;"></div>
						</label>
					</fieldset>
						
					<fieldset>
						<div class="row">
							<div class="col-md-6 col-xs-6">
								<label class="input">
									<form:input type="text" placeholder="First name" path="firstName" />
									<div id="firstName-error" style="color:red;"></div>
								</label>
							</div>
							<div class="col col-md-6  col-xs-6">
								<label class="input">
									<form:input type="text" path="lastName" placeholder="Last name" />
									<div id="lastName-error" style="color:red;"></div>
								</label>
							</div>
						</div>

						<!-- label class="input">
							<i class="icon-append fa fa-lock"></i>
							<form:input type="number" path="mobile" placeholder="Mobile Number" />
							<b class="tooltip tooltip-bottom-right">Mobile Number Only</b>
							<div id="mobile-error"></div>
						</label> -->
						
						<div class="margin-top20">
							<label class="checkbox nomargin"><input class="checked-agree" id="checked-agree" type="checkbox" name="checkbox"><i></i>I agree to the <a href="#" data-toggle="modal" data-target="#termsModal">Terms of Service</a></label>
							<div id="check-error" style="color:red;"></div>
						</div>
					</fieldset>

					<footer>
						
						<input type="button" id="btn-submit" class="btn btn-primary pull-right" value="Create Account" onclick="validateRegister()">
						<div class="forgot-password pull-left">
							<a href="home"><b>Already a member?</b></a>
						</div>
					</footer>

				</form:form>
				<!-- /registration form -->

				

			</div>

		</div>


		<!-- MODAL -->
		<div class="modal fade" id="termsModal" tabindex="-1" role="dialog" aria-labelledby="myModal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModal">Terms &amp; Conditions</h4>
					</div>

					<div class="modal-body modal-terms">
						<h4><b>Introduction</b></h4>
						<p>These terms and conditions govern your use of this website; by using this website, you accept these terms and conditions in full.   If you disagree with these terms and conditions or any part of these terms and conditions, you must not use this website.</p>
						<p>No legal actions can be taken against the creator od the promoter of the website</p>
						<p>This website is solely created for the entertainment purpose and is not associated with any illegal activities whatsoever</p>
						<p>Use this website at your own risk, we are not liable if your cat kills you or you die or there is a nuclear war :P ;)</p>
						
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-primary" id="terms-agree"><i class="fa fa-check"></i> I Agree</button>
						
						<button type="button" class="btn btn-danger pull-left"><i class="fa fa-print"></i> Print</button>
					</div>

				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div>
		<!-- /MODAL -->

	
		<!-- JAVASCRIPT FILES -->
		<script type="text/javascript">var plugin_path = 'assets/plugins/';</script>
		<script type="text/javascript" src="assets/plugins/jquery/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="assets/js/app2.js"></script>

		<!-- PAGE LEVEL SCRIPTS -->
		<script type="text/javascript">

			/**
				Checkbox on "I agree" modal Clicked!
			**/
			jQuery("#terms-agree").click(function(){
				jQuery('#termsModal').modal('toggle');

				// Check Terms and Conditions checkbox if not already checked!
				if(!jQuery("#checked-agree").checked) {
					jQuery("input.checked-agree").prop('checked', true);
				}
				
			});
			

		    jQuery(document).ready(
		    		function($) {
		    			
		    			
						$('#email').focusout( function() {
		    				
							$("#data-response").css('display', 'none');
							$("#btn-submit").removeAttr("disabled");
		    				var response='';
							var message='';
		    				$.ajax({
		       		             type: "POST",
		       		             url: "checkEmailExists",
		       		             data: 'emailId=' + $('#email').val(),
		       		             success: function (response) {
		       		                // $("#data-response").html(response);
		       		              if(response == 'true'){
	
		     		                	$("#data-response").removeAttr("style");
		     		                	
		     		                	$("#btn-submit").attr("disabled","disabled");
		     		                }
		     		             	else{
		     		             		
		     		             	}
		       		             },
		       		             error: function (response) {
		       		            	message = response;
		       		                // $("#btn-changePassword").prop("disabled", false);
		       		                
		       		             }
		       				});
		    				
		    			});

					});

			function validateRegister() {
				
				
				
				if($('#email').val()==null || $('#email').val()=='')
				{
				$('#email-error').html("Email id is mandatory");
				$('#email').focus();
				return false;
				}else{
					var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;  
					if(!$('#email').val().match(mailformat))  
					{  
						$('#email-error').html("Enter Valid Email");
						$('#email').focus(); 
						return false; 
					}  
					$('#email-error').html("");
					 
					}
				if($('#password').val()==null || $('#password').val()=='')
				{
				$('#password-error').html("Password is mandatory");
				$('#password').focus();
				return false;
				}else{$('#password-error').html("");}
				if($('#confirm-password').val()==null || $('#confirm-password').val()=='')
				{
				$('#confirm-password-error').html("Confirm Password is mandatory");
				$('#confirm-password').focus();
				return false;
				}else if($('#confirm-password').val() != $('#password').val()){
					$('#confirm-password-error').html("Passwords dont match");
					}else{$('#confirm-password-error').html("");}
				if($('#firstName').val()==null || $('#firstName').val()=='')
				{
				$('#firstName-error').html("First Name is mandatory");
				$('#firstName').focus();
				return false;
				}else{$('#firstName-error').html("");}
				
				if(!$('#checked-agree').is(':checked')){
					$('#check-error').html('Please check the terms and conditions to continue');
					return false;
				}
				$("#btn-submit").prop("disabled", true);
				document.forms[0].submit();
				
			}

		</script>

	</body>
</html>