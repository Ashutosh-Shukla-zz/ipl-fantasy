<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en-US">
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<title>Ipl 2018 Fantasy</title>
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

			<div class="login-box" style="margin-top: 0">

				<!-- login form -->
				<form action="login" method="post" class="sky-form boxed">
					<header><i class="fa fa-users"></i> Sign In</header>
					
					<c:if test="${ not empty messageToDisplay}">
					<div class="alert alert-success margin-bottom-30"><!-- SUCCESS -->
										<button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
										<strong>${messageToDisplay}</strong>
					</div>
					</c:if>
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
							<label class="label">E-mail</label>
							<label class="input">
								<i class="icon-append fa fa-envelope"></i>
								<input required="required" type="email" name="email" value="">
								<span class="tooltip tooltip-top-right">Email Address</span>
							</label>
						</section>
						
						<section>
							<label class="label">Password</label>
							<label class="input">
								<i class="icon-append fa fa-lock"></i>
								<input required="required" type="password" name="password" value="">
								<b class="tooltip tooltip-top-right">Type your Password</b>
							</label>
						</section>

					</fieldset>

					<footer>
						<button type="submit" class="btn btn-primary pull-right">Sign In</button>
						<div class="forgot-password pull-left">
							<a href="javascript:;" data-toggle="modal" data-target="#forget-password-form" data-dismiss="modal">Forgot password?</a> <br />
							<a href="register"><b>Need to Register?</b></a>
						</div>
					</footer>
				</form>
				<!-- /login form -->

				

			</div>

		</div>
		
		<!-- BEGIN: CONTENT/USER/FORGET-PASSWORD-FORM -->
        <div class="modal fade" id="forget-password-form" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <h3 class="c-font-24 c-font-sbold">Password Recovery</h3>
                        <p>To recover your password please fill in your email address</p>
                        <form method="post" action="">
                            <div class="form-group">
                                <label for="forget-email" class="hide">Email</label>
                                <input required="required" type="email" id="forgotPass-email" class="form-control input-lg c-square" id="forget-email" placeholder="Email"> </div>
                            <div class="form-group">
                                <button type="submit" id="btn-forgotPassword" class="btn btn-primary">Submit</button>
                                <a href="javascript:;" class="" data-toggle="modal" data-target="#login-form" data-dismiss="modal">Back To Login</a>
                            </div>
                            <p id="data-forgotPass-response"></p>
                        </form>
                    </div>
                    <div class="modal-footer c-no-border">
                        <span class="c-text-account">Don't Have An Account Yet ?</span>
                        <a class="btn c-btn-dark-1 btn c-btn-uppercase c-btn-bold c-btn-slim c-btn-border-2x c-btn-square c-btn-signup" href="<c:url value="register"/>">Register</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- END: CONTENT/USER/FORGET-PASSWORD-FORM -->

		<!-- JAVASCRIPT FILES -->
		<script type="text/javascript">var plugin_path = 'assets/plugins/';</script>
		<script type="text/javascript" src="assets/plugins/jquery/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="assets/js/app2.js"></script>
	</body>
	
	<script type="text/javascript">
   jQuery(document).ready(
   		function($) {

   			$("#btn-forgotPassword").click(function(event) {
   				
   				if($("#forgotPass-email").val()==null || $("#forgotPass-email").val()==''){
   					$("#forgotPass-email").setCustomValidity("Please enter email id");
   					return false;
   				}
   				var response='';
				$("#btn-forgotPassword").prop("disabled", true);
   				
   				$.ajax({
  		             type: "POST",
  		             url: "forgotPassword",
  		             data: "email=" +$("#forgotPass-email").val(),
  		             success: function (response) {
  		                 $("#data-forgotPass-response").html(response);
  		             },
  		             error: function (response) {
  		              $("#data-forgotPass-response").html("An error occurred while updating your password, Please contact administrator");
  		             }
  			});
				
			});

		});


   </script>
</html>