<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--
		.boxed = boxed version
	-->
	<body>


		<!-- WRAPPER -->
		<div id="wrapper" class="clearfix">

			<!-- 
				ASIDE 
				Keep it outside of #wrapper (responsive purpose)
			-->
			<aside id="aside">
				<!--
					Always open:
					<li class="active alays-open">

					LABELS:
						<span class="label label-danger pull-right">1</span>
						<span class="label label-default pull-right">1</span>
						<span class="label label-warning pull-right">1</span>
						<span class="label label-success pull-right">1</span>
						<span class="label label-info pull-right">1</span>
				-->
				<nav id="sideNav"><!-- MAIN MENU -->
					<ul class="nav nav-list">
						<li class="active"><!-- dashboard -->
						<c:choose>
							<c:when test="${user.isAdmin}">
								<a class="dashboard" href="adminDashboard"><!-- warning - url used by default by ajax (if eneabled) -->
								<i class="main-icon fa fa-dashboard"></i> <span>Dashboard</span>
								</a>
							</c:when>
							<c:otherwise>
								<a class="dashboard" href="dashboard"><!-- warning - url used by default by ajax (if eneabled) -->
									<i class="main-icon fa fa-dashboard"></i> <span>Dashboard</span>
								</a>
							</c:otherwise>
								
						</c:choose>
						</li>
						<li>
							<a href="fixtures">
								<i class="main-icon et-calendar"></i> <span>Fixtures</span>
							</a>
						</li>
						
						<li>
							<a href="standings">
								<i class="main-icon et-trophy"></i> <span>Points Table</span>
							</a>
						</li>
						
						<li>
							<a onclick="openHistory('${user.userId }')">
								<i class="main-icon fa fa-table"></i> <span>My History</span>
							</a>
						</li>
						
						<li>
							<a href="statistics">
								<i class="main-icon fa fa-bar-chart-o"></i> <span>Statistics</span>
							</a>
						</li>
						
						<li>
							<a href="rules">
								<i class="main-icon fa fa-book"></i> <span>Rules</span>
							</a>
						</li>
						
												<c:if test="${user.isAdmin}">
						<li>
							<a href="approvals">
								<i class="main-icon et-key"></i> <span>Approvals</span>
							</a>
						</li>
						</c:if>
						
					</ul>
				
					
					
				</nav>
				
				<ul class="nav nav-list" style="bottom: 15px;position: fixed;padding-left: 15px;">
						<li>
						Made with&nbsp; <i class="main-icon fa fa-heart fa-spin " style="color: #E66454"></i>in Mumbai
						</li>	
					</ul>
				
				<span id="asidebg"><!-- aside fixed background --></span>
			</aside>
			<!-- /ASIDE -->


			<!-- HEADER -->
			<header id="header">

				<!-- Mobile Button -->
				<button id="mobileMenuBtn"></button>

				<!-- Logo -->
				<span class="logo pull-left">
					<img src="assets/images/logo.png" alt="Ipl Fantasy" height="35" />
				</span>

				
				<nav>

					<!-- OPTIONS LIST -->
					<ul class="nav pull-right">

						<!-- USER OPTIONS -->
						<li class="dropdown pull-left">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
								<img class="user-avatar" alt="" src="assets/images/noavatar.jpg" height="34" /> 
								<span class="user-name">
									<span class="">
										${user.firstName } ${user.lastName } <i class="fa fa-angle-down"></i>
									</span>
								</span>
							</a>
							<ul class="dropdown-menu hold-on-click">
								

								<li><!-- lockscreen -->
									<a href="changePassword"><i class="fa fa-lock"></i>Change Password</a>
								</li>
								<li><!-- logout -->
									<a href="logout"><i class="fa fa-power-off"></i> Log Out</a>
								</li>
							</ul>
						</li>
						<!-- /USER OPTIONS -->

					</ul>
					<!-- /OPTIONS LIST -->

				</nav>

			</header>
			<!-- /HEADER -->
			
			
			<!-- <div class="modal fade" id="changePassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">Change Password</h4>
                    </div>
                    <div class="modal-body">
                    <p>You have logged in using auto generated password. Please change your password for your safety.</p>
                        <form method="post" action="">
                            <div class="form-group">
                                <label for="oldPassword" class="hide">Old Password</label>
                                <input type="password" class="form-control input-lg c-square" id="oldPassword" required placeholder="Old Password"> </div>
                            <div class="form-group">
                                <label for="newPassword" class="hide">New Password</label>
                                <input type="password" class="form-control input-lg c-square" id="newPassword" required placeholder="New Password"> </div>
                            <div class="form-group">
                                <label for="confirm_password" class="hide">Confirm Password</label>
                                <input type="password" class="form-control input-lg c-square" id="confirm_password" required placeholder="Confirm New Password"> </div>
                            <div class="form-group">
                                <button type="submit" id="btn-changePassword" class="btn btn-priamry">Submit</button>
                            </div>
                        </form>
                        <p id="data-response" style="color: red"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn c-theme-btn c-btn-border-2x c-btn-square c-btn-bold c-btn-uppercase" data-dismiss="modal">Close</button>
                    </div>
                </div>
                /.modal-content
            </div>
            /.modal-dialog
        </div>
         -->
        
        <script>
        
        function openHistory(userId){
        	var f = document.createElement("form");
        	f.setAttribute('method',"post");
        	f.setAttribute('action',"history");
        	f.setAttribute('id','myHistory');

        	var i = document.createElement("input"); //input element, text
        	i.setAttribute('type',"hidden");
        	i.setAttribute('name',"userId");
        	i.setAttribute('value',userId);
        	f.appendChild(i);
        	document.getElementsByTagName('body')[0].appendChild(f);
        	document.getElementById("myHistory").submit();
        	
        }
        
        /* jQuery(document).ready(
        		function($) {

        			$("#btn-changePassword").click(function(event) {
        				
        				var response='';
        				$("#btn-changePassword").prop("disabled", true);
						var message='';
        				$.ajax({
	       		             type: "POST",
	       		             url: "changePassword",
	       		             data: "oldPassword=" +$("#oldPassword").val()+"&newPassword=" +$("#newPassword").val(),
	       		             success: function (response) {
	       		                 $("#data-response").html(response);
	       		             },
	       		             error: function (response) {
	       		            	message = response;
	       		                 $("#btn-changePassword").prop("disabled", false);
	       		              $("#data-response").html(response);
	       		             }
	       			});
        				
        			});

        		});
         */
        /* $(window).load(function() {
        	var messageToDisplay = '${messageToDisplay}';
        	
        	var changePassword = '${resetPassword}';
        	//change
        	if(changePassword == 'true'){
        		$('#changePassword').modal('show'); 
        	}
        	
        	else if(messageToDisplay!='')
        		$('#messageModal').modal('show'); 
        	
        }); */
        </script>

        