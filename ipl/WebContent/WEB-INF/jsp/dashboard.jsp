<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- MIDDLE -->
<link href="assets/css/dashboard.css" rel="stylesheet" type="text/css" />
<style>
.matchBox :first-of-type strong {
padding:0;
}
.matchBox :last-of-type strong{
padding:0;
}
.table > thead > tr > th{
background-color: ;
color: white;
background-color: rgba(0, 72, 72, 1);
}
.selectPlayers > li{
background-color: #efffef;
}
</style>
<section id="middle">

	<c:if test="${not empty systemParametersMap.dashboard_message}">
	<div class="alert alert-info margin-bottom-30"><!-- INFO -->
		<button type="button" class="close" data-dismiss="alert">
			<span aria-hidden="true">×</span>
			<span class="sr-only">Close</span>
		</button>
		<strong>${systemParametersMap.dashboard_message}</strong>
	</div>
	</c:if>

	<!-- page title -->
	<!-- <header id="page-header">
		<h1>Blank Page</h1>
		<ol class="breadcrumb">
			<li><a href="#">Pages</a></li>
			<li class="active">Blank Page</li>
		</ol>
	</header> -->
	<!-- /page title -->
	
	<!-- get Current system Date and time -->
	<c:set var="now" value="<%=new java.util.Date()%>" />
	<fmt:formatDate value="${now}" pattern="yyyy/MM/dd HH:mm:ss" timeZone="IST" var="currentDateTime"/>
	<fmt:formatDate value="${now}" pattern="yyyy/MM/dd" timeZone="IST" var="currentDate"/>
	
	<c:if test="${not empty messageToDisplay}">
		<a style="display: none" href="#" id="message-lnk" class="btn btn-default toastr-notify" data-progressBar="true" data-position="top-right" data-notifyType="success" data-message="${messageToDisplay}"></a>
	</c:if>
	
	<div id="content" class="padding-15">
	<form action="selectPlayers" method="post">
		<div class="row">
		
			<div class="col-md-12 col-sm-12">

							<!-- BOX -->
							<div class="box danger"><!-- default, danger, warning, info, success -->

								<div class="box-title"><!-- add .noborder class if box-body is removed -->
										
										<h4><a href="#">${not empty userPointDetails.userPoints?userPointDetails.userPoints:0} Points</a></h4>
												<i class="fa fa-trophy"></i>
								</div>

								<div class="box-body text-center">
								<small class="block">Played: ${not empty userPointDetails.played?userPointDetails.played:0} , Won : ${not empty userPointDetails.wonCount?userPointDetails.wonCount:0} , Lost : ${not empty userPointDetails.lostCount?userPointDetails.lostCount:0} , Draw : ${not empty userPointDetails.drawCount?userPointDetails.drawCount:0}</small>
								
								</div>

							</div>
							<!-- /BOX -->

			</div>

		<c:if test="${not empty topScorerlist}">
		<div class="box-body text-center matchBox padding-15 my-box panel-body">
			<span style="text-align: center;color: navy;font-weight: bold">Top Scorer from previous match#${topScorerlist[0].matchFixtureId} ${topScorerlist[0].teamOne} vs ${topScorerlist[0].teamTwo}</span><br>
			<c:set var="count" value="0" scope="page" /><br>
			<c:forEach var="topScorer" items="${topScorerlist}">
			<c:set var="count" value="${count + 1}" scope="page"/>
			        <div class="col-md-4 col-sm-6 col-xs-12">
			          <div class="info-box">
			            <span class="info-box-icon bg-place${count}"><b>${count}</b></span>
			
			            <div class="info-box-content">
			              <span class="info-box-text" style="color: red;">${topScorer.fullName}</span>
			              <span class="info-box-number">${topScorer.userPoints}<small> Points</small></span>
			              <%-- <span class="info-box-number"><small>(vs ${topScorer.userPoints})</small></span> --%>
			              	<c:if test="${topScorer.isAutoVote == true}">
			              		<span class="info-box-number"><small>(Auto Selected)</small></span>
			              	</c:if>
			            </div>
			            <!-- /.info-box-content -->
			          </div>
			          <!-- /.info-box -->
			        </div>
	        </c:forEach>
	      </div>
		</c:if>	
		<div class="col-md-12 col-sm-12">
				<%-- <h5 class="page-header bold"><fmt:formatDate value="${now}" pattern="EEEE, dd MMMM yyyy" timeZone="IST"/></h5> --%>
		</div>
		
		<c:set var="count" value="0" scope="page" />
				
		<c:forEach items="${staticDataBean.matchFixturesBean}" var="fixtures">
	
		<fmt:parseDate value="${fixtures.matchDateTime}" pattern="yyyy-MM-dd HH:mm:ss" var="fixturesDate"/>
		
		<fmt:formatDate value="${fixturesDate}" pattern="yyyy/MM/dd" var="currentFixtureDate"/>
		<fmt:formatDate value="${fixturesDate}" pattern="yyyy/MM/dd HH:mm:ss" var="currentFixtureDateTime"/>
		
		<c:if test="${currentDate == currentFixtureDate}">
				
			<c:set var="count" value="${count + 1}" scope="page"/>
			<!-- Feedback Box -->
			<div class="col-md-12 col-sm-12">

				<!-- BOX -->
				<div class="panel panel-clean"><!-- default, danger, warning, info, success -->
					
					<div class=" box-title text-center panel-heading">

					<span class="elipsis"><!-- panel title  MATCH 2 4:00PM IST (2:30PM GMT) -->
						<strong>Match ${fixtures.matchFixturesId} :  <fmt:formatDate pattern="hh:mm a" value="${fixturesDate}" /> IST</strong>
					</span>

					<!-- right options -->
					<ul class="options pull-right list-inline">
						<li><a href="#" class="opt panel_colapse" data-toggle="tooltip" title="" data-placement="bottom" data-original-title="Colapse"></a></li>
						<!-- <li><a href="#" class="opt panel_fullscreen hidden-xs" data-toggle="tooltip" title="" data-placement="bottom" data-original-title="Fullscreen"><i class="fa fa-expand"></i></a></li>
						<li><a href="#" class="opt panel_close" data-confirm-title="Confirm" data-confirm-message="Are you sure you want to remove this panel?" data-toggle="tooltip" title="" data-placement="bottom" data-original-title="Close"><i class="fa fa-times"></i></a></li> -->
					</ul>
					
					<!-- /right options -->
					<div style="color:red;font-weight: bold;" class="countdown simple countdownId<c:out value="${count}" />" id="countdownId<c:out value="${count}" />" data-date="<c:out value="${currentFixtureDateTime}" />"></div>
				</div>
					
					

				<div class="box-body text-center matchBox venue-7 padding-4 my-box panel-body">
				
					<c:forEach items="${staticDataBean.teamBean}" var="teams">
						<c:if test="${teams.teamCode == fixtures.teamOneCode}">
							<c:set var="teamOneName" value="${teams.teamName}"/>	
						</c:if>
						
						<c:if test="${teams.teamCode == fixtures.teamTwoCode}">
							<c:set var="teamTwoName" value="${teams.teamName}"/>	
						</c:if>
					</c:forEach>
					
						<div class="col-md-5 col-sm-5 col-xs-5">
							<strong>${teamOneName}</strong>
							<div class="tLogo70x ${fixtures.teamOneCode}"></div>
						</div>
						
						<div class="col-md-2 col-sm-2 col-xs-2 padding-6 text-center">
						VS
						</div>
						
						<div class="col-md-5 col-sm-5 col-xs-5">
							<strong>${teamTwoName}</strong>
							<div class="tLogo70x ${fixtures.teamTwoCode}"></div>
						</div>
						
						<div class="col-xs-12 margin-top-10">
						 <strong class="color-grey">${fixtures.venueName}, ${fixtures.venueCity}</strong>
						 </div>
						
						<c:if test="${not empty userSelectionDetailList[count-1].selectedPlayersIds}">
							<div class="col-xs-12 margin-top-10 margin-bottom-10">
							<input type="button" class="btn btn-success" id="replacable-btn${count}" value="Update Players" onclick="selectPlayers(${fixtures.matchFixturesId})">
							</div>
						</c:if>
						
						<c:if test="${empty userSelectionDetailList[count-1].selectedPlayersIds}">
							<div class="col-xs-12 margin-top-10 margin-bottom-10">
							<input type="button" class="btn btn-primary my-btn" id="replacable-btn${count}" value="Select Players" onclick="selectPlayers(${fixtures.matchFixturesId})">
							</div>
						</c:if> 
						
					<c:if test="${empty userTwoSelectionDetailList[count-1].selectedPlayersIds}">
