<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- MIDDLE -->
<style>
.history > thead > tr > th{
background-color: ;
color: white;
background-color:rgb(1, 25, 66) !important;
}
.rowColor{
background-color: #efffef;
}
</style>

<section id="middle">


	
	<div id="content" class="padding-20">
		
		<div id="panel-1" class="panel panel-default">
						<div class="panel-heading">
							<span class="title elipsis">
								<strong>
								<c:if test="${not empty userName}">
								${userName}'s History
								</c:if>
								<c:if test="${empty userName}">
								${user.firstName}'s History
								</c:if>
								</strong> <!-- panel title -->
								
							</span>


						</div>

						<!-- panel content -->
						<div class="panel-body">

							<div class="table-responsive">
								<table class="table table-bordered table-vertical-middle nomargin history">
									<thead>
										<tr>
											<th>Match</th>
											<th>Versus</th>
											<th>Details</th>
											<th>Points</th>
											<th>Status</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${userFixtureBeanList}" var="userFixture">
										<tr>
											<td>${userFixture.matchId } <span style="color: red;font-weight: bold">${staticDataBean.matchFixturesBeanMap[userFixture.matchId].teamOneCode} vs ${staticDataBean.matchFixturesBeanMap[userFixture.matchId].teamTwoCode}</span>
											</td>	
											<td>
											
											<c:if test="${userId== userFixture.userOneId}">
											${userFixture.userTwoName }
											</c:if>
											<c:if test="${userId== userFixture.userTwoId}">
											${userFixture.userOneName }
											</c:if>
											
											</td>
											<td><span class="btn-default"><a class="" onclick="showMatchDetails('${userFixture.matchId }','${userFixture.userOneId}','${userFixture.userTwoId}','${userFixture.userWinnerId}','${userFixture.userOnePoints}','${userFixture.userTwoPoints}','${userFixture.userOneName}','${userFixture.userTwoName}','${userFixture.userOneTeamPlayerPoints}','${userFixture.userTwoTeamPlayerPoints}')" data-target="#historyDetails" data-toggle="modal">Details</a> </span></td>
											<td>
												<c:if test="${userFixture.matchId > 56}">
													
													<c:if test="${userFixture.userWinnerId eq 0}">
														${userFixture.userOnePoints}
													</c:if>
													<c:if test="${userFixture.userWinnerId ne 0}">
														<c:if test="${userId == userFixture.userWinnerId}">
															${userFixture.userOnePoints + userFixture.userTwoPoints}
														</c:if>
														
														<c:if test="${userId != userFixture.userWinnerId}">
															${-userFixture.userTwoPoints -userFixture.userOnePoints}
														</c:if>
													</c:if>
												</c:if>
												
												<c:if test="${userFixture.matchId < 57}">
													<c:if test="${userId== userFixture.userOneId}">
															<c:if test="${userFixture.userWinnerId eq 0}">
																${userFixture.userOnePoints}
															</c:if>
															<c:if test="${userFixture.userWinnerId ne 0}">
																${userFixture.userOnePoints - userFixture.userTwoPoints}
															</c:if>
													</c:if>
													<c:if test="${userId== userFixture.userTwoId}">
															<c:if test="${userFixture.userWinnerId eq 0}">
																	${userFixture.userTwoPoints}
															</c:if>
															<c:if test="${userFixture.userWinnerId ne 0}">
																	${userFixture.userTwoPoints -userFixture.userOnePoints}
															</c:if>													
													</c:if>
												</c:if>
												
											</td>
											<td>
													
														<c:if test="${userId== userFixture.userWinnerId}">
														<strong style="color:#25a747;">Won</strong>
														</c:if>
														<c:if test="${0!= userFixture.userWinnerId && userId!= userFixture.userWinnerId}">
														<strong style="color:#df0200;">Lost</strong>
														</c:if>
														<c:if test="${0== userFixture.userWinnerId && staticDataBean.matchFixturesBeanMap[userFixture.matchId].matchStatus == 1}">
														<strong>Draw</strong>
														</c:if>
														<c:if test="${0== userFixture.userWinnerId && staticDataBean.matchFixturesBeanMap[userFixture.matchId].matchStatus == 0}">
														<strong>Match in progress..</strong>
														</c:if>
								
											</td>
										</tr>
									 </c:forEach>
									</tbody>
								</table>
							</div>

						</div>
						<!-- /panel content -->
					</div>
	
	</div>
</section>
<!-- /MIDDLE -->

<div class="modal fade" id="historyDetails" role="basic" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myLargeModalLabel">Match Details</h4>
			</div>

			<!-- body modal -->
			<div class="modal-body">
					<div id="match-details" class="row">
					</div>
			</div>

			<!-- Modal Footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
			
			

		</div>
	</div>
</div>


</div>

<script>
$(window).load(function() {
	

	
});

function commonPlayers(){
    var $tableOneRows = $("#userOneTbl tbody tr");
    var $tableTwoRows = $("#userTwoTbl tbody tr");
    
    $tableOneRows.each(function(n) {
    	var tableOneRow = $(this);
    	if(n<7){
	        var firstValue = $(this).find('td:nth-child(1)')[0].childNodes[0].data;
	
	        $tableTwoRows.each(function(m) {
	        	if(m<7){
		            var secondValue = $(this).find('td:nth-child(1)')[0].childNodes[0].data;
		            
		            if (firstValue == secondValue) {
		                //var rowToMove = $(this).parents('tr.MoveableRow:first');
		                //$("#row"+m).prev().before($("#row"+n));
		               // 	 $('#userTwoTbl tbody tr:nth-child(' + indexTwo + ')').before($(this));
		                $('#userOneTbl tbody tr:nth-child(' + tableOneRow[0].rowIndex + ')').css({ 'background-color' : '#faccca'});
		                $('#userTwoTbl tbody tr:nth-child(' + $(this)[0].rowIndex + ')').css({ 'background-color' : '#faccca'});
		                //$('#userTwoTbl tbody tr:nth-child(' + indexTwo + ')').css({ 'background-color' : 'green'});
		               // if (prev.length == 1) { prev.before($(this)); }
		
		            }
	        	}
	        });
    	}
    });

}

function showMatchDetails(matchId,userOneId,userTwoId,userWinnerId,userOnePoints,userTwoPoints,userOneName,userTwoName,userOneTeamPlayerPoints,userTwoTeamPlayerPoints){
	
	$.ajax({
          type: "POST",
          url: "historyDetails",
          data: "matchId=" +matchId+"&userOneId="+userOneId+"&userTwoId="+userTwoId+"&userWinnerId="+userWinnerId+"&userOnePoints="+userOnePoints+"&userTwoPoints="+userTwoPoints+"&userOneName="+userOneName+"&userTwoName="+userTwoName+"&userOneTeamPlayerPoints="+userOneTeamPlayerPoints+"&userTwoTeamPlayerPoints="+userTwoTeamPlayerPoints,
          success: function (response) {
              $("#match-details").html(response);
              commonPlayers();
          },
          error: function (response) {
           $("#match-details").html("An error occurred while fetching the details, Please contact administrator");
           
          }
	});
	
}
</script>