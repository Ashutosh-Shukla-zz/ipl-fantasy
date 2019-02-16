<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- MIDDLE -->
<section id="middle">


	
	<div id="content" class="padding-20">
		<div class="panel panel-default">
		
		
					<div class="panel-heading">
					<span class="elipsis"><!-- panel title -->
						<strong>Pending User approvals</strong>
					</span>
					</div>
						<div class="panel-body">
							
							<div class="table-responsive">
										<table class="table table-condensed nomargin">
											<thead>
												<tr>
													<th>User Id</th>
													<th>Name</th>
													<th>Mobile number</th>
													<th>Email-Id</th>
													<th>is_admin</th>
													<th>is_active</th>
													<th>Activate</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${userBeanList }" var="userBean">
												<tr>
													<td>${userBean.userId }</td>
													<td>${userBean.firstName} ${userBean.lastName}</td>
													<td>${userBean.mobile }</td>
													<td>${userBean.email }</td>
													<td>${userBean.isAdmin }</td>
													<td>${userBean.isActive }</td>
													<td><button id="${userBean.userId }-btn" onclick="activatePlayer('${userBean.userId }')" class="label label-success">Activate </button></td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
							

						</div>
					</div>
		
	
	</div>
</section>
<!-- /MIDDLE -->

</div>
<a style="display: none" href="#" id="notification" class="btn btn-default toastr-notify" data-progressBar="true" data-position="top-right" data-notifyType="success" data-message="Data updatation successful"></a>
	<a style="display: none" href="#" id="notification-fail" class="btn btn-default toastr-notify" data-progressBar="true" data-position="top-right" data-notifyType="success" data-message="Data updatation failed"></a>


<script>
	
	
	function activatePlayer(userId) {
		
		
		
		$.ajax({
	             type: "POST",
	             url: "approveUser",
	             data: "userId="+userId,
	             success: function (response) {
	            	 data=response;
	            	 if(data=="true"){
	            		 $('#notification').click();
	            		 $('#'+userId+'-btn').attr("disabled","disabled");
	            			 }
	            		 },
	             error: function (response) {
	            	 $('#notification-fail').click();
	             }
		});
	}
	
</script>