<c:if test="${not empty userSelectionDetailList[count-1].selectedPlayersIds}">
						
							<div class="col-md-12 col-sm-12 col-xs-12">
								<hr style="margin: 5px; border: 1px solid #ddd">
								<strong style="display: block">My Selection</strong>
								<hr style="margin: 5px; border: 1px solid #ddd">
							</div>
						
							
							
							<div class="col-md-12 col-sm-12 col-xs-12" style="padding: 5px">
								<div class="col-md-4 col-sm-2 col-xs-0" style="padding: 5px"></div>
								<div class="col-md-4 col-sm-8 col-xs-12" style="padding: 5px">
									<div class="table-responsive nomargin">
												<table class="table table-condensed nomargin">
													<thead>
														<tr>
															<th style="text-align: center;" colspan="2">Selected Players</th>
														</tr>
													</thead>
													<tbody>
													<c:forEach items="${userSelectionDetailList[count-1].selectedPlayerBeanList}" var="players">
														<c:set var="labelType" value="primary"/>
														<c:if test="${players.role == 'Batsmen'}">
															<c:set var="labelType" value="warning"/>	
														</c:if>
														<c:if test="${players.role == 'Bowler'}">
															<c:set var="labelType" value="primary"/>	
														</c:if>
														<c:if test="${players.role == 'All Rounder'}">
															<c:set var="labelType" value="danger"/>	
														</c:if>
														<tr>
															<td style="text-align: left;">${players.firstName} ${players.lastName}</td>
															<td style="text-align: right;"><span class="label label-${labelType}" style="font-size: 10px">${players.role}</span></td>
														</tr>
														<c:if test="${players.playerId == userSelectionDetailList[count-1].playerMomId}">
															<c:set var="momPlayer" value="${players.firstName} ${players.lastName}" scope="page"/>
														</c:if>
													</c:forEach>
													</tbody>
												</table>

										</div>
									</div>
									<div class="col-md-4 col-sm-2 col-xs-0" style="padding: 5px"></div>
								
							</div>
							
							<div class="col-md-6 col-sm-6 col-xs-6" style="padding: 3px">
							<br>
								<div class="table-responsive nomargin">
									<table class="table table-condensed nomargin">
										<thead>
											<tr>
												<th style="text-align: center;">Power&nbsp;Player</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td style="text-align: center;">${momPlayer}</td>
											</tr>
										</tbody>
									</table>
								</div>	
							</div>
							
							<div class="col-md-6 col-sm-6 col-xs-6" style="padding: 3px">
							<br>
								<div class="table-responsive nomargin">
									<table class="table table-condensed nomargin">
										<thead>
											<tr>
												<th style="text-align: center;">Win&nbsp;Team</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td style="text-align: center;">${staticDataBean.teamBeanMap[userSelectionDetailList[count-1].winTeamId].teamCode}
												<div class="tLogo16x30 ${staticDataBean.teamBeanMap[userSelectionDetailList[count-1].winTeamId].teamCode}"></div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							
						</c:if>
					</c:if>
					<c:if test="${not empty userTwoSelectionDetailList[count-1].selectedPlayersIds}">
						<c:if test="${not empty userSelectionDetailList[count-1].selectedPlayersIds}">
						<div class="col-xs-6 col-md-6" style="padding: 1px" >
							<div class="pricing-table">
								<hr style="margin: 5px; border: 1px solid #ddd">
								<strong style="display: block" >My Selection</strong>
								<hr style="margin: 5px; border: 1px solid #ddd">
								
								<ul class="plan-features selectPlayers" id="userOne">
														<c:forEach items="${userSelectionDetailList[count-1].selectedPlayerBeanList}" var="players">
															<c:set var="labelType" value="primary"/>
															<c:if test="${players.role == 'Batsmen'}">
																<c:set var="labelType" value="warning"/>	
																<c:set var="playerRole" value="Bat"/>																
															</c:if>
															<c:if test="${players.role == 'Bowler'}">
																<c:set var="labelType" value="primary"/>
																<c:set var="playerRole" value="Bowl"/>	
															</c:if>
															<c:if test="${players.role == 'All Rounder'}">
																<c:set var="labelType" value="danger"/>	
																<c:set var="playerRole" value="All"/>
															</c:if>
															<li style="height: 40px">
																<div style="display: inline-block;float: left;padding-left: 5px">${fn:substring(players.firstName,0,1)} ${players.lastName}</div>
																<div style="display: inline-block;float: right;padding-right: 5px">
																	<c:if test="${players.playerId == userSelectionDetailList[count-1].playerMomId}">
																	<c:set var="momPlayer" value="${players.firstName} ${players.lastName}" scope="page"/><span class="label label-default" style="font-size: 10px">P</span>
																	</c:if>
																<span class="label label-${labelType}" style="font-size: 10px"><span class="hidden-xs">${players.role}</span> <span class=" hidden-sm hidden-md hidden-lg">${playerRole}</span></span>
																</div>
															
															</li>
														</c:forEach>
								</ul>
													<div class="plan-buy text-center">
													<strong>${staticDataBean.teamBeanMap[userSelectionDetailList[count-1].winTeamId].teamCode}</strong>
													<div class="tLogo16x30 ${staticDataBean.teamBeanMap[userSelectionDetailList[count-1].winTeamId].teamCode}"></div>
													</div>
							</div>
									
							
						</div>
						</c:if>
						
						<div class="col-xs-6 col-md-6" style="padding: 1px" >
							<div class="pricing-table">
								<hr style="margin: 5px; border: 1px solid #ddd">
								<strong style="display: block">${staticDataBean.userBeanMap[userTwoSelectionDetailList[count-1].userId].firstName}</strong>
								<hr style="margin: 5px; border: 1px solid #ddd">
								
								<ul class="plan-features selectPlayers" id="userTwo">
														<c:forEach items="${userTwoSelectionDetailList[count-1].selectedPlayerBeanList}" var="players">
														<c:set var="labelType" value="primary"/>
															<c:if test="${players.role == 'Batsmen'}">
																<c:set var="labelType" value="warning"/>	
																<c:set var="playerRole" value="Bat"/>
															</c:if>
															<c:if test="${players.role == 'Bowler'}">
																<c:set var="labelType" value="primary"/>	
																<c:set var="playerRole" value="Bowl"/>
															</c:if>
															<c:if test="${players.role == 'All Rounder'}">
																<c:set var="labelType" value="danger"/>	
																<c:set var="playerRole" value="All"/>
															</c:if>
														<li style="height: 40px">
														<div style="display: inline-block;float: left;padding-left: 5px">${fn:substring(players.firstName,0,1)} ${players.lastName}</div> 
														<div style="display: inline-block;float: right;padding-right: 5px">
															<c:if test="${players.playerId == userTwoSelectionDetailList[count-1].playerMomId}">
																<c:set var="momPlayer" value="${players.firstName} ${players.lastName}" scope="page"/><span class="label label-default" style="font-size: 10px">P</span>
															</c:if>
															<span class="label label-${labelType}" style="font-size: 10px"><span class="hidden-xs">${players.role}</span> <span class=" hidden-sm hidden-md hidden-lg">${playerRole}</span></span>
														</div>
															
															</li>
														</c:forEach>
								</ul>
													<div class="plan-buy text-center">
													<strong>${staticDataBean.teamBeanMap[userTwoSelectionDetailList[count-1].winTeamId].teamCode}</strong>
													<div class="tLogo16x30 ${staticDataBean.teamBeanMap[userTwoSelectionDetailList[count-1].winTeamId].teamCode}"></div>
													</div>
							</div>
									
							
						</div>
					</c:if>
					
						
						
					</div>

				</div>
				<!-- /BOX -->

			</div>
			
		</c:if>
	</c:forEach>
	
	
	<c:if test="${count == -1}">
	<div class="row">
		<div class="col-md-12 col-sm-12">
			<div class="col-md-3 col-sm-3"></div>
			<div class="col-md-6 col-sm-6">
			<div class="alert alert-danger margin-top-30"><!-- DANGER -->
				<strong>No Matches Today</strong>
			</div>
			</div>
			<div class="col-md-3 col-sm-3"></div>
		</div></div>
					
	</c:if>
	
	<div class="row">
	<div class="col-md-12 col-sm-12">
						<!-- Feedback Box -->
						<div class="col-md-4 col-sm-6">

							<!-- BOX -->
							<div class="box danger" style="padding-bottom: 0;background:#f4b04f url('assets/images/bg.png');"><!-- default, danger, warning, info, success -->

								<div class="box-title"><!-- add .noborder class if box-body is removed -->
									<span class="info-box-text" style="color:white;text-shadow:-1px -1px 0 #000, 2px -1px 0 #000, 0px 2px 0 #000, 1px 1px 0 #000;"><h3><b>Anirudh Pargal</b></h3></span>
			              			<span class="info-box-number" style="color:black">3655<small> Points</small></span>
									<i class="fa fa-trophy" aria-hidden="true" style="color:rgba(255, 255, 255, 0.9)"></i>
								</div>

								<div class="box-body text-center">
								<h4><span style="color: #d40000"><b>WINNER</b></span></h4>
								</div>

								<div class="box-body text-left" style="margin: 0px -10px 0px -10px;background:#f7d09a;border: 1px solid #f4b04f;padding: 5px">
								<h5><span style="color: black">&nbsp;&nbsp;<b>2.</b> Aadesh Dubey (1868 Points)</span></h5>
								<h5><span style="color: black">&nbsp;&nbsp;<b>3.</b> Anuj Rao (1317 Points)</span></h5>
								</div>
							</div>
							<!-- /BOX -->

						</div>

						<!-- Profit Box -->
						<div class="col-md-4 col-sm-6">

							<!-- BOX -->
							<div class="box warning" style="padding-bottom: 0;background:#999 url('assets/images/bg.png');"><!-- default, danger, warning, info, success -->

								<div class="box-title"><!-- add .noborder class if box-body is removed -->
									<span class="info-box-text" style="color:white;text-shadow:-1px -1px 0 #000, 2px -1px 0 #000, 0px 2px 0 #000, 1px 1px 0 #000;"><h3><b>Bharat Patel</b></h3></span>
			              			<span class="info-box-number" style="color:black">29 <small> Wins</small></span>
									<i class="fa fa-line-chart" aria-hidden="true"  style="color:rgba(255, 255, 255, 0.9)"></i>
								</div>

								<div class="box-body text-center">
								<h4><span style="color: #d40000"><b>Most Wins</b></span></h4>
								</div>

								<div class="box-body text-left" style="margin: 0px -10px 0px -10px;background:#e0e0e0;border: 1px solid #999;padding: 5px">
								<h5><span style="color: black">&nbsp;&nbsp;<b>2.</b> Roshan Chugh (29 Wins)</span></h5>
								<h5><span style="color: black">&nbsp;&nbsp;<b>3.</b> Aadesh Dubey (28 Wins)</span></h5>
								</div>
								
							</div>
							<!-- /BOX -->

						</div>

						<!-- Orders Box -->
						<div class="col-md-4 col-sm-6">

							<!-- BOX -->
							<div class="box default" style="padding-bottom: 0;background:#f97575 url('assets/images/bg.png');"><!-- default, danger, warning, info, success #999999 -->

								<div class="box-title"><!-- add .noborder class if box-body is removed -->
									<span class="info-box-text" style="color:white;text-shadow:-1px -1px 0 #000, 2px -1px 0 #000, 0px 2px 0 #000, 1px 1px 0 #000;"><h3><b>Apurva Gaikwad</b></h3></span>
			              			<span class="info-box-number" style="color:black"><small>&nbsp;</small></span>
									<i class="fa fa-thumbs-up" aria-hidden="true"  style="color:rgba(255, 255, 255, 0.9)"></i>
								</div>

								<div class="box-body text-center">
								<h4><span style="color: #d40000"><b>Emerging Player</b></span></h4>
								</div>
								
								<div class="box-body text-left" style="margin: 0px -10px 0px -10px;background:#f7d8d8;border: 1px solid #f97575;padding: 5px">
								<h5><span style="color: black">&nbsp;&nbsp;<b>2.</b> Priyanka Poojari</span></h5>
								<h5><span style="color: black">&nbsp;&nbsp;<b>3.</b> sonali paunikar</span></h5>
								</div>
							</div>
							<!-- /BOX -->

						</div>

</div>
					</div>
					
	<div class="row">
		<div class="col-md-12 col-sm-12">
			<div class="col-md-2 col-sm-2"></div>
			<div class="col-md-8 col-sm-8 text-center">
			<div class="margin-top-30" style=""><!-- DANGER -->
			<h3><b><span style="color:red">CSK Crowned IPL 2018 Champions</span> </b></h3>
			<img alt="" src="assets/images/champ.jpg" style="max-height: 100%; max-width: 100%;">
			</div>
			</div>
			<div class="col-md-2 col-sm-2"></div>
		</div></div>
					
	
	</div>
<%-- 	<div class="alert alert-info margin-bottom-30 text-center"><!-- INFO -->
		<strong>My Statistics</strong>
	</div>
	<canvas class="chartjs fullwidth height-300" id="lineChartCanvas" width="547" height="300"></canvas>
	<br>
	<canvas class="chartjs height-300" id="doughnutChartCanvas" width="547" height="300"></canvas>
 --%>
	
	<input type="hidden" name="matchId" id="matchId" value="">
	<input type="hidden" name="comingFrom" id="comingFrom" value="dashBoardPage">
	
	</form>

	</div>
</section>
<!-- /MIDDLE -->



<div class="modal fade" id="rulesMsg" aria-hidden="true">
	<div class="modal-dialog ">
		<div class="modal-content">
			
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myLargeModalLabel"><strong>IPL 2018 - Playoff Rules</strong></h4>
			</div>

			<!-- body modal -->
			<div class="modal-body">
					${systemParametersMap.rules_message}
			</div>

			<!-- Modal Footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
			
			

		</div>
	</div>
</div>

<script type="text/javascript" src="assets/js/jquery.countdown.min.js"></script>


<script type="text/javascript">
$( document ).ready(function(){
	
		
		var message = '${messageToDisplay}';
		
		if(message!='' || message!=undefined){
			$('.toastr-notify').attr('data-message',message);
			$('.toastr-notify').click();
			//document.getElementById("message-lnk").click();
		}
		
		if(document.getElementById("countdownId1")){
			var countdown1 = document.getElementById("countdownId1");
			var endDate1 = countdown1.getAttribute("data-date");
	
			
			$('#countdownId1').countdowntimer({
	            startDate : '${currentDateTime}',
	            dateAndTime : endDate1
			});
			
			if(document.getElementById("countdownId2"))
			{
				
				var countdown2 = document.getElementById("countdownId2");
				var endDate2 = countdown2.getAttribute("data-date");
				
				$('#countdownId2').countdowntimer({
					startDate : '${currentDateTime}',
					dateAndTime : endDate2
				});
			}
		}
/* 		
			if(testmy1==0){
				var replace = $('#replacable-btn1').val('See Selected Players');
			}
			if(testmy2==0){
				var replace = $('#replacable-btn2').val('See Selected Players');
			}
			 */

		
		commonPlayers();
		
	    var rulesMsg = "${systemParametersMap.rules_message}";
	    
	    
	    if(rulesMsg != '')
	    	{
			$('#rulesMsg').modal('show');
	
	    	}
	    

	});
	
	
	function validateVote0(){
		if(testmy1==0){
			var replace = $('#replacable-btn0').html('<div class="alert alert-danger"><strong>Voting Closed</strong> </div>');
			alert("Voting Closed");
			return false;
		}
		else{
			document.forms[0].submit();
		}
		
	}

	function validateVote1(){
		if(testmy2==0){
			var replace = $('#replacable-btn1').html('<div class="alert alert-danger"><strong>Voting Closed</strong> </div>');
			alert("Voting Closed");
			return false;
		}
		else
		{
			document.forms[1].submit();
		}
	}
	
	function selectPlayers(matchId){
		
		document.getElementById("matchId").value=matchId;
		
		document.forms[0].submit();
	}
	
	function commonPlayers(){
	    
		$('#userOne li').each(function(i, li) {
	    	var userOneLI = $(li);

	    	var firstValue = userOneLI[0].children[0].innerText;
		
	    		$('#userTwo li').each(function(i, li) {

	    			var secondValue = $(li)[0].children[0].innerText;
			            
			            if (firstValue == secondValue) {
			                //var rowToMove = $(this).parents('tr.MoveableRow:first');
			                //$("#row"+m).prev().before($("#row"+n));
			               // 	 $('#userTwoTbl tbody tr:nth-child(' + indexTwo + ')').before($(this));
			               $(li).css({ 'background-color' : '#faccca'});
			               userOneLI.css({ 'background-color' : '#faccca'});
			                //$('#userTwoTbl tbody tr:nth-child(' + indexTwo + ')').css({ 'background-color' : 'green'});
			               // if (prev.length == 1) { prev.before($(this)); }
			
			            }
		        	
		        });
	    	
	    });

	}
	
	
/* 	loadScript(plugin_path + 'chart.chartjs/Chart.min.js', function() {
		var lineChartCanvas = {
			labels:[${userPointDetails.indMatch}],
			datasets:[
				{
					label: "My Progress",
					fillColor : "rgba(151,187,205,0.2)",
					strokeColor : "rgba(151,187,205,1)",
					pointColor : "rgba(151,187,205,1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(151,187,205,1)",
					data : [${userPointDetails.indPoints}]
				}
			]
		};

		var ctx = document.getElementById("lineChartCanvas").getContext("2d");
		new Chart(ctx).Line(lineChartCanvas);
		pieChart();
	});	
	
	function pieChart() {
		var doughnutChartCanvas  = [
			{
				value: ${userPointDetails.wonCount},
				color:"green",
				label: 'Wins'
			},
			{
				value : ${userPointDetails.lostCount},
				color : "red",
				label: 'Lost'
			},
			{
				value : ${userPointDetails.drawCount},
				color : "grey",
				label: 'Draw'
			},
			{
				value : ${userPointDetails.played - (userPointDetails.wonCount+userPointDetails.lostCount+userPointDetails.drawCount)},
				color : "#1E73BE",
				label: 'Not PLayed'
				
			}
		];

		var ctx = document.getElementById("doughnutChartCanvas").getContext("2d");
		new Chart(ctx).Doughnut(doughnutChartCanvas);
	} */
</script>

